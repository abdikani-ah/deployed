<?php
if ($tpl['option_arr']['o_use_map'] == 1) {
	?>
	<div class="wrapper wrapper-content">
		<div class="middle-box text-center animated fadeInRightBig">
			<h3 class="font-bold"><?php __('plugin_base_access_denied_title'); ?></h3>
			<div class="error-desc">
				<?php __('infoUseMapDesc'); ?>
			</div>
		</div>
	</div>
	<?php
} else {
	?>
	<div class="row wrapper border-bottom white-bg page-heading">
		<div class="col-sm-12">
			<div class="row">
				<div class="col-sm-12">
					<h2><?php __('infoTablesTitle') ?></h2>
				</div>
			</div><!-- /.row -->

			<p class="m-b-none"><i class="fa fa-info-circle"></i><?php __('infoTablesDesc') ?></p>
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
				case in_array($error_code, array('AT03', 'AT05')):
					?>
					<div class="alert alert-success">
						<i class="fa fa-check m-r-xs"></i>
						<strong><?php echo @$titles[$error_code]; ?></strong>
						<?php echo @$bodies[$error_code]?>
					</div>
					<?php
					break;
				case in_array($error_code, array('AT04', 'AT08')):
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
			<div class="<?php echo $tpl['has_access_create']? 'col-lg-8': 'col-lg-12' ?>">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div id="grid"></div>
					</div>
				</div>
			</div><!-- /.col-lg-8 -->

			<?php if ($tpl['has_access_create']): ?>
				<div class="col-lg-4">
					<div class="panel no-borders">
						<div class="panel-heading bg-completed">
							<p class="lead m-n"><?php __('lblAddTable') ?></p>
						</div><!-- /.panel-heading -->
	
						<div class="panel-body">
							<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminTables&amp;action=pjActionCreate" method="post"  id="frmCreateTable" autocomplete="off">
								<input type="hidden" name="table_create" value="1" />
	
								<div class="form-group">
									<label class="control-label"><?php __('plugin_base_name') ?>:</label>
	
									<input type="text" name="name" class="form-control required" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>" data-msg-remote="<?php __('lblTableNameExist', false, true); ?>">
								</div>
	
								<div class="form-group">
									<label class="control-label"><?php __('lblCapacity') ?>:</label>
	
									<input type="text" name="seats" id="seats" class="form-control field-int required" maxlength="5" value="1" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>">
								</div>
	
								<div class="form-group">
									<label class="control-label"><?php __('lblMinimum') ?>:</label>
	
									<input type="text" name="minimum" id="minimum" class="form-control field-int required" maxlength="5" value="1"  data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>" data-msg-validateMinimum="<?php __('lblValidateMinimum', false, true); ?>">
								</div>
	
								<div class="m-t-lg">
									<button class="ladda-button btn btn-primary btn-lg btn-phpjabbers-loader" data-style="zoom-in">
										<span class="ladda-label"><?php __('plugin_base_btn_save'); ?></span>
										<?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
									</button>
								</div>
							</form>
						</div><!-- /.panel-body -->
					</div><!-- /.panel panel-primary -->
				</div><!-- /.col-lg-4 -->
			<?php endif; ?>
		</div>
	</div>

	<script type="text/javascript">
	var pjGrid = pjGrid || {};
	pjGrid.has_update = <?php echo (int) $tpl['has_access_update']; ?>;
	var myLabel = myLabel || {};
	myLabel.name = <?php x__encode('plugin_base_name'); ?>;
	myLabel.mininum = <?php x__encode('lblMinimum'); ?>;
	myLabel.capacity = <?php x__encode('lblCapacity'); ?>;
	myLabel.delete_selected = <?php x__encode('plugin_base_delete_selected'); ?>;
	myLabel.delete_confirmation = <?php x__encode('plugin_base_delete_confirmation'); ?>;
	</script>
	<?php
}
?>