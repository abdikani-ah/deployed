<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjUtil extends pjToolkit
{
    public static function toMomemtJS($format)
    {
        return str_replace(
            array('Y', 'm', 'n', 'd', 'j'),
            array('YYYY', 'MM', 'M', 'DD', 'D'),
            $format);
    }
    
	public static function textToHtml($content)
	{
		$content = preg_replace('/\r\n|\n/', '<br />', $content);
		return '<html><head><title></title></head><body>'.$content.'</body></html>';
	}
	
	public static function getWeekdays(){
		$arr = array();
		$arr[] = 'monday';
		$arr[] = 'tuesday';
		$arr[] = 'wednesday';
		$arr[] = 'thursday';
		$arr[] = 'friday';
		$arr[] = 'saturday';
		$arr[] = 'sunday';
		return $arr;
	}
	
	public static function getClass($arr, $hour)
	{
		$class = NULL;
		if (isset($arr[$hour]) && !empty($arr[$hour]))
		{
			$class = 'calendarStatus' . ucfirst($arr[$hour]['status']);
		}
		return $class;
	}
	
	public static function getTitles(){
		$arr = array();
		$arr[] = 'mr';
		$arr[] = 'mrs';
		$arr[] = 'ms';
		$arr[] = 'dr';
		$arr[] = 'prof';
		$arr[] = 'rev';
		$arr[] = 'other';
		return $arr;
	}
	
	public static function getReferer()
	{
		if (isset($_REQUEST['_escaped_fragment_']))
		{
			if (isset($_SERVER['REDIRECT_URL']))
			{
				return $_SERVER['REDIRECT_URL'];
			}
		}

		if (isset($_SERVER['HTTP_REFERER']))
		{
			$pos = strpos($_SERVER['HTTP_REFERER'], "#");
			if ($pos !== FALSE)
			{
				return substr($_SERVER['HTTP_REFERER'], 0, $pos);
			}
			return $_SERVER['HTTP_REFERER'];
		}
	}
	
	public static function checkDayAfter($wt_arr, $option_arr, $selected)
	{
		$status = false;
		
		$offset = self::getOffset($wt_arr);
		$booking_length = ceil((int) $option_arr['o_booking_length'] / 60);
		$start = (int) $wt_arr['start_hour'];
		$end = (int) $wt_arr['end_hour'] - $booking_length + $offset;
		if ($end < $start){
			$end = $start;
		}
		foreach (range($start, $end) as $v)
		{
			if($v >= 24)
			{
				$v = $v - 24;
				if($v == $selected)
				{
					$status = true;
				}
			}
		}
		return $status;
	}
	
	public static function getOffset($wt_arr)
	{
		$offset = 0;
		if ($wt_arr['end_hour'] < $wt_arr['start_hour'])
		{
			$offset = 24;
		} else if ($wt_arr['end_hour'] == $wt_arr['start_hour'] && $wt_arr['end_minutes'] < $wt_arr['start_minutes']) {
			$offset = 24;
		} else if ($wt_arr['start_hour'] == 0 && $wt_arr['start_minutes'] == 0 && $wt_arr['end_hour'] == 0 && $wt_arr['end_minutes'] == 0) {
			$offset = 24;
		}
		
		return $offset;
	}
}
?>