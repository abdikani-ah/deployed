<?php
$week_start = isset($tpl['option_arr']['o_week_start']) && in_array((int) $tpl['option_arr']['o_week_start'], range(0,6)) ? (int) $tpl['option_arr']['o_week_start'] : 0;
$jqDateFormat = pjUtil::momentJsDateFormat($tpl['option_arr']['o_date_format']);

$time_format = 'HH:mm';
if((strpos($tpl['option_arr']['o_time_format'], 'a') > -1))
{
    $time_format = 'hh:mm a';
}
if((strpos($tpl['option_arr']['o_time_format'], 'A') > -1))
{
    $time_format = 'hh:mm A';
}
$months = __('months', true);
ksort($months);
$short_days = __('short_days', true);
?>

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-10">
                <h2><?php __('infoScheduleTitle') ?></h2>
            </div>
        </div><!-- /.row -->

        <p class="m-b-none"><i class="fa fa-info-circle"></i> <?php __('infoScheduleDesc') ?></p>
    </div><!-- /.col-md-12 -->
</div>
<div id="dateTimePickerOptions" style="display:none;" data-wstart="<?php echo (int) $tpl['option_arr']['o_week_start']; ?>" data-dateformat="<?php echo pjUtil::toMomemtJS($tpl['option_arr']['o_date_format']); ?>" data-format="<?php echo pjUtil::toMomemtJS($tpl['option_arr']['o_date_format']); ?> <?php echo $time_format;?>" data-months="<?php echo implode("_", $months);?>" data-days="<?php echo implode("_", $short_days);?>"></div>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-lg-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content">
                    <div class="row m-b-md">
                        <div class="col-md-4">
                            <a href="javascript:void(0)" class="btn btn-primary btn-outline btnFilter" rev="<?php echo pjDateTime::formatDate(date('Y-m-d'), 'Y-m-d', $tpl['option_arr']['o_date_format'])?>" data-href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionPaper&amp;date=[DATE]"><i class="fa fa-calendar-check-o"></i> <?php __('lblToday');?></a>
                            <a href="javascript:void(0)" class="btn btn-primary btn-outline btnFilter" rev="<?php echo pjDateTime::formatDate(date('Y-m-d', time() + (24*60*60)), 'Y-m-d', $tpl['option_arr']['o_date_format']);?>" data-href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionPaper&amp;date=[DATE]"><i class="fa fa-calendar-check-o"></i> <?php __('lblTomorrow');?></a>
                        </div><!-- /.col-md-6 -->

                        <div class="col-md-2">
                            <div class="input-group date"
                                 data-provide="datepicker"
                                 data-date-autoclose="true"
                                 data-date-format="<?php echo $jqDateFormat ?>"
                                 data-date-week-start="<?php echo (int) $tpl['option_arr']['o_week_start'] ?>"
                            >
                                <input type="text" name="schedule_date" id="schedule_date" class="form-control required" value="<?php echo $controller->_get->toString('date') ?: date($tpl['option_arr']['o_date_format']); ?>" readonly="readonly" data-href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionPaper&amp;date=[DATE]"/>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div><!-- /.col-md-3 -->

                        <div class="col-md-2 col-md-offset-4 text-right">
                            <a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionPaper&amp;date=<?php echo pjDateTime::formatDate(date('Y-m-d'), 'Y-m-d', $tpl['option_arr']['o_date_format'])?>" target="_blank" class="btn btn-primary btn-outline btnPrint"><i class="fa fa-print"></i> <?php __('lblPrint') ?></a>
                        </div><!-- /.col-md-6 -->
                    </div><!-- /.row -->

                    <div class="hr-line-dashed"></div>

                    <div class="boxScheduleOuter">
                        <div id="boxSchedule"><?php include PJ_VIEWS_PATH . 'pjAdminBookings/elements/getSchedule.php'; ?></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
var disabledDates = [];
var disabledWeekDays = [];
var enabledDates = [];
<?php
foreach($tpl['date_arr'] as $k => $v)
{
    if($v['is_dayoff'] == 'T')
    {
        ?>disabledDates.push("<?php echo date('n-j-Y', strtotime($v['date']));?>");<?php
    }else{
        ?>enabledDates.push("<?php echo date('n-j-Y', strtotime($v['date']));?>");<?php
    }
}
$week_arr = array('sunday'=>0,'monday'=>1,'tuesday'=>2,'wednesday'=>3,'thursday'=>4,'friday'=>5,'saturday'=>6);
foreach($tpl['week_dayoff_arr'] as $k => $v)
{
    ?>disabledWeekDays.push(<?php echo $week_arr[$k];?>);<?php
}
?>
</script>