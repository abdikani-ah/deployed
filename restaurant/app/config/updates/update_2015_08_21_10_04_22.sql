
START TRANSACTION;

INSERT INTO `fields` VALUES (NULL, 'front_hour', 'frontend', 'Label / Hour', 'script', '2015-08-21 08:25:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Hour', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_minute', 'frontend', 'Label / Minute', 'script', '2015-08-21 08:35:37');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Minute', 'script');

COMMIT;