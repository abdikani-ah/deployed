
START TRANSACTION;

SET @id := (SELECT `id` FROM `fields` WHERE `key` = "front_label_select_date_time");
UPDATE `multi_lang` SET `content` = 'Select date and time for your reservation' WHERE `foreign_id` = @id AND `model` = "pjBaseField" AND `field` = "title";

SET @id := (SELECT `id` FROM `fields` WHERE `key` = "front_no_available_table");
UPDATE `multi_lang` SET `content` = 'There is no table available. Click on SEND ENQUIRY button to make an enquiry.' WHERE `foreign_id` = @id AND `model` = "pjBaseField" AND `field` = "title";

SET @id := (SELECT `id` FROM `fields` WHERE `key` = "front_label_avail_title");
UPDATE `multi_lang` SET `content` = 'Available tables for %1s person(s) on %2s at %3s. Click on a table to book it.' WHERE `foreign_id` = @id AND `model` = "pjBaseField" AND `field` = "title";

SET @id := (SELECT `id` FROM `fields` WHERE `key` = "front_label_your_booking");
UPDATE `multi_lang` SET `content` = 'Booking details' WHERE `foreign_id` = @id AND `model` = "pjBaseField" AND `field` = "title";

COMMIT;