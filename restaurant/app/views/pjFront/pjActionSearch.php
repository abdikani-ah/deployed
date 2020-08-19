<?php
$week_start = isset($tpl['option_arr']['o_week_start']) && in_array((int) $tpl['option_arr']['o_week_start'], range(0,6)) ? (int) $tpl['option_arr']['o_week_start'] : 0;
$jqDateFormat = pjUtil::jqDateFormat($tpl['option_arr']['o_date_format']);
$STORE = @$_SESSION[$controller->defaultStore];

$message_arr = __('front_messages', true, false);

$time_ampm = 0;
if(strpos($tpl['option_arr']['o_time_format'], 'a') > -1)
{
    $time_ampm = 1;
}
if(strpos($tpl['option_arr']['o_time_format'], 'A') > -1)
{
    $time_ampm = 2;
}
$booking_earlier = $tpl['option_arr']['o_booking_earlier'] * 60;
$months = __('months', true);
$short_months = __('short_months', true);
ksort($months);
ksort($short_months);
$days = __('days', true);
$short_days = __('short_days', true);
?>
<div class="panel panel-default pjRbMain">
	<header class="panel-heading clearfix pjRbHeader">
		<?php include PJ_VIEWS_PATH . 'pjFront/elements/locale.php';?>
		<div class="text-center pjRbHeaderTitle"><?php __('front_label_select_date_time', false, false);?></div><!-- /.text-center pjRbHeaderTitle -->
	</header><!-- /.panel-heading clearfix pjRbHeader -->

	<div class="panel-body pjRbBody">
		<section class="pjRbSection">

			<div class="pjRbSectionBody">
				<div class="pjRbForm pjRbFormSearch">
					<form id="rbSearchForm_<?php echo $controller->_get->toInt('index') ?>" action="" method="post">
						<input type="hidden" name="step" value="1" />
						
						<div class="row">
							<div class="col-lg-3 col-md-3 col-sm-6 col-xs-6">
								<div class="form-group">
									<label for=""><?php __('front_label_date'); ?>: </label>
									<div id="pjRbCalendarLocale" style="display: none;" data-months="<?php echo implode("_", $months);?>" data-days="<?php echo implode("_", $short_days);?>"></div>
									<div class="input-group pjRbDateTimePicker pjRbDatePicker">
										<input type="text" id="rbDate_<?php echo $controller->_get->toInt('index') ?>" name="date" value="<?php echo isset($STORE) && isset($STORE['date']) ? htmlspecialchars($STORE['date']) : date($tpl['option_arr']['o_date_format']) ; ?>" class="form-control rbSelectorDatepick" readonly/>

										<span class="input-group-addon">
											<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
										</span>
									</div><!-- /.input-group pjRbDateTimePicker pjRbDatePicker -->
								</div><!-- /.form-group -->
							</div><!-- /.col-lg-3 col-md-3 col-sm-6 col-xs-6 -->

							<div class="col-lg-3 col-md-3 col-sm-6 col-xs-6">
								<div class="form-group">
									<label for=""><?php __('front_label_time'); ?>: </label>
									<div id="pjRbTimeWrapper_<?php echo $controller->_get->toInt('index') ?>" >
										<?php
										if(isset($tpl['wt_arr']) || (isset($tpl['previous_wt_arr']) && $tpl['previous_wt_arr']['start_ts'] > $tpl['previous_wt_arr']['end_ts']) )
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
											if(isset($tpl['wt_arr']))
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
											if(isset($tpl['previous_wt_arr']) && $tpl['previous_wt_arr']['start_ts'] > $tpl['previous_wt_arr']['end_ts'])
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
												<input type="text" id="rbTime_<?php echo $controller->_get->toInt('index') ?>" name="time" value="<?php echo isset($STORE) && isset($STORE['time']) ? htmlspecialchars($STORE['time']) : $time ; ?>" class="form-control rbSelectorDatepick" readonly data-period="<?php echo $time_ampm;?>" data-enable="<?php echo join(',', $enable_arr)?>" data-disable="<?php echo join(',', $disable_arr)?>"/>
		
												<span class="input-group-addon">
													<span class="glyphicon glyphicon-time" aria-hidden="true"></span>
												</span>
											</div>
											<?php
										}else{
											?><div class="input-group"><div class="rbDayOffMessage"><?php __('front_label_dayoff');?></div></div><?php
										} 
										?>
									</div>
								</div><!-- /.form-group -->
							</div><!-- /.col-lg-3 col-md-3 col-sm-6 col-xs-6 -->

							<div class="col-lg-2 col-md-2 col-sm-6 col-xs-6">
								<div class="form-group">
									<label for=""><?php __('front_label_people'); ?>: </label>
									
									<div class="input-group pjRbSpinner">
										<input type="text" id="rbPeople_<?php echo $controller->_get->toInt('index') ?>" name="people" class="form-control rbPeople pjRbSpinnerField" value="<?php echo isset($STORE['people']) ? $STORE['people'] : 1;?>" data-min="1" data-max="20" readonly/>

										<span class="input-group-addon pjRbSpinnerAction pjRbSpinnerActionIncrease">-</span>
										<span class="input-group-addon pjRbSpinnerAction pjRbSpinnerActionDecrease">+</span>
									</div><!-- /.input-group pjRbSpinner -->
								</div><!-- /.form-group -->
							</div><!-- /.col-lg-2 col-md-2 col-sm-6 col-xs-6 -->

							<div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
								<div class="form-group pjRbFormActions">
									<button type="button" id="rbCheckAvail_<?php echo $controller->_get->toInt('index') ?>" class="btn btn-block btn-primary rbSelectorButton"><?php __('front_label_check_availability'); ?></button>
								</div><!-- /.form-group pjRbFormActions -->
							</div><!-- /.col-lg-4 col-md-4 col-sm-6 col-xs-6 -->
						</div><!-- /.row -->
						
					</form>
				</div><!-- /.pjRbForm pjRbFormSearch -->
			</div><!-- /.pjRbSectionBody -->
		</section><!-- /.pjRbSection -->
		
	</div><!-- /.panel-body pjRbBody -->
</div><!-- /.panel panel-default pjRbMain -->