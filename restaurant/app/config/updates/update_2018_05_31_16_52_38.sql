
START TRANSACTION;

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_confirmation', 'arrays', 'Notifications / Client email confirmation', 'script', '2018-05-31 06:19:54');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send confirmation email', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_payment', 'arrays', 'Notifications / Client email payment', 'script', '2018-05-31 06:20:22');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send payment confirmation email', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_cancel', 'arrays', 'Notifications / Client email cancel', 'script', '2018-05-31 06:20:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send cancellation email', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_enquiry', 'arrays', 'Notifications / Client email enquiry', 'script', '2018-05-31 06:21:24');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send enquiry email', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_email_confirmation', 'arrays', 'Notifications / Admin email confirmation', 'script', '2018-05-31 06:22:40');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send confirmation email', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_email_payment', 'arrays', 'Notifications / Admin email payment', 'script', '2018-05-31 06:23:02');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send payment confirmation email', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_email_cancel', 'arrays', 'Notifications / Admin email cancel', 'script', '2018-05-31 06:23:21');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send cancellation email', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_email_enquiry', 'arrays', 'Notifications / Admin email enquiry', 'script', '2018-05-31 06:23:21');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send enquiry email', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_confirmation', 'arrays', 'Notifications / Client email confirmation (title)', 'script', '2018-05-31 06:44:09');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation Confirmation email sent to Client', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_payment', 'arrays', 'Notifications / Client email payment (title)', 'script', '2018-05-31 06:45:06');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Confirmation email sent to Client', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_cancel', 'arrays', 'Notifications / Client email cancel (title)', 'script', '2018-05-31 06:45:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation Cancellation email sent to Client', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_enquiry', 'arrays', 'Notifications / Client email enquiry (title)', 'script', '2018-05-31 06:46:26');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Enquiry email sent to Client', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_email_cancel', 'arrays', 'Notifications / Admin email cancel (title)', 'script', '2018-05-31 06:59:17');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send Cancellation email sent to Admin', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_email_payment', 'arrays', 'Notifications / Admin email payment (title)', 'script', '2018-05-31 06:59:31');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send Payment Confirmation email sent to Admin', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_email_confirmation', 'arrays', 'Notifications / Admin email confirmation (title)', 'script', '2018-05-31 06:59:45');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New Reservation Received email sent to Admin', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_email_enquiry', 'arrays', 'Notifications / Admin email enquiry (title)', 'script', '2018-05-31 06:59:45');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Enquiry email sent to Admin', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_cancel', 'arrays', 'Notifications / Admin email cancel (sub-title)', 'script', '2018-05-31 07:01:20');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut lorem faucibus, pellentesque mi sit amet, sollicitudin dui. Duis vestibulum.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_payment', 'arrays', 'Notifications / Admin email payment (sub-title)', 'script', '2018-05-31 07:01:31');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut lorem faucibus, pellentesque mi sit amet, sollicitudin dui. Duis vestibulum.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_confirmation', 'arrays', 'Notifications / Admin email confirmation (sub-title)', 'script', '2018-05-31 07:01:42');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut lorem faucibus, pellentesque mi sit amet, sollicitudin dui. Duis vestibulum.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_enquiry', 'arrays', 'Notifications / Admin email enquiry (sub-title)', 'script', '2018-05-31 07:01:42');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut lorem faucibus, pellentesque mi sit amet, sollicitudin dui. Duis vestibulum.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_enquiry', 'arrays', 'Notifications / Client email enquiry (sub-title)', 'script', '2018-05-31 07:02:19');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut lorem faucibus, pellentesque mi sit amet, sollicitudin dui. Duis vestibulum.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_cancel', 'arrays', 'Notifications / Client email cancel (sub-title)', 'script', '2018-05-31 07:02:28');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut lorem faucibus, pellentesque mi sit amet, sollicitudin dui. Duis vestibulum.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_payment', 'arrays', 'Notifications / Client email payment (sub-title)', 'script', '2018-05-31 07:02:37');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut lorem faucibus, pellentesque mi sit amet, sollicitudin dui. Duis vestibulum.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_confirmation', 'arrays', 'Notifications / Client email confirmation (sub-title)', 'script', '2018-05-31 07:02:47');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut lorem faucibus, pellentesque mi sit amet, sollicitudin dui. Duis vestibulum.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_subject', 'backend', 'Subject', 'script', '2018-05-31 09:22:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Subject', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_message', 'backend', 'Message', 'script', '2018-05-31 09:23:13');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Message', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_is_active', 'backend', 'Send this message', 'script', '2018-05-31 09:23:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send this message', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_sms_na', 'backend', 'SMS not available', 'script', '2018-05-31 09:24:36');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMS notifications are currently not available for your website. See details', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_sms_na_here', 'backend', 'here', 'script', '2018-05-31 09:24:58');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'here', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_send', 'backend', 'Notifications / Send', 'script', '2018-05-31 09:25:37');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_do_not_send', 'backend', 'Notifications / Do not send', 'script', '2018-05-31 09:26:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Do not send', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_status', 'backend', 'Notifications / Status', 'script', '2018-05-31 09:26:20');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Status', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_msg_to_client', 'backend', 'Notifications / Messages sent to Clients', 'script', '2018-05-31 09:27:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages sent to Clients', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_msg_to_admin', 'backend', 'Notifications / Messages sent to Admin', 'script', '2018-05-31 09:30:48');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages sent to Admin', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_msg_to_default', 'backend', 'Notifications / Messages sent to Default', 'script', '2018-05-31 09:31:04');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages sent', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_main_title', 'backend', 'Notifications', 'script', '2018-05-31 09:32:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_main_subtitle', 'backend', 'Notifications (sub-title)', 'script', '2018-05-31 09:33:14');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Automated messages are sent both to client and administrator(s) on specific events. Select message type to edit it - enable/disable or just change message text. For SMS notifications you need to enable SMS service. See more <a href="https://www.phpjabbers.com/web-sms/" target="_blank">here</a>.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_recipient', 'backend', 'Notifications / Recipient', 'script', '2018-05-31 09:33:56');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Recipient', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_tokens_note', 'backend', 'Notifications / Tokens (note)', 'script', '2018-05-31 09:35:19');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Personalize the message by including any of the available tokens and it will be replaced with corresponding data.', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'notifications_tokens', 'backend', 'Notifications / Tokens', 'script', '2018-05-31 09:38:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Available tokens:', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'recipients_ARRAY_client', 'arrays', 'Recipients / Client', 'script', '2018-05-31 09:39:03');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'recipients_ARRAY_admin', 'arrays', 'Recipients / Administrator', 'script', '2018-05-31 09:39:23');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Administrator', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'recipient_admin_note', 'backend', 'Recipients / Administrator (note)', 'script', '2018-05-31 09:40:31');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Go to <a href="index.php?controller=pjBaseUsers&action=pjActionIndex">Users menu</a> and edit each administrator profile to select if they should receive "Admin notifications" or not.', 'script');

COMMIT;