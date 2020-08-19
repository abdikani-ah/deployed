
START TRANSACTION;

INSERT INTO `fields` VALUES (NULL, 'enum_arr_ARRAY_mail', 'arrays', 'enum_arr_ARRAY_mail', 'script', '2015-06-11 08:35:51');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'PHP mail()', 'script');

INSERT INTO `fields` VALUES (NULL, 'enum_arr_ARRAY_smtp', 'arrays', 'enum_arr_ARRAY_smtp', 'script', '2015-06-11 08:36:12');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'SMTP', 'script');

INSERT INTO `fields` VALUES (NULL, 'enum_arr_ARRAY_confirmed', 'arrays', 'enum_arr_ARRAY_confirmed', 'script', '2015-06-11 08:38:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Confirmed', 'script');

INSERT INTO `fields` VALUES (NULL, 'enum_arr_ARRAY_pending', 'arrays', 'enum_arr_ARRAY_pending', 'script', '2015-06-11 08:38:16');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Pending', 'script');

INSERT INTO `fields` VALUES (NULL, 'enum_arr_ARRAY_cancelled', 'arrays', 'enum_arr_ARRAY_cancelled', 'script', '2015-06-11 08:38:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Cancelled', 'script');

INSERT INTO `fields` VALUES (NULL, 'enum_arr_ARRAY_Yes', 'arrays', 'enum_arr_ARRAY_Yes', 'script', '2015-06-11 08:38:55');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Yes', 'script');

INSERT INTO `fields` VALUES (NULL, 'enum_arr_ARRAY_No', 'arrays', 'enum_arr_ARRAY_No', 'script', '2015-06-11 08:39:09');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'No', 'script');

INSERT INTO `fields` VALUES (NULL, 'enum_arr_ARRAY_0', 'arrays', 'enum_arr_ARRAY_0', 'script', '2015-06-11 08:39:25');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'No', 'script');

INSERT INTO `fields` VALUES (NULL, 'enum_arr_ARRAY_1', 'arrays', 'enum_arr_ARRAY_1', 'script', '2015-06-11 08:39:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Yes', 'script');

INSERT INTO `fields` VALUES (NULL, 'enum_arr_ARRAY_2', 'arrays', 'enum_arr_ARRAY_2', 'script', '2017-06-05 10:54:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Yes (required)', 'script');

INSERT INTO `fields` VALUES (NULL, 'buttons_ARRAY_delete', 'arrays', 'buttons_ARRAY_delete', 'script', '2017-06-05 11:02:10');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Delete', 'script');

INSERT INTO `fields` VALUES (NULL, 'buttons_ARRAY_save', 'arrays', 'buttons_ARRAY_save', 'script', '2017-06-05 11:02:36');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Save', 'script');

COMMIT;