
START TRANSACTION;

INSERT INTO `plugin_base_cron_jobs` (`name`, `controller`, `action`, `interval`, `period`, `is_active`) VALUES
('Cancel pending bookings after the "Table pending time" is over', 'pjCron', 'pjActionCancelBookings', 10, 'minute', 1);

SET @id := (SELECT `id` FROM `fields` WHERE `key` = "opt_o_min_hour");
UPDATE `multi_lang` SET `content` = 'Table pending time' WHERE `foreign_id` = @id AND `model` = "pjField" AND `field` = "title"; 

SET @id := (SELECT `id` FROM `fields` WHERE `key` = "opt_o_min_hour_text");
UPDATE `multi_lang` SET `content` = 'A period of time while table assigned to new bookings with Pending status will not be available for other bookings. After this time status will turn to Cancelled.' WHERE `foreign_id` = @id AND `model` = "pjField" AND `field` = "title"; 
 
COMMIT;