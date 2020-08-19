<?php
$date = $controller->_get->toString('date') ?: date($tpl['option_arr']['o_date_format']);
if ($tpl['wt_arr'] === false) {
    ?>
    <div class="alert alert-warning">
        <i class="fa fa-info-circle m-r-xs"></i>
        <strong><?php echo sprintf(__('lblDateIsDayOff', true, false), $date) ?></strong>
    </div>
    <?php
} else {
    $offset = pjUtil::getOffset($tpl['wt_arr']);

    $numOfHours = abs($tpl['wt_arr']['start_hour'] - $tpl['wt_arr']['end_hour'] - $offset);
    if (count($tpl['arr']) > 0) {
        $hour_interval = 3600;
        $min_interval = 300;
        ?>
        <div class="table-responsive text-center">
            <table class="table table-bordered table-striped table-hover dTable text-center">
                <tbody>
                    <tr>
                        <td class="dHeadcol text-left"><?php __('lblTableHour');?></td>
                        <?php
                        $date = pjDateTime::formatDate($date, $tpl['option_arr']['o_date_format']);
                        $stime = strtotime($date . ' ' . $tpl['wt_arr']['start_hour'] . ':' . $tpl['wt_arr']['start_minutes']);
                        if($offset == 0)
                        {
                            $etime = strtotime($date . ' ' . $tpl['wt_arr']['end_hour'] . ':' . $tpl['wt_arr']['end_minutes']);
                        }else{
                            $etime = strtotime($date . ' ' . $tpl['wt_arr']['end_hour'] . ':' . $tpl['wt_arr']['end_minutes']) + 86400;
                        }
                        $limit = $etime - ($tpl['option_arr']['o_booking_length'] * 60);
                        for ($i = $stime; $i < $etime; $i += $hour_interval)
                        {
                            $time = date($tpl['option_arr']['o_time_format'], $i);
                            ?><td colspan="12" class="dHead text-center"><?php echo $time; ?> </td><?php
                        }
                        ?>
                    </tr>
                    <?php
                    foreach ($tpl['arr'] as $k => $table)
                    {
                        ?>
                        <tr>
                            <td class="dHeadcol text-left"><?php echo stripslashes($table['name']); ?></td>
                            <?php
                            $booking_id = null;
                            $colspan = 1;
                            $booking_detail = '';
                            $full_name = '';
                            for ($j = $stime; $j < $etime; $j += $hour_interval)
                            {
                                for($i = $j; $i < ($j + $hour_interval); $i += $min_interval)
                                {
                                    if (isset($table['hour_arr'][$i]) && count($table['hour_arr'][$i]) > 0)
                                    {
                                        $booking = $table['hour_arr'][$i];
                                        $fullname_arr = array();
                                        if(!empty($booking['c_fname'])){
                                            $fullname_arr[] = $booking['c_fname'];
                                        }
                                        if(!empty($booking['c_lname'])){
                                            $fullname_arr[] = $booking['c_lname'];
                                        }

                                        if($booking_id == null)
                                        {
                                            $booking_id = $booking['id'];
                                        }else{
                                            if($booking['id'] == $booking_id)
                                            {
                                                $colspan++;
                                            }else{
                                                ?>
                                                <td colspan="<?php echo $colspan; ?>" class="dSlot tdCenter dSlot_<?php echo $k; ?>">
                                                    <a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionUpdate&amp;id=<?php echo $booking_id; ?>"><?php echo $full_name; ?></a>
                                                    <br/><?php echo $booking_detail;?>
                                                </td>
                                                <?php
                                                $colspan = 1;
                                                $booking_id = $booking['id'];
                                            }
                                        }
                                        $full_name = pjSanitize::clean(join(' ', $fullname_arr));
                                        $booking_detail = $booking['people'] . ' ' . ($booking['people'] > 1 ? __('lblPeople', true, false) : __('lblPerson', true, false));

                                    }else{
                                        if($booking_id != null)
                                        {
                                            ?>
                                            <td colspan="<?php echo $colspan; ?>" class="dSlot tdCenter dSlot_<?php echo $k; ?>">
                                                <a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionUpdate&amp;id=<?php echo $booking_id; ?>"><?php echo $full_name; ?></a>
                                                <br/><?php echo $booking_detail;?>
                                            </td>
                                            <?php
                                            $booking_id = null;
                                            $colspan = 1;
                                            $booking_detail = '';
                                        }
                                        if($i <= $limit)
                                        {
                                            $play = $tpl['option_arr']['o_booking_earlier'] * 60;
                                            if (time() + $play > $i)
                                            {
                                                ?><td class="dSlot tdCenter dSlot_<?php echo $k; ?>">-</td><?php
                                            }else{
                                                ?><td class="dSlot tdCenter dSlot_<?php echo $k; ?>"><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionCreate&amp;date=<?php echo $date; ?>&amp;hour=<?php echo $i; ?>&amp;table_id=<?php echo $table['id'];?>">+</a></td><?php
                                            }
                                        }else{
                                            ?><td class="dSlot tdCenter dSlot_<?php echo $k; ?>">-</td><?php
                                        }
                                    }
                                }
                            }
                            $v = $i - $min_interval;
                            if (isset($table['hour_arr'][$v]) && count($table['hour_arr'][$v]) > 0)
                            {
                                $booking = $table['hour_arr'][$v];
                                $fullname_arr = array();
                                if(!empty($booking['c_fname'])){
                                    $fullname_arr[] = $booking['c_fname'];
                                }
                                if(!empty($booking['c_lname'])){
                                    $fullname_arr[] = $booking['c_lname'];
                                }
                                $booking_detail = $booking['people'] . ' ' . ($booking['people'] > 1 ? __('lblPeople', true, false) : __('lblPerson', true, false));
                                $colspan = intval(($tpl['option_arr']['o_booking_length'] * 60)/$min_interval);
                                $mark = strtotime(date('Y-m-d H:i:s', strtotime($booking['dt_to'])));
                                ?>
                                <td colspan="<?php echo $colspan; ?>" class="dSlot tdCenter dSlot_<?php echo $k; ?>">
                                    <a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionUpdate&amp;id=<?php echo $booking_id; ?>"><?php echo $full_name; ?></a>
                                    <br/><?php echo $booking_detail;?>
                                </td>
                                <?php
                                for($last = $mark; $last < $etime; $last += $min_interval)
                                {
                                    ?><td class="dSlot tdCenter dSlot_<?php echo $k; ?>">-</td><?php
                                }
                            }
                            ?>
                        </tr>
                        <?php
                    }
                    ?>
                </tbody>
            </table>
        </div>
        <?php
    } else {
        ?>
        <div class="alert alert-warning">
            <i class="fa fa-info-circle m-r-xs"></i>
            <strong><?php __('lblNoTable') ?></strong>
        </div>
        <?php
    }
}
?>