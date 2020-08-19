
START TRANSACTION;

INSERT INTO `plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AM02', 'arrays', 'error_titles_ARRAY_AM02', 'script', '2018-06-08 14:18:30');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Error!', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AM02', 'arrays', 'error_bodies_ARRAY_AM02', 'script', '2018-06-08 14:18:48');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Image is too big.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AM03', 'arrays', 'error_titles_ARRAY_AM03', 'script', '2018-06-08 14:21:20');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Error!', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AM03', 'arrays', 'error_bodies_ARRAY_AM03', 'script', '2018-06-08 14:23:21');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Image format is not supported. Upload a map in JPG format.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AM04', 'arrays', 'error_titles_ARRAY_AM04', 'script', '2018-06-08 14:59:55');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Error!', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AM04', 'arrays', 'error_bodies_ARRAY_AM04', 'script', '2018-06-08 15:00:38');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tables can not have same names.', 'script');

COMMIT;