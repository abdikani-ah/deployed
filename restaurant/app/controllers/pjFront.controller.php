<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjFront extends pjAppController
{	
	public $defaultCaptcha = 'RBooking_Captcha';
	
	public $defaultLocale = 'RBooking_LocaleId';
	
	public $defaultStore = 'RBooking_Store';
	
	public $firstLoad = 'RBooking_FirstLoad';
	
	public $defaultForm = 'RBooking_Form';
	
	public $defaultVoucher = 'RBooking_Voucher';
	
	public function __construct()
	{
		$this->setLayout('pjActionFront');
		
		self::allowCORS();
	}
	
	private function _get($key)
	{
		if ($this->_is($key))
		{
			return $_SESSION[$this->defaultStore][$key];
		}
		return false;
	}
	
	private function _is($key)
	{
		return isset($_SESSION[$this->defaultStore]) && isset($_SESSION[$this->defaultStore][$key]);
	}
	
	private function _set($key, $value)
	{
		$_SESSION[$this->defaultStore][$key] = $value;
		return $this;
	}

	private function _unset($key)
	{
		if ($this->_is($key))
		{
			unset($_SESSION[$this->defaultStore][$key]);
		}
		return $this;
	}

	public function afterFilter()
	{
		if (!$this->_get->check('hide') || ($this->_get->check('hide') && $this->_get->toInt('hide') !== 1) &&
			in_array($this->_get->toString('action'), array('pjActionSearch', 'pjActionCheckout', 'pjActionPreview', 'pjActionGetPaymentForm')))
		{
			$locale_arr = pjLocaleModel::factory()->select('t1.*, t2.file, t2.title')
				->join('pjBaseLocaleLanguage', 't2.iso=t1.language_iso', 'left')
				->where('t2.file IS NOT NULL')
				->orderBy('t1.sort ASC')->findAll()->getData();
			
			$this->set('locale_arr', $locale_arr);
		}
	}
	
	public function beforeFilter()
	{
		$bf = parent::beforeFilter();
	    if($this->_get->toInt('locale') > 0)
	    {
	        $_SESSION[$this->defaultLocale] = $this->_get->toInt('locale');
	        $this->loadSetFields(true);
	    }
	    return $bf;
	}
	
	public function beforeRender()
	{
		if ($this->_get->check('iframe'))
		{
			$this->setLayout('pjActionIframe');
		}
	}

	public function pjActionCaptcha()
	{
		$this->setAjax(true);

		header("Cache-Control: max-age=3600, private");
		$rand = $this->_get->toInt('rand') ?: rand(1, 9999);
		$patterns = 'app/web/img/button.png';
		if(!empty($this->option_arr['o_captcha_background_front']) && $this->option_arr['o_captcha_background_front'] != 'plain')
		{
			$patterns = PJ_INSTALL_PATH . $this->getConstant('pjBase', 'PLUGIN_IMG_PATH') . 'captcha_patterns/' . $this->option_arr['o_captcha_background_front'];
		}
		$Captcha = new pjCaptcha(PJ_INSTALL_PATH . $this->getConstant('pjBase', 'PLUGIN_WEB_PATH') . 'obj/arialbd.ttf', $this->defaultCaptcha, (int) $this->option_arr['o_captcha_length_front']);
		$Captcha->setImage($patterns)->setMode($this->option_arr['o_captcha_mode_front'])->init($rand);
		exit;
	}

	public function pjActionCheckCaptcha()
	{
		$this->setAjax(true);
		if (!$this->_get->check('captcha') || !$this->_get->toString('captcha') || strtoupper($this->_get->toString('captcha')) != $_SESSION[$this->defaultCaptcha]){
			echo 'false';
		}else{
			echo 'true';
		}
		exit;
	}

	public function pjActionCheckReCaptcha()
	{
		$this->setAjax(true);
		$verifyResponse = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret='.$this->option_arr['o_captcha_secret_key_front'].'&response='.$this->_get->toString('recaptcha'));
		$responseData = json_decode($verifyResponse);
		echo $responseData->success ? 'true': 'false';
		exit;
	}

	public function pjActionLocale()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if ($this->_get->toInt('locale_id'))
			{
				$this->pjActionSetLocale($this->_get->toInt('locale_id'));
				$this->loadSetFields(true);
			}
		}
		exit;
	}
	private function pjActionSetLocale($locale)
	{
		if ((int) $locale > 0)
		{
			$_SESSION[$this->defaultLocale] = (int) $locale;
		}
		return $this;
	}
	
	public function pjActionGetLocale()
	{
		return isset($_SESSION[$this->defaultLocale]) && (int) $_SESSION[$this->defaultLocale] > 0 ? (int) $_SESSION[$this->defaultLocale] : FALSE;
	}
	
	public function pjActionLoadCss()
	{
		$dm = new pjDependencyManager(PJ_INSTALL_PATH, PJ_THIRD_PARTY_PATH);
		$dm->load(PJ_CONFIG_PATH . 'dependencies.php')->resolve();
	
		$theme = $fonts = $this->option_arr['o_theme'];
		if(in_array($this->_get->toString('theme'), array('theme1', 'theme2', 'theme3', 'theme4', 'theme5', 'theme6', 'theme7', 'theme8', 'theme9', 'theme10')))
		{
			$theme = $fonts = $this->_get->toString('theme');
		}
		$arr = array(
				array('file' => 'bootstrap-datetimepicker.min.css', 'path' => $dm->getPath('pj_bootstrap_datetimepicker')),
				array('file' => 'style.css', 'path' => PJ_CSS_PATH),
				array('file' => "$fonts.css", 'path' => PJ_CSS_PATH . "fonts/"),
				array('file' => "$theme.css", 'path' => PJ_CSS_PATH . "themes/"),
				array('file' => 'transitions.css', 'path' => PJ_CSS_PATH)
		);
		header("Content-Type: text/css; charset=utf-8");
		foreach ($arr as $item)
		{
			ob_start();
			@readfile($item['path'] . $item['file']);
			$string = ob_get_contents();
			ob_end_clean();

			if ($string !== FALSE)
			{
				echo str_replace(
						array('../fonts/glyphicons', "pjWrapper"),
						array(
								PJ_INSTALL_URL . PJ_FRAMEWORK_LIBS_PATH . 'pj/fonts/glyphicons',
								"pjWrapperRestaurant_" . $theme
						),
						$string
				) . "\n";
			}
		}
		exit;
	}
	
	public function pjActionLoad()
	{
		ob_start();
		header("Content-Type: text/javascript; charset=utf-8");
	}
	
	private function pjCheckWTime()
	{
		$date = pjDateTime::formatDate($this->_get('date'), $this->option_arr['o_date_format']);
		$wt_arr = self::getWorkingTime($date);
		$previous_date = date('Y-m-d', strtotime($date) - 86400);
		$next_date = date('Y-m-d', strtotime($date) + 86400);
		$previous_wt_arr = self::getWorkingTime($previous_date);
		$next_wt_arr = self::getWorkingTime($next_date);
		$_time = date('H:i:s', strtotime($this->_get('time')));
		$ts = strtotime($date . ' ' . $_time);
		$offset = 0;
		if ($wt_arr !== false)
		{
			$offset = pjUtil::getOffset($wt_arr);
		}
		$play = $this->option_arr['o_booking_earlier'] * 60;
		
		if ($wt_arr === false)
		{
			$status = 300;
		} else {
			$stime = $ts;
			$wt_arr['end_ts'] += $offset * 3600;
			if(time() + $play > $ts)
			{
			    if($play == 0)
			    {
			        $status = 304;
			    }else{
			        $status = 301;
			    }
			}else{
			    if($ts < $wt_arr['start_ts'])
			    {
			        if($previous_wt_arr['start_ts'] > $previous_wt_arr['end_ts'])
			        {
			            $previous_wt_arr['end_ts'] += 86400;
			            if($previous_wt_arr['end_ts'] >= $wt_arr['start_ts'])
			            {
			                $status = 200;
			            }else{
			                if($previous_wt_arr['end_ts'] < $ts + $this->option_arr['o_booking_length'] * 60)
			                {
			                    $status = 303;
			                }else{
			                    $status = 200;
			                }
			            }
			        }else{
			            $status = 302;
			        }
			    }elseif(($wt_arr['end_ts'] < $ts + $this->option_arr['o_booking_length'] * 60)) {
			        if($next_wt_arr !== false)
			        {
			            if($next_wt_arr['start_ts'] <= $wt_arr['end_ts'])
			            {
    			            if($ts + $this->option_arr['o_booking_length'] * 60 >= $next_wt_arr['start_ts'])
    			            {
    			                $status = 200;
    			            }else{
    			                $status = 303;
    			            }
			            }else{
			                $status = 303;
			            }
			        }else{
			        	$status = 303;
			        }
			    }else{
			        $status = 200;
			    }
			}
		}
		return $status;
	}
	
	private function pjCheckAvailability($start_time, $people, $use_map, $status)
	{
		$result = array();
		if($people !== false && (int) $people > 0)
		{
			$booking_length = $this->option_arr['o_booking_length'] * 60;
			$end_time = date('Y-m-d H:i:s',strtotime($start_time) + $booking_length);
			
			$sub_query = sprintf("(SELECT COUNT(`table_id`)
									FROM `%1\$s`
									WHERE `table_id` = `t1`.`id`
									AND `booking_id` IN (SELECT `id` FROM `%2\$s` WHERE (
										(`dt` <= '%3\$s' AND '%3\$s' < `dt_to`)
										OR (`dt_to` >= '%4\$s' AND '%4\$s' > `dt`)
									) AND (`status` = 'confirmed' OR (`status`='pending' AND UNIX_TIMESTAMP(`created`) >= UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL %5\$u MINUTE))) ))
									LIMIT 1)",
									pjBookingTableModel::factory()->getTable(),
									pjBookingModel::factory()->getTable(),
									$start_time, 
									$end_time,
									(int) $this->option_arr['o_min_hour']
								);
			$table_arr = pjTableModel::factory()->select("t1.*, $sub_query AS booked")->findAll()->getData();
			
			$passed = false;
			$result['avail_tables'] = 0;
			$result['action'] = 'table';
			$table_id = 0;
			
			foreach ($table_arr as $table)
			{
				if((int) $table['booked'] === 0)
				{
					$passed = true;
					if((int) $people <= (int) $table['seats'] && (int) $people >= (int) $table['minimum'])
					{
						$result['avail_tables']++;
						if($status == 200 && $table_id == 0 && $use_map == 0)
						{
							$table_id = $table['id'];
							$this->_set('table_id', $table['id']);
						}
					}
				}
			}
			if($passed == true)
			{
				if($result['avail_tables'] == 0)
				{
					$result['action'] = 'enquiry';
				}else{
					if($table_id != 0)
					{
						$result['action'] = 'checkout';
					}else{
						$result['action'] = 'table';
					}
				}
			}
			
			$result['passed'] = $passed;
			$result['table_arr'] = $table_arr;
		}else{
			$result['passed'] = true;
		}
		return $result;
	}
	
	public function pjActionAddPromo()
	{
		$this->setAjax(true);
		
		if ($this->isXHR())
		{
			$result = array('status' => 'ERR', 'code' => 100);

			if (pjObject::getPlugin('pjVouchers') !== NULL)
			{
				$result = pjVoucherModel::factory()->getVoucher($this->_get->toString('code'), date("Y-m-d", $this->_get('actual_datetime')), date("H:i:s", $this->_get('actual_datetime')));
			}

			if ($result['status'] == 'OK')
			{
				$resp = self::getPrice($this->option_arr, date("Y-m-d", $this->_get('actual_datetime')), date("H:i:s", $this->_get('actual_datetime')), $this->_get->toString('code'));
				$resp['code'] = $result['code'];
				$this->_set('code', $this->_get->toString('code'));

				if (isset($resp['discount_formatted']))
				{
					$resp['discount_text'] = $resp['discount_formatted'] . " " . __('front_label_discount', true, false);
				}
			}
			else
			{
				$resp = self::getPrice($this->option_arr, date("Y-m-d", $this->_get('actual_datetime')), date("H:i:s", $this->_get('actual_datetime')));
				$resp['code'] = $result['code'];
				$this->_unset('code');
			}

			self::jsonResponse($resp);
		}
	}
	
	public function pjActionRemovePromo()
	{
		$this->setAjax(true);
		
		if ($this->isXHR())
		{
			if ($this->_is('code'))
			{
				unset($_SESSION[$this->defaultStore]['code']);
			}
			$resp = self::getPrice($this->option_arr, date("Y-m-d", $this->_get('actual_datetime')), date("H:i:s", $this->_get('actual_datetime')));
			$resp['code'] = 200;
			self::jsonResponse($resp);
		}
	}
	
	public function pjActionGetWTime()
	{
		$this->setAjax(true);
		
		if ($this->isXHR())
		{
			$this->_set('date', $this->_get->toString('date'));
			$date = pjDateTime::formatDate($this->_get('date'), $this->option_arr['o_date_format']);
			$previous_date = date('Y-m-d', strtotime($date) - 86400);
			if($this->_is('table_id'))
			{
				unset($_SESSION[$this->defaultStore]['table_id']);
			}
			$this->set('wt_arr', self::getWorkingTime($date));
			$this->set('previous_wt_arr', self::getWorkingTime($previous_date));
		}
	}

	public function pjActionCheckAvail()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$resp = array();
			
			if($this->_post->check('step'))
			{
				if($this->_post->check('time'))
				{
					$this->_set('time', $this->_post->toString('time'));
				}
				if($this->_post->check('date'))
				{
					$this->_set('date', $this->_post->toString('date'));
				}
				if($this->_post->check('people'))
				{
					$this->_set('people', $this->_post->toInt('people'));
				}
				if ($this->_get('date_format') != $this->option_arr['o_date_format'])
				{
					$this->_set('date', pjDateTime::formatDate($this->_get('date'), $this->_get('date_format'), $this->option_arr['o_date_format']));
					$this->_set('date_format', $this->option_arr['o_date_format']);
				}
				$date = pjDateTime::formatDate($this->_get('date'), $this->option_arr['o_date_format']);
				$wt_arr = self::getWorkingTime($date);  
				$offset = 0;
				if ($wt_arr !== false)
				{
					$offset = pjUtil::getOffset($wt_arr);
				}
				$status = $this->pjCheckWTime();
				$_date = pjDateTime::formatDate($this->_get('date'), $this->option_arr['o_date_format']);
				$_time = date('H:i:s', strtotime($this->_get('time')));
				$start_time = $_date . " " . $_time;
				
				if($wt_arr != false)
				{
					$check_result = $this->pjCheckAvailability($start_time, $this->_get('people'), $this->option_arr['o_use_map'], $status);
					if($check_result['action'] == 'enquiry' && $this->_is('table_id'))
					{
						unset($_SESSION[$this->defaultStore]['table_id']);
					}
					$this->_set('check_result', $check_result);
					$resp['code'] = 200;
				}else{
					if($this->_is('table_id'))
					{
						unset($_SESSION[$this->defaultStore]['table_id']);
					}
					$resp['code'] = 100;
				}
			}else{
				$resp['code'] = 100;
			}
			self::jsonResponse($resp);
		}
	}
	
	public function pjActionSearch()
	{
		$this->setAjax(true);
		
		if ($this->isXHR() || $this->_get->check('_escaped_fragment_'))
		{
			if (!isset($_SESSION[$this->defaultStore]) || count($_SESSION[$this->defaultStore]) === 0)
			{
				$_SESSION[$this->defaultStore] = array();
			
				$this->_set('people', 1);
				$this->_set('date', pjDateTime::formatDate(date('Y-m-d', time() + 86400), "Y-m-d", $this->option_arr['o_date_format']));
				$this->_set('date_format', $this->option_arr['o_date_format']);
			}
			$date = pjDateTime::formatDate($this->_get('date'), $this->option_arr['o_date_format']);
			$previous_date = date('Y-m-d', strtotime($date) - 86400);
			$wt_arr = self::getWorkingTime($date);
			$previous_wt_arr = self::getWorkingTime($previous_date);
			
			if ($wt_arr !== false)
			{
				$this->set('wt_arr', $wt_arr);
			}
			if ($previous_wt_arr !== false)
			{
				$this->set('previous_wt_arr', $previous_wt_arr);
			}
		}
	}
	public function pjActionTables()
	{
		$this->setAjax(true);
	
		if ($this->isXHR() || $this->_get->check('_escaped_fragment_'))
		{
			if (!isset($_SESSION[$this->defaultStore]) || empty($_SESSION[$this->defaultStore]))
			{
				self::jsonResponse(array('status' => 'ERR', 'code' => 100));
			}
			$check_result = $this->_get('check_result');
			$_date = pjDateTime::formatDate($this->_get('date'), $this->option_arr['o_date_format']);
			$_time = date('H:i:s', strtotime($this->_get('time')));
			$start_time = $_date . " " . $_time;

			$previous_date = date('Y-m-d', strtotime($_date) - 86400);
			
			$wt_arr = self::getWorkingTime($_date);
			$previous_wt_arr = self::getWorkingTime($previous_date);
			$offset = 0;
			if ($wt_arr !== false)
			{
				$offset = pjUtil::getOffset($wt_arr);
				$this->set('wt_arr', $wt_arr);
			}
			if ($previous_wt_arr !== false)
			{
				$this->set('previous_wt_arr', $previous_wt_arr);
			}
			
			$stime = strtotime($start_time);
			$this->_set('actual_datetime', $stime);
			
			if($check_result['action'] == 'enquiry')
			{
				self::jsonResponse(array('status' => 'ERR', 'code' => 101));
			}
			if($check_result['action'] == 'checkout')
			{
				self::jsonResponse(array('status' => 'ERR', 'code' => 102));
			}
			
			$status = $this->pjCheckWTime();
			
			$time = date($this->option_arr['o_time_format'], $stime);
			$title_str = __('front_available_tables_for', true, false);
			$title_str = sprintf($title_str, $this->_get('people'), date($this->option_arr['o_date_format'], $stime), $time);
			
			$this->set('status', $status);
			$this->set('people', $this->_get('people'));
			$this->set('title_str', $title_str);
			$this->set('check_result', $check_result);
		}
	}
	
	public function pjActionAddTable()
	{
		$this->setAjax(true);
		
		if ($this->isXHR())
		{
			$this->_set('table_id', $this->_get->toInt('table_id'));
			$resp = array('code' => 200);
			self::jsonResponse($resp);
		}
	}
	
	public function pjActionRemoveTable()
	{
		$this->setAjax(true);
		
		if ($this->isXHR())
		{
			if($this->_is('table_id'))
			{
				unset($_SESSION[$this->defaultStore]['table_id']);
			}
			$resp = array('code' => 200);
			self::jsonResponse($resp);
		}
	}
	
	public function pjActionCheckout()
	{
		$this->setAjax(true);
		
		if ($this->isXHR() || $this->_get->check('_escaped_fragment_'))
		{
			if (isset($_SESSION[$this->defaultStore]) && count($_SESSION[$this->defaultStore]) > 0)
			{
				$table_id = $this->_get('table_id');
				if ($table_id !== false && (int) $table_id > 0)
				{
					$this->set('table', pjTableModel::factory()->find($table_id)->getData());
				}
				
				$country_arr = pjBaseCountryModel::factory()
							->select('t1.id, t2.content AS country_title')
							->join('pjBaseMultiLang', "t2.model='pjBaseCountry' AND t2.foreign_id=t1.id AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
							->where('status', 'T')
							->orderBy('`country_title` ASC')->findAll()->getData();
							
				$date = pjDateTime::formatDate($this->_get('date'), $this->option_arr['o_date_format']);
				$code = $this->_is('code') ? $this->_get('code') : NULL;
					
				$resp = self::getPrice($this->option_arr, date("Y-m-d", $this->_get('actual_datetime')), date("H:i:s", $this->_get('actual_datetime')), $code);
				if (isset($resp['discount_formatted']))
				{
					$resp['discount_text'] = $resp['discount_formatted'] . " " . __('front_label_discount', true, false);
				}else{
					if($this->_is('code'))
					{
						unset($_SESSION[$this->defaultStore]['code']);
					}
				}
				
				$terms_key = 'o_terms';
				if($_SESSION[$this->defaultStore]['check_result']['action'] == 'enquiry')
				{
					$terms_key = 'o_enquiry';
				}
				
				$terms_conditions = pjMultiLangModel::factory()->select('t1.content')
												 ->where('t1.model','pjOption')
												 ->where('t1.locale', $this->getLocaleId())
												 ->where('t1.field', $terms_key)
												 ->limit(1)
												 ->findAll()->getDataIndex(0);
	
				$this->set('country_arr', $country_arr);
				$this->set('price_arr', $resp);
				$this->set('terms_conditions', $terms_conditions['content']);
				$this->set('wt_arr', self::getWorkingTime($date));

				if ($this->option_arr['o_allow_bank'] == 'Yes')
				{
					$bank_account = pjMultiLangModel::factory()->select('t1.content')
													 ->where('t1.model','pjOption')
													 ->where('t1.locale', $this->getLocaleId())
													 ->where('t1.field', 'o_bank_account')
													 ->limit(1)
													 ->findAll()->getDataIndex(0);
					$this->set('bank_account', $bank_account['content']);
				}

				if(pjObject::getPlugin('pjPayments') !== NULL)
				{
					$this->set('payment_option_arr', pjPaymentOptionModel::factory()->getOptions(NULL));
					$this->set('payment_titles', pjPayments::getPaymentTitles($this->getForeignId(), $this->getLocaleId()));
				}
				else
				{
					$this->set('payment_titles', __('payment_methods', true));
				}
				$this->set('status', 'OK');
			}else{
				$this->set('status', 'ERR');
			}
		}
	}
	
	public function pjActionSaveForm()
	{
		$this->setAjax(true);
		
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'Invalid request.'));
		}
		
		if (!isset($_SESSION[$this->defaultForm]) || count($_SESSION[$this->defaultForm]) === 0)
		{
			$_SESSION[$this->defaultForm] = array();
		}
		
		if (!$this->_post->check('step_checkout'))
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Missing, empty or invalid form data.'));
		}
		
		# Validate form
		$map = array(
			'o_bf_include_title' => 'c_title',
			'o_bf_include_fname' => 'c_fname',
			'o_bf_include_lname' => 'c_lname',
			'o_bf_include_email' => 'c_email',
			'o_bf_include_phone' => 'c_phone',
			'o_bf_include_company' => 'c_company',
			'o_bf_include_address' => 'c_address',
			'o_bf_include_country' => 'c_country',
			'o_bf_include_state' => 'c_state',
			'o_bf_include_city' => 'c_city',
			'o_bf_include_zip' => 'c_zip',
			'o_bf_include_notes' => 'c_notes',
			'o_bf_include_captcha' => 'captcha',
			'o_bf_include_terms' => 'agreement',
		);
		
		$STORE = $_SESSION[$this->defaultStore];
		
		if (isset($STORE['table_id']) 
			&& $this->option_arr['o_payment_disable'] == 'No' 
			&& (float) $this->option_arr['o_booking_price'] > 0 
		)
		{
			$code = $this->_is('code') ? $this->_get('code') : NULL;
			$price_arr = self::getPrice($this->option_arr, date("Y-m-d", $this->_get('actual_datetime')), date("H:i:s", $this->_get('actual_datetime')), $code);
			
			if ((float) $price_arr['price'] > 0)
			{
				$map['o_bf_include_promo'] = 'promo_code';
			}
		}
		
		foreach ($map as $key => $idx)
		{
			$check = true;
			
			if ($this->option_arr[$key] == 2)
			{
				$check = $this->_post->has($idx);
				
			} elseif ($this->option_arr[$key] == 3) {
				
				$check = $this->_post->has($idx) && !$this->_post->isEmpty($idx);
			}
			
			if ($idx == 'c_email' && $this->_post->has($idx) && !$this->_post->isEmpty($idx))
			{
				if (!pjValidation::pjActionEmail($this->_post->toString($idx)))
				{
					$check = false;
				}
			}
			
			if (!$check)
			{
				self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Missing, empty or invalid form data.'));
			}
		}
		
		# Validate captcha
		if ($this->option_arr['o_bf_include_captcha'] == 3 && $this->option_arr['o_captcha_type_front'] == 'system')
		{
			if (!pjCaptcha::validate($this->_post->raw('captcha'), $_SESSION[$this->defaultCaptcha]))
			{
				# Invalid captcha
				self::jsonResponse(array('status' => 'ERR', 'code' => 104, 'text' => 'Captcha doesn\'t match.'));
			}
			
			# Clear valid captcha
			$_SESSION[$this->defaultCaptcha] = NULL;
			unset($_SESSION[$this->defaultCaptcha]);
		}
		
		$data = array();
		$data['c_title'] = $this->_post->toString('c_title') ?: null;
		$data['c_fname'] = $this->_post->toString('c_fname') ?: null;
		$data['c_lname'] = $this->_post->toString('c_lname') ?: null;
		$data['c_email'] = $this->_post->toString('c_email') ?: null;
		$data['c_phone'] = $this->_post->toString('c_phone') ?: null;
		$data['c_company'] = $this->_post->toString('c_company') ?: null;
		$data['c_notes'] = $this->_post->toString('c_notes') ?: null;
		$data['c_address'] = $this->_post->toString('c_address') ?: null;
		$data['c_city'] = $this->_post->toString('c_city') ?: null;
		$data['c_state'] = $this->_post->toString('c_state') ?: null;
		$data['c_zip'] = $this->_post->toString('c_zip') ?: null;
		$data['c_country'] = $this->_post->toInt('c_country') ?: null;
		$data['promo_code'] = $this->_post->toString('promo_code') ?: null;
		$data['payment_method'] = $this->_post->toString('payment_method') ?: null;
		$data['cc_type'] = $this->_post->toString('cc_type') ?: null;
		$data['cc_num'] = $this->_post->toString('cc_num') ?: null;
		$data['cc_code'] = $this->_post->toString('cc_code') ?: null;
		$data['cc_exp_month'] = $this->_post->toString('cc_exp_month') ?: null;
		$data['cc_exp_year'] = $this->_post->toString('cc_exp_year') ?: null;

		$_SESSION[$this->defaultForm] = $data;
		
		self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Form has been saved.'));
	}
	
	public function pjActionPreview()
	{
		$this->setAjax(true);
		
		if ($this->isXHR() || $this->_get->check('_escaped_fragment_'))
		{
			if (isset($_SESSION[$this->defaultForm]) && count($_SESSION[$this->defaultForm]) > 0)
			{
				$table_id = $this->_get('table_id');
				if ($table_id !== false && (int) $table_id > 0)
				{
					$this->set('table', pjTableModel::factory()->find($table_id)->getData());
				}
				
				$country_arr = array();
				if(isset($_SESSION[$this->defaultForm]['c_country']) && !empty($_SESSION[$this->defaultForm]['c_country'])){
					
					$country_arr = pjBaseCountryModel::factory()
								->select('t1.id, t2.content AS country_title')
								->join('pjBaseMultiLang', "t2.model='pjBaseCountry' AND t2.foreign_id=t1.id AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
								->find($_SESSION[$this->defaultForm]['c_country'])->getData();
				}
							
				$date = pjDateTime::formatDate($this->_get('date'), $this->option_arr['o_date_format']);
				$code = $this->_is('code') ? $this->_get('code') : NULL;
							
				$resp = self::getPrice($this->option_arr, date("Y-m-d", $this->_get('actual_datetime')), date("H:i:s", $this->_get('actual_datetime')), $code);
				if (isset($resp['discount_formatted']))
				{
					$resp['discount_text'] = $resp['discount_formatted'] . " " . __('front_label_discount', true, false);
				}
	
				$this->set('country_arr', $country_arr);
				$this->set('price_arr', $resp);
				$this->set('wt_arr', self::getWorkingTime($date));

				if(pjObject::getPlugin('pjPayments') !== NULL)
				{
					$this->set('payment_option_arr', pjPaymentOptionModel::factory()->getOptions(NULL));
					$this->set('payment_titles', pjPayments::getPaymentTitles($this->getForeignId(), $this->getLocaleId()));
				}
				else
				{
					$this->set('payment_titles', __('payment_methods', true));
				}

				if ($this->option_arr['o_allow_bank'] == 'Yes')
				{
					$bank_account = pjMultiLangModel::factory()->select('t1.content')
													 ->where('t1.model','pjOption')
													 ->where('t1.locale', $this->getLocaleId())
													 ->where('t1.field', 'o_bank_account')
													 ->limit(1)
													 ->findAll()->getDataIndex(0);
					$this->set('bank_account', $bank_account['content']);
				}
				
				$this->set('status', 'OK');
			}else{
				$this->set('status', 'ERR');
			}
		}
	}
	
	public function pjActionSaveBooking()
	{
		$this->setAjax(true);
		
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 110, 'text' => 'Missing headers.'));
		}
		
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 111, 'text' => 'Invalid request.'));
		}
		
		$FORM = $_SESSION[$this->defaultForm];
		
		# Validate form
		$map = array(
			'o_bf_include_title' => 'c_title',
			'o_bf_include_fname' => 'c_fname',
			'o_bf_include_lname' => 'c_lname',
			'o_bf_include_email' => 'c_email',
			'o_bf_include_phone' => 'c_phone',
			'o_bf_include_company' => 'c_company',
			'o_bf_include_address' => 'c_address',
			'o_bf_include_country' => 'c_country',
			'o_bf_include_state' => 'c_state',
			'o_bf_include_city' => 'c_city',
			'o_bf_include_zip' => 'c_zip',
			'o_bf_include_notes' => 'c_notes',
		);
		
		$STORE = $_SESSION[$this->defaultStore];
		
		if (isset($STORE['table_id'])
			&& $this->option_arr['o_payment_disable'] == 'No'
			&& (float) $this->option_arr['o_booking_price'] > 0
		)
		{
			$code = $this->_is('code') ? $this->_get('code') : NULL;
			$price_arr = self::getPrice($this->option_arr, date("Y-m-d", $this->_get('actual_datetime')), date("H:i:s", $this->_get('actual_datetime')), $code);
			
			if ((float) $price_arr['price'] > 0)
			{
				$map['o_bf_include_promo'] = 'promo_code';
			}
		}
		
		foreach ($map as $key => $idx)
		{
			$check = true;
			
			if ($this->option_arr[$key] == 2)
			{
				$check = array_key_exists($idx, $FORM);
				
			} elseif ($this->option_arr[$key] == 3) {
				
				$check = array_key_exists($idx, $FORM) && !empty($FORM[$idx]);
			}
			
			if ($idx == 'c_email' && array_key_exists($idx, $FORM) && !empty($FORM[$idx]))
			{
				if (!pjValidation::pjActionEmail($FORM[$idx]))
				{
					$check = false;
				}
			}
			
			if (!$check)
			{
				self::jsonResponse(array('status' => 'ERR', 'code' => 112, 'text' => 'Missing, empty or invalid form data.', 'idx' => $idx));
			}
		}
		
		$pjBookingModel = pjBookingModel::factory();
		$pjBookingTableModel = pjBookingTableModel::factory();
		
		$data = array();
		
		$data['status'] = $this->option_arr['o_booking_status'];
		
		$code = $this->_is('code') ? $this->_get('code') : NULL;
		
		$booking_length = $this->option_arr['o_booking_length'] * 60;
		$opts = self::getPrice($this->option_arr, date("Y-m-d", $this->_get('actual_datetime')), date("H:i:s", $this->_get('actual_datetime')), $code);
		$data['total']   = $opts['total'];
		$data['dt'] = date("Y-m-d H:i:s", $this->_get('actual_datetime'));
		$data['dt_to'] = date("Y-m-d H:i:s", strtotime($data['dt']) + $booking_length);
		$data['uuid'] = time();
		$data['locale_id'] = $this->getLocaleId();
		$data['ip'] = $_SERVER['REMOTE_ADDR'];

		if ($this->_is('table_id'))
		{
			$start_time = $this->_get('actual_datetime');
			$end_time = $this->_get('actual_datetime') + $booking_length;
			
			$cnt_tables = $pjBookingTableModel
				->where("t1.table_id", $this->_get('table_id'))
				->where("(t1.`booking_id` IN (SELECT `id` FROM `".$pjBookingModel->getTable()."` WHERE (
									(UNIX_TIMESTAMP(`dt`) <= '$end_time' AND UNIX_TIMESTAMP(`dt`) > '$start_time')
									OR (UNIX_TIMESTAMP(`dt_to`) <= '$end_time' AND UNIX_TIMESTAMP(`dt_to`) > '$start_time')
								) AND (`status` = 'confirmed' OR (`status`='pending' AND UNIX_TIMESTAMP(`created`) >= UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL ".$this->option_arr['o_min_hour']." MINUTE))) )))")
				->findCount()
				->getData();
			if($cnt_tables > 0)
			{	
				unset($_SESSION[$this->defaultStore]['table_id']);
				self::jsonResponse(array('status' => 'ERR', 'code' => 300, 'text' => ''));
			}
		}
		
		$payment = 'none';
		if(isset($FORM['payment_method']))
		{
			if ($FORM['payment_method'] && $FORM['payment_method'] == 'creditcard')
			{
				$data['cc_exp'] = $FORM['cc_exp_year'] . '-' . $FORM['cc_exp_month'];
			}
			
			if ($FORM['payment_method']){
				$payment = $FORM['payment_method'];
			}
		}
		
		$data = array_merge($FORM, $STORE, $data);
		
		$table_id = $this->_get('table_id');
		if ($_SESSION[$this->defaultStore]['check_result']['action'] == 'enquiry')
		{
			$data['status'] = 'enquiry';
		}
		
		$booking_id = $pjBookingModel->setAttributes($data)->insert()->getInsertId();
		if (!$booking_id)
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Booking has not been saved.'));
		}
		
		$booking_arr = $pjBookingModel->reset()->find($booking_id)->getData();
		if ($table_id !== false && (int) $table_id > 0)
		{
			$pjBookingTableModel->reset()->setAttributes(array('booking_id' => $booking_id, 'table_id' => $table_id))->insert();
			if (count($booking_arr) > 0)
			{
				$booking_arr['table_arr'] = $pjBookingTableModel->reset()->select("t1.*, t2.name")
												->join('pjTable', 't1.table_id = t2.id')
												->where('t1.booking_id', $booking_id)
												->findAll()->getData();
									
			}
			$op = 'confirmation';
			$json = array('status' => 'OK', 'code' => 200, 'text' => 'Booking has been saved.', 'booking_id' => $booking_id, 'payment' => $payment);
		}else{
			$booking_arr['table_arr'] = array();
			$op = 'enquiry';
			$json = array('status' => 'OK', 'code' => 201, 'text' => 'Booking has been saved.', 'booking_id' => $booking_id, 'payment' => $payment);
		}
		
		$this->sendNotifications($booking_arr, $op);
		
		unset($_SESSION[$this->defaultStore]);
		unset($_SESSION[$this->defaultForm]);
		unset($_SESSION[$this->firstLoad]);
		
		self::jsonResponse($json);
	}
	
	protected function sendNotifications($booking_arr, $variant)
	{
		$pjEmail = self::getMailer($this->option_arr);
		
		$locale_id = isset($booking_arr['locale_id']) && (int) $booking_arr['locale_id'] > 0 ? $booking_arr['locale_id'] : $this->getLocaleId();
		
		$data = self::getTokens($this->option_arr, $booking_arr, $locale_id, false);
		
		$pjNotificationModel = pjNotificationModel::factory();
		$notifications = $pjNotificationModel
			->select("t1.*, CONCAT_WS('_', t1.recipient, t1.transport, t1.variant) AS `index`")
			->findAll()
			->getDataPair('index');
		
		if ($notifications)
		{
			$i18n = pjBaseMultiLangModel::factory()
				->whereIn('t1.foreign_id', $pjNotificationModel->getDataPair(null, 'id'))
				->where('t1.model', 'pjNotification')
				->findAll()
				->getData();
			
			foreach ($notifications as &$notification)
			{
				$notification['i18n'] = array();
				foreach ($i18n as $item)
				{
					if ($notification['id'] == $item['foreign_id'])
					{
						$notification['i18n'][$item['locale']][$item['field']] = $item['content'];
					}
				}
			}
		}
		
		$index = sprintf('client_email_%s', $variant);
		if (@$notifications[$index]['is_active']
			&& @$notifications[$index]['i18n'][$locale_id]['subject']
			&& @$notifications[$index]['i18n'][$locale_id]['message'])
		{
			$message = str_replace($data['search'], $data['replace'], $notifications[$index]['i18n'][$locale_id]['message']);
			$pjEmail
				->setTo($booking_arr['c_email'])
				->setSubject($notifications[$index]['i18n'][$locale_id]['subject'])
				->send(pjUtil::textToHtml($message));
		}
		
		$index = sprintf('admin_email_%s', $variant);
		if (@$notifications[$index]['is_active']
			&& @$notifications[$index]['i18n'][$locale_id]['subject']
			&& @$notifications[$index]['i18n'][$locale_id]['message'])
		{
			$message = str_replace($data['search'], $data['replace'], $notifications[$index]['i18n'][$locale_id]['message']);
			$pjEmail
				->setTo(self::getAdminEmail())
				->setSubject($notifications[$index]['i18n'][$locale_id]['subject'])
				->send(pjUtil::textToHtml($message));
		}
	}
	
	public function pjActionGetPaymentForm()
	{
		$this->setAjax(true);
		
		if ($this->isXHR())
		{
			$booking_arr = pjBookingModel::factory()->select('t1.*')->find($this->_get->toInt('booking_id'))->getData();

			if(pjObject::getPlugin('pjPayments') !== NULL)
			{
				$pjPlugin = pjPayments::getPluginName($booking_arr['payment_method']);
				if(pjObject::getPlugin($pjPlugin) !== NULL)
				{
					$this->set('params', $pjPlugin::getFormParams(array('payment_method' => $booking_arr['payment_method']), array(
							'locale_id'	 => $this->getLocaleId(),
							'return_url'	=> $this->option_arr['o_thank_you_page'],
							'id'			=> $booking_arr['id'],
							'foreign_id'	=> NULL,
							'uuid'		  => $booking_arr['uuid'],
							'name'		  => $booking_arr['c_fname'] . ' ' . $booking_arr['c_lname'],
							'email'		 => $booking_arr['c_email'],
							'phone'		 => $booking_arr['c_phone'],
							'amount'		=> $booking_arr['total'],
							'cancel_hash'   => sha1($booking_arr['uuid'].strtotime($booking_arr['created']).PJ_SALT),
							'currency_code' => $this->option_arr['o_currency'],
					)));
				}

				if ($booking_arr['payment_method'] == 'bank')
				{
					$bank_account = pjMultiLangModel::factory()->select('t1.content')
													 ->where('t1.model','pjOption')
													 ->where('t1.locale', $this->getLocaleId())
													 ->where('t1.field', 'o_bank_account')
													 ->limit(1)
													 ->findAll()->getDataIndex(0);
					$this->set('bank_account', $bank_account['content']);
				}
			}

			$this->set('booking_arr', $booking_arr);
		}
	}

	public function pjActionConfirm()
	{
		$this->setAjax(true);

		if (pjObject::getPlugin('pjPayments') === NULL)
		{
			$this->log('pjPayments plugin not installed');
			exit;
		}

		$pjPayments = new pjPayments();
		if($pjPlugin = $pjPayments->getPaymentPlugin($_REQUEST))
		{
			if($uuid = $this->requestAction(array('controller' => $pjPlugin, 'action' => 'pjActionGetCustom', 'params' => $_REQUEST), array('return')))
			{
				$pjBookingModel = pjBookingModel::factory();

				$booking_arr = $pjBookingModel->select("t1.*, t3.name")
					->join('pjBookingTable', 't1.id = t2.booking_id')
					->join('pjTable', 't2.table_id = t3.id')
					->where('t1.uuid', $uuid)->limit(1)->findAll()->getDataIndex(0);
				if (!empty($booking_arr))
				{
					$params = array(
							'request'		=> $_REQUEST,
							'payment_method' => $_REQUEST['payment_method'],
							'foreign_id'	 => NULL,
							'amount'		 => $booking_arr['total'],
							'txn_id'		 => $booking_arr['txn_id'],
							'order_id'	   => $booking_arr['id'],
							'cancel_hash'	=> sha1($booking_arr['uuid'].strtotime($booking_arr['created']).PJ_SALT),
							'key'			=> md5($this->option_arr['private_key'] . PJ_SALT)
					);
					$response = $this->requestAction(array('controller' => $pjPlugin, 'action' => 'pjActionConfirm', 'params' => $params), array('return'));
					if($response['status'] == 'OK')
					{
						$this->log("Payments | {$pjPlugin} plugin<br>Reservation was confirmed. UUID: {$uuid}");
						$pjBookingModel
							->reset()
							->set('id', $booking_arr['id'])
							->modify(array(
								'status' => $this->option_arr['o_payment_status'],
								'txn_id' => $response['txn_id'],
								'is_paid' => 'T',
								'processed_on' => ':NOW()'
						));

						$booking_arr['table_arr'] = pjBookingTableModel::factory()
							->select("t1.*, t2.name")
							->join('pjTable', 't1.table_id = t2.id')
							->where('t1.booking_id', $booking_arr['id'])
							->findAll()->getData();

						$this->sendNotifications($booking_arr, 'payment');

						echo $this->option_arr['o_thank_you_page'];
						exit;
					}elseif($response['status'] == 'CANCEL'){
						$this->log("Payments | {$pjPlugin} plugin<br>Payment was cancelled. UUID: {$uuid}");
						$pjBookingModel
							->reset()
							->set('id', $booking_arr['id'])
							->modify(array('status' => 'cancelled', 'processed_on' => ':NOW()'));

						$booking_arr['table_arr'] = pjBookingTableModel::factory()
							->select("t1.*, t2.name")
							->join('pjTable', 't1.table_id = t2.id')
							->where('t1.booking_id', $booking_arr['id'])
							->findAll()->getData();

						$this->sendNotifications($booking_arr, 'cancel');

						echo $this->option_arr['o_thank_you_page'];
						exit;
					}else{
						$this->log("Payments | {$pjPlugin} plugin<br>Reservation confirmation was failed. UUID: {$uuid}");
					}

					if(isset($response['redirect']) && $response['redirect'] == true)
					{
						echo $this->option_arr['o_thank_you_page'];
						exit;
					}
				}else{
					$this->log("Payments | {$pjPlugin} plugin<br>Reservation with UUID {$uuid} not found.");
				}
				echo $this->option_arr['o_thank_you_page'];
				exit;
			}
		}

		echo $this->option_arr['o_thank_you_page'];
		exit;
	}
	
	public function pjActionCancel()
	{
		$this->setLayout('pjActionEmpty');
		
		$pjBookingModel = pjBookingModel::factory();
		
		if ($this->_post->check('booking_cancel'))
		{
			$booking_arr = $pjBookingModel->find($this->_post->toInt('id'))->getData();
			if (count($booking_arr) > 0)
			{
				$statement = sprintf("UPDATE `%s` SET `status` = :status WHERE SHA1(CONCAT(`id`, `created`, :salt)) = :hash;", $pjBookingModel->getTable());
				
				$pjBookingModel
					->reset()
					->prepare($statement)
					->exec(array(
						'status' => 'cancelled',
						'salt' => PJ_SALT,
						'hash' => $this->_post->toString('hash'),
							
					));

				$booking_arr['table_arr'] = pjBookingTableModel::factory()
					->select("t1.*, t2.name")
					->join('pjTable', 't1.table_id = t2.id')
					->where('t1.booking_id', $booking_arr['id'])
					->findAll()
					->getData();
									
				$this->sendNotifications($booking_arr, 'cancel');
				
				pjUtil::redirect($_SERVER['PHP_SELF'] . '?controller=pjFront&action=pjActionCancel&err=200');
			}
		}else{
			if ($this->_get->check('hash') && $this->_get->toInt('id'))
			{
				$arr = $pjBookingModel	
					->select('t1.*, t2.content as country_title')
					->join('pjBaseMultiLang', "t2.model='pjBaseCountry' AND t2.foreign_id=t1.c_country AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
					->find($this->_get->toInt('id'))
					->getData();
				if (count($arr) == 0)
				{
					$this->set('status', 2);
				}else{
					if ($arr['status'] == 'cancelled')
					{
						$this->set('status', 2);
					}else{
						$hash = sha1($arr['id'] . $arr['created'] . PJ_SALT);
						if ($this->_get->toString('hash') != $hash)
						{
							$this->set('status', 3);
						}else{
							
							$arr['table_arr'] = pjBookingTableModel::factory()->select('t1.*, t2.name')
														->join('pjTable', 't1.table_id = t2.id', 'left')
														->where('t1.booking_id', $this->_get->toInt('id'))
														->findAll()->getData();

							$date = date('Y-m-d', strtotime($arr['dt']));
							$time = date('H:i:s', strtotime($arr['dt']));
							$price_arr = self::getPrice($this->option_arr, $date, $time, $arr['code']);
							
							$this->set('arr', $arr);
							$this->set('discount', isset($price_arr['discount_formatted']) ? $price_arr['discount_formatted'] : '');

							if(pjObject::getPlugin('pjPayments') !== NULL)
							{
								$this->set('payment_option_arr', pjPaymentOptionModel::factory()->getOptions(NULL));
								$this->set('payment_titles', pjPayments::getPaymentTitles($this->getForeignId(), $this->getLocaleId()));
							}
							else
							{
								$this->set('payment_titles', __('payment_methods', true));
							}
						}
					}
				}
			}elseif (!$this->_get->check('err')) {
				$this->set('status', 1);
			}
		}
	}
	
	public function isXHR()
	{
		// CORS
		return parent::isXHR() || isset($_SERVER['HTTP_ORIGIN']);
	}
	
	protected static function allowCORS()
	{
		if (!isset($_SERVER['HTTP_ORIGIN']))
		{
			return;
		}
		
		header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
		header("Access-Control-Allow-Credentials: true");
		header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
		header("Access-Control-Allow-Headers: Origin, X-Requested-With");
		header('P3P: CP="ALL DSP COR CUR ADM TAI OUR IND COM NAV INT"');
		
		if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS')
		{
			exit;
		}
	}
}
?>