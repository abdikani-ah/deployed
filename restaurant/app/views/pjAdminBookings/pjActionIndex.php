<?php
$statuses = __('booking_statuses', true, false);
$week_start = isset($tpl['option_arr']['o_week_start']) && in_array((int) $tpl['option_arr']['o_week_start'], range(0,6)) ? (int) $tpl['option_arr']['o_week_start'] : 0;
$jqDateFormat = pjUtil::momentJsDateFormat($tpl['option_arr']['o_date_format']);
?>

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-10">
                <h2><?php __('infoBookingListTitle') ?></h2>
            </div>
        </div><!-- /.row -->

        <p class="m-b-none"><i class="fa fa-info-circle"></i> <?php __('infoBookingListDesc') ?></p>
    </div><!-- /.col-md-12 -->
</div>

<div class="row wrapper wrapper-content animated fadeInRight">
    <?php
	$error_code = $controller->_get->toString('err');
	if (!empty($error_code))
    {
    	$titles = __('error_titles', true);
    	$bodies = __('error_bodies', true);
    	switch (true)
    	{
    		case in_array($error_code, array('AB05', 'AB09', 'AB11')):
    			?>
    			<div class="alert alert-success">
    				<i class="fa fa-check m-r-xs"></i>
    				<strong><?php echo @$titles[$error_code]; ?></strong>
    				<?php echo @$bodies[$error_code]?>
    			</div>
    			<?php
    			break;
    		case in_array($error_code, array('AB08', 'AB10', 'AB12')):
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
    <div class="col-lg-12">
        <div class="ibox float-e-margins">
            <div class="ibox-content">
                <div class="row m-b-md">
                    <div class="col-md-4">
                        <a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionCreate" class="btn btn-primary"><i class="fa fa-plus"></i> <?php __('btnAddReservation') ?></a>
                    </div><!-- /.col-md-6 -->

                    <div class="col-md-4 col-sm-8">
                        <form action="" method="get" class="form-horizontal frm-filter">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <button class="btn btn-default pj-button-detailed" type="button">
                                        <i class="fa fa-caret-down"></i>
                                    </button>
                                </div>

                                <input type="text" name="q" placeholder="<?php __('plugin_base_btn_search', false, true); ?>" class="form-control">
                                <div class="input-group-btn">
                                    <button class="btn btn-primary" type="submit">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div><!-- /.col-md-3 -->

                    <div class="col-md-2 col-md-offset-2 text-right">
                        <select name="filter_status" id="filter_status" class="form-control">
                            <option value=""><?php __('plugin_base_lbl_all') ?></option>
                            <?php
                            foreach ($statuses as $k => $v) {
                                ?>
                                <option value="<?php echo $k ?>"<?php echo $k == $controller->_get->toString('status')? ' selected="selected"': null ?>><?php echo pjSanitize::clean($v) ?></option>
                                <?php
                            }
                            ?>
                        </select>
                    </div><!-- /.col-md-6 -->
                </div><!-- /.row -->

                <div class="m-b-md pj-form-filter-advanced" style="display: none;">
                    <form action="" method="get" class="form-horizontal frm-filter-advanced">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-lg-3 col-md-4 control-label"><?php __('lblDateFrom');?></label>

                                    <div class="col-lg-7 col-md-7">
                                        <div class="input-group date"
                                             data-provide="datepicker"
                                             data-date-autoclose="true"
                                             data-date-format="<?php echo $jqDateFormat ?>"
                                             data-date-week-start="<?php echo (int) $tpl['option_arr']['o_week_start'] ?>"
                                        >
                                            <input type="text" name="date_from" id="date_from" class="form-control" value="<?php echo $controller->_get->toString('date_from') ?: null ?>">
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-lg-3 col-md-4 control-label"><?php __('lblDateTo');?></label>

                                    <div class="col-lg-7 col-md-7">
                                        <div class="input-group date"
                                             data-provide="datepicker"
                                             data-date-autoclose="true"
                                             data-date-format="<?php echo $jqDateFormat ?>"
                                             data-date-week-start="<?php echo (int) $tpl['option_arr']['o_week_start'] ?>"
                                        >
                                            <input type="text" name="date_to" id="date_to" class="form-control" value="<?php echo $controller->_get->toString('date_to') ?: null ?>">
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-lg-3 col-md-4 control-label"><?php __('lblTable');?></label>

                                    <div class="col-lg-7 col-md-7">
                                        <select name="table_id" id="table_id" class="form-control">
                                            <option value=""><?php __('plugin_base_choose') ?></option>
                                            <?php
                                            foreach ($tpl['table_arr'] as $v)
                                            {
                                                ?><option value="<?php echo $v['id']; ?>"><?php echo stripslashes($v['name']); ?></option><?php
                                            }
                                            ?>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-lg-3 col-md-4 control-label"><?php __('plugin_base_name');?></label>

                                    <div class="col-lg-7 col-md-7">
                                        <input type="text" id="name" name="name" class="form-control" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-lg-3 col-md-4 control-label"><?php __('plugin_base_email');?></label>

                                    <div class="col-lg-7 col-md-7">
                                        <input type="text" id="email" name="email" class="form-control" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-lg-3 col-md-4 control-label"><?php __('plugin_base_phone');?></label>

                                    <div class="col-lg-7 col-md-7">
                                        <input type="text" id="phone" name="phone" class="form-control" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-lg-3 col-md-4 control-label hidden-sm hidden-xs">&nbsp;</label>

                                    <div class="col-lg-7 col-md-7">
                                        <button type="submit" class="ladda-button btn btn-primary btn-lg pull-left btn-phpjabbers-loader" data-style="zoom-in">
                                            <span class="ladda-label"><?php __('plugin_base_btn_search'); ?></span>
                                            <?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
                                        </button>

                                        <button type="reset" class="ladda-button btn btn-default btn-lg pull-right btn-phpjabbers-loader" data-style="zoom-in">
                                            <span class="ladda-label"><?php __('plugin_base_btn_cancel'); ?></span>
                                            <?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div id="grid"></div>
            </div>
        </div>
    </div><!-- /.col-lg-12 -->
</div>
<script type="text/javascript">
var pjGrid = pjGrid || {};
pjGrid.queryString = "";
<?php
if ($controller->_get->toInt('table_id'))
{
    ?>pjGrid.queryString += "&table_id=<?php echo $controller->_get->toInt('table_id') ?>";<?php
}
if ($controller->_get->toString('status'))
{
    ?>pjGrid.queryString += "&status=<?php echo $controller->_get->toString('status') ?>";<?php
}
if ($controller->_get->toString('date_from'))
{
    ?>pjGrid.queryString += "&date_from=<?php echo $controller->_get->toString('date_from') ?>";<?php
}
if ($controller->_get->toString('date_to'))
{
    ?>pjGrid.queryString += "&date_to=<?php echo $controller->_get->toString('date_to') ?>";<?php
}
if ($controller->_get->toInt('today'))
{
    ?>pjGrid.queryString += "&today=<?php echo $controller->_get->toInt('today') ?>";<?php
}
if ($controller->_get->toInt('next_week'))
{
    ?>pjGrid.queryString += "&next_week=<?php echo $controller->_get->toInt('next_week') ?>";<?php
}
?>
var myLabel = myLabel || {};
myLabel.from_datetime = "<?php __('lblFromDateTime', false, true); ?>";
myLabel.people = "<?php __('lblPeople', false, true); ?>";
myLabel.table = "<?php __('lblTable', false, true); ?>";
myLabel.name = "<?php __('plugin_base_name', false, true); ?>";
myLabel.email = "<?php __('plugin_base_email', false, true); ?>";
myLabel.status = "<?php __('plugin_base_status'); ?>";
myLabel.exported = "<?php __('plugin_base_export', false, true); ?>";
myLabel.delete_selected = "<?php __('plugin_base_delete_selected', false, true); ?>";
myLabel.delete_confirmation = "<?php __('plugin_base_delete_confirmation', false, true); ?>";
myLabel.pending = "<?php echo $statuses['pending']; ?>";
myLabel.confirmed = "<?php echo $statuses['confirmed']; ?>";
myLabel.cancelled = "<?php echo $statuses['cancelled']; ?>";
myLabel.enquiry = "<?php echo $statuses['enquiry']; ?>";
</script>