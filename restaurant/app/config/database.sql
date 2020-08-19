DROP TABLE IF EXISTS `restaurantbooking_bookings`;
CREATE TABLE IF NOT EXISTS `restaurantbooking_bookings` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `uuid` int(10) unsigned default NULL,
  `dt` datetime default NULL,
  `dt_to` datetime default NULL,
  `people` smallint(5) unsigned default NULL,
  `code` varchar(255) default NULL,
  `total` decimal(9,2) unsigned default NULL,
  `payment_method` VARCHAR(255) default NULL,
  `is_paid` enum('T','F') default 'F',
  `status` enum('confirmed','cancelled','pending','enquiry') default 'pending',
  `txn_id` varchar(255) default NULL,
  `processed_on` datetime default NULL,
  `created` datetime default NULL,
  `ip` varchar(255) default NULL,
  `c_title` varchar(255) default NULL,
  `c_fname` varchar(255) default NULL,
  `c_lname` varchar(255) default NULL,
  `c_phone` varchar(255) default NULL,
  `c_email` varchar(255) default NULL,
  `c_company` varchar(255) default NULL,
  `c_notes` text,
  `c_address` varchar(255) default NULL,
  `c_city` varchar(255) default NULL,
  `c_state` varchar(255) default NULL,
  `c_zip` varchar(255) default NULL,
  `c_country` int(10) unsigned default NULL,
  `cc_type` varchar(255) default NULL,
  `cc_num` varchar(255) default NULL,
  `cc_exp` varchar(255) default NULL,
  `cc_code` varchar(255) default NULL,
  `reminder_email` tinyint(1) unsigned default '0',
  `reminder_sms` tinyint(1) unsigned default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `dt` (`dt`),
  KEY `dt_to` (`dt_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `restaurantbooking_bookings_tables`;
CREATE TABLE IF NOT EXISTS `restaurantbooking_bookings_tables` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `booking_id` int(10) unsigned default NULL,
  `table_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `booking_table_id` (`booking_id`,`table_id`),
  KEY `booking_id` (`booking_id`),
  KEY `table_id` (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `restaurantbooking_tables`;
CREATE TABLE IF NOT EXISTS `restaurantbooking_tables` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `width` smallint(5) unsigned default NULL,
  `height` smallint(5) unsigned default NULL,
  `top` smallint(5) unsigned default NULL,
  `left` smallint(5) unsigned default NULL,
  `name` varchar(255) default NULL,
  `seats` smallint(5) unsigned default NULL,
  `minimum` smallint(5) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `restaurantbooking_working_times`;
CREATE TABLE IF NOT EXISTS `restaurantbooking_working_times` (
  `id` int(10) unsigned NOT NULL default '0',
  `monday_from` time default NULL,
  `monday_to` time default NULL,
  `monday_dayoff` enum('T','F') default 'F',
  `tuesday_from` time default NULL,
  `tuesday_to` time default NULL,
  `tuesday_dayoff` enum('T','F') default 'F',
  `wednesday_from` time default NULL,
  `wednesday_to` time default NULL,
  `wednesday_dayoff` enum('T','F') default 'F',
  `thursday_from` time default NULL,
  `thursday_to` time default NULL,
  `thursday_dayoff` enum('T','F') default 'F',
  `friday_from` time default NULL,
  `friday_to` time default NULL,
  `friday_dayoff` enum('T','F') default 'F',
  `saturday_from` time default NULL,
  `saturday_to` time default NULL,
  `saturday_dayoff` enum('T','F') default 'F',
  `sunday_from` time default NULL,
  `sunday_to` time default NULL,
  `sunday_dayoff` enum('T','F') default 'F',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `restaurantbooking_dates`;
CREATE TABLE IF NOT EXISTS `restaurantbooking_dates` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `date` date DEFAULT NULL,
  `start_time` time default NULL,
  `end_time` time default NULL,
  `is_dayoff` enum('T','F') default 'F',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `date` (`date`),
  KEY `is_dayoff` (`is_dayoff`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `restaurantbooking_options`;
CREATE TABLE IF NOT EXISTS `restaurantbooking_options` (
  `foreign_id` int(10) unsigned NOT NULL DEFAULT '0',
  `key` varchar(255) NOT NULL DEFAULT '',
  `tab_id` tinyint(3) unsigned DEFAULT NULL,
  `value` text,
  `label` text,
  `type` enum('string','text','int','float','enum','bool') NOT NULL DEFAULT 'string',
  `order` int(10) unsigned DEFAULT NULL,
  `is_visible` tinyint(1) unsigned DEFAULT '1',
  `style` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`foreign_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `restaurantbooking_users`;
CREATE TABLE IF NOT EXISTS `restaurantbooking_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` blob,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `status` enum('T','F') NOT NULL DEFAULT 'T',
  `is_active` enum('T','F') NOT NULL DEFAULT 'F',
  `ip` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'backend', 'backend', 'Backend titles', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Back-end titles', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'created', 'backend', 'Created', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'DateTime', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'frontend', 'backend', 'Front-end titles', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Front-end titles', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoListingAddressBody', 'backend', 'Infobox / Listing Address Body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'You can show a map with the location of the listing accommodation on the listing details page. Submit the full address first and then click on ''Get coordinates from Google Maps API'' button. Save your data.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoListingAddressTitle', 'backend', 'Infobox / Listing Address Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Location and address', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoListingBookingsBody', 'backend', 'Infobox / Listing Bookings Body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Listing Reservations Body', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoListingBookingsTitle', 'backend', 'Infobox / Listing Bookings Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Listing Reservation Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoListingContactBody', 'backend', 'Infobox / Listing Contact Body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Listing Contact Body', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoListingContactTitle', 'backend', 'Infobox / Listing Contact Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Listing Contact Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoListingExtendBody', 'backend', 'Infobox / Extend exp.date Body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Extend exp.date Body', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoListingExtendTitle', 'backend', 'Infobox / Extend exp.date Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Extend exp.date Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoListingPricesBody', 'backend', 'Infobox / Listing Prices Body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Listing Prices Body', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoListingPricesTitle', 'backend', 'Infobox / Listing Prices Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Listing Prices Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoLocalesArraysBody', 'backend', 'Locale / Languages Array Body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Languages Array Body', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoLocalesArraysTitle', 'backend', 'Locale / Languages Array Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Languages Arrays Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoLocalesBackendBody', 'backend', 'Infobox / Locales Backend Body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Languages Backend Body', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoLocalesBackendTitle', 'backend', 'Infobox / Locales Backend Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Languages Backend Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoLocalesBody', 'backend', 'Infobox / Locales Body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Languages Body', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoLocalesFrontendBody', 'backend', 'Infobox / Locales Frontend Body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Languages Frontend Body', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoLocalesFrontendTitle', 'backend', 'Infobox / Locales Frontend Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Languages Frontend Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoLocalesTitle', 'backend', 'Infobox / Locales Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Languages Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblError', 'backend', 'Error', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Error', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblNo', 'backend', 'No', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'No', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblOption', 'backend', 'Option', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Option', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblOptionList', 'backend', 'Option list', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Option list', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblType', 'backend', 'Type', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Type', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblUpdateUser', 'backend', 'Update user', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Update user', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblValue', 'backend', 'Value', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Value', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblYes', 'backend', 'Yes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Yes', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lnkBack', 'backend', 'Link Back', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Back', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'localeArrays', 'backend', 'Locale / Arrays titles', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Arrays titles', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'locales', 'backend', 'Languages', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Languages', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'locale_flag', 'backend', 'Locale / Flag', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Flag', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'locale_is_default', 'backend', 'Locale / Is default', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Is default', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'locale_order', 'backend', 'Locale / Order', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Order', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'locale_title', 'backend', 'Locale / Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuPlugins', 'backend', 'Menu Plugins', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Plugins', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'multilangTooltip', 'backend', 'MultiLang / Tooltip', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'url', 'backend', 'URL', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'URL', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'user', 'backend', 'Username', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Username', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'days_ARRAY_0', 'arrays', 'days_ARRAY_0', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Sunday', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'days_ARRAY_1', 'arrays', 'days_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Monday', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'days_ARRAY_2', 'arrays', 'days_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Tuesday', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'days_ARRAY_3', 'arrays', 'days_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Wednesday', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'days_ARRAY_4', 'arrays', 'days_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Thursday', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'days_ARRAY_5', 'arrays', 'days_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Friday', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'days_ARRAY_6', 'arrays', 'days_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Saturday', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'day_names_ARRAY_0', 'arrays', 'day_names_ARRAY_0', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'S', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'day_names_ARRAY_1', 'arrays', 'day_names_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'M', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'day_names_ARRAY_2', 'arrays', 'day_names_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'T', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'day_names_ARRAY_3', 'arrays', 'day_names_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'W', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'day_names_ARRAY_4', 'arrays', 'day_names_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'T', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'day_names_ARRAY_5', 'arrays', 'day_names_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'F', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'day_names_ARRAY_6', 'arrays', 'day_names_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'S', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AA10', 'arrays', 'error_bodies_ARRAY_AA10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Given email address is not associated with any account.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AA11', 'arrays', 'error_bodies_ARRAY_AA11', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'For further instructions please check your mailbox.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AA12', 'arrays', 'error_bodies_ARRAY_AA12', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'We are sorry, please try again later.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AA13', 'arrays', 'error_bodies_ARRAY_AA13', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'All the changes made to your profile have been saved.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_ALC01', 'arrays', 'error_bodies_ARRAY_ALC01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'All the changes made to titles have been saved.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AO01', 'arrays', 'error_bodies_ARRAY_AO01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'All the changes made to options have been saved.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AA10', 'arrays', 'error_titles_ARRAY_AA10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Account not found!', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AA11', 'arrays', 'error_titles_ARRAY_AA11', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Password send!', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AA12', 'arrays', 'error_titles_ARRAY_AA12', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Password not send!', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AA13', 'arrays', 'error_titles_ARRAY_AA13', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Profile updated!', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AB01', 'arrays', 'error_titles_ARRAY_AB01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Backup', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AB02', 'arrays', 'error_titles_ARRAY_AB02', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Backup complete!', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AB03', 'arrays', 'error_titles_ARRAY_AB03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Backup failed!', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AB04', 'arrays', 'error_titles_ARRAY_AB04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Backup failed!', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AO01', 'arrays', 'error_titles_ARRAY_AO01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Options updated!', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_1', 'arrays', 'months_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'January', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_10', 'arrays', 'months_ARRAY_10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'October', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_11', 'arrays', 'months_ARRAY_11', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'November', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_12', 'arrays', 'months_ARRAY_12', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'December', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_2', 'arrays', 'months_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'February', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_3', 'arrays', 'months_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'March', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_4', 'arrays', 'months_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'April', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_5', 'arrays', 'months_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'May', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_6', 'arrays', 'months_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'June', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_7', 'arrays', 'months_ARRAY_7', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'July', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_8', 'arrays', 'months_ARRAY_8', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'August', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'months_ARRAY_9', 'arrays', 'months_ARRAY_9', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'September', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'personal_titles_ARRAY_dr', 'arrays', 'personal_titles_ARRAY_dr', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Dr.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'personal_titles_ARRAY_miss', 'arrays', 'personal_titles_ARRAY_miss', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Miss', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'personal_titles_ARRAY_mr', 'arrays', 'personal_titles_ARRAY_mr', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Mr.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'personal_titles_ARRAY_mrs', 'arrays', 'personal_titles_ARRAY_mrs', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Mrs.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'personal_titles_ARRAY_ms', 'arrays', 'personal_titles_ARRAY_ms', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Ms.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'personal_titles_ARRAY_other', 'arrays', 'personal_titles_ARRAY_other', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Other', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'personal_titles_ARRAY_prof', 'arrays', 'personal_titles_ARRAY_prof', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Prof.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'personal_titles_ARRAY_rev', 'arrays', 'personal_titles_ARRAY_rev', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Rev.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_1', 'arrays', 'short_months_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Jan', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_10', 'arrays', 'short_months_ARRAY_10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Oct', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_11', 'arrays', 'short_months_ARRAY_11', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Nov', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_12', 'arrays', 'short_months_ARRAY_12', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Dec', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_2', 'arrays', 'short_months_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Feb', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_3', 'arrays', 'short_months_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Mar', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_4', 'arrays', 'short_months_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Apr', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_5', 'arrays', 'short_months_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'May', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_6', 'arrays', 'short_months_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Jun', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_7', 'arrays', 'short_months_ARRAY_7', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Jul', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_8', 'arrays', 'short_months_ARRAY_8', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Aug', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'short_months_ARRAY_9', 'arrays', 'short_months_ARRAY_9', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Sep', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_1', 'arrays', 'status_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'You are not loged in.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_123', 'arrays', 'status_ARRAY_123', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Your hosting account does not allow uploading such a large image.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_2', 'arrays', 'status_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Access denied. You have not requisite rights to.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_3', 'arrays', 'status_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Empty resultset.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_7', 'arrays', 'status_ARRAY_7', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'The operation is not allowed in demo mode.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_996', 'arrays', 'status_ARRAY_996', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'No property for the reservation found', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_997', 'arrays', 'status_ARRAY_997', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'No reservation found', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_998', 'arrays', 'status_ARRAY_998', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'No permisions to edit the reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_999', 'arrays', 'status_ARRAY_999', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'No permisions to edit the property', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_9997', 'arrays', 'status_ARRAY_9997', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'E-Mail address already exist', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_9998', 'arrays', 'status_ARRAY_9998', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Your registration was successfull. Your account needs to be approved.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'status_ARRAY_9999', 'arrays', 'status_ARRAY_9999', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Your registration was successfull.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-10800', 'arrays', 'timezones_ARRAY_-10800', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-03:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-14400', 'arrays', 'timezones_ARRAY_-14400', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-04:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-18000', 'arrays', 'timezones_ARRAY_-18000', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-05:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-21600', 'arrays', 'timezones_ARRAY_-21600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-06:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-25200', 'arrays', 'timezones_ARRAY_-25200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-07:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-28800', 'arrays', 'timezones_ARRAY_-28800', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-08:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-32400', 'arrays', 'timezones_ARRAY_-32400', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-09:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-3600', 'arrays', 'timezones_ARRAY_-3600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-01:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-36000', 'arrays', 'timezones_ARRAY_-36000', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-10:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-39600', 'arrays', 'timezones_ARRAY_-39600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-11:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-43200', 'arrays', 'timezones_ARRAY_-43200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-12:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_-7200', 'arrays', 'timezones_ARRAY_-7200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT-02:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_0', 'arrays', 'timezones_ARRAY_0', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_10800', 'arrays', 'timezones_ARRAY_10800', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+03:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_14400', 'arrays', 'timezones_ARRAY_14400', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+04:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_18000', 'arrays', 'timezones_ARRAY_18000', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+05:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_21600', 'arrays', 'timezones_ARRAY_21600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+06:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_25200', 'arrays', 'timezones_ARRAY_25200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+07:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_28800', 'arrays', 'timezones_ARRAY_28800', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+08:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_32400', 'arrays', 'timezones_ARRAY_32400', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+09:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_3600', 'arrays', 'timezones_ARRAY_3600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+01:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_36000', 'arrays', 'timezones_ARRAY_36000', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+10:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_39600', 'arrays', 'timezones_ARRAY_39600', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+11:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_43200', 'arrays', 'timezones_ARRAY_43200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+12:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_46800', 'arrays', 'timezones_ARRAY_46800', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+13:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'timezones_ARRAY_7200', 'arrays', 'timezones_ARRAY_7200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'GMT+02:00', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuRestaurant', 'backend', 'Menu / Restaurant', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Restaurant', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuBooking', 'backend', 'Menu / Booking', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation options', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuInstall', 'backend', 'Menu / Install', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Integration Code', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuPreview', 'backend', 'Menu / Preview', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Preview', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoBookingsTitle', 'backend', 'Infobox / Bookings title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation options', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoBookingsBody', 'backend', 'Infobox / Bookings body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Modify the options below and click Save button.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AO02', 'arrays', 'error_titles_ARRAY_AO02', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation options updated', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AO02', 'arrays', 'error_bodies_ARRAY_AO02', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'All changes made to the Reservation options have been saved.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_booking_price', 'backend', 'Options / Deposit fee', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Deposit fee', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_booking_price_text', 'backend', 'Options / Booking price text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'set default reservation price', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_booking_length', 'backend', 'Options / Booking length', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Default reservation length', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_booking_length_text', 'backend', 'Options / Booking length text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'minutes', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_booking_earlier', 'backend', 'Options / Book X hours earlier', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reserve X hours earlier', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_booking_earlier_text', 'backend', 'Options / Book X hours earlier text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'hours', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_booking_status', 'backend', 'Options / Default booking status', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Not paid reservation status', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_booking_status_text', 'backend', 'Options / Default booking status text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Status for the reservation if no payment is made', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_payment_status', 'backend', 'Options / booking status after payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Paid reservations', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_payment_status_text', 'backend', 'Options / booking status after payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Status for the reservation if payment is made', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_thank_you_page', 'backend', 'Options / "Thank you" page location', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Confirmation page', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_thank_you_page_text', 'backend', 'Options / "Thank you" page location', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'URL for the web page where your clients will be redirected after online payment', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_payment_disable', 'backend', 'Options / Disable payments', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Disable payments', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_payment_disable_text', 'backend', 'Options / Disable payments text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Select ''Yes'' if you want to disable payments and only collect reservation details', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_allow_cash', 'backend', 'Options / Allow payments with cash', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Allow payment with cash', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_allow_creditcard', 'backend', 'Options / Allow payments with Credit cards', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Collect Credit Card details for offline processing', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_allow_bank', 'backend', 'Option / Allow bank account', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Provide Bank account details for wire transfers', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bank_account', 'backend', 'Options / bank account', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Bank Account', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuBookingForm', 'backend', 'Menu / Booking form', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation form', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuTerms', 'backend', 'Menu / Terms', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Terms & Conditions', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuReminder', 'backend', 'Menu / Reminder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reminder', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoConfirmationTitle', 'backend', 'Infobox / Confirmation title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Email Confirmations', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoConfirmationDesc', 'backend', 'Infobox / Confirmation description', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'There are 4 types of email confirmations - one after reservation form is submitted , one after payment is made, one is enquiry email and one when cancelled the reservation. Use the available tokens to personalize the email messages.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_address', 'backend', 'Options / Notification email address', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Notification email address', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_confirmation', 'backend', 'Options / Send confirmation email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Send confirmation email', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_confirmation_text', 'backend', 'Options / Send confirmation email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'select if and when confirmation email should be sent to clients after they make a reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_confirmation_subject', 'backend', 'Options / Confirmation subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Confirmation email subject', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_confirmation_message_text', 'backend', 'Options / confirmation message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', '<div class="col-xs-6">
<p>{Title}</p>
<p>{FirstName}</p>
<p>{LastName}</p>
<p>{Email}</p>
<p>{Phone}</p>
<p>{Notes}</p>
<p>{Country}</p>
<p>{City}</p>
<p>{State}</p>
<p>{Zip}</p>
<p>{Address}</p>
<p>{Company}</p>
</div>
<div class="col-xs-6">
<p>{DtFrom}</p>
<p>{Table}</p>
<p>{People}</p>
<p>{BookingID}</p>
<p>{UniqueID}</p>
<p>{Total}</p>
<p>{PaymentMethod}</p>
<p>{CCType}</p>
<p>{CCNum}</p>
<p>{CCExp}</p>
<p>{CCSec}</p>
<p>{CancelURL}</p>
</div>
', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_confirmation_message', 'backend', 'Options / Confirmation message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Confirmation email message', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_payment', 'backend', 'Options / Send payment confirmation email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Send payment confirmation email', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_payment_text', 'backend', 'Options / Send payment confirmation email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'select if and when confirmation email should be sent to clients after they make a payment for their booking', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_payment_message', 'backend', 'Options / Payment email message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Payment email message', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_payment_message_text', 'backend', 'Options / payment message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', '<div class="col-xs-6">
<p>{Title}</p>
<p>{FirstName}</p>
<p>{LastName}</p>
<p>{Email}</p>
<p>{Phone}</p>
<p>{Notes}</p>
<p>{Country}</p>
<p>{City}</p>
<p>{State}</p>
<p>{Zip}</p>
<p>{Address}</p>
<p>{Company}</p>
</div>
<div class="col-xs-6">
<p>{DtFrom}</p>
<p>{Table}</p>
<p>{People}</p>
<p>{BookingID}</p>
<p>{UniqueID}</p>
<p>{Total}</p>
<p>{PaymentMethod}</p>
<p>{CCType}</p>
<p>{CCNum}</p>
<p>{CCExp}</p>
<p>{CCSec}</p>
<p>{CancelURL}</p>
</div>
', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_enquiry', 'backend', 'Options / Send enquiry email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Send enquiry email', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_enquiry_text', 'backend', 'Options / Send enquiry email text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'select if and when confirmation email should be sent to clients after they make a enquiry for booking', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_enquiry_subject', 'backend', 'Options / Enquiry email subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Enquiry email subject', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_enquiry_message', 'backend', 'Options / Enquiry email message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Enquiry email message', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_enquiry_message_text', 'backend', 'Options / Enquiry email message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', '<div class="col-xs-6">
<p>{Title}</p>
<p>{FirstName}</p>
<p>{LastName}</p>
<p>{Email}</p>
<p>{Phone}</p>
<p>{Notes}</p>
<p>{Country}</p>
<p>{City}</p>
<p>{State}</p>
<p>{Zip}</p>
<p>{Address}</p>
<p>{Company}</p>
</div>
<div class="col-xs-6">
<p>{DtFrom}</p>
<p>{People}</p>
<p>{UniqueID}</p>
<p>{CancelURL}</p>
</div>
', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_payment_subject', 'backend', 'Options / Payment email subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Payment email subject', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_cancel', 'backend', 'Optons / Send cancel email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Send cancel email', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_cancel_text', 'backend', 'Optons / Send cancel email text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'select if and when confirmation email should be sent to clients after they cancel for their booking', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_cancel_subject', 'backend', 'Options / Cancel email subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Cancel email subject', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_cancel_message', 'backend', 'Options / Cancel email message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Cancel email message', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_email_cancel_message_text', 'backend', 'Options / Cancel email message text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', '<div class="col-xs-6">
<p>{Title}</p>
<p>{FirstName}</p>
<p>{LastName}</p>
<p>{Email}</p>
<p>{Phone}</p>
<p>{Notes}</p>
<p>{Country}</p>
<p>{City}</p>
<p>{State}</p>
<p>{Zip}</p>
<p>{Address}</p>
<p>{Company}</p>
</div>
<div class="col-xs-6">
<p>{DtFrom}</p>
<p>{Table}</p>
<p>{People}</p>
<p>{BookingID}</p>
<p>{UniqueID}</p>
<p>{Total}</p>
<p>{PaymentMethod}</p>
<p>{CCType}</p>
<p>{CCNum}</p>
<p>{CCExp}</p>
<p>{CCSec}</p>
<p>{CancelURL}</p>
</div>
', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoBookingFormTitle', 'backend', 'Infobox / Booking form title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation Form Options', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoBookingFormDesc', 'backend', 'Infobox / Booking form descriptoin', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Choose the fields that should be available on the reservation form and click SAVE button.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_title', 'backend', 'Options / Title included', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_text', 'backend', 'Options / include text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Select "Yes" if you want to include the field on the reservation form, otherwise select "No"', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_fname', 'backend', 'Options / First name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'First name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_lname', 'backend', 'Options / Last name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Last name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_phone', 'backend', 'Options / Phone', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Phone', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_email', 'backend', 'Options / Email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Email', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_company', 'backend', 'Options / Company', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Company', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_address', 'backend', 'Options / Address', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Address', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_notes', 'backend', 'Options / Notes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Notes', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_promo', 'backend', 'Options / Voucher', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Voucher', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_city', 'backend', 'Options / City', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'City', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_state', 'backend', 'Options / State', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'State', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_zip', 'backend', 'Options / Zip', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Zip', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_country', 'backend', 'Options / Country', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Country', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_bf_include_captcha', 'backend', 'Options / Captcha', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Captcha', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoTermsTitle', 'backend', 'Infobox / Terms title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Terms and Conditions', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoTermsDesc', 'backend', 'Infobox / Terms description', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Please write down the Terms and Conditions for making reservation and click SAVE button.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_terms', 'backend', 'Options / Terms and Conditions', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Terms and Conditions', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_enquiry', 'backend', 'Options / Enquiry', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Enquiry', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoReminderTitle', 'backend', 'Infobox / Reminder Options', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reminder Options', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoReminderDesc', 'backend', 'Infobox / Reminder Options desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Let set the options for Reminder and click SAVE button. It includes email notification and SMS message.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_reminder_enable', 'backend', 'Options / Enable notifications', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Enable notifications', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_reminder_email_before', 'backend', 'Options / Send email reminder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Send email reminder', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_reminder_subject', 'backend', 'Options / Email Reminder subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Email Reminder subject', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_reminder_body', 'backend', 'Options / Email Reminder body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Email Reminder message', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_reminder_body_text', 'backend', 'Options / Email Reminder body text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', '<div class="col-xs-6">
<p>{Title}</p>
<p>{FirstName}</p>
<p>{LastName}</p>
<p>{Email}</p>
<p>{Phone}</p>
<p>{Notes}</p>
<p>{Country}</p>
<p>{City}</p>
<p>{State}</p>
<p>{Zip}</p>
<p>{Address}</p>
<p>{Company}</p>
</div>
<div class="col-xs-6">
<p>{DtFrom}</p>
<p>{Table}</p>
<p>{People}</p>
<p>{BookingID}</p>
<p>{UniqueID}</p>
<p>{Total}</p>
<p>{PaymentMethod}</p>
<p>{CCType}</p>
<p>{CCNum}</p>
<p>{CCExp}</p>
<p>{CCSec}</p>
<p>{CancelURL}</p>
</div>
', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_reminder_sms_hours', 'backend', 'Options / Send SMS reminder', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Send SMS reminder', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_reminder_sms_api', 'backend', 'Options / SMS api key', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'SMS api key', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_reminder_sms_message', 'backend', 'Options / SMS message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'SMS message', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_reminder_sms_message_text', 'backend', 'Options / SMS message text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', '<div class="col-xs-6">
<p>{Title}</p>
<p>{FirstName}</p>
<p>{LastName}</p>
<p>{Email}</p>
<p>{Phone}</p>
<p>{Notes}</p>
<p>{Country}</p>
<p>{City}</p>
<p>{State}</p>
<p>{Zip}</p>
<p>{Address}</p>
<p>{Company}</p>
</div>
<div class="col-xs-6">
<p>{DtFrom}</p>
<p>{Table}</p>
<p>{People}</p>
<p>{BookingID}</p>
<p>{UniqueID}</p>
<p>{Total}</p>
<p>{PaymentMethod}</p>
<p>{CCType}</p>
<p>{CCNum}</p>
<p>{CCExp}</p>
<p>{CCSec}</p>
<p>{CancelURL}</p>
</div>
', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_reminder_cron', 'backend', 'Options / Cron script', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Cron script', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'opt_o_reminder_cron_text', 'backend', 'Option / Cron text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'You need to set CRON jobs. Please, go to System Options - Cron jobs and follow the instructions.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblHoursBefore', 'backend', 'Label / hours before', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'hours before', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AO03', 'arrays', 'error_titles_ARRAY_AO03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation Form Options Updated', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AO03', 'arrays', 'error_bodies_ARRAY_AO03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Your settings for reservation form have been saved successfully.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AO04', 'arrays', 'error_titles_ARRAY_AO04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Confirmation Options Updated', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AO04', 'arrays', 'error_bodies_ARRAY_AO04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Your settings for confirmation have been saved successfully.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AO05', 'arrays', 'error_titles_ARRAY_AO05', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Terms and Conditions updated', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AO05', 'arrays', 'error_bodies_ARRAY_AO05', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'All changes you made on the Terms and Conditions options have been saved.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AO06', 'arrays', 'error_titles_ARRAY_AO06', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reminder updated', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AO06', 'arrays', 'error_bodies_ARRAY_AO06', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Your settings for reminder options have been saved successfully.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblGetKey', 'backend', 'Lable / get key', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'get key', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuWorkingTime', 'backend', 'Menu / Working Time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Working Time', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuSeatMap', 'backend', 'Menu / Seat Map', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Seat Map', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuTables', 'backend', 'Menu / Tables', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Tables', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDefault', 'backend', 'Label / Default', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Default', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblCustom', 'backend', 'Label / Custom', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Custom', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDayOfWeek', 'backend', 'Label / Day of Week', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Day of Week', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblStartTime', 'backend', 'Label / Start Time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Start Time', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblEndTime', 'backend', 'Label / End Time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'End Time', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblIsDayOff', 'backend', 'Label / Is Day off', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Is Day off', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AT01', 'arrays', 'error_titles_ARRAY_AT01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Working Time Updated', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AT01', 'arrays', 'error_bodies_ARRAY_AT01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'All changes made to the working time have been saved.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AT02', 'arrays', 'error_titles_ARRAY_AT02', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Custom working time saved', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AT02', 'arrays', 'error_bodies_ARRAY_AT02', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Custom working time has been saved successfully.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblMap', 'backend', 'Label / Map', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Map', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblOptions', 'backend', 'Label / Options', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Options', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoMapTitle', 'backend', 'Infobox / Seat Map', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Seat Map', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoMapDesc', 'backend', 'Infobox / Seat Map desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Check ''Use seat map'' checkbox to enable map table selection. You need to upload a JPG image map of your restaurant. Once image is uploaded click on the map to create a click-able hot spot for each table. You can click on each hot spot and position it on the map. To delete a hot spot click on it and then click on ''Delete'' button. To rename a hot spot (table) and set people capacity just click on it.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoMapOptionsTitle', 'backend', 'Infobox / Hot spot size', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Hot spot sizes', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoMapOptionsDesc', 'backend', 'Infobox / Hot spot size desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Below you can set the size for the hot spots that you create on the map. You can create different sized hot spots on each map. Just enter the desired size, click on Save button and go to Update map tab to create the new hot spot. Visit Knowledgebase to watch video showing how to create a map.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblUseSeatMap', 'backend', 'Label / Use seat map', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Use seat map', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblFile', 'backend', 'Label / File', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'File', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDeleteMap', 'backend', 'Label / Delete map', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Delete this image file', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDeleteMapConfirm', 'backend', 'Label / Delete map confirm', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Are you sure you want to delete this image file? If yes, the image file will be deleted and will not be possible to restore it.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblUpdateMapTitle', 'backend', 'Label / Update Map', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Update Map', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblUpdateMapDesc', 'backend', 'Label / Update map desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Add a custom name for this spot on the map (VIP sector, Sector A, etc..). Also set how many available seats can be reserved in this sector.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblCapacity', 'backend', 'Label / Capacity', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Capacity', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblMinimum', 'backend', 'Label / Minimum', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Minimum', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AM01', 'arrays', 'error_titles_ARRAY_AM01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Map settings updated', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AM01', 'arrays', 'error_bodies_ARRAY_AM01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'All settings made to the map have been saved.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoUseMapDesc', 'backend', 'Infobox / User map desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'You are using a seat map.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblWidth', 'backend', 'Label / Width', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Width', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblHeight', 'backend', 'Label / Height', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Height', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblAddTable', 'backend', 'Label / Add table', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Add table', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoTablesTitle', 'backend', 'Infobox / Table list', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Table list', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoTablesDesc', 'backend', 'Infobox / Table list desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Below is the list of tables. If you wan to add new table, use the form on right. There you can add new table and set number of people allowed to reserve a table. For example if Minimum is set to 2 and Capacity is set to 4 then only reservation for 2, 3 or 4 people will be accepted for this table. To edit or delete a certain table, click on corresponding icons on the row.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblTableNameExist', 'backend', 'Label / Table name used', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Table name was already used.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AT03', 'arrays', 'error_titles_ARRAY_AT03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Table added', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AT03', 'arrays', 'error_bodies_ARRAY_AT03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'A new table has been added to the list.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AT04', 'arrays', 'error_titles_ARRAY_AT04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Table failed to add', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AT04', 'arrays', 'error_bodies_ARRAY_AT04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'We are sorry that the table could not be added successfully.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AT05', 'arrays', 'error_titles_ARRAY_AT05', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Table updated', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AT05', 'arrays', 'error_bodies_ARRAY_AT05', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'All changes made to the table have been saved.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AT08', 'arrays', 'error_titles_ARRAY_AT08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Table not found', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AT08', 'arrays', 'error_bodies_ARRAY_AT08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'The table you are looking for is missing.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblUpdateTable', 'backend', 'Label / Update table', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Update table', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoUpdateTableTitle', 'backend', 'Infobox / Update table title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Update table', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoUpdateTableDesc', 'backend', 'Infobox / Update table desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'On the for below you can set number of people allowed to reserve a table. For example if Minimum is set to 2 and Capacity is set to 4 then only reservation for 2, 3 or 4 people will be accepted for this table.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblUpdate', 'backend', 'Label / Update', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Update', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuSchedule', 'backend', 'Menu / Schedule', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Schedule', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuBookingList', 'backend', 'Menu / Booking List', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservations List', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuPrint', 'backend', 'Menu / Print', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Print', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblNoTable', 'backend', 'Label / No tables found', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'No tables found', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDateIsDayOff', 'backend', 'Label / Date is day off', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', '%s is day off', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'booking_statuses_ARRAY_confirmed', 'arrays', 'booking_statuses_ARRAY_confirmed', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Confirmed', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'booking_statuses_ARRAY_cancelled', 'arrays', 'booking_statuses_ARRAY_cancelled', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Cancelled', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'booking_statuses_ARRAY_pending', 'arrays', 'booking_statuses_ARRAY_pending', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Pending', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'booking_statuses_ARRAY_enquiry', 'arrays', 'booking_statuses_ARRAY_enquiry', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Enquiry', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblFromDateTime', 'backend', 'Label / From date time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'From date/time', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDateFrom', 'backend', 'Label / Date from', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Date from', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDateTo', 'backend', 'Label / Date to', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Date to', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblTable', 'backend', 'Label / Table', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Table', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AB08', 'arrays', 'error_titles_ARRAY_AB08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation not found', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AB08', 'arrays', 'error_bodies_ARRAY_AB08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'We are sorry that the reservation you are looking for is missing.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingDetails', 'backend', 'Label / Booking Details', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation Details', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblClientDetails', 'backend', 'Label / Client Details', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Client Details', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblUpdateBooking', 'backend', 'Label / Update Booking', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Update Reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblUniqueID', 'backend', 'Label / Unique ID', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Unique ID', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDepositPaid', 'backend', 'Label / Deposit paid', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Deposit paid', 'script');

INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, 1, 'pjPayment', 1, 'creditcard', 'Credit Card', 'script'),
(NULL, 1, 'pjPayment', 1, 'cash', 'Cash', 'script'),
(NULL, 1, 'pjPayment', 1, 'bank', 'Bank Account', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'payment_methods_ARRAY_paypal', 'arrays', 'payment_methods_ARRAY_paypal', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Paypal', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'payment_methods_ARRAY_creditcard', 'arrays', 'payment_methods_ARRAY_creditcard', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Credit Card', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'payment_methods_ARRAY_cash', 'arrays', 'payment_methods_ARRAY_cash', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Cash', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'payment_methods_ARRAY_bank', 'arrays', 'payment_methods_ARRAY_bank', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Bank Account', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblPaymentMethod', 'backend', 'Label / Payment Method', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Payment method', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblCCType', 'backend', 'Label / CC type', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'CC type', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'cc_types_ARRAY_Visa', 'arrays', 'cc_types_ARRAY_Visa', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Visa', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'cc_types_ARRAY_MasterCard', 'arrays', 'cc_types_ARRAY_MasterCard', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'MasterCard', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'cc_types_ARRAY_Maestro', 'arrays', 'cc_types_ARRAY_Maestro', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Maestro', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'cc_types_ARRAY_AmericanExpress', 'arrays', 'cc_types_ARRAY_AmericanExpress', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'AmericanExpress', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblCCNum', 'backend', 'Label / CC number', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'CC number', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblCCExp', 'backend', 'Label / CC expiration date', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'CC expiration date', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblCCCode', 'backend', 'Label / CC security code', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'CC security code', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingTotal', 'backend', 'Label / Total', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Total', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblPeople', 'backend', 'Label / People', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'People', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblTableName', 'backend', 'Label / Table name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Table name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblViewAvailability', 'backend', 'Label / View availability', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'View availability', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingAvailability', 'backend', 'Label / Availability', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Availability', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'name_titles_ARRAY_mr', 'arrays', 'name_titles_ARRAY_mr', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Mr', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'name_titles_ARRAY_mrs', 'arrays', 'name_titles_ARRAY_mrs', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Mrs', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'name_titles_ARRAY_ms', 'arrays', 'name_titles_ARRAY_ms', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Ms', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'name_titles_ARRAY_dr', 'arrays', 'name_titles_ARRAY_dr', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Dr', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'name_titles_ARRAY_prof', 'arrays', 'name_titles_ARRAY_prof', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Prof', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'name_titles_ARRAY_rev', 'arrays', 'name_titles_ARRAY_rev', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Rev', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'name_titles_ARRAY_other', 'arrays', 'name_titles_ARRAY_other', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Other', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingTitle', 'backend', 'Label / Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingFname', 'backend', 'Label / First name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'First name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingLname', 'backend', 'Label / Last name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Last name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingPhone', 'backend', 'Label / Phone', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Phone', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingEmail', 'backend', 'Label / Email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Email', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingNotes', 'backend', 'Label / Notes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Notes', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingCompany', 'backend', 'Label / Company name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Company name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingAddress', 'backend', 'Label / Address', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Address', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingCity', 'backend', 'Label / City', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'City', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingState', 'backend', 'Label / State', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'County/Region/State', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingZip', 'backend', 'Label / Zip', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Postcode/Zip', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingCountry', 'backend', 'Label / Country', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Country', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AB05', 'arrays', 'error_titles_ARRAY_AB05', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation updated', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AB05', 'arrays', 'error_bodies_ARRAY_AB05', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'All changes made to the reservation have been saved.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingPrint', 'backend', 'Label / Print Booking Details', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Print Reservation Details', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingRemind', 'backend', 'Label / Re-send confirmation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Re-send confirmation email', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingID', 'backend', 'Label / ID', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'ID', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingCreated', 'backend', 'Label / Created', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Created', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingTxnID', 'backend', 'Label / Txn ID', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Transaction ID', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingProcessedOn', 'backend', 'Label / Processed on', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Processed on', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoReminderEmailTitle', 'backend', 'Infobox / Reminder email title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reminder email', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoReminderEmailDesc', 'backend', 'Infobox / Reminder email desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'You can make any change on the form below and click SEND button to send the reminder message.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblReminderTo', 'backend', 'Label / To', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'To', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblReminderSubject', 'backend', 'Label / Subject', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Subject', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblReminderMessage', 'backend', 'Label / Message', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Message', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AB09', 'arrays', 'error_titles_ARRAY_AB09', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reminder email sent', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AB09', 'arrays', 'error_bodies_ARRAY_AB09', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'The reminder email has been sent to the give email address.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AB10', 'arrays', 'error_titles_ARRAY_AB10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reminder failed to send', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AB10', 'arrays', 'error_bodies_ARRAY_AB10', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'The reminder email could not be sent successfully. Please check again.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblClientName', 'backend', 'Label / Client name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Client name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblPerson', 'backend', 'label / Person', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Person', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblNoBookings', 'backend', 'Label / No bookings', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'No reservations found', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblPrint', 'backend', 'Label / Print', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Print', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblInstallJs1_title', 'backend', 'Install / Install code', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Install code', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblInstallJs1_body', 'backend', 'Install / Install code body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Copy the code below and put it on your web page. It will show the front end booking engine. Please, note that the code should be used on a web page from the same domain name where script is installed.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblInstallConfig', 'backend', 'Label / Language options', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Language options', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblInstallConfigLocale', 'backend', 'Label / Language', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Language', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblInstallConfigHide', 'backend', 'Label / Hide language selector ', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Hide language selector', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblInstallJs1_1', 'backend', 'Label / Step 1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Step 1 (Required)', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_select_date_time', 'frontend', 'Label / Select date time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Select date and time
for your reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_date', 'frontend', 'Label / Date', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Date', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_time', 'frontend', 'Label / Time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Time', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_people', 'frontend', 'Label / People', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'People', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_check_availability', 'frontend', 'Label / Check Availability', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Check Availability', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_avail_title', 'frontend', 'Label / Available for', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Available tables for %1s person(s) on %2s at %3s
click on a table to book it', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_book', 'frontend', 'Book', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Book', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_send_enquiry', 'frontend', 'Label / Send Enquiry', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Send Enquiry', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_no_available_table', 'frontend', 'Label / No table', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'There is no table available
click on SEND ENQUIRY button to make an enquiry', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_selected_tables', 'frontend', 'Label / Selected table(s)', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Selected table', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_your_booking', 'frontend', 'Label / Your booking', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Your booking
booking details', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_booking_form', 'frontend', 'Label / Booking form', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation form
fill the form to reserve a table', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_date_time', 'frontend', 'Label / Date and time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Date and time', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_table_for', 'frontend', 'Label / Table for person', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Table for %s person(s)', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_change', 'frontend', 'Label / change', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'change selection', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_title', 'frontend', 'Label / Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_fname', 'frontend', 'Label / First name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'First name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_lname', 'frontend', 'Label / Last name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Last name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_phone', 'frontend', 'Label / Phone', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Phone', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_email', 'backend', 'Label / Email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Email', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_company', 'frontend', 'Label / Company name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Company name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_notes', 'frontend', 'Label / Notes', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Notes', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_address', 'frontend', 'Label / Address', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Address', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_city', 'frontend', 'Label / City', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'City', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_state', 'frontend', 'Label / State', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'State', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_zip', 'frontend', 'Label / Zip', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Zip', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_country', 'frontend', 'Label / Country', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Country', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_checkout', 'frontend', 'Label / Checkout', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Checkout', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_discount', 'frontend', 'Label / discount', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'discount', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_deposit_note', 'frontend', 'Label / Deposit note', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Payment is required to secure your reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_price', 'frontend', 'Label / Price', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Price', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDate', 'backend', 'Label / Date', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Date', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDateTimeFrom', 'backend', 'Label / From date time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'From date/time', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDateTimeTo', 'backend', 'Label / To date/time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'To date/time', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_payment_medthod', 'frontend', 'Label / Payment method', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Payment method', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cc_type', 'frontend', 'Label / CC type', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'CC type', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cc_num', 'frontend', 'Label / CC number', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'CC number', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cc_exp', 'frontend', 'Label / CC expiration date', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'CC expiration date', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cc_code', 'frontend', 'Label / CC security code', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'CC security code', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_captcha', 'frontend', 'Captcha', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Captcha', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_required_field', 'frontend', 'Label / This field is required.', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'This field is required.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_invalid_email', 'frontend', 'Label / Email is not valid.', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Email is not valid.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_incorrect_captcha', 'frontend', 'Label / Captcha is not correct.', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Captcha is not correct.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_exp_month', 'frontend', 'Label / Expiration month is required.', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Expiration month is required.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_exp_year', 'frontend', 'Label / Expiration year is required.', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Expiration year is required.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_agree', 'frontend', 'Label / Agreements', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'I have read and accept reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_terms_conditions', 'frontend', 'Label / Terms and Conditions', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Terms and Conditions', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_booking_summary', 'frontend', 'Label / Booking summary', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation summary
detail information', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_confirm', 'frontend', 'Label / Confirm Booking', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Confirm Reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_back', 'frontend', 'Label / Back', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Back', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_messages_ARRAY_4', 'arrays', 'front_messages_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation failed to save.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_messages_ARRAY_1', 'arrays', 'front_messages_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Your reservation has been saved. Redirecting to payment gateway....', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_messages_ARRAY_3', 'arrays', 'front_messages_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Your reservation is saved. [STAG]Start over[ETAG].', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_messages_ARRAY_5', 'arrays', 'front_messages_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Your enquiry has been sent. [STAG]Start over[ETAG].', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_messages_ARRAY_0', 'arrays', 'front_messages_ARRAY_0', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation is being processed...', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_missing_params', 'frontend', 'Label / Missing params', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Error! Some parameters are missing. ', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_restaurant_reservations', 'frontend', 'Label / Restaurant Reservations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Restaurant Reservations', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_note', 'frontend', 'Label / Cancel note', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Cancel Reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'cancel_err_ARRAY_1', 'arrays', 'cancel_err_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Missing parameters', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'cancel_err_ARRAY_2', 'arrays', 'cancel_err_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation with such ID does not exist.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'cancel_err_ARRAY_3', 'arrays', 'cancel_err_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Security hash did not match', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'cancel_err_ARRAY_4', 'arrays', 'cancel_err_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation is already cancelled.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'cancel_err_ARRAY_200', 'arrays', 'cancel_err_ARRAY_200', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation has been cancelled successfully.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_heading', 'frontend', 'Label / Cancel Heading', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Your reservation details', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_from', 'frontend', 'Label / Cancel from', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Date/Time From', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_people', 'frontend', 'Label / People', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'People', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_code', 'frontend', 'Label / Promo code', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Promo code', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_title', 'frontend', 'Label / Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Title', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_description', 'frontend', 'Label / Description', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Description', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_datetime', 'frontend', 'Label / Date/time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Date/time', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_fname', 'frontend', 'Label / First name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'First name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_lname', 'frontend', 'Label / Last name', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Last name', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_email', 'frontend', 'Label / Email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Email', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_phone', 'frontend', 'Label / Phone', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Phone', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_company', 'frontend', 'Label / Company', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Company', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_country', 'frontend', 'Label / Country', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Country', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_city', 'frontend', 'Label / City', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'City', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_state', 'frontend', 'Label / State', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'State', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_zip', 'frontend', 'Label / Zip', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Zip', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_address', 'frontend', 'Label / Address', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Address', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_payment', 'frontend', 'Label / Payment', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Payment', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_total', 'frontend', 'Label / Total', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Total', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_table', 'frontend', 'Label / Table', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Table', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_confirm', 'frontend', 'Label / Table', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Cancel Reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel_personal', 'frontend', 'Label / Personal Details', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Personal Details', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_cancel', 'frontend', 'Label / Cancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Cancel', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_intro_text', 'frontend', 'Label / Intro text', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', '%1s available table(s) found.
click on a table to reserve it', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_loading_tables', 'frontend', 'Label / loading tables', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Loading tables ...', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoWTimeTitle', 'backend', 'Infobox / Working Time Settings', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Working Time Settings', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoWTimeDesc', 'backend', 'Infobox / Working Time Desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Below is the form to set the working time for the restaurant. You can also set different settings for some specific dates by clicking on the Tab Custom.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_dayoff', 'frontend', 'Label / Day off', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'There is no working time for day off.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblToday', 'backend', 'Label / Today', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Today', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblTomorrow', 'backend', 'Label / Tomorrow', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Tomorrow', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_messages_ARRAY_300', 'arrays', 'front_messages_ARRAY_300', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'The selected date is day off.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_messages_ARRAY_301', 'arrays', 'front_messages_ARRAY_301', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'You must reserve [HOUR] hours before.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_messages_ARRAY_302', 'arrays', 'front_messages_ARRAY_302', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'We are not open yet.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_messages_ARRAY_303', 'arrays', 'front_messages_ARRAY_303', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'We are close.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblTableHour', 'backend', 'Label / Table / Hour', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Table / Hour', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuAddBooking', 'backend', 'Menu / Add Booking', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Add Reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBookingPrice', 'backend', 'Label / Price', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Price', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AB11', 'arrays', 'error_titles_ARRAY_AB11', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation Added', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_bodies_ARRAY_AB11', 'arrays', 'error_bodies_ARRAY_AB11', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'A new reservation has been added to the list.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'error_titles_ARRAY_AB12', 'arrays', 'error_titles_ARRAY_AB12', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation could not be added.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_button_cancel', 'frontend', 'Button / Cancel', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Cancel', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'menuBookings', 'backend', 'Menu / Reservations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservations', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblOptionClient', 'backend', 'Label / Option Client', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'To Clients', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblOptionAdministrator', 'backend', 'Label / Option Administrator', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'To Administrators', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_intro_text2', 'frontend', 'Label / Intro text 2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Please send an enquiry and we will manually confirm your reservation.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblBack', 'backend', 'Lable / Back', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Back', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_start_over', 'frontend', 'Label / Error start over', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Error! Please, [STAG]start over[ETAG]', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblDepositFee', 'backend', 'Label / Deposit fee', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Deposit fee', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoScheduleTitle', 'backend', 'Infobox / Schedule Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Schedule', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoScheduleDesc', 'backend', 'Infobox / Schedule Desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'By default below you see today''s schedule. Use the date picker to switch to any date. You can also print the schedule by clicking on the Print button.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoAddBookingTitle', 'backend', 'Infobox / Add Booking Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Add new reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoAddBookingDesc', 'backend', 'Infobox / Add booking Desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Fill in the form below to add a new reservation.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoUpdateBookingTitle', 'backend', 'Infobox / Update booking title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Update reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoUpdateBookingDesc', 'backend', 'Infobox / Update booking desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Update reservation details', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoBookingListTitle', 'backend', 'Infobox / Bookings list', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservations list', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoBookingListDesc', 'backend', 'Infobox / Reservations list desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Below you can see all the reservations and enquiries made. Click on any of them to view and edit it. Using the buttons you can filter the reservation by their status. Use the advance search to quickly locate a reservation.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoConfirmation2Title', 'backend', 'Infobox / Confirmation Admin Title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Email Confirmations', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'infoConfirmation2Desc', 'backend', 'Infobox / Confirmation Admin Desc', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'There are 4 types of email confirmations - one after reservation form is submitted , one after payment is made, one is enquiry email and one when cancelled the reservation. Use the available tokens to personalize the email messages.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblMadeOn', 'backend', 'Label / Made on', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Made on', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_cancel_reservation', 'frontend', 'Label / Cancel reservation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Cancel reservation', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_cron_completed', 'frontend', 'Label / CRON job completed.', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'CRON job completed.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblPositiveNumber', 'backend', 'Label / Please enter positive number', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Please enter positive number.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblValidateMinimum', 'backend', 'Label / Validate minimum', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Minimum cannot be greater than capacity.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'uuid_used', 'backend', 'Label / Unique ID was used.', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Unique ID was used.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblValidateTime', 'backend', 'Label / Validate time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'End time must be greater than start time.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblValidateDateTime', 'backend', 'Label / Validate date time', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'To date/time must be greater than From date/time.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'front_label_price_after', 'frontend', 'Label / Price after discount applied', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Price after discount applied', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblFieldRequired', 'backend', 'Label / This field is required.', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'This field is required.', 'script');

INSERT INTO `restaurantbooking_plugin_base_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(NULL, 'lblReservationID', 'backend', 'Label / Reservation ID', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, @id, 'pjField', 1, 'title', 'Reservation ID', 'script');

INSERT INTO `restaurantbooking_plugin_base_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, 1, 'pjOption', 1, 'o_reminder_subject', 'Booking Reminder', 'data'),
(NULL, 1, 'pjOption', 1, 'o_reminder_body', 'You''ve just made a booking.<br/><br/>Personal details:<br/>Title: {Title}<br/>First Name: {FirstName}<br/>Last Name: {LastName}<br/>E-Mail: {Email}<br/>Phone: {Phone}<br/>Notes: {Notes}<br/>Country: {Country}<br/>City: {City}<br/>State: {State}<br/>Zip: {Zip}<br/>Address: {Address}<br/>Company: {Company}<br/><br/>Booking details:<br/>Date/Time From: {DtFrom}<br/>Table: {Table}<br/>People: {People}<br/>Booking ID: {BookingID}<br/>Unique ID: {UniqueID}<br/>Total: {Total}<br/><br/>If you want to cancel your booking follow next link: {CancelURL}<br/><br/>Thank you, we will contact you ASAP.', 'data'),
(NULL, 1, 'pjOption', 1, 'o_reminder_sms_message', '{FirstName}, booking reminder {Table}', 'data'),
(NULL, 1, 'pjOption', 1, 'o_terms', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eu ipsum consectetur arcu commodo egestas nec eu ante. Aenean nec enim lorem. Proin accumsan luctus luctus. Vivamus pulvinar mollis orci, id convallis eros ultricies vel. Nullam adipiscing, risus non pellentesque aliquam, nibh ligula dictum justo, quis commodo nisi dolor ut nulla. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ante leo, ultricies quis gravida id, vestibulum nec risus. Mauris adipiscing vestibulum nibh non ullamcorper. Suspendisse justo turpis, mattis a cursus ac, vulputate quis metus. Fusce vestibulum faucibus dignissim. Aliquam fermentum mauris felis, a ultrices sem.', 'data'),
(NULL, 1, 'pjOption', 1, 'o_enquiry', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eu ipsum consectetur arcu commodo egestas nec eu ante. Aenean nec enim lorem. Proin accumsan luctus luctus. Vivamus pulvinar mollis orci, id convallis eros ultricies vel. Nullam adipiscing, risus non pellentesque aliquam, nibh ligula dictum justo, quis commodo nisi dolor ut nulla. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ante leo, ultricies quis gravida id, vestibulum nec risus. Mauris adipiscing vestibulum nibh non ullamcorper. Suspendisse justo turpis, mattis a cursus ac, vulputate quis metus. Fusce vestibulum faucibus dignissim. Aliquam fermentum mauris felis, a ultrices sem.', 'data'),
(NULL, 1, 'pjOption', 1, 'o_email_confirmation_subject', 'Confirmation message', 'data'),
(NULL, 1, 'pjOption', 1, 'o_email_confirmation_message', 'You''ve just made a booking.<br/><br/>Personal details:<br/>Title: {Title}<br/>First Name: {FirstName}<br/>Last Name: {LastName}<br/>E-Mail: {Email}<br/>Phone: {Phone}<br/>Notes: {Notes}<br/>Country: {Country}<br/>City: {City}<br/>State: {State}<br/>Zip: {Zip}<br/>Address: {Address}<br/>Company: {Company}<br/><br/>Booking details:<br/>Date/Time From: {DtFrom}<br/>Table: {Table}<br/>People: {People}<br/>Booking ID: {BookingID}<br/>Unique ID: {UniqueID}<br/>Total: {Total}<br/><br/>If you want to cancel your booking follow next link: {CancelURL}<br/><br/>Thank you, we will contact you ASAP.', 'data'),
(NULL, 1, 'pjOption', 1, 'o_email_payment_subject', 'Payment message', 'data'),
(NULL, 1, 'pjOption', 1, 'o_email_payment_message', 'You''ve just made a booking.<br/><br/>Personal details:<br/>Title: {Title}<br/>First Name: {FirstName}<br/>Last Name: {LastName}<br/>E-Mail: {Email}<br/>Phone: {Phone}<br/>Notes: {Notes}<br/>Country: {Country}<br/>City: {City}<br/>State: {State}<br/>Zip: {Zip}<br/>Address: {Address}<br/>Company: {Company}<br/><br/>Booking details:<br/>Date/Time From: {DtFrom}<br/>Table: {Table}<br/>People: {People}<br/>Booking ID: {BookingID}<br/>Unique ID: {UniqueID}<br/>Total: {Total}<br/><br/>If you want to cancel your booking follow next link: {CancelURL}<br/><br/>Thank you, we will contact you ASAP.', 'data'),
(NULL, 1, 'pjOption', 1, 'o_email_cancel_subject', 'Cancel booking message', 'data'),
(NULL, 1, 'pjOption', 1, 'o_email_cancel_message', 'You''ve just cancel a booking.<br/><br/>Personal details:<br/>Title: {Title}<br/>First Name: {FirstName}<br/>Last Name: {LastName}<br/>E-Mail: {Email}<br/>Phone: {Phone}<br/>Notes: {Notes}<br/>Country: {Country}<br/>City: {City}<br/>State: {State}<br/>Zip: {Zip}<br/>Address: {Address}<br/>Company: {Company}<br/><br/>Booking details:<br/>Date/Time From: {DtFrom}<br/>Table: {Table}<br/>People: {People}<br/>Booking ID: {BookingID}<br/>Unique ID: {UniqueID}<br/>Total: {Total}<br/><br/>Thank you!', 'data'),
(NULL, 1, 'pjOption', 1, 'o_email_enquiry_subject', 'Enquiry message', 'data'),
(NULL, 1, 'pjOption', 1, 'o_email_enquiry_message', 'You''ve just made an enquiry.<br/><br/>Personal details:<br/>Title: {Title}<br/>First Name: {FirstName}<br/>Last Name: {LastName}<br/>E-Mail: {Email}<br/>Phone: {Phone}<br/>Notes: {Notes}<br/>Country: {Country}<br/>City: {City}<br/>State: {State}<br/>Zip: {Zip}<br/>Address: {Address}<br/>Company: {Company}<br/><br/>Enquiry details:<br/>Date/Time From: {DtFrom}<br/>People: {People}<br/>Unique ID: {UniqueID}<br/><br/>If you want to cancel your enquiry follow next link: {CancelURL}<br/><br/>Thank you, we will contact you ASAP.', 'data'),
(NULL, 1, 'pjOption', 1, 'o_admin_email_confirmation_subject', 'Confirmation message', 'data'),
(NULL, 1, 'pjOption', 1, 'o_admin_email_confirmation_message', 'You''ve just received a booking.<br/><br/>Personal details:<br/>Title: {Title}<br/>First Name: {FirstName}<br/>Last Name: {LastName}<br/>E-Mail: {Email}<br/>Phone: {Phone}<br/>Notes: {Notes}<br/>Country: {Country}<br/>City: {City}<br/>State: {State}<br/>Zip: {Zip}<br/>Address: {Address}<br/>Company: {Company}<br/><br/>Booking details:<br/>Date/Time From: {DtFrom}<br/>Table: {Table}<br/>People: {People}<br/>Booking ID: {BookingID}<br/>Unique ID: {UniqueID}<br/>Total: {Total}<br/><br/>Thank you!', 'data'),
(NULL, 1, 'pjOption', 1, 'o_admin_email_payment_subject', 'Payment message', 'data'),
(NULL, 1, 'pjOption', 1, 'o_admin_email_payment_message', 'You''ve just receive the payment for the following booking.<br/><br/>Personal details:<br/>Title: {Title}<br/>First Name: {FirstName}<br/>Last Name: {LastName}<br/>E-Mail: {Email}<br/>Phone: {Phone}<br/>Notes: {Notes}<br/>Country: {Country}<br/>City: {City}<br/>State: {State}<br/>Zip: {Zip}<br/>Address: {Address}<br/>Company: {Company}<br/><br/>Booking details:<br/>Date/Time From: {DtFrom}<br/>Table: {Table}<br/>People: {People}<br/>Booking ID: {BookingID}<br/>Unique ID: {UniqueID}<br/>Total: {Total}<br/><br/><br/>Thank you!', 'data'),
(NULL, 1, 'pjOption', 1, 'o_admin_email_enquiry_subject', 'Enquiry message', 'data'),
(NULL, 1, 'pjOption', 1, 'o_admin_email_enquiry_message', 'You''ve just received an enquiry.<br/><br/>Personal details:<br/>Title: {Title}<br/>First Name: {FirstName}<br/>Last Name: {LastName}<br/>E-Mail: {Email}<br/>Phone: {Phone}<br/>Notes: {Notes}<br/>Country: {Country}<br/>City: {City}<br/>State: {State}<br/>Zip: {Zip}<br/>Address: {Address}<br/>Company: {Company}<br/><br/>Enquiry details:<br/>Date/Time From: {DtFrom}<br/>People: {People}<br/>Unique ID: {UniqueID}<br/><br/><br/>Thank you!', 'data'),
(NULL, 1, 'pjOption', 1, 'o_admin_email_cancel_subject', 'Cancel booking message', 'data'),
(NULL, 1, 'pjOption', 1, 'o_admin_email_cancel_message', 'A booking has been cancelled.<br/><br/>Personal details:<br/>Title: {Title}<br/>First Name: {FirstName}<br/>Last Name: {LastName}<br/>E-Mail: {Email}<br/>Phone: {Phone}<br/>Notes: {Notes}<br/>Country: {Country}<br/>City: {City}<br/>State: {State}<br/>Zip: {Zip}<br/>Address: {Address}<br/>Company: {Company}<br/><br/>Booking details:<br/>Date/Time From: {DtFrom}<br/>Table: {Table}<br/>People: {People}<br/>Booking ID: {BookingID}<br/>Unique ID: {UniqueID}<br/>Total: {Total}<br/><br/>Thank you!', 'data');

INSERT INTO `restaurantbooking_options` (`foreign_id`, `key`, `tab_id`, `value`, `label`, `type`, `order`, `is_visible`, `style`) VALUES
(1, 'o_booking_price', 2, '50', NULL, 'float', 2, 1, NULL),
(1, 'o_booking_length', 2, '180', NULL, 'int', 3, 1, NULL),
(1, 'o_booking_earlier', 2, '2', NULL, 'int', 4, 1, NULL),
(1, 'o_booking_status', 2, 'confirmed|pending|cancelled::pending', 'Confirmed|Pending|Cancelled', 'enum', 5, 1, NULL),
(1, 'o_payment_status', 2, 'confirmed|pending|cancelled::confirmed', 'Confirmed|Pending|Cancelled', 'enum', 6, 1, NULL),
(1, 'o_thank_you_page', 2, 'https://www.phpjabbers.com', NULL, 'string', 7, 1, NULL),
(1, 'o_payment_disable', 2, 'Yes|No::No', 'Yes|No', 'enum', 8, 1, NULL),
(1, 'o_allow_cash', 2, 'Yes|No::Yes', 'Yes|No', 'enum', 16, 1, NULL),
(1, 'o_allow_creditcard', 2, 'Yes|No::Yes', 'Yes|No', 'enum', 17, 1, NULL),
(1, 'o_allow_bank', 2, 'Yes|No::No', NULL, 'enum', 18, 1, NULL),
(1, 'o_bank_account', 2, NULL, NULL, 'text', 19, 1, NULL),

(1, 'o_email_confirmation', 3, 'Yes|No::Yes', 'Yes|No', 'enum', 1, 1, NULL),
(1, 'o_email_confirmation_subject', 3, '', NULL, 'string', 2, 1, NULL),
(1, 'o_email_confirmation_message', 3, '', NULL, 'text', 3, 1, NULL),
(1, 'o_email_payment', 3, 'Yes|No::Yes', 'Yes|No', 'enum', 4, 1, NULL),
(1, 'o_email_payment_subject', 3, '', NULL, 'string', 5, 1, NULL),
(1, 'o_email_payment_message', 3, '', NULL, 'text', 6, 1, NULL),
(1, 'o_email_enquiry', 3, 'Yes|No::Yes', 'Yes|No', 'enum', 7, 1, NULL),
(1, 'o_email_enquiry_subject', 3, '', NULL, 'string', 8, 1, NULL),
(1, 'o_email_enquiry_message', 3, '', NULL, 'text', 9, 1, NULL),
(1, 'o_email_cancel', 3, 'Yes|No::Yes', 'Yes|No', 'enum', 10, 1, NULL),
(1, 'o_email_cancel_subject', 3, '', NULL, 'string', 11, 1, NULL),
(1, 'o_email_cancel_message', 3, '', NULL, 'text', 12, 1, NULL),

(1, 'o_admin_email_confirmation', 3, 'Yes|No::Yes', 'Yes|No', 'enum', 1, 1, NULL),
(1, 'o_admin_email_confirmation_subject', 3, '', NULL, 'string', 2, 1, NULL),
(1, 'o_admin_email_confirmation_message', 3, '', NULL, 'text', 3, 1, NULL),
(1, 'o_admin_email_payment', 3, 'Yes|No::Yes', 'Yes|No', 'enum', 4, 1, NULL),
(1, 'o_admin_email_payment_subject', 3, '', NULL, 'string', 5, 1, NULL),
(1, 'o_admin_email_payment_message', 3, '', NULL, 'text', 6, 1, NULL),
(1, 'o_admin_email_enquiry', 3, 'Yes|No::Yes', 'Yes|No', 'enum', 7, 1, NULL),
(1, 'o_admin_email_enquiry_subject', 3, '', NULL, 'string', 8, 1, NULL),
(1, 'o_admin_email_enquiry_message', 3, '', NULL, 'text', 9, 1, NULL),
(1, 'o_admin_email_cancel', 3, 'Yes|No::Yes', 'Yes|No', 'enum', 10, 1, NULL),
(1, 'o_admin_email_cancel_subject', 3, '', NULL, 'string', 11, 1, NULL),
(1, 'o_admin_email_cancel_message', 3, '', NULL, 'text', 12, 1, NULL),

(1, 'o_bf_include_title', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 1, 1, NULL),
(1, 'o_bf_include_fname', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 2, 1, NULL),
(1, 'o_bf_include_lname', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 3, 1, NULL),
(1, 'o_bf_include_phone', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 4, 1, NULL),
(1, 'o_bf_include_email', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 5, 1, NULL),
(1, 'o_bf_include_company', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 6, 1, NULL),
(1, 'o_bf_include_address', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 7, 1, NULL),
(1, 'o_bf_include_country', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 8, 1, NULL),
(1, 'o_bf_include_state', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 9, 1, NULL),
(1, 'o_bf_include_city', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 10, 1, NULL),
(1, 'o_bf_include_zip', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 11, 1, NULL),
(1, 'o_bf_include_notes', 4, '1|2|3::1', 'No|Yes|Yes (required)', 'enum', 12, 1, NULL),
(1, 'o_bf_include_promo', 4, '1|2|3::2', 'No|Yes|Yes (required)', 'enum', 13, 1, NULL),
(1, 'o_bf_include_captcha', 4, '1|2|3::3', 'No|Yes|Yes (required)', 'enum', 14, 1, NULL),

(1, 'o_terms', 5, '', NULL, 'text', 1, 1, NULL),
(1, 'o_enquiry', 5, '', NULL, 'text', 2, 1, NULL),

(1, 'o_reminder_enable', 6, 'Yes|No::Yes', 'Yes|No', 'enum', 1, 1, NULL),
(1, 'o_reminder_cron', 6, '', NULL, 'text', 2, 1, NULL),
(1, 'o_reminder_email_before', 6, '2', NULL, 'int', 3, 1, NULL),
(1, 'o_reminder_subject', 6, '', NULL, 'string', 4, 1, NULL),
(1, 'o_reminder_body', 6, '', NULL, 'text', 5, 1, NULL),
(1, 'o_reminder_sms_hours', 6, '2', NULL, 'int', 6, 1, NULL),
(1, 'o_reminder_sms_message', 6, '', NULL, 'text', 7, 1, NULL),

(1, 'o_use_map', 99, '1|0::1', NULL, 'enum', NULL, 0, NULL);

INSERT INTO `restaurantbooking_working_times` (`id`, `monday_from`, `monday_to`, `monday_dayoff`, `tuesday_from`, `tuesday_to`, `tuesday_dayoff`, `wednesday_from`, `wednesday_to`, `wednesday_dayoff`, `thursday_from`, `thursday_to`, `thursday_dayoff`, `friday_from`, `friday_to`, `friday_dayoff`, `saturday_from`, `saturday_to`, `saturday_dayoff`, `sunday_from`, `sunday_to`, `sunday_dayoff`) VALUES
(1, '09:00:00', '23:00:00', 'F', '09:00:00', '23:00:00', 'F', '09:00:00', '23:00:00', 'F', '09:00:00', '23:00:00', 'F', '09:00:00', '23:00:00', 'F', '09:00:00', '23:00:00', 'F', NULL, NULL, 'T');