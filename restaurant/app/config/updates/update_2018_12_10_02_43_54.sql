
START TRANSACTION;

SET @id := (SELECT `id` FROM `plugin_base_fields` WHERE `key` = 'front_messages_ARRAY_303');
UPDATE `plugin_base_multi_lang` SET `content` = 'We are closed.' WHERE `foreign_id` = @id AND `model` = "pjBaseField" AND `field` = "title";

COMMIT;