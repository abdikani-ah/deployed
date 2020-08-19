<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjWorkingTimeModel extends pjAppModel
{
	protected $primaryKey = 'id';
	
	protected $table = 'working_times';
	
	protected $schema = array(
		array('name' => 'id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'monday_from', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'monday_to', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'monday_dayoff', 'type' => 'enum', 'default' => 'F'),
		array('name' => 'tuesday_from', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'tuesday_to', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'tuesday_dayoff', 'type' => 'enum', 'default' => 'F'),
		array('name' => 'wednesday_from', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'wednesday_to', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'wednesday_dayoff', 'type' => 'enum', 'default' => 'F'),
		array('name' => 'thursday_from', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'thursday_to', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'thursday_dayoff', 'type' => 'enum', 'default' => 'F'),
		array('name' => 'friday_from', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'friday_to', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'friday_dayoff', 'type' => 'enum', 'default' => 'F'),
		array('name' => 'saturday_from', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'saturday_to', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'saturday_dayoff', 'type' => 'enum', 'default' => 'F'),
		array('name' => 'sunday_from', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'sunday_to', 'type' => 'time', 'default' => ':NULL'),
		array('name' => 'sunday_dayoff', 'type' => 'enum', 'default' => 'F')
	);
	
	public static function factory($attr=array())
	{
		return new self($attr);
	}
	
	public function getDaysOff($id)
	{
		$_arr = array();
		$arr = $this->find($id)->getData();
		foreach ($arr as $k => $v)
		{
			if (is_null($v) && (strpos($k, "_from") !== false || strpos($k, "_to") !== false))
			{
				list($key) = explode("_", $k);
				$_arr[$key] = 1;
			}
		}
		return $_arr;
	}
	
	public function getWorkingTime($id, $date)
	{
		$day = strtolower(date("l", strtotime($date)));
		$arr = $this->find($id)->getData();

		if (count($arr) == 0)
		{
			return false;
		}
	
		if ($arr[$day . '_dayoff'] == 'T')
		{
			return array();
		}
		
		$wt = array();
		
		$start = $arr[$day . '_from'];
		$end = $arr[$day . '_to'];
		
		if(!is_null($start))
		{
		    $d = getdate(strtotime($start));
		    $wt['start_hour'] = $d['hours'];
		    $wt['start_minutes'] = $d['minutes'];
		    $wt['start_ts'] = strtotime($date . " " . $start);
		}
		if(!is_null($end))
		{
		    $d = getdate(strtotime($end));
		    $wt['end_hour'] = $d['hours'];
		    $wt['end_minutes'] = $d['minutes'];
		    $wt['end_ts'] = strtotime($date . " " . $end);
		}
		
		return $wt;
	}
}
?>