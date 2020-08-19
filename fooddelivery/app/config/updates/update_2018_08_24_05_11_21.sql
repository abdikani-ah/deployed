
START TRANSACTION;

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjBaseBackup_pjActionAutoBackup', 'backend', 'Cron job name auto backup', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Create automatic back-ups for database and files', 'script');

COMMIT;