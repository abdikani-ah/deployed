
START TRANSACTION;

INSERT INTO `fields` VALUES (NULL, 'lblMissingParameters', 'backend', 'Label / Missing parameters', 'script', '2015-03-24 09:45:48');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Missing parameters', 'script');

COMMIT;