
START TRANSACTION;

UPDATE `multi_lang` SET `content` = '{FirstName}, booking reminder {Table}' WHERE `foreign_id` = 1 AND `model` = "pjOption" AND `field` = "o_reminder_sms_message";

COMMIT;