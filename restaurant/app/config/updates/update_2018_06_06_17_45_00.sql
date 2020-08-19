
START TRANSACTION;

INSERT INTO `options` (`foreign_id`, `key`, `tab_id`, `value`, `label`, `type`, `order`, `is_visible`, `style`) VALUES
(1, 'o_reminder_enable_sms', 6, 'Yes|No::No', 'Yes|No', 'enum', 8, 1, NULL);

SET @label := 'Options / Enable SMS notifications';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'opt_o_reminder_enable_sms', 'backend', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'backend', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'Enable SMS notifications';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'opt_o_reminder_enable_sms'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

COMMIT;