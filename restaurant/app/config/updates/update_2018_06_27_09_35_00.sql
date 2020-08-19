
START TRANSACTION;

INSERT IGNORE INTO `options` (`foreign_id`, `key`, `tab_id`, `value`, `label`, `type`, `order`, `is_visible`, `style`) VALUES 
('1', 'o_bf_include_terms', '4', '1|3::3', 'No|Yes (required)', 'enum', '15', '1', NULL);

SET @label := 'Options / include terms';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'opt_o_bf_include_terms', 'backend', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'backend', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'Terms';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'opt_o_bf_include_terms'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

COMMIT;