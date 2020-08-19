
START TRANSACTION;

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pj_please_enter_valid_number', 'backend', 'Label / Please enter a valid number.', 'plugin', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Please enter a valid number.', 'plugin');

COMMIT;