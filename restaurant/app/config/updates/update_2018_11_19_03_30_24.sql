
START TRANSACTION;

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdmin_pjActionIndex', 'backend', 'pjAdmin_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dashboard', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminBookings', 'backend', 'pjAdminBookings', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations Menu', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminBookings_pjActionSchedule', 'backend', 'pjAdminBookings_pjActionSchedule', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Schedule', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminBookings_pjActionPaper', 'backend', 'pjAdminBookings_pjActionPaper', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Print the schedule', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminBookings_pjActionIndex', 'backend', 'pjAdminBookings_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations List', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminBookings_pjActionCreate', 'backend', 'pjAdminBookings_pjActionCreate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add reservations', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminBookings_pjActionUpdate', 'backend', 'pjAdminBookings_pjActionUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit reservations', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminBookings_pjActionDeleteBooking', 'backend', 'pjAdminBookings_pjActionDeleteBooking', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single reservation', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminBookings_pjActionDeleteBookingBulk', 'backend', 'pjAdminBookings_pjActionDeleteBookingBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple reservations', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminBookings_pjActionExportBooking', 'backend', 'pjAdminBookings_pjActionExportBooking', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export reservations', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTime', 'backend', 'pjAdminTime', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Working Time Menu', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTime_pjActionIndex', 'backend', 'pjAdminTime_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Default Working Time', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTime_pjActionCustom', 'backend', 'pjAdminTime_pjActionCustom', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Custom Working Time', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTime_pjActionCreate', 'backend', 'pjAdminTime_pjActionCreate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add dates', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTime_pjActionUpdate', 'backend', 'pjAdminTime_pjActionUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit dates', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTime_pjActionDeleteDate', 'backend', 'pjAdminTime_pjActionDeleteDate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single date', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTime_pjActionDeleteDateBulk', 'backend', 'pjAdminTime_pjActionDeleteDateBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple dates', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminMaps_pjActionIndex', 'backend', 'pjAdminMaps_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Seat Map Menu', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminMaps_pjActionIndex_use_map', 'backend', 'pjAdminMaps_pjActionIndex_use_map', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use seat map ON/OFF', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminMaps_pjActionSaveSeat', 'backend', 'pjAdminMaps_pjActionSaveSeat', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Manage tables on seat map', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminMaps_pjActionDeleteFile', 'backend', 'pjAdminMaps_pjActionDeleteFile', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete seat map image', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTables', 'backend', 'pjAdminTables', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tables Menu', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTables_pjActionIndex', 'backend', 'pjAdminTables_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tables List', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTables_pjActionCreate', 'backend', 'pjAdminTables_pjActionCreate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add tables', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTables_pjActionUpdate', 'backend', 'pjAdminTables_pjActionUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit tables', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTables_pjActionDeleteTable', 'backend', 'pjAdminTables_pjActionDeleteTable', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single table', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminTables_pjActionDeleteTableBulk', 'backend', 'pjAdminTables_pjActionDeleteTableBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple tables', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminOptions', 'backend', 'pjAdminOptions', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Settings Menu', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionBooking', 'backend', 'pjAdminOptions_pjActionBooking', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation Options', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionPayments', 'backend', 'pjAdminOptions_pjActionPayments', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Options', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionBookingForm', 'backend', 'pjAdminOptions_pjActionBookingForm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation Form', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionTerm', 'backend', 'pjAdminOptions_pjActionTerm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Terms & Conditions', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionNotifications', 'backend', 'pjAdminOptions_pjActionNotifications', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionReminder', 'backend', 'pjAdminOptions_pjActionReminder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reminder Options', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionPreview', 'backend', 'pjAdminOptions_pjActionPreview', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Preview Menu', 'script');

INSERT INTO `plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionInstall', 'backend', 'pjAdminOptions_pjActionInstall', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Integration Code Menu', 'script');


COMMIT;