<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminBookings extends pjAdmin
{
	public function pjActionCheckUID()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if (!$this->_get->toString('uuid'))
			{
				echo 'false';
				exit;
			}
			$pjBookingModel = pjBookingModel::factory()->where('t1.uuid', $this->_get->toString('uuid'));
			if ($this->_get->toInt('id'))
			{
				$pjBookingModel->where('t1.id !=', $this->_get->toInt('id'));
			}
			echo $pjBookingModel->findCount()->getData() == 0 ? 'true' : 'false';
		}
		exit;
	}
	
	public function pjActionCheckDate()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if(strpos($this->option_arr['o_time_format'], 'a') > -1 || strpos($this->option_arr['o_time_format'], 'A') > -1)
			{
				$dt_from = strtotime(pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']) . ' ' .$this->_post->toString('hour') . ':' . $this->_post->toString('minute') . ' ' . strtoupper($this->_post->toString('ampm')));
				$dt_to = strtotime(pjDateTime::formatDate($this->_post->toString('date_to'), $this->option_arr['o_date_format']) . ' ' .$this->_post->toString('hour_to') . ':' . $this->_post->toString('minute_to') . ' ' . strtoupper($this->_post->toString('ampm_to')));
			}else{
				$dt_from = sprintf("%s %s:%s:00", pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']), $this->_post->toString('hour'), $this->_post->toString('minute'));
				$dt_to = sprintf("%s %s:%s:00", pjDateTime::formatDate($this->_post->toString('date_to'), $this->option_arr['o_date_format']), $this->_post->toString('hour_to'), $this->_post->toString('minute_to'));
				$dt_from = strtotime($dt_from);
				$dt_to = strtotime($dt_to);
			}
			echo $dt_to > $dt_from ? 'true' : 'false';
		}
		exit;
	}
	public function pjActionCheckTable()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if ($this->_post->check('table_id'))
			{
				$date = pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']);
				$booking_length = $this->option_arr['o_booking_length'] * 60;
				if(strpos($this->option_arr['o_time_format'], 'a') > -1 || strpos($this->option_arr['o_time_format'], 'A') > -1)
				{
					$start_time = strtotime(pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']) . ' ' .$this->_post->toString('hour') . ':' . $this->_post->toString('minute') . ' ' . strtoupper($this->_post->toString('ampm')));
					$end_time = $start_time + $booking_length;
				}else{
					$start_time = strtotime(sprintf("%s %s:%s:00", $date, $this->_post->toString('hour'), $this->_post->toString('minute')));
					$end_time = $start_time + $booking_length;
				}
				
				$table_id_arr = array();
				$_arr = explode("&", $this->_post->toString('table_id'));
								
				foreach($_arr as $v)
				{
					list(, $_id) = explode("=", $v);
					$table_id_arr[] = $_id;
				}
				
				$sub_str = '';
				if($this->_post->toInt('id'))
				{
					$sub_str = " AND (`id` <> '".$this->_post->toInt('id')."')";
				}
				
				$sub_query = sprintf("(SELECT COUNT(`table_id`)
										FROM `%1\$s`
										WHERE `table_id` = `t1`.`id`
										AND `booking_id` IN (SELECT `id` FROM `%2\$s` WHERE ( (`dt` BETWEEN '%3\$s' AND '%4\$s') OR (`dt_to` BETWEEN '%3\$s' AND '%4\$s') OR ('%3\$s' BETWEEN `dt` AND `dt_to`) OR ('%4\$s' BETWEEN `dt` AND `dt_to`)) AND (`status` = 'confirmed' OR (`status`='pending' AND UNIX_TIMESTAMP(`created`) >= UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL %5\$u MINUTE))))$sub_str)
										LIMIT 1)",
										pjBookingTableModel::factory()->getTable(),
										pjBookingModel::factory()->getTable(),
										date('Y-m-d H:i:s', $start_time), 
										date('Y-m-d H:i:s', $end_time),
										(int) $this->option_arr['o_min_hour']
									);
				$table_arr = pjTableModel::factory()->select("t1.*, $sub_query AS booked")->findAll()->getData();
				foreach ($table_arr as $table)
				{
					if((int)$table['booked'] != 0)
					{
						if(in_array($table['id'], $table_id_arr))
						{
							echo 'false';
							exit;
						}
					}
				}
				echo 'true';
			}else{
				echo 'false';
			}
		}
		exit;
	}
		
	private function _getSchedule($date, $wt_arr)
	{
		$arr = pjTableModel::factory()->orderBy("id ASC")->findAll()->getData();
		foreach ($arr as $k => $table)
		{
			$arr[$k]['hour_arr'] = pjBookingModel::factory()->getBookings($table['id'], $date, $wt_arr);
		}
		return $arr;
	}

	public function pjActionSchedule()
	{
		$date = date("Y-m-d");

		$wt_arr = self::getWorkingTime($date);
		$arr = $this->_getSchedule($date, $wt_arr);

		$this->set('arr', $arr);
		$this->set('wt_arr', $wt_arr);

		$pjWorkingTimeModel = pjWorkingTimeModel::factory();
		$pjDateModel = pjDateModel::factory();
		$week_dayoff_arr = $pjWorkingTimeModel->getDaysOff(1);
		$date_arr = $pjDateModel->where("(t1.date >= CURDATE())")->orderBy('`date` ASC')->findAll()->getData();
		$this->set('week_dayoff_arr', $week_dayoff_arr);
		$this->set('date_arr', $date_arr);

		$this->appendJs('moment-with-locales.min.js', PJ_THIRD_PARTY_PATH . 'moment/');
		$this->appendCss('datepicker.css', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
		$this->appendJs('bootstrap-datepicker.js', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
		$this->appendJs('pjAdminBookings.js');
	}

	public function pjActionPaper()
	{
		$this->setLayout('pjActionEmpty');

		if($this->_get->check('date'))
		{
			$date = pjDateTime::formatDate($this->_get->toString('date'), $this->option_arr['o_date_format']);
			$wt_arr = self::getWorkingTime($date);
			$arr = $this->_getSchedule($date, $wt_arr);

			$this->set('arr', $arr);
			$this->set('wt_arr', $wt_arr);
		}
	}
	
	public function pjActionGetSchedule()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$date = pjDateTime::formatDate($this->_get->toString('date'), $this->option_arr['o_date_format']);
			$wt_arr = self::getWorkingTime($date);
			$arr = $this->_getSchedule($date, $wt_arr);
			
			$this->set('arr', $arr);
			$this->set('wt_arr', $wt_arr);
		}
	}
	
	public function pjActionIndex()
	{
		$this->set('table_arr', pjTableModel::factory()->orderBy('t1.name ASC')->findAll()->getData());

		$this->appendCss('datepicker.css', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
		$this->appendJs('bootstrap-datepicker.js', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
		$this->appendJs('jquery.datagrid.js', PJ_FRAMEWORK_LIBS_PATH . 'pj/js/');
		$this->appendJs('pjAdminBookings.js');
	}
	
	public function pjActionGetBooking()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$pjBookingModel = pjBookingModel::factory();

			if ($q = $this->_get->toString('q'))
			{
				$pjBookingModel->where('t1.c_fname LIKE', "%$q%");
				$pjBookingModel->orWhere('t1.c_lname LIKE', "%$q%");
				$pjBookingModel->orWhere('t1.c_email LIKE', "%$q%");
				$pjBookingModel->orWhere('t3.name LIKE', "%$q%");
			}
			if ($q = $this->_get->toString('name'))
			{
				$pjBookingModel->where('t1.c_fname LIKE', "%$q%");
				$pjBookingModel->orWhere('t1.c_lname LIKE', "%$q%");
			}
			if ($q = $this->_get->toString('email'))
			{
				$pjBookingModel->where('t1.c_email LIKE', "%$q%");
			}
			if ($q = $this->_get->toString('phone'))
			{
				$pjBookingModel->where('t1.c_phone LIKE', "%$q%");
			}
			if ($this->_get->toString('date_from') && $this->_get->toString('date_to'))
			{
				$df = pjDateTime::formatDate($this->_get->toString('date_from'), $this->option_arr['o_date_format']);
				$dt = pjDateTime::formatDate($this->_get->toString('date_to'), $this->option_arr['o_date_format']);
				$pjBookingModel->where("(DATE(t1.dt) BETWEEN '$df' AND '$dt')");
				
			} else {
				if ($this->_get->toString('date_from'))
				{
					$df = pjDateTime::formatDate($this->_get->toString('date_from'), $this->option_arr['o_date_format']);
					$pjBookingModel->where("(DATE(t1.dt) >= '$df')");
				} elseif ($this->_get->toString('date_to')) {
					$dt = pjDateTime::formatDate($this->_get->toString('date_to'), $this->option_arr['o_date_format']);
					$pjBookingModel->where("(DATE(t1.dt) <= '$dt')");
				}
			}
			if ($this->_get->toInt('today'))
			{
				$pjBookingModel->where("(DATE(t1.created) = CURDATE())");
			}
			if ($this->_get->toInt('next_week'))
			{
				$pjBookingModel->where("(DATE(t1.dt) BETWEEN DATE_ADD(CURDATE(), INTERVAL 1 DAY) AND DATE_ADD(CURDATE(), INTERVAL 7 DAY))");
			}
			if ($this->_get->toInt('table_id'))
			{
				$pjBookingModel->where("(t1.id IN(SELECT TBT.booking_id FROM `".pjBookingTableModel::factory()->getTable()."` as TBT WHERE TBT.table_id = ".$this->_get->toInt('table_id')."))");
			}

			if (in_array($this->_get->toString('status'), array('confirmed','cancelled','pending','enquiry')))
			{
				$pjBookingModel->where('t1.status', $this->_get->toString('status'));
			}

			$column = 'created';
			$direction = 'DESC';
			if ($this->_get->toString('column') && in_array(strtoupper($this->_get->toString('direction')), array('ASC', 'DESC')))
			{
				$column = $this->_get->toString('column');
				$direction = strtoupper($this->_get->toString('direction'));
			}

			$total = $pjBookingModel->findCount()->getData();
			$rowCount = $this->_get->toInt('rowCount') ?: 10;
			$pages = ceil($total / $rowCount);
			$page = $this->_get->toInt('page') ?: 1;
			$offset = ((int) $page - 1) * $rowCount;
			if ($page > $pages)
			{
				$page = $pages;
			}
			
			$data = $pjBookingModel->select(sprintf("t1.*, (SELECT GROUP_CONCAT(`TT`.name SEPARATOR ' | ') FROM `%s` AS `TT` WHERE `TT`.id IN(SELECT `TBT`.table_id FROM `%s` AS `TBT` WHERE `TBT`.booking_id=t1.id)) AS table_name", pjTableModel::factory()->getTable(), pjBookingTableModel::factory()->getTable()))
				->orderBy("$column $direction")->limit($rowCount, $offset)->findAll()->getData();
			foreach($data as $k => $v){
				$name_arr = array();
				if(!empty($v['c_fname'])){
					$name_arr[] = pjSanitize::clean($v['c_fname']);
				}
				if(!empty($v['c_lname'])){
					$name_arr[] = pjSanitize::clean($v['c_lname']);
				}
				$v['dt'] = date($this->option_arr['o_date_format'], strtotime($v['dt'])) . ', ' . date($this->option_arr['o_time_format'], strtotime($v['dt']));
				$v['full_name'] = join(" ", $name_arr);
				$data[$k]  = $v;
			}	
			
			self::jsonResponse(compact('data', 'total', 'pages', 'page', 'rowCount', 'column', 'direction'));
		}
		exit;
	}
	
	public function pjActionSaveBooking()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
			exit;
		}
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'HTTP method not allowed.'));
		}

		$pjBookingModel = pjBookingModel::factory();
		$pjBookingTableModel = pjBookingTableModel::factory();
		if($this->_post->toString('column') == 'status')
		{
			$arr = $pjBookingModel->find($this->_get->toInt('id'))->getData();
			if(!empty($arr))
			{
				if(($arr['status'] != 'pending' && $arr['status'] != 'confirmed') && ($this->_post->toString('value') == 'pending' || $this->_post->toString('value') == 'confirmed'))
				{
					$start_time = strtotime($arr['dt']);
					$end_time = strtotime($arr['dt_to']);
					$sub_query = sprintf("(SELECT COUNT(`table_id`)
								FROM `%1\$s`
								WHERE `table_id` = `t1`.`id`
								AND `booking_id` IN (SELECT `id` FROM `%2\$s` WHERE (
									(UNIX_TIMESTAMP(`dt`) <= '%4\$u' AND UNIX_TIMESTAMP(`dt`) > '%3\$u')
									OR (UNIX_TIMESTAMP(`dt_to`) <= '%4\$u' AND UNIX_TIMESTAMP(`dt_to`) > '%3\$u')
								) AND (`status` = 'confirmed' OR (`status`='pending' AND UNIX_TIMESTAMP(`created`) >= UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL %5\$u MINUTE)))))
								LIMIT 1)",
							$pjBookingTableModel->getTable(),
							$pjBookingModel->getTable(),
							$start_time,
							$end_time,
							(int) $this->option_arr['o_min_hour']);
					$valid = true;
					$booking_table_arr = $pjBookingTableModel->where('t1.booking_id', $arr['id'])->limit(1)->findAll()->getData();
					if(count($booking_table_arr) == 1)
					{
						$table_id = $booking_table_arr[0]['table_id'];
						$table_arr = pjTableModel::factory()->select("t1.*, $sub_query AS booked")->find($table_id)->getData();
						if((int) $table_arr['booked'] > 0)
						{
							$valid = false;
						}
					}
					if($valid == true)
					{
						$pjBookingModel->reset()->where('id', $this->_get->toInt('id'))->limit(1)->modifyAll(array($this->_post->toString('column') => $this->_post->toString('value')));
					}
				}else{
					$pjBookingModel->reset()->where('id', $this->_get->toInt('id'))->limit(1)->modifyAll(array($this->_post->toString('column') => $this->_post->toString('value')));
				}
			}
		}else{
			$pjBookingModel->where('id', $this->_get->toInt('id'))->limit(1)->modifyAll(array($this->_post->toString('column') => $this->_post->toString('value')));
		}
	}
	
	public function pjActionExportBooking()
	{
		if (self::isPost() && $this->_post->has('record'))
		{
			$record = $this->_post->toArray('record');
			if (count($record))
			{
				$arr = pjBookingModel::factory()->whereIn('id', $record)->findAll()->getData();
				$datetime = array('dt', 'dt_to', 'processed_on', 'created');
				foreach ($arr as &$item)
				{
					foreach ($datetime as $index)
					{
						if (!empty($item[$index]))
						{
							$item[$index] = pjDateTime::formatDateTime($item[$index], 'Y-m-d H:i:s', $this->option_arr['o_date_format'] . ', ' . $this->option_arr['o_time_format']);
						}
					}
				}
				$csv = new pjCSV();
				$csv
					->setHeader(true)
					->setName("Bookings-".time().".csv")
					->process($arr)
					->download();
			}
			exit;
		}
	}
	
	public function pjActionDeleteBooking()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if (!self::isPost())
			{
				self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'HTTP method not allowed.'));
			}

			if (pjBookingModel::factory()->setAttributes(array('id' => $this->_get->toInt('id')))->erase()->getAffectedRows() == 1)
			{
				pjBookingTableModel::factory()->where('booking_id', $this->_get->toInt('id'))->eraseAll();
				
				self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Reservation has been deleted.'));
			} else {
				self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Reservation has not been deleted.'));
			}
		}
		exit;
	}
	
	public function pjActionDeleteBookingBulk()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if (!self::isPost())
			{
				self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'HTTP method not allowed.'));
			}

			$record = $this->_post->toArray('record');
			if (count($record))
			{
				pjBookingModel::factory()->whereIn('id', $record)->eraseAll();
				pjBookingTableModel::factory()->whereIn('booking_id', $record)->eraseAll();

				self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Reservation(s) has been deleted.'));
			}

			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Reservation(s) has not been deleted.'));
		}
		exit;
	}
	
	public function pjActionUpdate()
	{
		if ($this->_post->check('booking_update'))
		{
			$booking_id = $this->_post->toInt('id');
			$date = pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']);
			if(strpos($this->option_arr['o_time_format'], 'a') > -1 || strpos($this->option_arr['o_time_format'], 'A') > -1)
			{
				$time = date('H:i:s', strtotime(pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']) . ' ' .$this->_post->toString('hour') . ':' . $this->_post->toString('minute') . ' ' . strtoupper($this->_post->toString('ampm'))));
			}else{
				$time = $this->_post->toString('hour') . ":" . $this->_post->toString('minute') . ":00";
			}
			$date_to = pjDateTime::formatDate($this->_post->toString('date_to'), $this->option_arr['o_date_format']);
			if(strpos($this->option_arr['o_time_format'], 'a') > -1 || strpos($this->option_arr['o_time_format'], 'A') > -1)
			{
				$time_to = date('H:i:s', strtotime(pjDateTime::formatDate($this->_post->toString('date_to'), $this->option_arr['o_date_format']) . ' ' .$this->_post->toString('hour_to') . ':' . $this->_post->toString('minute_to') . ' ' . strtoupper($this->_post->toString('ampm_to'))));
			}else{
				$time_to = $this->_post->toString('hour_to') . ":" . $this->_post->toString('minute_to') . ":00";
			}

			$data = array();
			$data['id'] = $booking_id;
			$data['dt'] = sprintf("%s %s", $date, $time);
			$data['dt_to'] = sprintf("%s %s", $date_to, $time_to);
			$data['hour'] = $this->_post->toString('hour');
			$data['minute'] = $this->_post->toString('minute');
			$data['hour_to'] = $this->_post->toString('hour_to');
			$data['minute_to'] = $this->_post->toString('minute_to');
			$data['uuid'] = $this->_post->toInt('uuid');
			$data['status'] = $this->_post->toString('status');
			$data['total'] = $this->_post->toFloat('total');
			$data['code'] = $this->_post->toString('code') ?: ':NULL';
			$data['payment_method'] = $this->_post->toString('payment_method');
			if ($data['payment_method'] == 'creditcard')
			{
				$data['cc_type'] = $this->_post->toString('cc_type');
				$data['cc_num'] = $this->_post->toString('cc_num');
				$data['cc_exp'] = $this->_post->toString('cc_exp_year') . '-' . $this->_post->toString('cc_exp_month');
				$data['cc_code'] = $this->_post->toString('cc_code');
			}
			$data['is_paid'] = $this->_post->check('is_paid')? 'T': 'F';
			$data['people'] = $this->_post->toInt('people') ?: 1;
			$data['c_title'] = $this->_post->toString('c_title') ?: ':NULL';
			$data['c_fname'] = $this->_post->toString('c_fname') ?: ':NULL';
			$data['c_lname'] = $this->_post->toString('c_lname') ?: ':NULL';
			$data['c_email'] = $this->_post->toString('c_email') ?: ':NULL';
			$data['c_phone'] = $this->_post->toString('c_phone') ?: ':NULL';
			$data['c_company'] = $this->_post->toString('c_company') ?: ':NULL';
			$data['c_address'] = $this->_post->toString('c_address') ?: ':NULL';
			$data['c_city'] = $this->_post->toString('c_city') ?: ':NULL';
			$data['c_state'] = $this->_post->toString('c_state') ?: ':NULL';
			$data['c_zip'] = $this->_post->toString('c_zip') ?: ':NULL';
			$data['c_country'] = $this->_post->toInt('c_country') ?: ':NULL';
			$data['c_notes'] = $this->_post->toString('c_notes') ?: ':NULL';

			$stop = false;
			if (!$stop)
			{
				pjBookingModel::factory()->set('id', $booking_id)->modify($data);

				$pjBookingTableModel = pjBookingTableModel::factory();
				$pjBookingTableModel->where('booking_id', $booking_id)->eraseAll();
				if (count($this->_post->toArray('table_id')) > 0)
				{
					$data = array();
					$data['booking_id'] = $booking_id;
					foreach ($this->_post->toArray('table_id') as $table_id)
					{
						$data['table_id'] = $table_id;
						$pjBookingTableModel->reset()->setAttributes($data)->insert();
					}
				}
				$err = 'AB05';
			}
			pjUtil::redirect(PJ_INSTALL_URL. "index.php?controller=pjAdminBookings&action=pjActionUpdate&id=$booking_id&err=$err");
		}else{
			$pjTableModel = pjTableModel::factory();
			$pjBookingTableModel = pjBookingTableModel::factory();

			$arr = pjBookingModel::factory()->find($this->_get->toInt('id'))->getData();
			if (count($arr) === 0)
			{
				pjUtil::redirect(PJ_INSTALL_URL. "index.php?controller=pjAdminBookings&action=pjActionIndex&err=AB08");
			}
			$pjBookingTableModel->join('pjBooking', "t2.id = t1.booking_id AND t2.status = 'confirmed' AND `dt` < '".$arr['dt_to']."' AND `dt_to` > '".$arr['dt']."'", 'inner');
			$bt_arr = $pjBookingTableModel->where("t1.booking_id != " . $arr['id'])->findAll()->getDataPair('table_id', 'table_id');

			if (count($bt_arr) > 0){
				$pjTableModel->where("(t1.id NOT IN('".join("','", $bt_arr)."'))");
			}
			$table_arr = $pjTableModel->orderBy("t1.name ASC")->findAll()->getData();

			$bt_arr = $pjBookingTableModel->reset()->where('t1.booking_id', $arr['id'])->findAll()->getDataPair('id', 'table_id');

			$country_arr = pjBaseCountryModel::factory()
						->select('t1.id, t2.content AS country_title')
						->join('pjBaseMultiLang', "t2.model='pjBaseCountry' AND t2.foreign_id=t1.id AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
						->where('status', 'T')
						->orderBy('`country_title` ASC')->findAll()->getData();

			$date = date('Y-m-d', strtotime($arr['dt']));
			$time = date('H:i:s', strtotime($arr['dt']));

			$price_arr = self::getPrice($this->option_arr, $date, $time, $arr['code']);

			$this->set('arr', $arr);
			$this->set('table_arr', $table_arr);
			$this->set('bt_arr', $bt_arr);
			$this->set('country_arr', $country_arr);
			$this->set('discount', isset($price_arr['discount_formatted']) ? $price_arr['discount_formatted'] : '');

			$pjWorkingTimeModel = pjWorkingTimeModel::factory();
			$pjDateModel = pjDateModel::factory();
			$week_dayoff_arr = $pjWorkingTimeModel->getDaysOff(1);
			$date_arr = $pjDateModel->where("(t1.date >= CURDATE())")->orderBy('`date` ASC')->findAll()->getData();
			$this->set('week_dayoff_arr', $week_dayoff_arr);
			$this->set('date_arr', $date_arr);

			if(pjObject::getPlugin('pjPayments') !== NULL)
			{
				$this->set('payment_option_arr', pjPaymentOptionModel::factory()->getOptions(NULL));
				$this->set('payment_titles', pjPayments::getPaymentTitles($this->getForeignId(), $this->getLocaleId()));
			}
			else
			{
				$this->set('payment_titles', __('payment_methods', true));
			}

			$this->setLocalesData();

			$this->appendJs('moment-with-locales.min.js', PJ_THIRD_PARTY_PATH . 'moment/');
			$this->appendJs('jquery.multilang.js', $this->getConstant('pjBase', 'PLUGIN_JS_PATH'), false, false);
			$this->appendJs('tinymce.min.js', PJ_THIRD_PARTY_PATH . 'tinymce/');
			$this->appendCss('datepicker.css', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
			$this->appendJs('bootstrap-datepicker.js', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
			$this->appendCss('select2.min.css', PJ_THIRD_PARTY_PATH . 'select2/css/');
			$this->appendJs('select2.full.js', PJ_THIRD_PARTY_PATH . 'select2/js/');
			$this->appendJs('pjAdminBookings.js');
		}
	}
	
	public function pjActionCreate()
	{
		if ($this->_post->check('booking_create'))
		{
			$pjBookingModel = pjBookingModel::factory();

			$date = pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']);
			if(strpos($this->option_arr['o_time_format'], 'a') > -1 || strpos($this->option_arr['o_time_format'], 'A') > -1)
			{
				$time = date('H:i:s', strtotime(pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']) . ' ' .$this->_post->toString('hour') . ':' . $this->_post->toString('minute') . ' ' . strtoupper($this->_post->toString('ampm'))));
			}else{
				$time = $this->_post->toString('hour') . ":" . $this->_post->toString('minute') . ":00";
			}
			$date_to = pjDateTime::formatDate($this->_post->toString('date_to'), $this->option_arr['o_date_format']);
			if(strpos($this->option_arr['o_time_format'], 'a') > -1 || strpos($this->option_arr['o_time_format'], 'A') > -1)
			{
				$time_to = date('H:i:s', strtotime(pjDateTime::formatDate($this->_post->toString('date_to'), $this->option_arr['o_date_format']) . ' ' .$this->_post->toString('hour_to') . ':' . $this->_post->toString('minute_to') . ' ' . strtoupper($this->_post->toString('ampm'))));
			}else{
				$time_to = $this->_post->toString('hour_to') . ":" . $this->_post->toString('minute_to') . ":00";
			}

			$data = array();
			$data['dt'] = sprintf("%s %s", $date, $time);
			$data['dt_to'] = sprintf("%s %s", $date_to, $time_to);
			$data['hour'] = $this->_post->toString('hour');
			$data['minute'] = $this->_post->toString('minute');
			$data['hour_to'] = $this->_post->toString('hour_to');
			$data['minute_to'] = $this->_post->toString('minute_to');
			$data['uuid'] = $this->_post->toInt('uuid');
			$data['status'] = $this->_post->toString('status');
			$data['total'] = $this->_post->toFloat('total');
			$data['code'] = $this->_post->toString('code') ?: ':NULL';
			$data['payment_method'] = $this->_post->toString('payment_method');
			$data['locale_id'] = $this->getLocaleId();
			if ($data['payment_method'] == 'creditcard')
			{
				$data['cc_type'] = $this->_post->toString('cc_type');
				$data['cc_num'] = $this->_post->toString('cc_num');
				$data['cc_exp'] = $this->_post->toString('cc_exp_year') . '-' . $this->_post->toString('cc_exp_month');
				$data['cc_code'] = $this->_post->toString('cc_code');
			}
			$data['is_paid'] = $this->_post->check('is_paid')? 'T': 'F';
			$data['people'] = $this->_post->toInt('people') ?: 1;
			$data['c_title'] = $this->_post->toString('c_title') ?: ':NULL';
			$data['c_fname'] = $this->_post->toString('c_fname') ?: ':NULL';
			$data['c_lname'] = $this->_post->toString('c_lname') ?: ':NULL';
			$data['c_email'] = $this->_post->toString('c_email') ?: ':NULL';
			$data['c_phone'] = $this->_post->toString('c_phone') ?: ':NULL';
			$data['c_company'] = $this->_post->toString('c_company') ?: ':NULL';
			$data['c_address'] = $this->_post->toString('c_address') ?: ':NULL';
			$data['c_city'] = $this->_post->toString('c_city') ?: ':NULL';
			$data['c_state'] = $this->_post->toString('c_state') ?: ':NULL';
			$data['c_zip'] = $this->_post->toString('c_zip') ?: ':NULL';
			$data['c_country'] = $this->_post->toInt('c_country') ?: ':NULL';
			$data['c_notes'] = $this->_post->toString('c_notes') ?: ':NULL';
			$data['ip'] = $_SERVER['REMOTE_ADDR'];

			$booking_id = $pjBookingModel->setAttributes($data)->insert()->getInsertId();
			if ($booking_id !== false)
			{
				$pjBookingTableModel = pjBookingTableModel::factory();
				if (count($this->_post->toArray('table_id')) > 0)
				{
					$data = array();
					$data['booking_id'] = $booking_id;
					foreach ($this->_post->toArray('table_id') as $table_id)
					{
						$data['table_id'] = $table_id;
						$pjBookingTableModel->reset()->setAttributes($data)->insert();
					}
				}
				$err = 'AB11';
			}else{
				$err = 'AB12';
				pjUtil::redirect(PJ_INSTALL_URL. "index.php?controller=pjAdminBookings&action=pjActionIndex&err=$err");
			}

			pjUtil::redirect(PJ_INSTALL_URL. "index.php?controller=pjAdminBookings&action=pjActionUpdate&id=$booking_id&err=$err");
		}else{

			$table_arr = pjTableModel::factory()->findAll()->getData();

			$date = $this->_get->check('date') ? pjDateTime::formatDate($this->_get->toString('date'), $this->option_arr['o_date_format']) : date('Y-m-d');
			$date_from = $this->_get->check('hour') ? date('Y-m-d H:i:s', $this->_get->toString('hour')) : date('Y-m-d H:i:s');

			$country_arr = pjBaseCountryModel::factory()
						->select('t1.id, t2.content AS country_title')
						->join('pjBaseMultiLang', "t2.model='pjBaseCountry' AND t2.foreign_id=t1.id AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
						->where('status', 'T')
						->orderBy('`country_title` ASC')->findAll()->getData();

			$wt_arr = self::getWorkingTime($date);

			$this->set('table_arr', $table_arr);
			$this->set('wt_arr', $wt_arr);
			$this->set('country_arr', $country_arr);
			$this->set('date_from', $date_from);
			if($this->_get->toInt('table_id')){

				$this->set('table', pjTableModel::factory()->find($this->_get->toInt('table_id'))->getData());
			}

			$pjWorkingTimeModel = pjWorkingTimeModel::factory();
			$pjDateModel = pjDateModel::factory();
			$week_dayoff_arr = $pjWorkingTimeModel->getDaysOff(1);
			$date_arr = $pjDateModel->where("(t1.date >= CURDATE())")->orderBy('`date` ASC')->findAll()->getDataPair('date', 'is_dayoff');
			$this->set('week_dayoff_arr', $week_dayoff_arr);
			$this->set('date_arr', $date_arr);

			if(pjObject::getPlugin('pjPayments') !== NULL)
			{
				$this->set('payment_option_arr', pjPaymentOptionModel::factory()->getOptions(NULL));
				$this->set('payment_titles', pjPayments::getPaymentTitles($this->getForeignId(), $this->getLocaleId()));
			}
			else
			{
				$this->set('payment_titles', __('payment_methods', true));
			}

			$this->appendJs('moment-with-locales.min.js', PJ_THIRD_PARTY_PATH . 'moment/');
			$this->appendCss('datepicker.css', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
			$this->appendJs('bootstrap-datepicker.js', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
			$this->appendCss('select2.min.css', PJ_THIRD_PARTY_PATH . 'select2/css/');
			$this->appendJs('select2.full.js', PJ_THIRD_PARTY_PATH . 'select2/js/');
			$this->appendJs('pjAdminBookings.js');
		}
	}
	
	public function pjActionGetTables()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$pjTableModel = pjTableModel::factory();
			$pjBookingTableModel = pjBookingTableModel::factory();
			
			if (strpos($this->option_arr['o_time_format'], 'a') > -1 || strpos($this->option_arr['o_time_format'], 'A') > -1)
			{
				$time = date('H:i:s', strtotime(pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']) . ' ' .$this->_post->toString('hour') . ':' . $this->_post->toString('minute') . ' ' . strtoupper($this->_post->toString('ampm'))));
				$time_to = date('H:i:s', strtotime(pjDateTime::formatDate($this->_post->toString('date_to'), $this->option_arr['o_date_format']) . ' ' .$this->_post->toString('hour_to') . ':' . $this->_post->toString('minute_to') . ' ' . strtoupper($this->_post->toString('ampm_to'))));
			} else {
				$time = $this->_post->toString('hour') . ":" . $this->_post->toString('minute') . ":00";
				$time_to = $this->_post->toString('hour_to') . ":" . $this->_post->toString('minute_to') . ":00";
			}

			$dt_from = sprintf("%s %s", pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']), $time);
			if ($this->_post->check('id'))
			{
				$dt_to = sprintf("%s %s", pjDateTime::formatDate($this->_post->toString('date_to'), $this->option_arr['o_date_format']), $time_to);
				$pjBookingTableModel->where('t1.booking_id !=', $this->_post->toInt('id'));
			}else{
				$dt_to = date("Y-m-d H:i:s", strtotime($dt_from) + $this->option_arr['o_booking_length'] * 60);
			}
						
			$pjBookingTableModel->join('pjBooking', "t2.id = t1.booking_id AND t2.status = 'confirmed' AND `dt` <= '".$dt_to."' AND `dt_to` >= '".$dt_from."'", 'inner');
			$table_ids = $pjBookingTableModel->findAll()->getDataPair(null, 'table_id');
			
			if ($table_ids)
			{
				$pjTableModel->whereNotIn('t1.id', $table_ids);
			}
			$table_arr = $pjTableModel->orderBy("t1.name ASC")->findAll()->getData();
			
			$this->set('table_arr', $table_arr);
		}
	}

	public function pjActionPrinter()
	{
		if (!$this->isAdmin() && !$this->isEditor())
		{
			$this->sendForbidden();
			return;
		}

		$this->setLayout('pjActionPrint');

		$pjBookingModel = pjBookingModel::factory();
		$pjTableModel = pjTableModel::factory();

		$arr = $pjBookingModel->select('t1.*, t2.content as country_title')
							->join('pjBaseMultiLang', "t2.model='pjBaseCountry' AND t2.foreign_id=t1.c_country AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
							->find($this->_get->toInt('id'))->getData();
		if (count($arr) === 0)
		{
			pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminBookings&action=pjActionIndex&err=AB08");
		}
		$table_arr = $pjTableModel->orderBy("t1.name ASC")->findAll()->getData();
		$bt_arr = pjBookingTableModel::factory()->where('t1.booking_id', $arr['id'])->findAll()->getDataPair('table_id', 'id');

		$date = date('Y-m-d', strtotime($arr['dt']));
		$time = date('H:i:s', strtotime($arr['dt']));
		$price_arr = self::getPrice($this->option_arr, $date, $time, $arr['code']);

		$this->set('arr', $arr);
		$this->set('bt_arr', $bt_arr);
		$this->set('table_arr', $table_arr);
		$this->set('discount', isset($price_arr['discount_formatted']) ? $price_arr['discount_formatted'] : '');
	}

	public function pjActionAddPromo()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$resp = array();
			
			$date = pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']);
			if(strpos($this->option_arr['o_time_format'], 'a') > -1 || strpos($this->option_arr['o_time_format'], 'A') > -1)
			{
				$time = date('H:i:s', strtotime(pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']) . ' ' .$this->_post->toString('hour') . ':' . $this->_post->toString('minute') . ' ' . strtoupper($this->_post->toString('ampm'))));
			}else{
				$time = $this->_post->toString('hour') . ":" . $this->_post->toString('minute') . ":00";
			}

			$price_arr = self::getPrice($this->option_arr, $date, $time, $this->_post->toString('code'));
			$resp['total'] = $price_arr['total'];
			$resp['discount'] = isset($price_arr['discount_formatted']) ? $price_arr['discount_formatted'] : '';
			
			self::jsonResponse($resp);
		}
	}
	
	public function pjActionConfirmation()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if (
				$this->_post->check('send_confirm') &&
				$this->_post->toString('to') && $this->_post->toString('from') &&
				$this->_post->toInt('locale_id') && $this->_post->check('i18n'))
			{
				$pjEmail = self::getMailer($this->option_arr);

				$locale_id = $this->_post->toInt('locale_id');
				$i18n = $this->_post->toI18n('i18n');

				$subject = $i18n[$locale_id]['subject'];
				$message = $i18n[$locale_id]['message'];
				if (get_magic_quotes_gpc())
				{
					$subject = stripslashes($subject);
					$message = stripslashes($message);
				}

				$r = $pjEmail
					->setTo($this->_post->toString('to'))
					->setSubject($subject)
					->send($message);
					
				if ($r)
				{
					self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Email has been sent.'));
				}
				self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Email failed to send.'));
			}
	
			if ($this->_get->toInt('booking_id'))
			{
				$notification = self::getNotification('confirmation');
				
				$booking_arr = pjBookingModel::factory()->find($this->_get->toInt('booking_id'))->getData();
				$booking_arr['table_arr'] = pjBookingTableModel::factory()
					->select("t1.*, t2.name")
					->join('pjTable', 't1.table_id = t2.id')
					->where('t1.booking_id', $booking_arr['id'])
					->findAll()
					->getData();
				$tokens = self::getTokens($this->option_arr, $booking_arr, $booking_arr['locale_id'], false);
				
				foreach ($notification['i18n'] as &$item)
				{
					$item['subject'] = str_replace($tokens['search'], $tokens['replace'], $item['subject']);
					$item['message'] = str_replace($tokens['search'], $tokens['replace'], $item['message']);
				}
				
				$this->set('arr', array(
					'locale_id' => $booking_arr['locale_id'],
					'to' => $booking_arr['c_email'],
					'from' => self::getAdminEmail(),
					'i18n' => $notification['i18n']
				));

				$this->setLocalesData();
			} else {
				exit;
			}
		}
	}
	public function pjActionCancellation()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if ($this->_post->check('send_cancellation') &&
				$this->_post->toString('to') && $this->_post->toString('from') &&
				$this->_post->toInt('locale_id') && $this->_post->check('i18n'))
			{
				$pjEmail = self::getMailer($this->option_arr);
	
				$locale_id = $this->_post->toInt('locale_id');
				$i18n = $this->_post->toI18n('i18n');

				$subject = $i18n[$locale_id]['subject'];
				$message = $i18n[$locale_id]['message'];
				if (get_magic_quotes_gpc())
				{
					$subject = stripslashes($subject);
					$message = stripslashes($message);
				}
	
				$r = $pjEmail
					->setTo($this->_post->toString('to'))
					->setSubject($subject)
					->send($message);
					
				if ($r)
				{
					self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Email has been sent.'));
				}
				self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Email failed to send.'));
			}
	
			if ($this->_get->toInt('booking_id'))
			{
				$notification = self::getNotification('cancel');
				
				$booking_arr = pjBookingModel::factory()->find($this->_get->toInt('booking_id'))->getData();
				$booking_arr['table_arr'] = pjBookingTableModel::factory()
					->select("t1.*, t2.name")
					->join('pjTable', 't1.table_id = t2.id')
					->where('t1.booking_id', $booking_arr['id'])
					->findAll()
					->getData();
				$tokens = self::getTokens($this->option_arr, $booking_arr, $booking_arr['locale_id'], false);
				
				foreach ($notification['i18n'] as &$item)
				{
					$item['subject'] = str_replace($tokens['search'], $tokens['replace'], $item['subject']);
					$item['message'] = str_replace($tokens['search'], $tokens['replace'], $item['message']);
				}
				
				$this->set('arr', array(
					'locale_id' => $booking_arr['locale_id'],
					'to' => $booking_arr['c_email'],
					'from' => self::getAdminEmail(),
					'i18n' => @$notification['i18n'],
				));

				$this->setLocalesData();
			} else {
				exit;
			}
		}
	}
	
	protected static function getNotification($variant='confirmation', $recipient='client', $transport='email')
	{
		$pjNotificationModel = pjNotificationModel::factory();
		$notification = $pjNotificationModel
			->select("t1.*, CONCAT_WS('_', t1.recipient, t1.transport, t1.variant) AS `index`")
			->where('t1.recipient', $recipient)
			->where('t1.transport', $transport)
			->where('t1.variant', $variant)
			->limit(1)
			->findAll()
			->getDataIndex(0);
		
		if ($notification)
		{
			$i18n = pjBaseMultiLangModel::factory()
				->whereIn('t1.foreign_id', $pjNotificationModel->getDataPair(null, 'id'))
				->where('t1.model', 'pjNotification')
				->findAll()
				->getData();
			
			$notification['i18n'] = array();
			foreach ($i18n as $item)
			{
				if ($notification['id'] == $item['foreign_id'])
				{
					$notification['i18n'][$item['locale']][$item['field']] = $item['content'];
				}
			}
		}
		
		return $notification;
	}
}
?>