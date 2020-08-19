
START TRANSACTION;

INSERT INTO `options` (`foreign_id`, `key`, `tab_id`, `value`, `label`, `type`, `order`, `is_visible`, `style`) VALUES
(1, 'o_terms_show', 5, '1|0::1', 'Yes|No', 'enum', 1, 1, NULL)
ON DUPLICATE KEY UPDATE `options`.`value` = '1|0::1', `label` = 'Yes|No', `type` = 'enum';

COMMIT;