<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAppController extends pjBaseAppController
{
	public function isEditor()
    {
    	return $this->getRoleId() == 2;
    }

    public function pjActionCheckInstall()
    {
        $this->setLayout('pjActionEmpty');

        $result = array('status' => 'OK', 'code' => 200, 'text' => 'Operation succeeded', 'info' => array());
        $folders = array('app/web/upload');
        foreach ($folders as $dir)
        {
            if (!is_writable($dir))
            {
                $result['status'] = 'ERR';
                $result['code'] = 101;
                $result['text'] = 'Permission requirement';
                $result['info'][] = sprintf('Folder \'<span class="bold">%1$s</span>\' is not writable. You need to set write permissions (chmod 777) to directory located at \'<span class="bold">%1$s</span>\'', $dir);
            }
        }

        return $result;
    }

    /**
     * Sets some predefined role permissions and grants full permissions to Admin.
     */
    public function pjActionAfterInstall()
    {
        $this->setLayout('pjActionEmpty');

        $result = array('status' => 'OK', 'code' => 200, 'text' => 'Operation succeeded', 'info' => array());

        $pjAuthRolePermissionModel = pjAuthRolePermissionModel::factory();
        $pjAuthUserPermissionModel = pjAuthUserPermissionModel::factory();

        $permissions = pjAuthPermissionModel::factory()->findAll()->getDataPair('key', 'id');

        $roles = array(1 => 'admin', 2 => 'editor');
        foreach ($roles as $role_id => $role)
        {
            if (isset($GLOBALS['CONFIG'], $GLOBALS['CONFIG']["role_permissions_{$role}"])
                && is_array($GLOBALS['CONFIG']["role_permissions_{$role}"])
                && !empty($GLOBALS['CONFIG']["role_permissions_{$role}"]))
            {
                $pjAuthRolePermissionModel->reset()->where('role_id', $role_id)->eraseAll();

                foreach ($GLOBALS['CONFIG']["role_permissions_{$role}"] as $role_permission)
                {
                    if($role_permission == '*')
                    {
                        // Grant full permissions for the role
                        foreach($permissions as $key => $permission_id)
                        {
                            $pjAuthRolePermissionModel->setAttributes(compact('role_id', 'permission_id'))->insert();
                        }
                        break;
                    }
                    else
                    {
                        $hasAsterix = strpos($role_permission, '*') !== false;
                        if($hasAsterix)
                        {
                            $role_permission = str_replace('*', '', $role_permission);
                        }

                        foreach($permissions as $key => $permission_id)
                        {
                            if($role_permission == $key || ($hasAsterix && strpos($key, $role_permission) !== false))
                            {
                                $pjAuthRolePermissionModel->setAttributes(compact('role_id', 'permission_id'))->insert();
                            }
                        }
                    }
                }
            }
        }

		// Grant full permissions to Admin
        $user_id = 1; // Admin ID
        $pjAuthUserPermissionModel->reset()->where('user_id', $user_id)->eraseAll();
        foreach($permissions as $key => $permission_id)
        {
            $pjAuthUserPermissionModel->setAttributes(compact('user_id', 'permission_id'))->insert();
        }

        return $result;
    }

    public function beforeFilter()
    {
        parent::beforeFilter();

        if(!in_array($this->_get->toString('controller'), array('pjFront')))
        {
            $this->appendJs('pjAdminCore.js');
            // TODO: DELETE unnecessary files
            #$this->appendCss('reset.css');
            #$this->appendCss('pj-all.css', PJ_FRAMEWORK_LIBS_PATH . 'pj/css/');
            $this->appendCss('admin.css');
        }
        
        return true;
    }

	protected static function getWorkingTime($date)
	{
		$date_arr = pjDateModel::factory()->getWorkingTime($date);
		if ($date_arr === false)
		{
			$wt_arr = pjWorkingTimeModel::factory()->getWorkingTime(1, $date);
			if (count($wt_arr) == 0)
			{
				return false;
			}
			$t_arr = $wt_arr;
		} else {
			if (count($date_arr) == 0)
			{
				return false;
			}
			$t_arr = $date_arr;
		}
		return $t_arr;
	}

	protected static function getTokens($option_arr, $booking_arr, $locale_id, $is_sms)
	{
		$country = NULL;
		if (isset($booking_arr['c_country']) && !empty($booking_arr['c_country']))
		{
			$country_arr = pjBaseCountryModel::factory()
						->select('t1.id, t2.content AS country_title')
						->join('pjBaseMultiLang', "t2.model='pjBaseCountry' AND t2.foreign_id=t1.id AND t2.field='name' AND t2.locale='".$locale_id."'", 'left outer')
						->find($booking_arr['c_country'])->getData();
			if (!empty($country_arr))
			{
				$country = $country_arr['country_title'];
			}
		}

		$row = array();
		if (isset($booking_arr['table_arr']))
		{
			foreach ($booking_arr['table_arr'] as $v)
			{
				$row[] = stripslashes($v['name']);
			}
		}
		$booking_data = count($row) > 0 ? join("\n", $row) : NULL;
		$dt = NULL;
		if (isset($booking_arr['dt']) && !empty($booking_arr['dt']))
		{
			$tm = strtotime(@$booking_arr['dt']);
			$dt = date($option_arr['o_date_format'], $tm) . ", " . date($option_arr['o_time_format'], $tm);
		}

		$payment_methods = pjObject::getPlugin('pjPayments') !== NULL? pjPayments::getPaymentTitles(1, $locale_id): __('payment_methods',true);

		$cancelURL = PJ_INSTALL_URL . 'index.php?controller=pjFront&action=pjActionCancel&id='.@$booking_arr['id'].'&hash='.sha1(@$booking_arr['id'].@$booking_arr['created'].PJ_SALT).'&locale='.@$booking_arr['locale_id'];
		$cancelURL = '<a href="'.$cancelURL.'">'.__('front_cancel_reservation', true, false).'</a>';
		$search = array(
			'{Title}', '{FirstName}', '{LastName}', '{Email}', '{Phone}', '{Country}',
			'{City}', '{State}', '{Zip}', '{Address}',
			'{Company}', '{CCType}', '{CCNum}', '{CCExp}',
			'{CCSec}', '{PaymentMethod}', '{UniqueID}', '{DtFrom}',
			'{Total}', '{People}', '{Notes}',
			'{BookingID}', '{Table}', '{CancelURL}');
		$replace = array(
			$booking_arr['c_title'], $booking_arr['c_fname'], $booking_arr['c_lname'], $booking_arr['c_email'], $booking_arr['c_phone'], $country,
			$booking_arr['c_city'], $booking_arr['c_state'], $booking_arr['c_zip'], $booking_arr['c_address'],
			$booking_arr['c_company'], @$booking_arr['cc_type'], @$booking_arr['cc_num'], (@$booking_arr['payment_method'] == 'creditcard' ? @$booking_arr['cc_exp'] : NULL),
			@$booking_arr['cc_code'], @$payment_methods[$booking_arr['payment_method']], @$booking_arr['uuid'], $dt,
			@$booking_arr['total'] . " " . $option_arr['o_currency'], @$booking_arr['people'], @$booking_arr['c_notes'],
			@$booking_arr['id'], $booking_data, $is_sms == false ? $cancelURL : null);

		return compact('search', 'replace');
	}

	protected static function getPrice($option_arr, $date, $time, $code=null)
	{
		$code_arr = array();
		if (!empty($code))
		{
		    if (pjObject::getPlugin('pjVouchers') !== NULL)
            {
                $result = pjVoucherModel::factory()->getVoucher($code, $date, $time);
                if($result['status'] == 'OK')
                {
                    $code_arr = $result['arr'];
                }
            }
		}
		$price = $option_arr['o_booking_price'];
		if (count($code_arr) > 0)
		{
			switch ($code_arr['type'])
			{
				case 'percent':
					$price_after_discount = $price - (($price * $code_arr['discount']) / 100);
					$price_after_discount = $price_after_discount > 0 ? $price_after_discount : 0;
					break;
				case 'amount':
					$price_after_discount = $price - $code_arr['discount'] > 0 ? $price - $code_arr['discount'] : 0;
					break;
			}
			$total = $price_after_discount;

			$p = array(
				'type' => $code_arr['type'],
				'discount' => $code_arr['discount'],
				'discount_formatted' => $code_arr['type'] == 'amount' ? pjCurrency::formatPrice($code_arr['discount']) : (float) $code_arr['discount'] .'%',
				'price' => round($price, 2),
				'price_before_discount' => round($price, 2),
				'price_after_discount' => round($price_after_discount, 2),
				'price_before_formatted' => pjCurrency::formatPrice($price),
				'price_after_formatted' => pjCurrency::formatPrice($price_after_discount),
				'total' => round($total, 2)
			);
		}else {
			$total = $price;
			$p = array(
				'price' => round($price, 2),
				'price_formatted' => pjCurrency::formatPrice($price),
				'total' => round($total, 2)
			);
		}
		return $p;
	}

	protected static function getAdminEmail()
	{
		$arr = pjAuthUserModel::factory()->select('t1.email')->find(1)->getData();
		
		return $arr ? $arr['email'] : NULL;
	}

	/*
     * Returns the ID needed to fetch the Payment Options from pjPayments plugin.
     *
     * Scenario 1:
     *  - The script uses just one set of options, so the method returns NULL to fetch script's default options.
     *
     * Scenario 2:
     *  - The script uses multiple option sets, e.g. Vacation Rental Website.
     *    Then the method should find the related Property ID as each property has different payment options.
     */
    public function getPaymentOptionsForeignId($foreign_id)
    {
        return null;
    }
    
    protected function isAmPm()
    {
    	return strpos($this->option_arr['o_time_format'], 'a') !== false || strpos($this->option_arr['o_time_format'], 'A') !== false;
    }
    
    protected function getAmPmTime()
    {
    	if (!$this->isAmPm())
    	{
    		return 0;
    	}
    	
    	if (strpos($this->option_arr['o_time_format'], 'a') !== false)
    	{
    		return 1;
    	}
    	
    	return 2;
    }
    
    protected function getAmPmFormat()
    {
    	if (strpos($this->option_arr['o_time_format'], 'a') !== false)
    	{
    		return 'a';
    	}

    	return 'A';
    }
}
?>