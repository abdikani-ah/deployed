<?php
mt_srand();
$index = mt_rand(1, 9999);
$theme = $controller->_get->toString('theme') ? $controller->_get->toString('theme') : $tpl['option_arr']['o_theme'];

$validate = str_replace(array('"', "'"), array('\"', "\'"), __('validate', true, true));
$front_messages = __('front_messages', true, false);
$show_period = false;
if(strpos($tpl['option_arr']['o_time_format'], 'a') > -1)
{
	$show_period = true;
}
if(strpos($tpl['option_arr']['o_time_format'], 'A') > -1)
{
	$show_period = true;
}
?>
<div id="pjWrapperRestaurant_<?php echo $theme;?>">
	<div id="rbContainer_<?php echo $index; ?>" class="container-fluid pjRbContainer"></div>
</div>
<script type="text/javascript">
var pjQ = pjQ || {},
	RestaurantBooking_<?php echo $index; ?>;
(function () {
	"use strict";
	var isSafari = /Safari/.test(navigator.userAgent) && /Apple Computer/.test(navigator.vendor),

	loadCssHack = function(url, callback){
		var link = document.createElement('link');
		link.type = 'text/css';
		link.rel = 'stylesheet';
		link.href = url;

		document.getElementsByTagName('head')[0].appendChild(link);

		var img = document.createElement('img');
		img.onerror = function(){
			if (callback && typeof callback === "function") {
				callback();
			}
		};
		img.src = url;
	},
	loadRemote = function(url, type, callback) {
		if (type === "css" && isSafari) {
			loadCssHack(url, callback);
			return;
		}
		var _element, _type, _attr, scr, s, element;
		
		switch (type) {
		case 'css':
			_element = "link";
			_type = "text/css";
			_attr = "href";
			break;
		case 'js':
			_element = "script";
			_type = "text/javascript";
			_attr = "src";
			break;
		}
		
		scr = document.getElementsByTagName(_element);
		s = scr[scr.length - 1];
		element = document.createElement(_element);
		element.type = _type;
		if (type == "css") {
			element.rel = "stylesheet";
		}
		if (element.readyState) {
			element.onreadystatechange = function () {
				if (element.readyState == "loaded" || element.readyState == "complete") {
					element.onreadystatechange = null;
					if (callback && typeof callback === "function") {
						callback();
					}
				}
			};
		} else {
			element.onload = function () {
				if (callback && typeof callback === "function") {
					callback();
				}
			};
		}
		element[_attr] = url;
		s.parentNode.insertBefore(element, s.nextSibling);
	},
	loadScript = function (url, callback) {
		loadRemote(url, "js", callback);
	},
	loadCss = function (url, callback) {
		loadRemote(url, "css", callback);
	},
	getSessionId = function () {
		return sessionStorage.getItem("session_id") == null ? "" : sessionStorage.getItem("session_id");
	},
	createSessionId = function () {
		if(getSessionId()=="") {
			sessionStorage.setItem("session_id", "<?php echo session_id(); ?>");
		}
	},
	options = {
		server: "<?php echo PJ_INSTALL_URL; ?>",
		folder: "<?php echo PJ_INSTALL_URL; ?>",
		theme: "<?php echo $theme;?>",
		index: <?php echo $index; ?>,
		locale: <?php echo $controller->_get->toInt('locale') ? $controller->_get->toInt('locale') : $controller->pjActionGetLocale(); ?>,
		hide: <?php echo $controller->_get->toInt('hide') === 1 ? 1 : 0; ?>,
		week_start: <?php echo (int) $tpl['option_arr']['o_week_start']; ?>,
		momentDateFormat: "<?php echo pjUtil::momentJsDateFormat($tpl['option_arr']['o_date_format']); ?>",
		date_format: "<?php echo $tpl['option_arr']['o_date_format']; ?>",
		time_format: "<?php echo $show_period == true ? 'LT' : "HH:mm";?>",
		show_period: <?php echo $show_period == true ? 'true' : 'false'; ?>,
		include_voucher: "<?php echo $tpl['option_arr']['o_bf_include_promo']; ?>",
		use_map: <?php echo $tpl['option_arr']['o_use_map']; ?>,

		validation:{
			required_field: "<?php __('front_label_required_field', false, true);?>",
			invalid_email: "<?php __('front_label_invalid_email', false, true);?>",
			incorrect_captcha: "<?php __('front_label_incorrect_captcha', false, true);?>",
			exp_month: "<?php __('front_label_exp_month', false, true);?>",
			exp_year: "<?php __('front_label_exp_year', false, true);?>"
		},

		loading_tables: "<?php echo $tpl['option_arr']['o_use_map'] == 1 ? __('front_label_loading_tables', true, false) : '';?>",
		
		message_0: "<?php echo pjSanitize::clean($front_messages[0]); ?>",
		message_1: "<?php echo pjSanitize::clean($front_messages[1]); ?>",
		message_3: "<?php echo pjSanitize::clean($front_messages[3]); ?>",
		message_4: "<?php echo pjSanitize::clean($front_messages[4]); ?>",
		message_5: "<?php echo pjSanitize::clean($front_messages[5]); ?>",

		invalid_voucher: "<?php echo pjSanitize::clean(__('plugin_vouchers_front_label_invalid_voucher', true, false)); ?>",
		out_of_range_voucher: "<?php echo pjSanitize::clean(__('plugin_vouchers_front_label_out_range_voucher', true, false)); ?>"
	};
	<?php
	$dm = new pjDependencyManager(PJ_INSTALL_PATH, PJ_THIRD_PARTY_PATH);
	$dm->load(PJ_CONFIG_PATH . 'dependencies.php')->resolve();
	?>
	loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('storage_polyfill'); ?>storagePolyfill.min.js", function () {
		if (isSafari) {
			createSessionId();
			options.session_id = getSessionId();
		}else{
			options.session_id = "";
		}
		loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('pj_jquery'); ?>pjQuery.min.js", function () {
			loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('pj_validate'); ?>pjQuery.validate.min.js", function () {
				loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('pj_bootstrap'); ?>pjQuery.bootstrap.min.js", function () {
					loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('pj_bootstrap_datetimepicker'); ?>moment-with-locales.min.js", function () {
						loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('pj_bootstrap_datetimepicker'); ?>pjQuery.bootstrap-datetimepicker.min.js", function () {
						    <?php if($tpl['option_arr']['o_captcha_type_front'] == 'google'): ?>
						    loadScript('https://www.google.com/recaptcha/api.js', function () {
                            <?php endif; ?>
                                loadScript("<?php echo PJ_INSTALL_URL . PJ_JS_PATH ?>pjRestaurantBooking.js", function () {
                                    RestaurantBooking_<?php echo $index; ?> = new RestaurantBooking(options);
                                });
                            <?php if($tpl['option_arr']['o_captcha_type_front'] == 'google'): ?>
                            });
						    <?php endif; ?>
						});
					});
				});
			});
		});
	});
})();
</script>