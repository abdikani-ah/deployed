<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjBookingModel extends pjAppModel
{
	protected $primaryKey = 'id';
	
	protected $table = 'bookings';
	
	protected $schema = array(
		array('name' => 'id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'uuid', 'type' => 'int', 'default' => ':NULL'),
	    array('name' => 'locale_id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'dt', 'type' => 'datetime', 'default' => ':NULL'),
		array('name' => 'dt_to', 'type' => 'datetime', 'default' => ':NULL'),
		array('name' => 'people', 'type' => 'smallint', 'default' => ':NULL'),
		array('name' => 'code', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'total', 'type' => 'decimal', 'default' => ':NULL'),
		array('name' => 'payment_method', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'is_paid', 'type' => 'enum', 'default' => 'F'),
		array('name' => 'status', 'type' => 'enum', 'default' => ':NULL'),
		array('name' => 'txn_id', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'processed_on', 'type' => 'datetime', 'default' => ':NULL'),
		array('name' => 'created', 'type' => 'datetime', 'default' => ':NOW()'),
		array('name' => 'ip', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'c_title', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'c_fname', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'c_lname', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'c_phone', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'c_email', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'c_company', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'c_notes', 'type' => 'text', 'default' => ':NULL'),
		array('name' => 'c_address', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'c_city', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'c_state', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'c_zip', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'c_country', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'cc_type', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'cc_num', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'cc_exp', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'cc_code', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'reminder_email', 'type' => 'tinyint', 'default' => 0),
		array('name' => 'reminder_sms', 'type' => 'tinyint', 'default' => 0)
	);
	
	public static function factory($attr=array())
	{
		return new self($attr);
	}
	
	public function getBookings($table_id, $date, $wt_arr)
	{
		if ($wt_arr === false)
		{
			return false;
		}

		$offset = pjUtil::getOffset($wt_arr);
		
		$stime = $wt_arr['start_ts'];
		if($offset == 0)
		{
			$etime = $wt_arr['end_ts'];
		}else{
			$etime = $wt_arr['end_ts'] + 86400;
		}

		$arr = $this->reset()
					->join('pjBookingTable', 't2.booking_id = t1.id AND t2.table_id = ' . $table_id, 'inner')
			 		->where("( (UNIX_TIMESTAMP(t1.dt) BETWEEN $stime AND $etime) OR (UNIX_TIMESTAMP(t1.dt_to) BETWEEN $stime AND $etime) ) AND (t1.status='confirmed' OR t1.status='pending')")
			 		->findAll()->getData();	
		
		$h_arr = array();
		
		$hour_interval = 3600;
		$min_interval = 300;
		
		for ($j = $stime; $j <= $etime; $j += $hour_interval)
		{
			for($i = $j; $i < ($j + $hour_interval); $i += $min_interval)
			{
				$h_arr[$i] = array();
				
				foreach ($arr as $booking)
				{
					if ($i >= strtotime($booking['dt']) && $i < strtotime($booking['dt_to']))
					{
						$h_arr[$i] = $booking;
						break;
					}
					
				}
				
			}
		}
		return $h_arr;
	}
}
?>