
START TRANSACTION;

ALTER TABLE `orders` ADD `price_packing` DECIMAL(9,2) UNSIGNED NULL AFTER `price`;
ALTER TABLE `categories` ADD `packing_fee` DECIMAL(9,2) UNSIGNED NULL AFTER `order`;

SET @label := 'Categories / Packing Fee';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblCategoryPackingFee', 'backend', @label, 'plugin', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'backend', `label` = @label, `source` = 'plugin', `modified` = NULL;

SET @content := 'Packing fee';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'plugin'
FROM `plugin_base_fields` WHERE `key` = 'lblCategoryPackingFee'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'plugin';

SET @label := 'Orders / Packing Fee';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblPacking', 'backend', @label, 'plugin', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'backend', `label` = @label, `source` = 'plugin', `modified` = NULL;

SET @content := 'Packing fee';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'plugin'
FROM `plugin_base_fields` WHERE `key` = 'lblPacking'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'plugin';

SET @label := 'Packing Fee';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_packing_fee', 'frontend', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'frontend', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'Packing fee';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'front_packing_fee'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

SET @label := 'Reports / Packing Fees';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'report_packing_fees', 'backend', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'backend', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'Packing fees';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'report_packing_fees'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

COMMIT;