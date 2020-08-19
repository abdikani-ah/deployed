
START TRANSACTION;

INSERT INTO `fields` VALUES (NULL, 'lblSendCancellationEmail', 'backend', 'Label / Send Cancellation Email', 'script', '2016-11-08 11:37:54');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Send Cancellation Email', 'script');

INSERT INTO `fields` VALUES (NULL, 'booking_cancellation_title', 'backend', 'Label / Send Cancellation Email', 'script', '2016-11-08 12:48:30');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Send Cancellation Email', 'script');

INSERT INTO `fields` VALUES (NULL, 'booking_subject', 'backend', 'Label / Email subject', 'script', '2016-11-08 12:57:11');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Email subject', 'script');

INSERT INTO `fields` VALUES (NULL, 'booking_message', 'backend', 'Label / Email message', 'script', '2016-11-08 12:57:28');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Email message', 'script');

INSERT INTO `fields` VALUES (NULL, 'buttons_ARRAY_send', 'arrays', 'buttons_ARRAY_send', 'script', '2016-11-08 12:58:02');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Send', 'script');

INSERT INTO `fields` VALUES (NULL, 'buttons_ARRAY_cancel', 'arrays', 'buttons_ARRAY_cancel', 'script', '2016-11-08 12:58:31');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Cancel', 'script');

INSERT INTO `fields` VALUES (NULL, 'booking_confirmation_title', 'backend', 'Label / Send Confirmation Email', 'script', '2016-11-08 13:13:28');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Send Confirmation Email', 'script');

COMMIT;