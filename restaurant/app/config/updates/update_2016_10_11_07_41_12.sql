
START TRANSACTION;

INSERT INTO `fields` VALUES (NULL, 'front_available_tables_for', 'frontend', 'Label / Available for', 'script', '2016-10-11 06:15:38');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Available tables for %1s person(s) on %2s at %3s.', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_click_to_book', 'frontend', 'Label / click on an available table to book it', 'script', '2016-10-11 03:34:12');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'click on an available table to book it', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_unavailable_tables_for', 'frontend', 'Label / Unavailable for', 'script', '2016-10-11 06:24:15');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'There is no available table on %1s at %2s.', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_change_date_time', 'frontend', 'Label / Please, change date time', 'script', '2016-10-11 06:27:51');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Please, change date and/or time and check availability', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_empty_step_2', 'frontend', 'Label / Step empty message 2', 'script', '2016-10-11 06:35:58');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Step empty message 2', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_enquiry_details', 'frontend', 'Label / Enquiry details', 'script', '2016-10-11 06:37:15');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Enquiry details', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_enquiry_form', 'frontend', 'Label / Enquiry form', 'script', '2016-10-11 06:38:07');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Enquiry form', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_fill_to_make', 'frontend', 'Label / fill the form to make an enquiry', 'script', '2016-10-11 06:38:39');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'fill the form to make an enquiry', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_table', 'frontend', 'Label / Table', 'script', '2016-10-11 06:43:09');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Table', 'script');

INSERT INTO `fields` VALUES (NULL, 'front_for_persons', 'frontend', 'Label / for person', 'script', '2016-10-11 06:43:30');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'for %s person(s)', 'script');

INSERT INTO `fields` VALUES (NULL, 'btnAddReservation', 'backend', 'Button / Add reservation', 'script', '2016-10-11 07:29:04');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Add reservation', 'script');

COMMIT;