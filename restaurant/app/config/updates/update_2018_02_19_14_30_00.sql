
START TRANSACTION;

INSERT INTO `plugin_base_cron_jobs` (`name`, `controller`, `action`, `interval`, `period`, `is_active`) VALUES
('Create automatic back-ups for database and files', 'pjBaseBackup', 'pjActionAutoBackup', 1, 'week', 0)
ON DUPLICATE KEY UPDATE `plugin_base_cron_jobs`.`interval` = 1, `period` = 'week', `is_active` = 0;
  
INSERT INTO `plugin_base_cron_jobs` (`name`, `controller`, `action`, `interval`, `period`, `is_active`) VALUES
('Send Email and SMS reminders', 'pjCron', 'pjActionReminder', 10, 'minute', 0)
ON DUPLICATE KEY UPDATE `plugin_base_cron_jobs`.`interval` = 10, `period` = 'minute', `is_active` = 0;

UPDATE `plugin_base_options` SET `value` = 'index.php?controller=pjAdmin&action=pjActionIndex' WHERE `key` = 'o_dashboard';

INSERT INTO `fields` VALUES (NULL, 'dashboard_total_reservations', 'backend', 'Label / total reservations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'total reservations', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_new_reservations', 'backend', 'Label / new reservations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'new reservations', 'script');

INSERT INTO `fields` VALUES (NULL, 'lblGuests', 'backend', 'Label / Guests', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Guests', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_guests_coming', 'backend', 'Label / guests coming', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'guests coming', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_tables_booked', 'backend', 'Label / tables booked', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'tables booked', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_next_days', 'backend', 'Label / Next X days', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Next 7 days', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_reservations', 'backend', 'Label / reservations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'reservations', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_guests', 'backend', 'Label / guests', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'guests', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_deposit', 'backend', 'Label / deposit', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'deposit', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_latest_reservations', 'backend', 'Label / Latest Reservations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Latest Reservations', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_x_reservations_received', 'backend', 'Label / X reservations received', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'You received <strong>{X}</strong> reservations today', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_view_schedule', 'backend', 'Label / View Schedule', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'View Schedule', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_available_tables', 'backend', 'Label / Available Tables', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Available Tables', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_x_appointments_made', 'backend', 'Label / X appointments made', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'total <strong>{X}</strong> appointments made', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_view_bookings', 'backend', 'Label / View All Bookings', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'View All Bookings', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_booked', 'backend', 'Label / Booked', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Booked', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_available', 'backend', 'Label / available', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'available', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_table_by_capacity', 'backend', 'Label / Table by capacity', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Table by capacity', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_reservations_by_guest_count', 'backend', 'Label / reservations by guest count', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'reservations by guest count', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_x_guests', 'backend', 'Label / X guests', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', '{X} guests', 'script');

INSERT INTO `fields` VALUES (NULL, 'dashboard_x_guests_tables', 'backend', 'Label / X guests tables', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', '{X} guests tables', 'script');

INSERT INTO `fields` VALUES (NULL, 'infoInstallTitle', 'backend', 'Infobox / Install', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Integration code', 'script');

INSERT INTO `fields` VALUES (NULL, 'infoInstallDesc', 'backend', 'Infobox / Install', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam optio officiis harum iusto, adipisci animi odit dolore eius. Molestiae, assumenda?', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_install_your_website', 'backend', 'Label / Install your website', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Install your website', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_preview_your_website', 'backend', 'Label / Preview your website', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Open in new window', 'script');

INSERT INTO `fields` VALUES (NULL, 'lblClient', 'backend', 'Label / Client', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Client', 'script');

INSERT INTO `fields` VALUES (NULL, 'lblManageTables', 'backend', 'Label / Manage tables', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Manage tables [STAG]here[ETAG]', 'script');

INSERT INTO `fields` VALUES (NULL, 'script_name', 'backend', 'Label / Script name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Restaurant Booking System', 'script');

COMMIT;