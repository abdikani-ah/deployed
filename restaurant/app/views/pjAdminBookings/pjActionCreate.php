<?php
$week_start = isset($tpl['option_arr']['o_week_start']) && in_array((int) $tpl['option_arr']['o_week_start'], range(0,6)) ? (int) $tpl['option_arr']['o_week_start'] : 0;
$jqDateFormat = pjUtil::momentJsDateFormat($tpl['option_arr']['o_date_format']);

list($date_from, $time_from) = explode(" ", $tpl['date_from']);
list($hour_from, $minute_from, ) = explode(":", $time_from);

while ((isset($tpl['date_arr'][$date_from]) && $tpl['date_arr'][$date_from] == 'T') || (!isset($tpl['date_arr'][$date_from]) && isset($tpl['week_dayoff_arr'][strtolower(date("l", strtotime($date_from)))])) )
{
    $date_from = date("Y-m-d", strtotime($date_from) + 86400);
}

list($date_to, $time_to) = explode(" ", date('Y-m-d H:i:s', strtotime($date_from . ' ' . $time_from) + ($tpl['option_arr']['o_booking_length'] * 60)));
list($hour_to, $minute_to, ) = explode(":", $time_to);

$time_ampm = 0;
$ampm_from = 'am';
$ampm_to = 'am';
if(strpos($tpl['option_arr']['o_time_format'], 'a') > -1 || strpos($tpl['option_arr']['o_time_format'], 'A') > -1)
{
    if(strpos($tpl['option_arr']['o_time_format'], 'a') > -1)
    {
        $time_ampm = 1;
        $ampm_format = 'a';
    }
    else
    {
        $time_ampm = 2;
        $ampm_format = 'A';
    }

    $_ts = strtotime($tpl['date_from']);
    $hour_from = date('h', $_ts);
    $minute_from = date('i', $_ts);
    $ampm_from = date($ampm_format, $_ts);

    $_ts = strtotime($tpl['date_from']) + ($tpl['option_arr']['o_booking_length'] * 60);
    $hour_to = date('h', $_ts);
    $minute_to = date('i', $_ts);
    $ampm_to = date($ampm_format, $_ts);
}

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
                <h2><?php __('infoAddBookingTitle') ?></h2>
            </div>
        </div><!-- /.row -->

        <p class="m-b-none"><i class="fa fa-info-circle"></i> <?php __('infoAddBookingDesc') ?></p>
    </div><!-- /.col-md-12 -->
</div>

<div class="row wrapper wrapper-content animated fadeInRight">
    <div class="col-lg-9">
        <form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionCreate" method="post" class="" id="frmCreateBooking">
            <input type="hidden" name="booking_create" value="1" />
            <?php
            if($controller->_get->toInt('table_id'))
            {
                ?><input type="hidden" id="tmp_table_id" name="tmp_table_id" value="<?php echo $controller->_get->toInt('table_id') ?>" /><?php
            }
            ?>
			<div id="dateTimePickerOptions" style="display:none;" data-wstart="<?php echo (int) $tpl['option_arr']['o_week_start']; ?>" data-dateformat="<?php echo pjUtil::toMomemtJS($tpl['option_arr']['o_date_format']); ?>" data-format="<?php echo pjUtil::toMomemtJS($tpl['option_arr']['o_date_format']); ?> <?php echo $time_format;?>" data-months="<?php echo implode("_", $months);?>" data-days="<?php echo implode("_", $short_days);?>"></div>
            <div class="tabs-container tabs-reservations m-b-lg">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#order-details" aria-controls="order-details" role="tab" data-toggle="tab"><?php __('lblBookingDetails') ?></a></li>
                    <li role="presentation"><a href="#client-details" aria-controls="client-details" role="tab" data-toggle="tab"><?php __('lblClientDetails') ?></a></li>
                </ul>

                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="order-details">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-6 col-xs-12">
                                    <label class="control-label"><?php __('lblDateTimeFrom') ?></label>

                                    <div class="row">
                                        <div class="col-custom-3">
                                            <div class="form-group">
                                                <div class="input-group date"
                                                         data-provide="datepicker"
                                                         data-date-autoclose="true"
                                                         data-date-format="<?php echo $jqDateFormat ?>"
                                                         data-date-week-start="<?php echo (int) $tpl['option_arr']['o_week_start'] ?>">
                                                    <input type="text" name="date" id="date" class="form-control required" autocomplete="off"
                                                    	value="<?php echo pjDateTime::formatDate($date_from, 'Y-m-d', $tpl['option_arr']['o_date_format']); ?>">
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </div><!-- /.form-group -->
                                        </div>

                                        <div class="col-custom-3">
                                            <?php if(isset($tpl['wt_arr'])): ?>
                                                <?php
                                                $dtHour = pjDateTime::factory()
                                                    ->attr('name', 'hour')
                                                    ->attr('id', 'hour')
                                                    ->attr('class', 'form-control pj-booking-time')
                                                    ->prop('ampm', $time_ampm)
                                                    ->prop('selected', $hour_from);
                                                $dtMinute = pjDateTime::factory()
                                                    ->attr('name', 'minute')
                                                    ->attr('id', 'minute')
                                                    ->attr('class', 'form-control pj-booking-time')
                                                    ->prop('step', 5)
                                                    ->prop('selected', $minute_from);
                                                ?>
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <span class="input-group-btn">
                                                            <?php echo $dtHour->hour() ?>
                                                        </span>

                                                        <span class="input-group-btn">
                                                            <?php echo $dtMinute->minute() ?>
                                                        </span>

                                                        <?php
                                                        if($time_ampm != 0) {
                                                            $dtAmPm = pjDateTime::factory()
                                                                ->attr('name', 'ampm')
                                                                ->attr('id', 'ampm')
                                                                ->attr('class', 'form-control pj-booking-time')
                                                                ->prop('ampm', $time_ampm)
                                                                ->prop('selected', $ampm_from);
                                                            ?>
                                                            <span class="input-group-btn">
                                                                <?php echo $dtAmPm->ampm() ?>
                                                            </span>

                                                            <?php
                                                        }
                                                        ?>
                                                    </div>
                                                </div><!-- /.form-group -->
                                            <?php endif; ?>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 col-xs-12">
                                    <label class="control-label"><?php __('lblDateTimeTo') ?></label>

                                    <div class="row">
                                        <div class="col-custom-3">
                                            <div class="form-group">
                                                <div class="input-group date"
                                                         data-provide="datepicker"
                                                         data-date-autoclose="true"
                                                         data-date-format="<?php echo $jqDateFormat ?>"
                                                         data-date-week-start="<?php echo (int) $tpl['option_arr']['o_week_start'] ?>">
                                                    <input type="text" name="date_to" id="date_to" class="form-control required" autocomplete="off" 
                                                    	value="<?php echo pjDateTime::formatDate($date_to, 'Y-m-d', $tpl['option_arr']['o_date_format']); ?>">
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </div><!-- /.form-group -->
                                        </div>

                                        <div class="col-custom-3">
                                            <?php if(isset($tpl['wt_arr'])): ?>
                                                <?php
                                                $dtHour = pjDateTime::factory()
                                                    ->attr('name', 'hour_to')
                                                    ->attr('id', 'hour_to')
                                                    ->attr('class', 'form-control')
                                                    ->prop('ampm', $time_ampm)
                                                    ->prop('selected', $hour_to);
                                                $dtMinute = pjDateTime::factory()
                                                    ->attr('name', 'minute_to')
                                                    ->attr('id', 'minute_to')
                                                    ->attr('class', 'form-control')
                                                    ->prop('step', 5)
                                                    ->prop('selected', $minute_to);
                                                ?>
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <span class="input-group-btn">
                                                            <?php echo $dtHour->hour() ?>
                                                        </span>

                                                        <span class="input-group-btn">
                                                            <?php echo $dtMinute->minute() ?>
                                                        </span>

                                                        <?php
                                                        if($time_ampm != 0) {
                                                            $dtAmPm = pjDateTime::factory()
                                                                ->attr('name', 'ampm_to')
                                                                ->attr('id', 'ampm_to')
                                                                ->attr('class', 'form-control')
                                                                ->prop('ampm', $time_ampm)
                                                                ->prop('selected', $ampm_to);
                                                            ?>
                                                            <span class="input-group-btn">
                                                                <?php echo $dtAmPm->ampm() ?>
                                                            </span>
                                                            <?php
                                                        }
                                                        ?>
                                                    </div>
                                                </div><!-- /.form-group -->
                                            <?php endif; ?>
                                        </div>
                                    </div>

                                    <input type="hidden" id="validate_datetime" name="validate_datetime" value="<?php echo mt_rand(1, 9999); ?>" data-msg-remote="<?php __('lblValidateDateTime', false, true); ?>"/>
                                </div>
                            </div>

                            <div class="hr-line-dashed"></div>

                            <div class="row">
                                <div class="col-md-3 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblUniqueID') ?></label>

                                        <input type="text" name="uuid" id="uuid" class="form-control" value="<?php echo time(); ?>" data-msg-remote="<?php __('uuid_used', false, true); ?>" />
                                    </div>
                                </div><!-- /.col-md-3 -->

                                <div class="col-md-3 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('plugin_base_status') ?></label>

                                        <select name="status" id="status" class="form-control required" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                            <option value="">-- <?php __('plugin_base_choose'); ?>--</option>
                                            <?php
                                            foreach (__('booking_statuses', true, false) as $k => $v)
                                            {
                                                ?><option value="<?php echo $k; ?>"><?php echo $v; ?></option><?php
                                            }
                                            ?>
                                        </select>
                                    </div>
                                </div><!-- /.col-md-3 -->

                                <div class="col-md-3 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblDepositFee') ?></label>

                                        <div class="input-group">
                                            <input type="text" name="total" id="total" class="form-control number decimal text-right required" value="<?php echo number_format($tpl['option_arr']['o_booking_price'], 2); ?>" data-msg-number="<?php __('pj_please_enter_valid_number', false, true);?>">

                                            <span class="input-group-addon"><?php echo pjCurrency::getCurrencySign($tpl['option_arr']['o_currency'], false) ?></span>
                                        </div>
                                    </div>
                                </div><!-- /.col-md-3 -->

                                <div class="col-md-3 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('plugin_vouchers_voucher_code') ?> <span id="discount_format" class="label label-primary" style="display:none;"></span></label>

                                        <input type="text" name="code" id="code" class="form-control">
                                    </div>
                                </div><!-- /.col-md-3 -->
                            </div><!-- /.row -->

                            <div class="hr-line-dashed"></div>

                            <div class="row">
                                <div class="col-md-3 col-sm-6">
                                    <?php
                                    $plugins_payment_methods = pjObject::getPlugin('pjPayments') !== NULL? pjPayments::getPaymentMethods(): array();
                                    $haveOnline = $haveOffline = false;
                                    foreach ($tpl['payment_titles'] as $k => $v)
                                    {
                                    	if($k == 'creditcard') continue;
                                    	if (array_key_exists($k, $plugins_payment_methods))
                                    	{
                                    		if(!isset($tpl['payment_option_arr'][$k]['is_active']) || (isset($tpl['payment_option_arr']) && $tpl['payment_option_arr'][$k]['is_active'] == 0) )
                                    		{
                                    			continue;
                                    		}
                                    	}else if( (isset($tpl['option_arr']['o_allow_'.$k]) && $tpl['option_arr']['o_allow_'.$k] == 'No') || $k == 'cash' || $k == 'bank' ){
                                    		continue;
                                    	}
                                    	$haveOnline = true;
                                    	break;
                                    }
                                    foreach ($tpl['payment_titles'] as $k => $v)
                                    {
                                    	if($k == 'creditcard') continue;
                                    	if( $k == 'cash' || $k == 'bank' )
                                    	{
                                    		if( (isset($tpl['option_arr']['o_allow_'.$k]) && $tpl['option_arr']['o_allow_'.$k] == 'Yes'))
                                    		{
                                    			$haveOffline = true;
                                    			break;
                                        	}
                                    	}
									}
                                    ?>
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblPaymentMethod') ?></label>

                                        <select name="payment_method" id="payment_method" class="form-control<?php echo $tpl['option_arr']['o_payment_disable'] != 'Yes' ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                            <option value="">-- <?php __('plugin_base_choose'); ?> --</option>
                                            <?php 
                                            if ($haveOnline && $haveOffline)
                                            {
	                                            ?><optgroup label="<?php __('script_online_payment_gateway', false, true); ?>"><?php 
                                            }
                                            ?>
	                                                <?php
	                                                foreach ($tpl['payment_titles'] as $k => $v)
	                                                {
	                                                    if($k == 'creditcard') continue;
	                                                    if (array_key_exists($k, $plugins_payment_methods))
	                                                    {
	                                                        if(!isset($tpl['payment_option_arr'][$k]['is_active']) || (isset($tpl['payment_option_arr']) && $tpl['payment_option_arr'][$k]['is_active'] == 0) )
	                                                        {
	                                                            continue;
	                                                        }
	                                                    }else if( (isset($tpl['option_arr']['o_allow_'.$k]) && $tpl['option_arr']['o_allow_'.$k] == 'No') || $k == 'cash' || $k == 'bank' ){
	                                                        continue;
	                                                    }
	                                                    ?><option value="<?php echo $k; ?>"><?php echo $v; ?></option><?php
	                                                }
	                                                ?>
                                            <?php
                                            if ($haveOnline && $haveOffline)
                                            {
                                            	?>
                                            	</optgroup>
                                            	<optgroup label="<?php __('script_offline_payment', false, true); ?>">
                                            	<?php 
                                            }
                                            ?>
	                                                <?php
	                                                foreach ($tpl['payment_titles'] as $k => $v)
	                                                {
	                                                    if($k == 'creditcard') continue;
	                                                    if( $k == 'cash' || $k == 'bank' )
	                                                    {
	                                                        if( (isset($tpl['option_arr']['o_allow_'.$k]) && $tpl['option_arr']['o_allow_'.$k] == 'Yes'))
	                                                        {
	                                                            ?><option value="<?php echo $k; ?>"><?php echo $v; ?></option><?php
	                                                        }
	                                                    }
	                                                }
	                                                ?>
                                            <?php
                                            if ($haveOnline && $haveOffline)
                                            {
                                            	?></optgroup><?php 
                                            }
                                            ?>
                                        </select>
                                    </div>
                                </div><!-- /.col-md-3 -->

                                <div class="col-md-3 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblDepositPaid') ?></label>
										<div class="clearfix">
                                            <div class="switch onoffswitch-data pull-left">
                                                <div class="onoffswitch">
                                                    <input type="checkbox" class="onoffswitch-checkbox" id="is_paid" name="is_paid">
                                                    <label class="onoffswitch-label" for="is_paid">
                                                        <span class="onoffswitch-inner" data-on="<?php __('plugin_base_yesno_ARRAY_T', false, true); ?>" data-off="<?php __('plugin_base_yesno_ARRAY_F', false, true); ?>"></span>
                                                        <span class="onoffswitch-switch"></span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- /.col-md-3 -->

                                <div class="col-md-2 col-sm-4">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblPeople') ?></label>

                                        <input type="text" name="people" id="people" class="form-control field-int required" value="1" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>"/>
                                    </div>
                                </div><!-- /.col-md-2 -->
                            </div><!-- /.row -->

                            <div class="row boxCC" style="display: none;">
                                <div class="col-md-3 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblCCType') ?></label>

                                        <select name="cc_type" class="form-control">
                                            <option value="">-- <?php __('plugin_base_choose'); ?> --</option>
                                            <?php
                                            foreach (__('cc_types', true, false) as $k => $v)
                                            {
                                                ?><option value="<?php echo $k; ?>"><?php echo $v; ?></option><?php
                                            }
                                            ?>
                                        </select>
                                    </div>
                                </div><!-- /.col-md-3 -->

                                <div class="col-md-3 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblCCNum') ?></label>

                                        <input type="text" name="cc_num" class="form-control" />
                                    </div>
                                </div><!-- /.col-md-3 -->

                                <div class="col-md-3 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblCCExp') ?></label>

                                        <div class="input-group">
                                            <span class="input-group-btn">
                                                <select name="cc_exp_month" class="form-control">
                                                    <option value="">---</option>
                                                    <?php
                                                    $month_arr = __('months', true, false);
                                                    ksort($month_arr);
                                                    foreach ($month_arr as $key => $val)
                                                    {
                                                        ?><option value="<?php echo $key;?>"><?php echo $val;?></option><?php
                                                    }
                                                    ?>
                                                </select>
                                            </span>

                                            <span class="input-group-btn">
                                                <select name="cc_exp_year" class="form-control">
                                                    <option value="">---</option>
                                                    <?php
                                                    $y = (int) date('Y');
                                                    for ($i = $y; $i <= $y + 10; $i++)
                                                    {
                                                        ?><option value="<?php echo $i; ?>"><?php echo $i; ?></option><?php
                                                    }
                                                    ?>
                                                </select>
                                            </span>
                                        </div>
                                    </div>
                                </div><!-- /.col-md-3 -->

                                <div class="col-md-3 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblCCCode') ?></label>

                                        <input type="text" name="cc_code" class="form-control" />
                                    </div>
                                </div><!-- /.col-md-3 -->
                            </div>

                            <div class="hr-line-dashed"></div>

                            <div class="m-b-md">
                                <div class="form-group">
                                    <a href="#" class="btn btn-primary btn-outline m-t-xs btnAddTable"><i class="fa fa-plus"></i> <?php __('lblAddTable') ?></a>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <div class="table-responsive table-responsive-secondary">
                                            <table id="tblBookingTables" class="table table-striped table-hover">
                                                <thead>
                                                    <tr>
                                                        <th><?php __('lblTableName') ?></th>
                                                        <th>&nbsp;</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr class="tblEmptyRow">
                                                        <td><?php __('lblSelectTable') ?></td>
                                                        <td>&nbsp;</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>

                                        <input type="hidden" id="validate_table" name="validate_table" value="" class="required" data-msg-required="<?php __('lblSelectTable');?>"/>
                                    </div>
                                </div>
                            </div>

                            <div class="hr-line-dashed"></div>

                            <div class="clearfix">
                                <button class="ladda-button btn btn-primary btn-lg btn-phpjabbers-loader pull-left" data-style="zoom-in">
                                    <span class="ladda-label"><?php __('plugin_base_btn_save') ?></span>
                                    <?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
                                </button>

                                <button class="btn btn-white btn-lg pull-right" type="button" onclick="window.location.href='<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjAdminBookings&action=pjActionIndex';"><?php __('plugin_base_btn_cancel') ?></button>
                            </div><!-- /.clearfix -->
                        </div>
                    </div>

                    <div role="tabpanel" class="tab-pane" id="client-details">
                        <div class="panel-body">

                            <div class="row">
                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblBookingTitle') ?></label>

                                        <select name="c_title" id="c_title" class="form-control<?php echo $tpl['option_arr']['o_bf_include_title'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                            <option value="">-- <?php __('plugin_base_choose'); ?>--</option>
                                            <?php
                                            $title_arr = pjUtil::getTitles();
                                            $name_titles = __('name_titles', true, false);
                                            foreach ($title_arr as $v)
                                            {
                                                ?><option value="<?php echo $v; ?>"><?php echo $name_titles[$v]; ?></option><?php
                                            }
                                            ?>
                                        </select>
                                    </div>
                                </div><!-- /.col-md-4 -->

                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblBookingFname') ?></label>

                                        <input type="text" name="c_fname" id="c_fname" class="form-control<?php echo $tpl['option_arr']['o_bf_include_fname'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                    </div>
                                </div><!-- /.col-md-4 -->

                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblBookingLname') ?></label>

                                        <input type="text" name="c_lname" id="c_lname" class="form-control<?php echo $tpl['option_arr']['o_bf_include_lname'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                    </div>
                                </div><!-- /.col-md-4 -->
                            </div><!-- /.row -->

                            <div class="row">
                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblBookingEmail') ?></label>

                                        <input type="email" name="c_email" id="c_email" class="form-control email<?php echo $tpl['option_arr']['o_bf_include_email'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>" data-msg-email="<?php __('plugin_base_email_invalid', false, true);?>">
                                    </div>
                                </div><!-- /.col-md-4 -->

                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblBookingPhone') ?></label>

                                        <input type="text" name="c_phone" id="c_phone" class="form-control<?php echo $tpl['option_arr']['o_bf_include_phone'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                    </div>
                                </div><!-- /.col-md-4 -->

                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblBookingCompany') ?></label>

                                        <input type="text" name="c_company" id="c_company" class="form-control<?php echo $tpl['option_arr']['o_bf_include_company'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                    </div>
                                </div><!-- /.col-md-4 -->
                            </div><!-- /.row -->

                            <div class="hr-line-dashed"></div>

                            <div class="row">
                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblBookingAddress') ?></label>

                                        <input type="text" name="c_address" id="c_address" class="form-control<?php echo $tpl['option_arr']['o_bf_include_address'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                    </div>
                                </div><!-- /.col-md-4 -->

                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblBookingCity') ?></label>

                                        <input type="text" name="c_city" id="c_city" class="form-control<?php echo $tpl['option_arr']['o_bf_include_city'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                    </div>
                                </div><!-- /.col-md-4 -->

                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblBookingState') ?></label>

                                        <input type="text" name="c_state" id="c_state" class="form-control<?php echo $tpl['option_arr']['o_bf_include_state'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                    </div>
                                </div><!-- /.col-md-4 -->

                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblBookingZip') ?></label>

                                        <input type="text" name="c_zip" id="c_zip" class="form-control<?php echo $tpl['option_arr']['o_bf_include_zip'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                    </div>
                                </div><!-- /.col-md-4 -->

                                <div class="col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblBookingCountry') ?></label>

                                        <select name="c_country" id="c_country" class="select-countries form-control<?php echo $tpl['option_arr']['o_bf_include_country'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
                                            <option value="">-- <?php __('plugin_base_choose'); ?>--</option>
                                            <?php
                                            foreach ($tpl['country_arr'] as $v)
                                            {
                                                ?><option value="<?php echo $v['id']; ?>"><?php echo stripslashes($v['country_title']); ?></option><?php
                                            }
                                            ?>
                                        </select>
                                    </div>
                                </div><!-- /.col-md-4 -->
                            </div><!-- /.row -->

                            <div class="hr-line-dashed"></div>

                            <div class="form-group">
                                <label class="control-label"><?php __('lblBookingNotes') ?></label>

                                <textarea name="c_notes" id="c_notes" class="form-control form-control-sm<?php echo $tpl['option_arr']['o_bf_include_notes'] == 3 ? ' required' : NULL; ?>" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>"></textarea>
                            </div>

                            <div class="hr-line-dashed"></div>

                            <div class="clearfix">
                                <button class="ladda-button btn btn-primary btn-lg btn-phpjabbers-loader pull-left" data-style="zoom-in">
                                    <span class="ladda-label"><?php __('plugin_base_btn_save') ?></span>
                                    <?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
                                </button>

                                <button class="btn btn-white btn-lg pull-right" type="button" onclick="window.location.href='<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjAdminBookings&action=pjActionIndex';"><?php __('plugin_base_btn_cancel') ?></button>
                            </div><!-- /.clearfix -->
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div><!-- /.col-lg-9 -->
</div><!-- /.wrapper wrapper-content -->

<script type="text/javascript">
var myLabel = myLabel || {};
myLabel.select = '-- <?php __('plugin_base_choose', false, true);?> --';

var isPaymentDisabled = '<?php echo $tpl['option_arr']['o_payment_disable'] ?>';
var disabledDates = [];
var disabledWeekDays = [];
var enabledDates = [];
<?php
foreach($tpl['date_arr'] as $date => $is_dayoff)
{
	if($is_dayoff == 'T')
    {
    	?>disabledDates.push("<?php echo date('n-j-Y', strtotime($date));?>");<?php
    }else{
    	?>enabledDates.push("<?php echo date('n-j-Y', strtotime($date));?>");<?php
    }
}
$week_arr = array('sunday'=>0,'monday'=>1,'tuesday'=>2,'wednesday'=>3,'thursday'=>4,'friday'=>5,'saturday'=>6);
foreach($tpl['week_dayoff_arr'] as $k => $v)
{
    ?>disabledWeekDays.push(<?php echo $week_arr[$k];?>);<?php
}
?>
</script>
