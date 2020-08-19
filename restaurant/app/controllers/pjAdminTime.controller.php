<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminTime extends pjAdmin
{
	public function pjActionIndex()
	{
	    if (!pjAuth::factory()->hasAccess())
        {
            if (pjAuth::factory('pjAdminTime', 'pjActionCustom')->hasAccess())
            {
                pjUtil::redirect(PJ_INSTALL_URL . "index.php?controller=pjAdminTime&action=pjActionCustom");
            } else {
                $this->sendForbidden();
                return;
            }
        }

        if (self::isPost() && $this->_post->check('working_time'))
        {
            $pjWorkingTimeModel = pjWorkingTimeModel::factory();

            $arr = $pjWorkingTimeModel->find(1)->getData();

            $data = array();
            $data['id'] = 1;

            $weekDays = pjUtil::getWeekdays();
            foreach ($weekDays as $day)
            {
                if (!$this->_post->check($day . '_dayoff'))
                {
                    if ($this->isAmPm())
                    {
                    	$data[$day . '_from'] = date('H:i:s', strtotime($this->_post->toString($day . '_hour_from') . ':' . $this->_post->toString($day . '_minute_from') . ' ' . strtoupper($this->_post->toString($day . '_ampm_from'))));
                    	$data[$day . '_to'] = date('H:i:s', strtotime($this->_post->toString($day . '_hour_to') . ':' . $this->_post->toString($day . '_minute_to') . ' ' . strtoupper($this->_post->toString($day . '_ampm_to'))));
                    } else {
                    	$data[$day . '_from'] = join(":", array($this->_post->toString($day . '_hour_from'), $this->_post->toString($day . '_minute_from'), '00'));
                    	$data[$day . '_to'] = join(":", array($this->_post->toString($day . '_hour_to'), $this->_post->toString($day . '_minute_to'), '00'));
                    }
                    $data[$day . '_dayoff'] = 'F';
                } else {
                	$data[$day . '_dayoff'] = 'T';
                }
            }
            if (count($arr) > 0)
            {
                $pjWorkingTimeModel->reset()->set('id', 1)->erase();
            }
            $pjWorkingTimeModel->reset()->setAttributes($data)->insert();

            pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminTime&action=pjActionIndex&err=AT01");
        }

        $arr = pjWorkingTimeModel::factory()->find(1)->getData();
        
        foreach (pjUtil::getWeekdays() as $k)
        {
        	$this
        		->set($k . '_ampm_from', $this->isAmPm() ? date($this->getAmPmFormat(), strtotime($arr[$k . '_from'])) : 'am')
        		->set($k . '_ampm_to', $this->isAmPm() ? date($this->getAmPmFormat(), strtotime($arr[$k . '_to'])) : 'am');
        }
        
        if ($this->isAmPm())
        {
        	foreach (pjUtil::getWeekdays() as $k)
        	{
        		$arr[$k . '_from'] = date('h:i', strtotime($arr[$k . '_from']));
        		$arr[$k . '_to'] = date('h:i', strtotime($arr[$k . '_to']));
        	}
        }
        
        $this
        	->set('arr', $arr)
	        ->set('time_ampm', $this->getAmPmTime())
	        ->set('ampm_format', $this->getAmPmFormat());

	    $this->appendJs('moment-with-locales.min.js', PJ_THIRD_PARTY_PATH . 'moment/');
        $this->appendCss('datepicker.css', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
	    $this->appendJs('bootstrap-datepicker.js', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
        $this->appendJs('pjAdminTime.js');
	}

	public function pjActionCustom()
	{
        $this->set('has_access_create', pjAuth::factory('pjAdminTime', 'pjActionCreate')->hasAccess());

        if (self::isPost() 
        	&& $this->get('has_access_create')
        	&& $this->_post->has('custom_time', 'date', 'start_hour', 'start_minute', 'end_hour', 'end_minute')
        )
        {
            $date = pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']);

            $data = array();
            $data['is_dayoff'] = $this->_post->has('is_dayoff') ? 'T' : 'F';
            
            if ($this->isAmPm())
            {
            	$data['start_time'] = date('H:i:s', strtotime($date . ' ' .$this->_post->toString('start_hour') . ':' . $this->_post->toString('start_minute') . ' ' . strtoupper($this->_post->toString('start_ampm'))));
            	$data['end_time'] = date('H:i:s', strtotime($date . ' ' .$this->_post->toString('end_hour') . ':' . $this->_post->toString('end_minute') . ' ' . strtoupper($this->_post->toString('end_ampm'))));
            } else {
            	$data['start_time'] = join(":", array($this->_post->toString('start_hour'), $this->_post->toString('start_minute'), '00'));
            	$data['end_time'] = join(":", array($this->_post->toString('end_hour'), $this->_post->toString('end_minute'), '00'));
            }
            
            $pjDateModel = pjDateModel::factory();
            $pjDateModel->where('date', $date)->eraseAll();
            
            $data['date'] = $date;

            $pjDateModel->reset()->setAttributes($data)->insert();

            pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminTime&action=pjActionCustom&err=AT02");
        }
        
        $time_ampm = 0;
        $ampm_format = NULL;
        if ($this->isAmPm())
        {
        	if (strpos($this->option_arr['o_time_format'], 'a') !== false)
        	{
        		$time_ampm = 1;
        		$ampm_format = 'a';
        	} else {
        		$time_ampm = 2;
        		$ampm_format = 'A';
        	}
        }
        
        $this
	        ->set('time_ampm', $time_ampm)
	        ->set('ampm_format', $ampm_format);

	    $this->appendJs('moment-with-locales.min.js', PJ_THIRD_PARTY_PATH . 'moment/');
	    $this->appendCss('datepicker.css', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
	    $this->appendJs('bootstrap-datepicker.js', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
        $this->appendJs('jquery.datagrid.js', PJ_FRAMEWORK_LIBS_PATH . 'pj/js/');
        $this->appendJs('pjAdminTime.js');
	}

	public function pjActionGetDate()
	{
		$this->setAjax(true);

		if ($this->isXHR())
		{
			$pjDateModel = pjDateModel::factory();

			$column = 'date';
			$direction = 'DESC';
			if ($this->_get->check('direction') && $this->_get->check('column') && in_array(strtoupper($this->_get->toString('direction')), array('ASC', 'DESC')))
			{
				$column = $this->_get->toString('column');
				$direction = strtoupper($this->_get->toString('direction'));
			}

			$total = $pjDateModel->findCount()->getData();
			$rowCount = $this->_get->toInt('rowCount') ? $this->_get->toInt('rowCount') : 10;
			$pages = ceil($total / $rowCount);
			$page = $this->_get->toInt('page') ? $this->_get->toInt('page') : 1;
			$offset = ((int) $page - 1) * $rowCount;
			if ($page > $pages)
			{
				$page = $pages;
			}

			$data = $pjDateModel->select('t1.*')
				->orderBy("$column $direction")->limit($rowCount, $offset)->findAll()->getData();

			$yesno = __('plugin_base_yesno', true, false);
			foreach($data as $k => $v){
				$v['start_time'] = date($this->option_arr['o_time_format'], strtotime($v['start_time']));
				$v['end_time'] = date($this->option_arr['o_time_format'], strtotime($v['end_time']));
				$v['is_dayoff'] = $yesno[$v['is_dayoff']];
				$data[$k] = $v;
			}
			self::jsonResponse(compact('data', 'total', 'pages', 'page', 'rowCount', 'column', 'direction'));
		}
		exit;
	}

	public function pjActionDeleteDate()
	{
		$this->setAjax(true);

		if ($this->isXHR())
		{
		    if (!self::isPost())
            {
                self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'HTTP method not allowed.'));
            }

			if (pjDateModel::factory()->setAttributes(array('id' => $this->_get->toInt('id')))->erase()->getAffectedRows() == 1)
			{
				self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Custom working time has been deleted.'));
			} else {
				self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Custom working time has not been deleted.'));
			}
		}
		exit;
	}

	public function pjActionDeleteDateBulk()
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
				pjDateModel::factory()->whereIn('id', $record)->eraseAll();

				self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Custom working times has been deleted.'));
			} else {
				self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Custom working times has not been deleted.'));
			}
		}
		exit;
	}

	public function pjActionUpdate()
	{
		if (self::isPost() && $this->_post->has('custom_time', 'id', 'date', 'start_hour', 'start_minute', 'end_hour', 'end_minute'))
        {
            $date = pjDateTime::formatDate($this->_post->toString('date'), $this->option_arr['o_date_format']);
            $is_dayoff = $this->_post->has('is_dayoff') ? 'T' : 'F';
            
            if ($this->isAmPm())
            {
            	$start_time = date('H:i:s', strtotime($date . ' ' .$this->_post->toString('start_hour') . ':' . $this->_post->toString('start_minute') . ' ' . strtoupper($this->_post->toString('start_ampm'))));
            	$end_time = date('H:i:s', strtotime($date . ' ' .$this->_post->toString('end_hour') . ':' . $this->_post->toString('end_minute') . ' ' . strtoupper($this->_post->toString('end_ampm'))));
            } else {
            	$start_time = join(":", array($this->_post->toString('start_hour'), $this->_post->toString('start_minute'), '00'));
            	$end_time = join(":", array($this->_post->toString('end_hour'), $this->_post->toString('end_minute'), '00'));
            }
            
            # Validate time
            if ($is_dayoff == 'F' && strtotime($start_time) >= strtotime($end_time))
            {
            	pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminTime&action=pjActionUpdate&id=".$this->_post->toInt('id')."&err=AT10");
            }
            
            $pjDateModel = pjDateModel::factory();
            
            $arr = $pjDateModel->find($this->body['id'])->getData();
            
            if ($arr['date'] != $date)
            {
            	$pjDateModel
            		->reset()
	            	->where('id !=', $this->body['id'])
	            	->where('date', $date)
	            	->eraseAll();
            }

            $pjDateModel
            	->reset()
            	->set('id', $this->body['id'])
            	->modify(array(
            		'start_time' => $start_time,
            		'end_time' => $end_time,
            		'date' => $date,
            		'is_dayoff' => $is_dayoff,
            	));

            pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminTime&action=pjActionCustom&err=AT02");
        }

        if (self::isGet() && $this->_get->has('id'))
        {
	        $arr = pjDateModel::factory()->find($this->_get->toInt('id'))->getData();
	        if (!$arr)
	        {
	            pjUtil::redirect(PJ_INSTALL_URL. "index.php?controller=pjAdminTime&action=pjActionCustom&err=AT09");
	        }
	
	        $this->set('arr', $arr);
	        
	        $this
		        ->set('is_ampm', $this->isAmPm())
		        ->set('time_ampm', $this->getAmPmTime())
		        ->set('start_ampm', $this->isAmPm() ? date($this->getAmPmFormat(), strtotime($arr['start_time'])) : 'am')
		        ->set('end_ampm', $this->isAmPm() ? date($this->getAmPmFormat(), strtotime($arr['end_time'])) : 'am')
		        ->set('ampm_format', $this->getAmPmFormat());
	
	        $this->appendJs('moment-with-locales.min.js', PJ_THIRD_PARTY_PATH . 'moment/');
	        $this->appendCss('datepicker.css', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
		    $this->appendJs('bootstrap-datepicker.js', PJ_THIRD_PARTY_PATH . 'bootstrap_datepicker/');
	        $this->appendJs('pjAdminTime.js');
        }
	}
}
?>