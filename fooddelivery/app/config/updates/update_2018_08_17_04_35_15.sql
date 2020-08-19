
START TRANSACTION;

INSERT INTO `plugin_base_fields` VALUES (NULL, 'gridTotalPrefix', 'backend', 'Grid / of', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'of', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'gridTotalSuffix', 'backend', 'Grid / total', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'total', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'gridShow', 'backend', 'Grid / Show', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Show', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'gridEmptyDate', 'backend', 'Grid / (empty date)', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '(empty date)', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'gridInvalidDate', 'backend', 'Grid / (invalid date)', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '(invalid date)', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'enum_arr_ARRAY_confirmed', 'backend', 'enum_arr_ARRAY_confirmed', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirmed', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'enum_arr_ARRAY_pending', 'backend', 'enum_arr_ARRAY_pending', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pending', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'enum_arr_ARRAY_cancelled', 'backend', 'enum_arr_ARRAY_cancelled', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancelled', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'enum_arr_ARRAY_1', 'backend', 'enum_arr_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'enum_arr_ARRAY_2', 'backend', 'enum_arr_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Yes', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'enum_arr_ARRAY_3', 'backend', 'enum_arr_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Yes (required)', 'script');

COMMIT;