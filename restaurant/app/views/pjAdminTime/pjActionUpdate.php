<?php
$week_start = isset($tpl['option_arr']['o_week_start']) && in_array((int) $tpl['option_arr']['o_week_start'], range(0,6)) ? (int) $tpl['option_arr']['o_week_start'] : 0;
$jqDateFormat = pjUtil::jqDateFormat($tpl['option_arr']['o_date_format']);

list($sh, $sm,) = explode(":", $tpl['arr']['start_time']);
list($eh, $em,) = explode(":", $tpl['arr']['end_time']);

if ($tpl['is_ampm'])
{
	$_ts = strtotime($tpl['arr']['start_time']);
	$sh = date('h', $_ts);
	$sm = date('i', $_ts);
	
	$_ts = strtotime($tpl['arr']['end_time']);
	$eh = date('h', $_ts);
	$em = date('i', $_ts);
}
?>

<div class="row wrapper border-bottom white-bg page-heading">
	<div class="col-sm-12">
		<div class="row">
			<div class="col-sm-12">
				<h2><?php __('infoWTimeTitle');?></h2>
			</div>
		</div><!-- /.row -->

		<p class="m-b-none"><i class="fa fa-info-circle"></i><?php __('infoWTimeDesc');?></p>
	</div><!-- /.col-md-12 -->
</div>

<div class="wrapper wrapper-content animated fadeInRight">
	<?php
	$error_code = $controller->_get->toString('err');
	if (!empty($error_code))
	{
	    $titles = __('error_titles', true);
	    $bodies = __('error_bodies', true);
	    switch (true)
	    {
            case in_array($error_code, array('AT10')):
				?>
				<div class="alert alert-danger">
					<i class="fa fa-exclamation-triangle m-r-xs"></i>
					<strong><?php echo @$titles[$error_code]; ?></strong>
					<?php echo @$bodies[$error_code]?>
				</div>
				<?php
				break;
		}
	}
    
	if (isset($tpl['arr']) && is_array($tpl['arr']) && !empty($tpl['arr']))
	{
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
		<div id="dateTimePickerOptions" style="display:none;" data-wstart="<?php echo (int) $tpl['option_arr']['o_week_start']; ?>" data-dateformat="<?php echo pjUtil::toMomemtJS($tpl['option_arr']['o_date_format']); ?>" data-format="<?php echo pjUtil::toMomemtJS($tpl['option_arr']['o_date_format']); ?> <?php echo $time_format;?>" data-months="<?php echo implode("_", $months);?>" data-days="<?php echo implode("_", $short_days);?>"></div>
		<div class="row">
			<div class="col-lg-12">
				<div class="tabs-container tabs-reservations m-b-lg">
					<ul class="nav nav-tabs">
						<li role="presentation" class="active"><a href="#update" aria-controls="update" role="tab" data-toggle="tab"><?php __('lblUpdate'); ?></a></li>
					</ul>
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane active" id="update">
							<div class="panel-body">
								<?php
								$jqDateFormat = pjUtil::momentJsDateFormat($tpl['option_arr']['o_date_format']);
								$yesno = __('plugin_base_yesno', true, false);
								?>
								<form id="frmTimeCustom" action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminTime&amp;action=pjActionUpdate" class="form-horizontal" method="post">
									<input type="hidden" name="custom_time" value="1">
									<input type="hidden" name="id" value="<?php echo $tpl['arr']['id']; ?>">
	
									<div class="form-group">
										<label class="col-sm-2 control-label"><?php __('lblDate'); ?></label>
										<div class="col-lg-5 col-sm-7">
											<div class="row">
												<div class="col-sm-6">
													<div class="input-group date"
														 data-provide="datepicker"
														 data-date-autoclose="true"
														 data-date-format="<?php echo $jqDateFormat ?>"
														 data-date-week-start="<?php echo (int) $tpl['option_arr']['o_week_start'] ?>">
														<input type="text" name="date" id="date" class="form-control required" value="<?php echo pjDateTime::formatDate($tpl['arr']['date'], 'Y-m-d', $tpl['option_arr']['o_date_format']); ?>">
														<span class="input-group-addon">
															<span class="glyphicon glyphicon-calendar"></span>
														</span>
													</div>
												</div>
											</div>
										</div>
									</div>
									<?php 
									$startHour = pjDateTime::factory()
										->attr('name', 'start_hour')
										->attr('id', 'start_hour')
										->attr('class', 'form-control')
										->prop('ampm', $tpl['time_ampm'])
										->prop('selected', $sh);
									
									$startMinute = pjDateTime::factory()
										->attr('name', 'start_minute')
										->attr('id', 'start_minute')
										->attr('class', 'form-control')
										->prop('selected', $sm)
										->prop('step', 5);
									
									$endHour = pjDateTime::factory()
										->attr('name', 'end_hour')
										->attr('id', 'end_hour')
										->attr('class', 'form-control' . ($tpl['arr']['is_dayoff'] == 'F' ? ' greaterThan' : NULL))
										->prop('ampm', $tpl['time_ampm'])
										->prop('selected', $eh);
										
									$endMinute = pjDateTime::factory()
										->attr('name', 'end_minute')
										->attr('id', 'end_minute')
										->attr('class', 'form-control')
										->prop('selected', $em)
										->prop('step', 5);
									
									if ($tpl['time_ampm'])
									{
										$startAmPm = pjDateTime::factory()
											->attr('name', 'start_ampm')
											->attr('id', 'start_ampm')
											->attr('class', 'form-control')
											->prop('ampm', $tpl['time_ampm'])
											->prop('selected', $tpl['start_ampm']);
										
										$endAmPm = pjDateTime::factory()
											->attr('name', 'end_ampm')
											->attr('id', 'end_ampm')
											->attr('class', 'form-control')
											->prop('ampm', $tpl['time_ampm'])
											->prop('selected', $tpl['end_ampm']);
									}
									?>
									<div class="form-group customeTimeRow" style="display:<?php echo $tpl['arr']['is_dayoff'] == 'T' ? 'none' : 'block'; ?>;">
										<label class="col-sm-2 control-label"><?php __('lblStartTime'); ?></label>
										<div class="col-lg-3 col-sm-7">
											
											<div class="input-group">
												<span class="input-group-btn"><?php echo $startHour->hour(); ?></span>
												<span class="input-group-btn"><?php echo $startMinute->minute(); ?></span>
												<?php if ($tpl['time_ampm']) : ?>
												<span class="input-group-btn"><?php echo $startAmPm->ampm(); ?></span>
												<?php endif; ?>
											</div>
											
										</div>
									</div>
	
									<div class="form-group customeTimeRow" style="display:<?php echo $tpl['arr']['is_dayoff'] == 'T' ? 'none' : 'block'; ?>;">
										<label class="col-sm-2 control-label"><?php __('lblEndTime'); ?></label>
										<div class="col-lg-3 col-sm-7">
										
									   		<div class="input-group">
												<span class="input-group-btn"><?php echo $endHour->hour(); ?></span>
												<span class="input-group-btn"><?php echo $endMinute->minute(); ?></span>
												<?php if ($tpl['time_ampm']) : ?>
												<span class="input-group-btn"><?php echo $endAmPm->ampm(); ?></span>
												<?php endif; ?>
											</div>
											
										</div>
									</div>
	
									<div class="form-group">
										<label class="col-sm-2 control-label"><?php __('lblIsDayOff'); ?></label>
										<div class="col-lg-5 col-sm-7">
											<div class="row">
												<div class="col-sm-6">
													<div class="clearfix">
														<div class="switch onoffswitch-data pull-left">
															<div class="onoffswitch">
																<input type="checkbox" class="onoffswitch-checkbox" id="is_dayoff" name="is_dayoff" value="T"<?php echo $tpl['arr']['is_dayoff'] == 'T' ? ' checked="checked"' : NULL; ?>>
																<label class="onoffswitch-label" for="is_dayoff">
																	<span class="onoffswitch-inner" data-on="<?php echo $yesno['T'] ?>" data-off="<?php echo $yesno['F'] ?>"></span>
																	<span class="onoffswitch-switch"></span>
																</label>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
	
									<div class="form-group">
										<label class="col-sm-2 control-label">&nbsp;</label>
	
										<div class="col-sm-10">
											<button class="ladda-button btn btn-primary btn-lg btn-phpjabbers-loader" data-style="zoom-in">
												<span class="ladda-label"><?php __('plugin_base_btn_save'); ?></span>
												<?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
											</button>
	
											<a class="btn btn-white btn-lg pull-right" href="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjAdminTime&action=pjActionCustom"><?php __('plugin_base_btn_cancel'); ?></a>
										</div>
									</div>
								</form>
							</div><!-- /.panel-body -->
						</div><!-- /.tab-pane -->
					</div><!-- /.tab-content -->
				</div><!-- /.tabs-container tabs-reservations m-b-lg -->
			</div><!-- /.col-lg-12 -->
		</div>
		<?php
	}
	?>
</div>