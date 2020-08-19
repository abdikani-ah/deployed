
START TRANSACTION;

ALTER TABLE `bookings` ADD COLUMN `locale_id` int(10) unsigned default NULL AFTER `uuid`;

COMMIT;