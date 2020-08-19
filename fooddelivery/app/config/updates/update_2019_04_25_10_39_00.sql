
START TRANSACTION;

SET @label := 'Terms / Show terms';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_terms_show', 'backend', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'backend', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'Show terms and conditions';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'opt_o_terms_show'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

COMMIT;