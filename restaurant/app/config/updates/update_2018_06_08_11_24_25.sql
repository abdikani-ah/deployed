
START TRANSACTION;

INSERT INTO `plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AT10', 'arrays', 'error_titles_ARRAY_AT10', 'script', '2018-06-08 11:23:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Error!', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AT10', 'arrays', 'error_bodies_ARRAY_AT10', 'script', '2018-06-08 11:24:15');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Time is not valid.', 'script');

COMMIT;