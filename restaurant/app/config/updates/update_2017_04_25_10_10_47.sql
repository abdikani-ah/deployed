
START TRANSACTION;

INSERT INTO `fields` VALUES (NULL, 'front_price_after_discount', 'frontend', 'Label / Price after discount is applied', 'script', '2017-04-25 09:53:12');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Price after discount is applied', 'script');

COMMIT;