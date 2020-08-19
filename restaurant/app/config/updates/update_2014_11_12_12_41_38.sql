
START TRANSACTION;

INSERT INTO `fields` VALUES (NULL, 'front_messages_ARRAY_6', 'arrays', 'front_messages_ARRAY_6', 'script', '2014-11-12 11:40:03');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'We are sorry, but your reservation failed. The selected table has just been booked by other while you were placing your order. You can [STAG]start over[ETAG] searching for other table.', 'script');

COMMIT;