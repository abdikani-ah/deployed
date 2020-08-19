<?php
$STORE = @$_SESSION[$controller->defaultStore];
$time_ampm = 0;
if(strpos($tpl['option_arr']['o_time_format'], 'a') > -1)
{
    $time_ampm = 1;
}
if(strpos($tpl['option_arr']['o_time_format'], 'A') > -1)
{
    $time_ampm = 2;
}
if($tpl['wt_arr'] != false /* || ($tpl['previous_wt_arr'] != false && $tpl['previous_wt_arr']['start_ts'] > $tpl['previous_wt_arr']['end_ts'])  */)
{
    $hour_arr = array();
    $enable_arr = array();
    $disable_arr = array();
    
    for($i = 0; $i <= 24; $i++)
    {
        $hour_arr[] = $i;
    }
    $time = NULL;
    $booking_length = ceil((int) $tpl['option_arr']['o_booking_length'] / 60);
    $booking_earlier = $tpl['option_arr']['o_booking_earlier'] * 60;
    if($tpl['wt_arr'] != false)
    {
        # Fix 24h support
    	$offset = pjUtil::getOffset($tpl['wt_arr']);
        
        $start = (int) $tpl['wt_arr']['start_hour'];
        $end = (int) $tpl['wt_arr']['end_hour'] - $booking_length + $offset;
        
        $start_ts = (int) $tpl['wt_arr']['start_ts'];
        $end_ts = (int) $tpl['wt_arr']['end_ts'];
        if($offset == 24)
        {
            $end_ts = strtotime(date('Y-m-d 00:00:00', $tpl['wt_arr']['start_ts'] + 86400) );
            if(($tpl['wt_arr']['end_ts'] + 86400) - $booking_length <= $end_ts)
            {
                $end_ts = $tpl['wt_arr']['end_ts'] + 86400 - $booking_length;
            }
        }
        for($i = $start_ts; $i < $end_ts; $i += 300)
        {
            if($i >=  time() + $booking_earlier)
            {
                if(empty($enable_arr))
                {
                    $time = date("H:i", $i);
                    if($time_ampm > 0)
                    {
                        $time = date("h:i A", $i);
                    }
                }
                $enable_arr[] = date('G', $i);
            }
        }
    }
    if($tpl['previous_wt_arr'] != false && $tpl['previous_wt_arr']['start_ts'] > $tpl['previous_wt_arr']['end_ts'])
    {
        $tpl['previous_wt_arr']['end_ts'] += 86400;
        
        $previous_start_ts = strtotime(date('Y-m-d 00:00:00', $tpl['previous_wt_arr']['end_ts']) );
        if($tpl['previous_wt_arr']['end_ts'] - $booking_length > $previous_start_ts)
        {
            for($i = $previous_start_ts; $i <= $tpl['previous_wt_arr']['end_ts']; $i += 300)
            {
                if($i >= time() + $booking_earlier)
                {
                    if(empty($enable_arr))
                    {
                        $time = date("H:i", $i);
                        if($time_ampm > 0)
                        {
                            $time = date("h:i A", $i);
                        }
                    }
                    $enable_arr[] = date('G', $i);
                }
            }
        }
    }
    asort($enable_arr);
    $enable_arr = array_unique($enable_arr);
    $disable_arr = array_diff($hour_arr, $enable_arr);
    ?>
	<div class="input-group pjRbDateTimePicker pjRbTimePicker">
		<input type="text" id="rbTime_<?php echo $controller->_get->toInt('index') ?>" name="time" value="<?php echo $time; ?>" class="form-control" readonly data-period="<?php echo $time_ampm;?>" data-enable="<?php echo join(',', $enable_arr)?>" data-disable="<?php echo join(',', $disable_arr)?>"/>
		
		<span class="input-group-addon">
			<span class="glyphicon glyphicon-time" aria-hidden="true"></span>
		</span>
	</div>
	<?php
}else{
	?><div class="input-group"><div class="rbDayOffMessage"><?php __('front_label_dayoff');?></div></div><?php
}
?>