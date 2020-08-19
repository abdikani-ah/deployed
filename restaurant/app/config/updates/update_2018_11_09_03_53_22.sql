
START TRANSACTION;

SET @id := (SELECT `id` FROM `plugin_base_fields` WHERE `key` = 'multilangTooltip');
UPDATE `plugin_base_multi_lang` SET `content` = 'Select a language by clicking on the corresponding flag and update existing translation.' WHERE `foreign_id` = @id AND `model` = "pjBaseField" AND `field` = "title";

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjBaseBackup_pjActionAutoBackup', 'backend', 'pjBaseBackup_pjActionAutoBackup', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Create automatic back-ups for database and files', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjCron_pjActionReminder', 'backend', 'pjCron_pjActionReminder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send Email and SMS reminders', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjCron_pjActionCancelBookings', 'backend', 'pjCron_pjActionCancelBookings', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel pending bookings after the "Table pending time" is over', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'cron_cancel_booking_status', 'backend', 'cron_cancel_booking_status', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '%u bookings has been cancelled.', 'script');

COMMIT;