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
                    <h2><?php __('infoUpdateTableTitle') ?></h2>
                </div>
            </div><!-- /.row -->

            <p class="m-b-none"><i class="fa fa-info-circle"></i><?php __('infoUpdateTableDesc') ?></p>
        </div><!-- /.col-md-12 -->
    </div>

    <div class="row wrapper wrapper-content animated fadeInRight">
        <div class="col-lg-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content">
                    <form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminTables&amp;action=pjActionUpdate" method="post"  id="frmUpdateTable" autocomplete="off">
                        <input type="hidden" name="table_update" value="1" />
					    <input type="hidden" name="id" value="<?php echo $tpl['arr']['id'];?>" />

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="control-label"><?php __('plugin_base_name') ?>:</label>

                                    <input type="text" name="name" class="form-control required" value="<?php echo pjSanitize::clean($tpl['arr']['name']);?>"  data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>" data-msg-remote="<?php __('lblTableNameExist', false, true); ?>">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="control-label"><?php __('lblCapacity') ?>:</label>

                                    <input type="text" name="seats" id="seats" class="form-control field-int required" maxlength="5" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>" value="<?php echo pjSanitize::clean($tpl['arr']['seats']);?>">
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="control-label"><?php __('lblMinimum') ?>:</label>

                                    <input type="text" name="minimum" id="minimum" class="form-control field-int required" maxlength="5" data-msg-required="<?php __('plugin_base_this_field_is_required', false, true);?>" value="<?php echo pjSanitize::clean($tpl['arr']['minimum']);?>" data-msg-validateMinimum="<?php __('lblValidateMinimum', false, true); ?>">
                                </div>
                            </div>
                        </div>

                        <div class="hr-line-dashed"></div>

                        <div class="clearfix">
                            <button class="ladda-button btn btn-primary btn-lg btn-phpjabbers-loader" data-style="zoom-in">
                                <span class="ladda-label"><?php __('plugin_base_btn_save'); ?></span>
                                <?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div><!-- /.col-lg-12 -->
    </div>
    <?php
}
?>