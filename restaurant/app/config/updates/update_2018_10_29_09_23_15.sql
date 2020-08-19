
START TRANSACTION;

SET @id := (SELECT `id` FROM `plugin_base_fields` WHERE `key` = 'notifications_main_subtitle');
UPDATE `plugin_base_multi_lang` SET `content` = 'Automated messages are sent both to client and administrator on specific events. Select message type to edit it - enable/disable or just change message text. For SMS notifications you need to enable SMS service. See more <a href="https://www.phpjabbers.com/web-sms/" target="_blank">here</a>.' WHERE `foreign_id` = @id AND `model` = "pjBaseField" AND `field` = "title";

COMMIT;