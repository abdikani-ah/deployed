<div class="row wrapper border-bottom white-bg page-heading">
	<div class="col-sm-12">
		<div class="row">
			<div class="col-sm-12">
				<h2><?php __('infoMapTitle') ?></h2>
			</div>
		</div><!-- /.row -->

		<p class="m-b-none"><i class="fa fa-info-circle"></i><?php __('infoMapDesc') ?></p>
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
			case in_array($error_code, array('AM01')):
				?>
				<div class="alert alert-success">
					<i class="fa fa-check m-r-xs"></i>
					<strong><?php echo @$titles[$error_code]; ?></strong>
					<?php echo @$bodies[$error_code]?>
				</div>
				<?php
				break;
			case in_array($error_code, array('AM02', 'AM03', 'AM04')):
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
	?>
	<div class="row">
		<div class="col-lg-12">
			<div class="ibox float-e-margins">
				<div class="ibox-content">
					<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminMaps&amp;action=pjActionIndex" method="post" id="frmUpdateMap" class="form-horizontal" enctype="multipart/form-data" autocomplete="off">
						<input type="hidden" name="map_update" value="1" />
						<input type="hidden" name="id" value="1" />
	
						<div class="form-group">
							<label class="col-sm-2 control-label"><?php __('lblUseSeatMap');?></label>
	
							<div class="col-sm-6">
								<div class="m-t-xs">
									<div class="onoffswitch onoffswitch-data">
										<input type="checkbox" class="onoffswitch-checkbox" id="use_map" value="1"<?php echo $tpl['has_access_use_map'] ? null: 'disabled="disabled"' ?><?php echo (int) $tpl['option_arr']['o_use_map'] == 1? ' checked' : NULL ?>>
										<label class="onoffswitch-label" for="use_map">
											<span class="onoffswitch-inner" data-on="<?php __('plugin_base_yesno_ARRAY_T', false, true); ?>" data-off="<?php __('plugin_base_yesno_ARRAY_F', false, true); ?>"></span>
											<span class="onoffswitch-switch"></span>
										</label>
									</div>
								</div><!-- /.m-t-xs -->
	
								<input type="hidden" name="use_map" value="<?php echo (int) $tpl['option_arr']['o_use_map'] ?>">
							</div>
						</div>
	
						<div class="hr-line-dashed"></div>
	
						<div id="boxMap" style="overflow: auto; display: <?php echo (int) $tpl['option_arr']['o_use_map'] == 1? 'block' : 'none'; ?>">
							<?php
							$map = PJ_UPLOAD_PATH . 'maps/map.jpg';
							if (is_file($map)) {
								$size = getimagesize($map);
								?>
								<div id="mapHolder" class="<?php echo $tpl['has_access_manage'] ? 'has_access_manage' : NULL; ?>"
									style="position: relative; overflow: hidden; width: <?php echo $size[0]; ?>px; height: <?php echo $size[1]; ?>px; margin: 0 auto;">
								<?php 
								if (!$tpl['has_access_manage'])
								{
									?><div style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; z-index: 9999"></div><?php
								}
								?>
									<img id="map" src="<?php echo $map; ?>?<?php echo rand(1, 99999); ?>" alt="" style="margin: 0; border: none; position: absolute; top: 0; left: 0; z-index: 500" />
									<?php
									foreach ($tpl['seat_arr'] as $seat)
									{
										?><span rel="hi_<?php echo $seat['id']; ?>" class="rect empty" style="width: <?php echo $seat['width']; ?>px; height: <?php echo $seat['height']; ?>px; left: <?php echo $seat['left']; ?>px; top: <?php echo $seat['top']; ?>px; line-height: <?php echo $seat['height']; ?>px"><span class="rbInnerRect" data-name="hi_<?php echo $seat['id']; ?>"><?php echo stripslashes($seat['name']); ?></span></span><?php
									}
									?>
								</div>
								<div id="hiddenHolder">
									<?php
									foreach ($tpl['seat_arr'] as $seat)
									{
										?><input id="hi_<?php echo $seat['id']; ?>" type="hidden" name="seats[]" value="<?php echo join("|", array($seat['id'], $seat['width'], $seat['height'], $seat['left'], $seat['top'], $seat['name'], $seat['seats'], $seat['minimum'])); ?>" /><?php
									}
									?>
								</div>
								<?php
							}else{
								?>
								<div class="form-group">
									<label class="col-sm-2 control-label"><?php __('lblFile');?></label>
	
									<div class="col-sm-6">
										<div class="fileinput fileinput-new" data-provides="fileinput">
											<span class="btn btn-primary btn-outline btn-file"><span class="fileinput-new"><i class="fa fa-upload m-r-xs"></i><?php __('plugin_base_locale_select_file');?></span>
											<span class="fileinput-exists"><i class="fa fa-upload m-r-xs"></i><?php __('plugin_base_locale_change_file');?></span><input name="path" type="file"></span>
											<span class="fileinput-filename"></span>
	
											<a href="#" class="close fileinput-exists" data-dismiss="fileinput" style="float: none">x</a>
										</div>
									</div>
								</div>
								<?php
							}
							?>
						</div>
	
						<div id="boxManageTables" style="display: <?php echo (int) $tpl['option_arr']['o_use_map'] != 1? 'block' : 'none'; ?>">
								<div class="form-group">
								<label class="col-sm-2 control-label">&nbsp;</label>
	
								<div class="col-sm-6">
									<div class="m-t-sm m-b-sm">
										<h3><?php echo str_replace(array(
												'[STAG]',
												'[ETAG]',
											), array(
												'<a href="' . $_SERVER['PHP_SELF'] . '?controller=pjAdminTables&amp;action=pjActionIndex">',
												'</a>',
											), __('lblManageTables', true)) ?></h3>
									</div>
								</div>
							</div>
						</div>
	
						<div class="box-map-related<?php echo (int) $tpl['option_arr']['o_use_map'] === 1 ? NULL : ' hidden'; ?>">
							<div class="hr-line-dashed"></div>
		
							<div class="form-group">
								<label class="col-sm-2 control-label">&nbsp;</label>
		
								<div class="col-sm-10">
									<?php
									if (is_file($map)) {
										?>
										<button type="button" class="btn btn-danger btn-lg pull-right"<?php echo $tpl['has_access_delete'] ? ' id="btnDeleteMap"' : ' disabled'; ?>><?php __('plugin_base_btn_delete'); ?></button>
										<?php
									}
									?>
		
									<button class="ladda-button btn btn-primary btn-lg btn-phpjabbers-loader" data-style="zoom-in">
										<span class="ladda-label"><?php __('plugin_base_btn_save'); ?></span>
										<?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
									</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div><!-- /.col-lg-12 -->
	</div>
</div>

<div class="modal fade" id="modalUpdateMap" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<button type="button" class="close"
				   data-dismiss="modal">
					   <span aria-hidden="true">&times;</span>
					   <span class="sr-only"><?php __('plugin_base_btn_close') ?></span>
				</button>
				<h4 class="modal-title" id="myModalLabel"><?php __('lblUpdateMapTitle') ?></h4>
			</div>

			<!-- Modal Body -->
			<div class="modal-body">
				<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminMaps&amp;action=pjActionSaveSeat" method="post"  id="frmUpdateSeat" class="form-horizontal" autocomplete="off">
					<input type="hidden" name="seat_id" id="seat_id" />

					<div class="form-group">
						<label class="col-sm-2 control-label">&nbsp;</label>
						<div class="col-sm-10">
							<?php __('lblUpdateMapDesc') ?>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label"><?php __('plugin_base_name') ?></label>
						<div class="col-sm-10">
							<input type="text" name="seat_name" id="seat_name" class="form-control required" data-msg-remote="<?php __('lblTableNameExist', false, true); ?>">
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label"><?php __('lblCapacity') ?></label>
						<div class="col-sm-10">
							<input type="text" name="seat_seats" id="seat_seats" class="form-control field-int required" maxlength="5">
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label"><?php __('lblMinimum') ?></label>
						<div class="col-sm-10">
							<input type="text" name="seat_minimum" id="seat_minimum" class="form-control field-int required" maxlength="5" data-msg-validateMinimum="<?php __('lblValidateMinimum', false, true) ?>">
						</div>
					</div>
				</form>
			</div>

			<!-- Modal Footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary"><?php __('plugin_base_btn_save') ?></button>
				<button type="button" class="btn btn-danger"><?php __('plugin_base_btn_delete') ?></button>
				<button type="button" class="btn btn-default" data-dismiss="modal"><?php __('plugin_base_btn_close') ?></button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
var myLabel = myLabel || {};
myLabel.delete_map_title = <?php x__encode('lblDeleteMap'); ?>;
myLabel.delete_map_text = <?php x__encode('lblDeleteMapConfirm'); ?>;
myLabel.btn_delete = <?php x__encode('plugin_base_btn_delete'); ?>;
myLabel.btn_cancel = <?php x__encode('plugin_base_btn_cancel'); ?>;
</script>