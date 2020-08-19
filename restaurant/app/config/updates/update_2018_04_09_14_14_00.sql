
START TRANSACTION;

INSERT INTO `options` (`foreign_id`, `key`, `tab_id`, `value`, `label`, `type`, `order`, `is_visible`, `style`) VALUES
(1, 'o_min_hour', 2, '30', NULL, 'int', 7, 1, NULL);

UPDATE `options` SET `order` = '8' WHERE `key` = 'o_thank_you_page';
UPDATE `options` SET `order` = '9' WHERE `key` = 'o_payment_disable';

INSERT INTO `plugin_base_fields` VALUES (NULL, 'opt_o_min_hour', 'backend', 'Options / Seats pending time', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Seats pending time', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'opt_o_min_hour_text', 'backend', 'Options / Seats pending time text', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'A period of time, while seats assigned to new bookings with Pending status will not be available for other bookings.', 'plugin');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'lblMinutes', 'backend', 'Label / minutes', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'minutes', 'plugin');

COMMIT;