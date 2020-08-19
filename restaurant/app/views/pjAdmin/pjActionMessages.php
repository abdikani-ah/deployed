var rbApp = rbApp || {};
rbApp = jQuery_1_8_2.extend(rbApp, {
    locale: {
        button: <?php echo pjAppController::jsonEncode(__('buttons', true)); ?>
    }
});