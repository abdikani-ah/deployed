
START TRANSACTION;

INSERT INTO `fields` VALUES (NULL, 'front_step_1', 'frontend', 'Step 1', 'script', '2016-10-06 07:16:41');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Step 1', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_step_2', 'frontend', 'Step 2', 'script', '2016-10-06 07:16:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Step 2', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_step_3', 'frontend', 'Step 3', 'script', '2016-10-07 02:22:40');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Step 3', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_step_4', 'frontend', 'Step 4', 'script', '2016-10-07 02:22:56');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Step 4', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_reservation_form', 'frontend', 'Label / Reservation form', 'script', '2016-10-07 02:30:24');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Reservation form', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_fill_to_reserve', 'frontend', 'Label / fill the form to reserve a table', 'script', '2016-10-07 02:30:56');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'fill the form to reserve a table', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_field_required', 'frontend', 'Label / This field is required.', 'script', '2016-10-07 02:34:06');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'This field is required.', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_email_validation', 'frontend', 'Label / Email address is invalid.', 'script', '2016-10-07 02:38:13');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Email address is invalid.', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_bank_account', 'frontend', 'Label / Bank account', 'script', '2016-10-07 04:27:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Bank account', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_thank_you', 'frontend', 'Label / Thank you for your reservation', 'script', '2016-10-07 04:32:20');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Thank you for your reservation', 'script');

COMMIT;