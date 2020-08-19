
START TRANSACTION;

INSERT INTO `fields` VALUES (NULL, 'lblValidateTable', 'backend', 'Label / The selected table was reserved.', 'script', '2014-11-12 16:30:07');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'The selected table was reserved.', 'script');

COMMIT;