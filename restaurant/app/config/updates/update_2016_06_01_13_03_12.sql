
START TRANSACTION;

INSERT INTO `fields` VALUES (NULL, 'lblSelectTable', 'backend', 'Label / Please select a table.', 'script', '2016-06-01 12:44:46');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Please select a table.', 'script');

COMMIT;