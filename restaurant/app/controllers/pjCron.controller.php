<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjCron extends pjAppController
{
	public function pjActionReminder()
	{
		$this->setLayout('pjActionEmpty');

		$emails_sent = $sms_sent = 0;

		if ($this->option_arr['o_reminder_enable'] == 'Yes' || $this->option_arr['o_reminder_enable_sms'] == 'Yes')
		{
			if (isset($this->option_arr['o_timezone']))
			{
				pjTimezone::factory()->setAllTimezones($this->option_arr['o_timezone']);
			}
			
		    $pjBookingModel = pjBookingModel::factory();
		    $pjBookingTableModel = pjBookingTableModel::factory();
			$pjMultiLangModel = pjMultiLangModel::factory();
			
			# Email reminder
			if ($this->option_arr['o_reminder_enable'] == 'Yes')
			{
				$pjEmail = self::getMailer($this->option_arr);
				
				$arr = $pjBookingModel
					->where('t1.status', 'confirmed')
					->where('t1.reminder_email', '0')
					->where(sprintf("(NOW() BETWEEN (t1.dt - INTERVAL %u HOUR) AND t1.dt)", $this->option_arr['o_reminder_email_before']))
					->findAll()
					->getData();
				
				foreach ($arr as $booking_arr)
				{
					$pjBookingTableModel
						->reset()
						->select("t1.*, t2.name")
						->join('pjTable', 't1.table_id = t2.id', 'left')
						->where('t1.booking_id', $booking_arr['id']);
					$booking_arr['table_arr'] = $pjBookingTableModel->findAll()->getData();
					
					$locale_id = isset($booking_arr['locale_id']) && (int) $booking_arr['locale_id'] > 0 ? $booking_arr['locale_id'] : $this->getLocaleId();
					
					$data = self::getTokens($this->option_arr, $booking_arr, $locale_id, false);
					
					$i18n = $pjMultiLangModel
						->reset()
						->select('t1.field, t1.content')
						->where('t1.model','pjOption')
						->where('t1.locale', $locale_id)
						->whereIn('t1.field', array('o_reminder_subject', 'o_reminder_body'))
						->limit(2)
						->findAll()
						->getDataPair('field', 'content');
					
					if (isset($i18n['o_reminder_subject'], $i18n['o_reminder_body']) 
						&& !empty($i18n['o_reminder_subject'])
						&& !empty($i18n['o_reminder_body']))
					{
						$message = str_replace($data['search'], $data['replace'], $i18n['o_reminder_body']);
						
						$result = $pjEmail
							->setTo($booking_arr['c_email'])
							->setSubject($i18n['o_reminder_subject'])
							->send(pjUtil::textToHtml($message));
						
						if ($result)
						{
							$pjBookingModel
								->reset()
								->setAttributes(array('id' => $booking_arr['id']))
								->modify(array('reminder_email' => 1));
		
							$emails_sent++;
						}
					}
				}
			}
			
			# SMS reminder
			if ($this->option_arr['o_reminder_enable_sms'] == 'Yes')
			{
				$hours_sms = (int) $this->option_arr['o_reminder_sms_hours'];
					
				$arr = $pjBookingModel
					->reset()
					->where('t1.reminder_sms', '0')
					->where('t1.status', 'confirmed')
					->where("(UNIX_TIMESTAMP() BETWEEN (UNIX_TIMESTAMP(t1.dt) - " . $hours_sms * 3600 . ") AND UNIX_TIMESTAMP(t1.dt) )")
					->findAll()
					->getData();
				foreach ($arr as $booking_arr)
				{
					if (empty($booking_arr['c_phone']))
					{
						continue;
					}
					$locale_id = isset($booking_arr['locale_id']) && (int) $booking_arr['locale_id'] > 0 ? $booking_arr['locale_id'] : $this->getLocaleId();
					$pjBookingTableModel
						->reset()
						->select("t1.*, t2.name")
						->join('pjTable', 't1.table_id = t2.id', 'left')
						->where('t1.booking_id', $booking_arr['id']);
					$booking_arr['table_arr'] = $pjBookingTableModel->findAll()->getData();
					
					$data = self::getTokens($this->option_arr, $booking_arr, $locale_id, true);
					
					$i18n = $pjMultiLangModel
						->reset()
						->select('t1.content')
						->where('t1.model','pjOption')
						->where('t1.locale', $locale_id)
						->where('t1.field', 'o_reminder_sms_message')
						->limit(1)
						->findAll()
						->getDataIndex(0);
					
					if (isset($i18n['content']) && !empty($i18n['content']))
					{
						$message = str_replace($data['search'], $data['replace'], $i18n['content']);
					
						$pjSmsApi = new pjSmsApi();
						
						$result = $pjSmsApi
							->setType('unicode')
							->setApiKey($this->option_arr['plugin_sms_api_key'])
							->setNumber($booking_arr['c_phone'])
							->setText($message)
							->setSender(null)
							->send();
						
						if ($result == 1)
						{
							$pjBookingModel
								->reset()
								->setAttributes(array('id' => $booking_arr['id']))
								->modify(array('reminder_sms' => 1));
							
							$sms_sent++;
						}
					}
				}
			}
		}

		return "{$emails_sent} emails sent. {$sms_sent} SMS sent.";
	}
	
	public function pjActionCancelBookings()
	{
	    $this->setLayout('pjActionEmpty');
	    $option_arr = pjOptionModel::factory()->getPairs($this->getForeignId());
	    $pjBookingModel = pjBookingModel::factory();
	    $ids = $pjBookingModel
	    	->select('t1.id')
		    ->where('status', 'pending')
		    ->where(sprintf("(UNIX_TIMESTAMP(t1.created) < UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL %u MINUTE)))", $option_arr['o_min_hour']))
		    ->findAll()
		    ->getDataPair(null, 'id');
	    
		if ($ids)
		{
			$pjBookingModel->reset()->whereIn('id', $ids)->modifyAll(array('status' => 'cancelled'));
		}
		
		return sprintf(__('cron_cancel_booking_status', true), count($ids));
	}
}
?>