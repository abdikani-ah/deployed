
START TRANSACTION;

INSERT INTO `fields` VALUES (NULL, 'script_menu_settings', 'backend', 'Menu / Settings', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Settings', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_menu_notifications', 'backend', 'Menu / Notifications', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Notifications', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_emails', 'backend', 'Label / Emails', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Emails', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_sms', 'backend', 'Label / SMS', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'SMS', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_notifications', 'backend', 'Label / Notifications', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Notifications', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_send_this_notifications', 'backend', 'Label / Send this notification', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Send this notification', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_subject', 'backend', 'Label / Subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Subject', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_message', 'backend', 'Label / Message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Message', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_change_labels', 'backend', 'Label / Change Labels', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Change Labels', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_menu_payments', 'backend', 'Menu / Payments', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Payments', 'script');

INSERT INTO `fields` VALUES (NULL, 'infoPaymentsTitle', 'backend', 'Infobox / Payment options', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Payment Options', 'script');

INSERT INTO `fields` VALUES (NULL, 'infoPaymentsDesc', 'backend', 'Infobox / Payments', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Here you can choose your payment methods and set payment gateway accounts and payment preferences. Note that for cash payments the system will not be able to collect deposit amount online.', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_offline_payment_methods', 'backend', 'Label / Offline Payment Methods', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Offline Payment Methods', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_request_antoher_payment', 'backend', 'Label / Request Another Payment Gateway', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Request Another Payment Gateway', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_online_payment_gateway', 'backend', 'Label / Online payment gateway', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Online payment gateway', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_offline_payment', 'backend', 'Label / Offline payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Offline payment', 'script');













COMMIT;