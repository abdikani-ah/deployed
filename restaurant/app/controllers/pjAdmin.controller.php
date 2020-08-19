<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdmin extends pjAppController
{
	public $defaultUser = 'admin_user';
	
	public $thumbSize = 'thumb_size';
	
	public $previewSize = 'preview_size';
	
	public $requireLogin = true;
	
	public function __construct($requireLogin=null)
	{
		$this->setLayout('pjActionAdmin');
		
		if (!is_null($requireLogin) && is_bool($requireLogin))
		{
			$this->requireLogin = $requireLogin;
		}
		
		if ($this->requireLogin)
		{
			if (!$this->isLoged() && !in_array(@$_GET['action'], array('pjActionLogin', 'pjActionForgot', 'pjActionPreview')))
			{
				if (!$this->isXHR())
				{
			    	pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjBase&action=pjActionLogin");
				} else {
					header('HTTP/1.1 401 Unauthorized');
					exit;
				}
			}
		}
		
		$inherits_arr = array(
			'pjAdminBookings::pjActionGetBooking' => 'pjAdminBookings::pjActionIndex',
			'pjAdminBookings::pjActionGetTables' => 'pjAdminBookings::pjActionCreate',
			'pjAdminBookings::pjActionSaveBooking' => 'pjAdminBookings::pjActionUpdate',
			'pjAdminBookings::pjActionCheckUID' => 'pjAdminBookings::pjActionCreate',
			'pjAdminBookings::pjActionCheckDate' => 'pjAdminBookings::pjActionCreate',
			'pjAdminBookings::pjActionCheckTable' => 'pjAdminBookings::',
			'pjAdminBookings::pjActionGetSchedule' => 'pjAdminBookings::pjActionSchedule',
			'pjAdminBookings::pjActionPrinter' => 'pjAdminBookings::pjActionUpdate',
			'pjAdminBookings::pjActionAddPromo' => 'pjAdminBookings::pjActionCreate',
			'pjAdminBookings::pjActionConfirmation' => 'pjAdminBookings::pjActionUpdate',
			'pjAdminBookings::pjActionCancellation' => 'pjAdminBookings::pjActionUpdate',
			'pjAdminMaps::pjActionCheckName' => 'pjAdminMaps::pjActionIndex',
			'pjAdminMaps::pjActionToggle' => 'pjAdminMaps::pjActionIndex',
			'pjAdminMaps::pjActionGetFileUpload' => 'pjAdminMaps::pjActionDeleteFile',
			'pjAdminOptions::pjActionNotificationsSetContent' => 'pjAdminOptions::pjActionNotifications',
			'pjAdminOptions::pjActionNotificationsGetContent' => 'pjAdminOptions::pjActionNotifications',
			'pjAdminOptions::pjActionNotificationsGetMetaData' => 'pjAdminOptions::pjActionNotifications',
			'pjAdminOptions::pjActionPaymentOptions' => 'pjAdminOptions::pjActionPayments',		
			'pjAdminOptions::pjActionUpdateTheme' => 'pjAdminOptions::pjActionPreview',		
			'pjAdminTime::pjActionGetDate' => 'pjAdminTime::pjActionCustom',
			'pjAdminTables::pjActionCheckName' => 'pjAdminTables::pjActionIndex',
			'pjAdminTables::pjActionGetTable' => 'pjAdminTables::pjActionIndex',
			'pjAdminTables::pjActionSaveTable' => 'pjAdminTables::pjActionUpdate'
		);
		if (@$_REQUEST['controller'] == 'pjAdminOptions' && @$_REQUEST['action'] == 'pjActionUpdate' && @$_REQUEST['options_update'] == 1) {
			$inherits_arr = array_merge($inherits_arr, array('pjAdminOptions::pjActionUpdate' => 'pjAdminOptions::'.$_REQUEST['next_action']));	
		}
		pjRegistry::getInstance()->set('inherits', $inherits_arr);
	}
	
	public function beforeFilter()
	{
		parent::beforeFilter();
		
		if (!($this->_get->toString('controller') == 'pjAdmin' && $this->_get->toString('action') == 'pjActionMessages'))
		{
			if (!pjAuth::factory()->hasAccess())
			{
				$this->sendForbidden();
				return false;
			}
		}
		
		return true;
	}

	public function afterFilter()
	{
	    parent::afterFilter();
	    $this->appendJs('index.php?controller=pjBase&action=pjActionMessages', PJ_INSTALL_URL, true);
	    if ($this->isLoged() && !in_array(@$_GET['action'], array('pjActionLogin')))
	    {
	        $this->appendJs('index.php?controller=pjAdmin&action=pjActionMessages', PJ_INSTALL_URL, true);
	    }
	}

	public function beforeRender()
	{
		
	}

	public function pjActionMessages()
	{
		$this->setAjax(true);
		header("Content-Type: text/javascript; charset=utf-8");
	}

	public function setLocalesData()
    {
        $locale_arr = pjLocaleModel::factory()
            ->select('t1.*, t2.file')
            ->join('pjBaseLocaleLanguage', 't2.iso=t1.language_iso', 'left')
            ->where('t2.file IS NOT NULL')
            ->orderBy('t1.sort ASC')->findAll()->getData();

        $lp_arr = array();
        foreach ($locale_arr as $item)
        {
            $lp_arr[$item['id']."_"] = $item['file'];
        }
        $this->set('lp_arr', $locale_arr);
        $this->set('locale_str', pjAppController::jsonEncode($lp_arr));
        $this->set('is_flag_ready', $this->requestAction(array('controller' => 'pjBaseLocale', 'action' => 'pjActionIsFlagReady'), array('return')));
    }

    public function pjActionVerifyAPIKey()
    {
        $this->setAjax(true);

        if ($this->isXHR())
        {
            if (!self::isPost())
            {
                self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'HTTP method is not allowed.'));
            }

            $option_key = $this->_post->toString('key');
            if (!array_key_exists($option_key, $this->option_arr))
            {
                self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Option cannot be found.'));
            }

            $option_value = $this->_post->toString('value');
            if(empty($option_value))
            {
                self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'API key is empty.'));
            }

            $html = '';
            $isValid = false;
            switch ($option_key)
            {
                case 'o_google_maps_api_key':
                    $address = preg_replace('/\s+/', '+', $this->option_arr['o_timezone']);
                    $api_key_str = $option_value;
                    $gfile = "https://maps.googleapis.com/maps/api/geocode/json?key=".$api_key_str."&address=".$address;
                    $Http = new pjHttp();
                    $response = $Http->request($gfile)->getResponse();
                    $geoObj = pjAppController::jsonDecode($response);
                    $geoArr = (array) $geoObj;
                    if ($geoArr['status'] == 'OK')
                    {
                        $html = '<img src="' . $url . '" class="img-responsive" />';
                        $isValid = true;
                    }
                    break;
                default:
                    // API key for an unknown service. We can't verify it so we assume it's correct.
                    $isValid = true;
            }

            if ($isValid)
            {
                self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Key is correct!', 'html' => $html));
            }
            else
            {
                self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Key is not correct!', 'html' => $html));
            }
        }
        exit;
    }

    public function pjActionIndex()
    {
        $pjBookingModel = pjBookingModel::factory();
        $pjBookingTableModel = pjBookingTableModel::factory();

        $this->set('today_reservations', $pjBookingModel
            ->reset()
            ->where('status', 'confirmed')
            ->where('DATE(dt) = CURDATE()')
            ->findCount()
            ->getData());
        $this->set('today_new_reservations', $pjBookingModel
            ->reset()
            ->where('status', 'confirmed')
            ->where('DATE(created) = CURDATE()')
            ->findCount()
            ->getData());
        $total_guests = $pjBookingModel
            ->reset()
            ->select('SUM(people) as total_guests')
            ->where('status', 'confirmed')
            ->where('DATE(dt) = CURDATE()')
            ->findAll()
            ->getDataIndex(0);
        $this->set('today_guests', (int) $total_guests['total_guests']);
        $this->set('today_tables', $pjBookingTableModel
            ->reset()
            ->join('pjBooking', 't2.id=t1.booking_id', 'inner')
            ->where('t2.status', 'confirmed')
            ->where('DATE(t2.dt) = CURDATE()')
            ->groupBy('t1.id')
            ->findCount()
            ->getData());

        $next_week_reservations = $pjBookingModel
            ->reset()
            ->select('COUNT(id) as total_count, SUM(people) as total_guests, SUM(total) as total_amount')
            ->where('status', 'confirmed')
            ->where('DATE(dt) BETWEEN DATE_ADD(CURDATE(), INTERVAL 1 DAY) AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)')
            ->findAll()
            ->getDataIndex(0);
        $this->set('next_week_reservations', (int) $next_week_reservations['total_count']);
        $this->set('next_week_guests', (int) $next_week_reservations['total_guests']);
        $this->set('next_week_total', (float) $next_week_reservations['total_amount']);

        $this->set('latest_reservation_arr', $pjBookingModel
            ->reset()
            ->select(sprintf("t1.*, (SELECT GROUP_CONCAT(`TT`.name SEPARATOR ' | ') FROM `%s` AS `TT` WHERE `TT`.id IN(SELECT `TBT`.table_id FROM `%s` AS `TBT` WHERE `TBT`.booking_id=t1.id)) AS table_name", pjTableModel::factory()->getTable(), pjBookingTableModel::factory()->getTable()))
            ->orderBy('t1.created DESC')
            ->limit(3)
            ->findAll()
            ->getData());
        $this->set('today_total_reservations', $pjBookingModel
            ->reset()
            ->where('DATE(created) = CURDATE()')
            ->findCount()
            ->getData());

        $total_appointments = 0;
        $table_arr = pjTableModel::factory()->findAll()->getData();
        foreach ($table_arr as $k => $table)
        {
            $table_arr[$k]['booking_hours'] = $pjBookingModel
                ->reset()
                ->select('t1.id, DATE_FORMAT(t1.dt, "%H:%i") as booking_time')
                ->join('pjBookingTable', 't2.booking_id=t1.id', 'inner')
                ->where('t1.status', 'confirmed')
                ->where('DATE(t1.dt) = CURDATE()')
                ->where('t2.table_id', $table['id'])
                ->findAll()
                ->getDataPair('id', 'booking_time');

            $total_appointments += count($table_arr[$k]['booking_hours']);
        }
        $this->set('total_appointments', $total_appointments);
        $this->set('table_arr', $table_arr);

        $tables_by_capacity_arr = pjTableModel::factory()
            ->select('t1.seats, COUNT(t3.id) as total_bookings')
            ->join('pjBookingTable', 't2.table_id=t1.id', 'left')
            ->join('pjBooking', 't3.id=t2.booking_id AND t3.status="confirmed" AND DATE(t3.dt) = CURDATE()', 'left')
            ->groupBy('t1.seats')
            ->orderBy('t1.seats ASC')
            ->findAll()
            ->getDataPair('seats', 'total_bookings');
        $this->set('tables_by_capacity_arr', $tables_by_capacity_arr);

        $this->appendCss('morris.min.css', PJ_THIRD_PARTY_PATH . 'morris/');
        $this->appendCss('c3.min.css', PJ_THIRD_PARTY_PATH . 'c3/');

        $this->appendJs('morris.min.js', PJ_THIRD_PARTY_PATH . 'morris/');
        $this->appendJs('d3.min.js', PJ_THIRD_PARTY_PATH . 'd3/');
        $this->appendJs('c3.min.js', PJ_THIRD_PARTY_PATH . 'c3/');
        $this->appendJs('pjAdmin.js');
    }
}
?>