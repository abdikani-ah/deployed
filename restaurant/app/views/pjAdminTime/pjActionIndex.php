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
	        case in_array($error_code, array('AT01', 'AT02')):
	            ?>
				<div class="alert alert-success">
					<i class="fa fa-check m-r-xs"></i>
					<strong><?php echo @$titles[$error_code]; ?></strong>
					<?php echo @$bodies[$error_code]?>
				</div>
				<?php
				break;
            case in_array($error_code, array('AT09', 'AT10')):
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
        ?>
        
        <div class="row">
	        <div class="col-lg-12">
	            <div class="tabs-container tabs-reservations m-b-lg">
	                <ul class="nav nav-tabs">
	                    <li class="active"><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminTime&amp;action=pjActionIndex"><?php __('lblDefault'); ?></a></li>
	                    <?php if ($hasAccessScriptCustomTime) : ?>
	                    <li><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminTime&amp;action=pjActionCustom"><?php __('lblCustom'); ?></a></li>
	                    <?php endif; ?>
	                </ul>
	                <div class="tab-content">
	                    <div role="tabpanel" class="tab-pane active" id="default">
	                        <div class="panel-body">
	                            <?php include PJ_VIEWS_PATH . 'pjAdminTime/elements/default.php'; ?>
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

<script type="text/javascript">
var pjGrid = pjGrid || {};
pjGrid.jsDateFormat = "<?php echo pjUtil::jsDateFormat($tpl['option_arr']['o_date_format']); ?>";
var myLabel = myLabel || {};
myLabel.date = "<?php __('lblDate', false, true); ?>";
myLabel.start_time = "<?php __('lblStartTime', false, true); ?>";
myLabel.end_time = "<?php __('lblEndTime', false, true); ?>";
myLabel.is_day_off = "<?php __('lblIsDayOff', false, true); ?>";
myLabel.delete_selected = "<?php __('plugin_base_delete_selected', false, true); ?>";
myLabel.delete_confirmation = "<?php __('plugin_base_delete_confirmation', false, true); ?>";
</script>