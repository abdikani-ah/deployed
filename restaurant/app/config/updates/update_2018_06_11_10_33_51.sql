
START TRANSACTION;

INSERT INTO `plugin_base_fields` VALUES (NULL, 'front_label_reload_captcha', 'frontend', 'Label / Click to reload', 'script', '2018-06-11 10:33:48');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Can''t read the text? Click to reload.', 'script');

COMMIT;