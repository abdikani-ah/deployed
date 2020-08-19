
START TRANSACTION;

UPDATE `options` SET `value` = '1|3::3', `label` = 'No|Yes (required)' WHERE `foreign_id` = '1' AND `key` = 'o_bf_include_captcha';

COMMIT;