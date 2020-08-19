<?php
if (isset($tpl['arr']) && !empty($tpl['arr']))
{
	?>
	<form action="" method="post" id="frmConfirmation" autocomplete="off" data-locale="<?php echo $tpl['arr']['locale_id']; ?>">
        <input type="hidden" name="send_confirm" value="1" />
        <input type="hidden" name="to" value="<?php echo $tpl['arr']['to']; ?>" />
        <input type="hidden" name="from" value="<?php echo $tpl['arr']['from']; ?>" />
        <input type="hidden" name="locale_id" value="<?php echo $controller->getLocaleId(); ?>" />

        <div class="form-group">
            <label class="control-label"><?php __('booking_subject') ?></label>

            <?php
            foreach ($tpl['lp_arr'] as $v)
            {
                ?>
                <div class="<?php echo $tpl['is_flag_ready'] ? 'input-group ' : NULL;?>pj-multilang-wrap" data-index="<?php echo $v['id']; ?>" style="display: <?php echo (int) $v['is_default'] === 1 ? '' : 'none'; ?>">
                    <input type="text" name="i18n[<?php echo $v['id']; ?>][subject]" class="form-control required" value="<?php echo htmlspecialchars(stripslashes(@$tpl['arr']['i18n'][$v['id']]['subject'])); ?>" />
                    <?php if ($tpl['is_flag_ready']) : ?>
                    <span class="input-group-addon pj-multilang-input"><img src="<?php echo PJ_INSTALL_URL . PJ_FRAMEWORK_LIBS_PATH . 'pj/img/flags/' . $v['file']; ?>" alt="<?php echo pjSanitize::html($v['name']); ?>"></span>
                    <?php endif; ?>
                </div>
                <?php
            }
            ?>
        </div>

        <div class="form-group">
            <label class="control-label"><?php __('booking_message') ?></label>

            <?php
            foreach ($tpl['lp_arr'] as $v)
            {
                ?>
                <div class="<?php echo $tpl['is_flag_ready'] ? 'input-group ' : NULL;?>pj-multilang-wrap" data-index="<?php echo $v['id']; ?>" style="display: <?php echo (int) $v['is_default'] === 0 ? 'none' : 'table'; ?>">
                    <textarea name="i18n[<?php echo $v['id']; ?>][message]" class="form-control required mceEditor" style="width: 400px; height: 260px;"><?php echo htmlspecialchars(stripslashes(@$tpl['arr']['i18n'][$v['id']]['message'])); ?></textarea>
                    <?php if ($tpl['is_flag_ready']) : ?>
                    <span class="input-group-addon pj-multilang-input"><img src="<?php echo PJ_INSTALL_URL . PJ_FRAMEWORK_LIBS_PATH . 'pj/img/flags/' . $v['file']; ?>" alt="<?php echo pjSanitize::html($v['name']); ?>"></span>
                    <?php endif; ?>
                </div>
                <?php
            }
            ?>
        </div>
    </form>
	<?php
}
?>
