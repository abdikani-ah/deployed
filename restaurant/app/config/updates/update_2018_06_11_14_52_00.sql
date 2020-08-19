
START TRANSACTION;

SET @label := 'Label / Offline payments';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'script_offline_payment', 'backend', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'backend', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'Offline payments';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'script_offline_payment'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

SET @label := 'Label / Online payments';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'script_online_payment_gateway', 'backend', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'backend', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'Online payments';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'script_online_payment_gateway'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

COMMIT;