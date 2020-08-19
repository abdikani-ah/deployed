START TRANSACTION;

UPDATE `options` SET `value`=60 WHERE `key`='o_booking_earlier';

SET @id := (SELECT `id` FROM `plugin_base_fields` WHERE `key` = 'opt_o_booking_earlier');
UPDATE `plugin_base_multi_lang` SET `content` = 'Reserve X minutes earlier' WHERE `foreign_id` = @id AND `model` = "pjBaseField" AND `field` = "title";

SET @id := (SELECT `id` FROM `plugin_base_fields` WHERE `key` = 'opt_o_booking_earlier_text');
UPDATE `plugin_base_multi_lang` SET `content` = 'minutes' WHERE `foreign_id` = @id AND `model` = "pjBaseField" AND `field` = "title";

SET @id := (SELECT `id` FROM `plugin_base_fields` WHERE `key` = 'front_messages_ARRAY_301');
UPDATE `plugin_base_multi_lang` SET `content` = 'You must reserve [HOUR] minutes before.' WHERE `foreign_id` = @id AND `model` = "pjBaseField" AND `field` = "title";

INSERT INTO `plugin_base_fields` VALUES (NULL, 'front_messages_ARRAY_304', 'arrays', 'front_messages_ARRAY_304', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You cannot make reservation at the passed time.', 'script');

COMMIT;