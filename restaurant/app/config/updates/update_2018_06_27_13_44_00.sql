START TRANSACTION;

SET @label := 'Infobox / Install';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'infoInstallDesc', 'backend', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'backend', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'Follow the instructions below to install the script on your website.';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'infoInstallDesc'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';


SET @label := 'Notifications / Admin email cancel (sub-title)';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_cancel', 'arrays', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'arrays', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'This message is sent to the administrator when a client cancels a reservation.';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'notifications_subtitles_ARRAY_admin_email_cancel'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

SET @label := 'Notifications / Admin email enquiry (sub-title)';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_enquiry', 'arrays', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'arrays', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'This message is sent to the administrator when a new enquiry is received.';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'notifications_subtitles_ARRAY_admin_email_enquiry'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

SET @label := 'Notifications / Admin email confirmation (sub-title)';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_confirmation', 'arrays', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'arrays', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'This message is sent to the administrator when a new reservation is made.';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'notifications_subtitles_ARRAY_admin_email_confirmation'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

SET @label := 'Notifications / Admin email payment (sub-title)';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_payment', 'arrays', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'arrays', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'This message is sent to the administrator when a payment for a new reservation is made.';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'notifications_subtitles_ARRAY_admin_email_payment'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

SET @label := 'Notifications / Client email confirmation (sub-title)';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_confirmation', 'arrays', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'arrays', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'This message is sent to client when a new reservation is made.';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'notifications_subtitles_ARRAY_client_email_confirmation'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

SET @label := 'Notifications / Client email payment (sub-title)';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_payment', 'arrays', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'arrays', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'This message is sent to the client when a payment is made for a new reservation.';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'notifications_subtitles_ARRAY_client_email_payment'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

SET @label := 'Notifications / Client email cancel (sub-title)';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_cancel', 'arrays', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'arrays', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'This message is sent to the client when a client cancels a reservation.';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'notifications_subtitles_ARRAY_client_email_cancel'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

SET @label := 'Notifications / Client email enquiry (sub-title)';

INSERT INTO `plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_enquiry', 'arrays', @label, 'script', NULL)
ON DUPLICATE KEY UPDATE `plugin_base_fields`.`type` = 'arrays', `label` = @label, `source` = 'script', `modified` = NULL;

SET @content := 'This message is sent to the client when a new enquiry is made.';

INSERT INTO `plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
SELECT NULL, `id`, 'pjBaseField', '::LOCALE::', 'title', @content, 'script'
FROM `plugin_base_fields` WHERE `key` = 'notifications_subtitles_ARRAY_client_email_enquiry'
ON DUPLICATE KEY UPDATE `plugin_base_multi_lang`.`content` = @content, `source` = 'script';

COMMIT;