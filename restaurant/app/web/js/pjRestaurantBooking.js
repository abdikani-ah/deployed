/*!
 * Restaurant Booking System v2.0
 * https://www.phpjabbers.com/restaurant-booking-system/
 * 
 * Copyright 2014, StivaSoft Ltd.
 * 
 */
(function (window, undefined){
	"use strict";
	
	pjQ.$.ajaxSetup({
		xhrFields: {
			withCredentials: true
		}
	});
	
	var document = window.document,
		datepicker = (pjQ.$.fn.datepicker !== undefined),
		routes = [
		          	{pattern: /^#!\/Search$/, eventName: "loadSearch"},
		          	{pattern: /^#!\/Tables$/, eventName: "loadTables"},
		          	{pattern: /^#!\/Checkout$/, eventName: "loadCheckout"},
		          	{pattern: /^#!\/Preview$/, eventName: "loadPreview"},
		          ];
	
	function log() {
		if (window.console && window.console.log) {
			for (var x in arguments) {
				if (arguments.hasOwnProperty(x)) {
					window.console.log(arguments[x]);
				}
			}
		}
	}
	
	function assert() {
		if (window && window.console && window.console.assert) {
			window.console.assert.apply(window.console, arguments);
		}
	}
	
	function hashBang(value) {
		if (value !== undefined && value.match(/^#!\//) !== null) {
			if (window.location.hash == value) {
				return false;
			}
			
			window.location.hash = value;
			return true;
		}
		
		return false;
	}
	
	function onHashChange() {
		var i, iCnt, m;
		for (i = 0, iCnt = routes.length; i < iCnt; i++) {
			m = window.location.hash.match(routes[i].pattern);
			if (m !== null) {
				pjQ.$(window).trigger(routes[i].eventName, m.slice(1));
				break;
			}
		}
		if (m === null) {
			pjQ.$(window).trigger("loadSearch");
		}
	}
	pjQ.$(window).on("hashchange", function (e) {
    	onHashChange.call(null);
    });
	
	function RestaurantBooking(opts) {
		if (!(this instanceof RestaurantBooking)) {
			return new RestaurantBooking(opts);
		}
				
		this.reset.call(this);
		this.init.call(this, opts);
		
		return this;
	}
	
	RestaurantBooking.inObject = function (val, obj) {
		var key;
		for (key in obj) {
			if (obj.hasOwnProperty(key)) {
				if (obj[key] == val) {
					return true;
				}
			}
		}
		return false;
	};
	
	RestaurantBooking.size = function(obj) {
		var key,
			size = 0;
		for (key in obj) {
			if (obj.hasOwnProperty(key)) {
				size += 1;
			}
		}
		return size;
	};
	
	RestaurantBooking.prototype = {
		reset: function () {
			this.$container = null;
			this.container = null;
			this.opts = {};
			
			return this;
		},
		disableButtons: function () {
			var $el;
			this.$container.find(".btn").each(function (i, el) {
				$el = pjQ.$(el).attr("disabled", "disabled");
			});
		},
		enableButtons: function () {
			this.$container.find(".btn").removeAttr("disabled");
		},
		
		init: function (opts) {
			var self = this;
			this.opts = opts;
			this.container = document.getElementById("rbContainer_" + this.opts.index);
			this.$container = pjQ.$(this.container);
			
			this.$container.on("click.rb", ".rbSelectorLocale", function (e) {
				if (e && e.preventDefault) {
					e.preventDefault();
				}
				var locale = pjQ.$(this).data("id");
				self.opts.locale = locale;
				pjQ.$(this).addClass("rbLocaleFocus").parent().parent().find("a.rbSelectorLocale").not(this).removeClass("rbLocaleFocus");
				
				pjQ.$.get([self.opts.folder, "index.php?controller=pjFront&action=pjActionLocale", "&session_id=", self.opts.session_id].join(""), {
					"locale_id": locale
				}).done(function (data) {
					if (!hashBang("#!/Search")) {
						pjQ.$(window).trigger("loadSearch");
					}
				}).fail(function () {
					log("Deferred is rejected");
				});
				return false;
			}).on("focusin.rb", ".rbSelectorDatepick", function (e) {
				if (datepicker) {
					var $this = pjQ.$(this),
						current_date = $this.val(),
						dOpts = {
						dateFormat: $this.data("dformat"),
						firstDay: $this.data("fday"),
						minDate: 0,
						
					    dayNames: ($this.data("day")).split(","),
					    monthNames: ($this.data("months")).split(","),
					    monthNamesShort: ($this.data("shortmonths")).split(","),
					    dayNamesMin: ($this.data("daymin")).split(","),
						onClose: function(selectedDate){
							if(current_date != selectedDate)
							{
								current_date = selectedDate;
								self.getWorkingTime(selectedDate);
							}
						}
					};
					$this.datepicker(dOpts);
				}
			}).on("focusin.rb", ".rbSelectTimepick", function (e) {
				
				var $this = pjQ.$(this),
					dOpts = {
						hourText: $this.data('hourtitle'),
						minuteText: $this.data('mintitle'),
						showPeriod: self.opts.show_period,
						minTime: {                
					        hour: $this.data('minhour'), 
					        minute: $this.data('minminute')
					    },
					    maxTime: {
					        hour: $this.data('maxhour'), 
					        minute: $this.data('maxminute')
					    },
						beforeShow: function(input, inst) {
							pjQ.$('#ui-timepicker-div').addClass("pjRbjQueryUI");
						}
					};
				$this.timepicker(dOpts);
				
			}).on("click.rb", ".pjRbHotSpotAvailable", function (e) {
				var $this = pjQ.$(this);

				self.addTable($this);
			}).on("change.rb", ".rbSelectTime", function (e) {
				var $this = pjQ.$(this);
				
				self.formChange();
			}).on("click.rb", "#rbCheckAvail_" + self.opts.index, function (e) {
				self.disableButtons.call(self);
				
				self.checkAvailability.call(self);
			}).on("click.rb", "#rbSendEnquiry_" + self.opts.index, function (e) {
				self.disableButtons.call(self);
				hashBang("#!/Checkout");
				return false;
			}).on("click.rb", "#rbBtnAddVoucher_" + self.opts.index, function (e) {
				if (e && e.preventDefault) {
					e.preventDefault();
				}
				var frm = document.getElementById('rbCheckoutForm_' + self.opts.index);
				if (frm && frm.promo_code && frm.promo_code.value != "") {
					self.addPromo(frm);
				}
			}).on("click.rb", "#rbBtnRemoveVoucher_" + self.opts.index, function (e) {
				if (e && e.preventDefault) {
					e.preventDefault();
				}
				var frm = document.getElementById('rbCheckoutForm_' + self.opts.index);
				self.removePromo(frm);
			}).on("change.rb", "#rbPaymentMethod_" + self.opts.index, function (e) {
				pjQ.$('.pjRbCcWrap').hide();
				pjQ.$('.pjRbBankWrap').hide();
				if(pjQ.$(this).val() == 'creditcard'){
					pjQ.$('.pjRbCcWrap').show();
				}
				if(pjQ.$(this).val() == 'bank'){
					pjQ.$('.pjRbBankWrap').show();
				}
			}).on("click.rb", "#rbBtnTerms_" + self.opts.index, function (e) {
				if (e && e.preventDefault) {
					e.preventDefault();
				}
				var $terms = pjQ.$("#rbTermContainer_" + self.opts.index);
				if($terms.is(':visible')){
					$terms.css('display', 'none');
				}else{
					$terms.css('display', 'block');
				}
			}).on("click.rb", "#rbBtnBack_" + self.opts.index, function (e) {
				self.disableButtons.call(self);
				hashBang("#!/Checkout");
			}).on("click.rb", "#rbBtnCancel_" + self.opts.index, function (e) {
				self.disableButtons.call(self);
				hashBang("#!/Search");
			}).on("click.rb", "#rbBtnConfirm_" + self.opts.index, function (e) {
				self.disableButtons.call(self);
				var $msg_container = pjQ.$('#rbBookingMsg_' + self.opts.index);
				$msg_container.html(self.opts.message_0);
				$msg_container.parent().parent().css('display', 'block');
				
				pjQ.$.post([self.opts.folder, "index.php?controller=pjFront&action=pjActionSaveBooking", "&session_id=", self.opts.session_id].join("")).done(function (data) {
					if (!data.code) {
						return;
					}
					
					switch (parseInt(data.code, 10)) {
						case 100:
						case 110:
						case 111:
						case 112:
							$msg_container.html(self.opts.message_4);
							self.enableButtons.call(self);
							break;
						case 300:
							$msg_container.html(pjQ.$('#rbFailMessage_' + self.opts.index).val());
							$msg_container.html(self.opts.message_6);
							break;
						case 200:window.location = 'http://localhost/fooddelivery/resuser.php?locale=1&hide=0&theme=theme1';
						case 201:
							self.getPaymentForm(data);
							break;
					}
				}).fail(function () {
					self.enableButtons.call(self);
				});
			}).on("click.rb", ".rbLinkCancel", function (e) {
				if (e && e.preventDefault) {
					e.preventDefault();
				}
				var $this = pjQ.$(this);
				
				self.removeTable();
				
			}).on("click.rb", ".rbStartOver", function (e) {
				if (e && e.preventDefault) {
					e.preventDefault();
				}
				hashBang("#!/Search");
			}).on("click.rb", ".pjRbFormCaptcha img", function () {
				var $this = pjQ.$(this);
				$this.attr("src", $this.attr("src").replace(/(&?rand=)\d+/, "$1" + Math.ceil(Math.random() * 999999)));
			});
			
			//Custom events
			pjQ.$(window).on("loadSearch", this.$container, function (e) {
				self.loadSearch.call(self);
			}).on("loadTables", this.$container, function (e) {
				self.loadTables.call(self);
			}).on("loadCheckout", this.$container, function (e) {
				self.loadCheckout.call(self);
			}).on("loadPreview", this.$container, function (e) {
				self.loadPreview.call(self);
			});
			
			if (window.location.hash.length === 0) {
				this.loadSearch.call(this);
			} else {
				onHashChange.call(null);
			}
		},
		checkAvailability: function(){
			var self = this,
				index = this.opts.index,
				$form = pjQ.$('#rbSearchForm_' + index);
			
			self.disableButtons.call(self);
			pjQ.$.post([this.opts.folder, "index.php?controller=pjFront&action=pjActionCheckAvail", "&session_id=", self.opts.session_id].join(""), $form.serialize()).done(function (data) {
				if(data.code == '200')
				{
					if (!hashBang("#!/Tables")) 
					{
						self.loadTables.call(self);
					}
				}else{
					
				}
			});
		},
		loadSearch: function () {
			var self = this,
				index = this.opts.index,
				params = 	{
								"locale": this.opts.locale,
								"hide": this.opts.hide,
								"index": this.opts.index
							};
			if(pjQ.$('#rbSearchForm_' + self.opts.index).find("input[name='first_load']").val() == '0')
			{
				if(pjQ.$('#rbDate_' + index).length > 0)
				{
					pjQ.$.extend(params, {"date": pjQ.$('#rbDate_' + index).val()});
				}
				if(pjQ.$('#rbTime_' + index).length > 0)
				{
					pjQ.$.extend(params, {"time": pjQ.$('#rbTime_' + index).val()});
				}
				if(pjQ.$('#rbPeople_' + index).length > 0)
				{
					pjQ.$.extend(params, {"people": pjQ.$('#rbPeople_' + index).val()});
				}
			}
			pjQ.$.get([this.opts.folder, "index.php?controller=pjFront&action=pjActionSearch", "&session_id=", self.opts.session_id].join(""), params).done(function (data) {
				self.$container.html(data);
				self.bindSearch.call(self);
				self.bindTimePicker.call(self);
				self.bindSpinner.call(self);
			}).fail(function () {
				self.enableButtons.call(self);
			});
		},
		loadTables: function () {
			var self = this,
				index = this.opts.index,
				params = 	{
								"locale": this.opts.locale,
								"hide": this.opts.hide,
								"index": this.opts.index
							};
			pjQ.$.get([this.opts.folder, "index.php?controller=pjFront&action=pjActionTables", "&session_id=", self.opts.session_id].join(""), params).done(function (data) {
				if (data.code != undefined && data.status == 'ERR') {
					if(data.code == '101' || data.code == '102')
					{
						if (!hashBang("#!/Checkout")) 
						{
							self.loadCheckout.call(self);
						}
					}else{
						if (!hashBang("#!/Search")) 
						{
							self.loadSearch.call(self);
						}
					}
				}else{
					self.$container.html(data);
					self.bindSearch.call(self);
					self.bindTimePicker.call(self);
					self.bindSpinner.call(self);
				}
				
			}).fail(function () {
				self.enableButtons.call(self);
			});
		},
		
		bindSpinner: function(){
			var self = this;
			
			if (pjQ.$('.pjRbSpinner').length) {
				pjQ.$('.pjRbSpinner').on('click', '.pjRbSpinnerAction', function(e) {
					var spinnerBtnUpClass = 'pjRbSpinnerActionDecrease';
					var spinnerBtnDownClass = 'pjRbSpinnerActionIncrease';
					var $currentSpinnerBtn = pjQ.$(this);
					var $currentSpinner = $currentSpinnerBtn.parents('.pjRbSpinner');
					var $currentSpinnerInput = $currentSpinner.find('.pjRbSpinnerField');
					var $currentSpinnerInputInitialValue = parseInt($currentSpinnerInput.val());
					var $currentSpinnerInputMaximum = $currentSpinnerInput.attr('data-max');
					var $currentSpinnerInputMinimum = $currentSpinnerInput.attr('data-min');

					if(!$currentSpinnerInput.is(':disabled'))
					{
						if ($currentSpinnerBtn.hasClass(spinnerBtnDownClass)) {
							$currentSpinnerInput.val($currentSpinnerInputInitialValue --- 1);
						} else if ($currentSpinnerBtn.hasClass(spinnerBtnUpClass)) {
							$currentSpinnerInput.val($currentSpinnerInputInitialValue +++ 1);
						};

						if ($currentSpinnerInputMinimum) {
							if ((parseInt($currentSpinnerInput.val())) <= (parseInt($currentSpinnerInputMinimum))) {
								$currentSpinnerInput.val($currentSpinnerInputMinimum)
							};
						};

						if ($currentSpinnerInputMaximum) {
							if ((parseInt($currentSpinnerInput.val())) >= (parseInt($currentSpinnerInputMaximum))) {
								$currentSpinnerInput.val($currentSpinnerInputMaximum)
							};
						};

						$currentSpinnerInput.attr('value', $currentSpinnerInput.val());

						self.formChange.call(self);
					}
					
					e.preventDefault();
				});
			};
		},
		bindSearch: function(){
			var self = this;
			
			if (pjQ.$('.pjRbDatePicker').length) 
			{
				moment.updateLocale('en', {
					week: { dow: self.opts.week_start },
					months : pjQ.$('#pjRbCalendarLocale').data('months').split("_"),
			        weekdaysMin : pjQ.$('#pjRbCalendarLocale').data('days').split("_")
				});
				
				var currentDate = new Date();
				pjQ.$('.pjRbDatePicker').datetimepicker({
					format: self.opts.momentDateFormat.toUpperCase(),
					locale: moment.locale('en'),
					allowInputToggle: true,
					ignoreReadonly: true,
					useCurrent: true,
					minDate: new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate())
				});
				
				pjQ.$('.pjRbDatePicker').on('dp.change', function (e) {
					var selectedDate = pjQ.$('#rbDate_' + self.opts.index).val();
					
					self.getWorkingTime(selectedDate);
				});
			}
		},
		bindTimePicker: function(){
			var self = this;
			if (pjQ.$('.pjRbTimePicker').length) 
			{
				var $timeInput = pjQ.$('#rbTime_' + self.opts.index);
				var enable_str = $timeInput.attr('data-enable');
				var disable_str = $timeInput.attr('data-disable');
				var enable_arr = enable_str.split(",").map(Number);
				var disable_arr = disable_str.split(",").map(Number);
				var time_options = {
					format: self.opts.time_format,
					ignoreReadonly: true,
					allowInputToggle: true,
					useCurrent: false,
					disabledHours: disable_arr,
					enabledHours: enable_arr,
					stepping: 5,
					timeZone: null
				};
				pjQ.$('.pjRbTimePicker').datetimepicker(time_options);
				pjQ.$('.pjRbTimePicker').on('dp.change', function (e) {
					self.formChange.call(self);
				});
			}
		},
		getWorkingTime: function(selectedDate)
		{
			var self = this;
			self.disableButtons.call(self);
			pjQ.$.get([this.opts.folder, "index.php?controller=pjFront&action=pjActionGetWTime", "&session_id=", this.opts.session_id, "&date=", selectedDate].join(""), {
				"locale": this.opts.locale,
				"hide": this.opts.hide,
				"index": this.opts.index
			}).done(function (data) {
				pjQ.$('#pjRbTimeWrapper_' + self.opts.index).html(data);
				self.bindTimePicker.call(self);
				if(pjQ.$('.rbDayOffMessage').length > 0)
				{
					pjQ.$('#rbPromptBooking_' + self.opts.index).parent().css('display', 'none');
					pjQ.$('#rbMapContainer_' + self.opts.index).find(".sbook-rect").each(function (i, el) {
						pjQ.$(el).removeClass('pjRbHotSpotAvailable');
						pjQ.$(el).removeClass('pjRbTableHotspotChosen').addClass('pjRbTableHotspotDisabled');
					});
				}else{
					self.enableButtons.call(self);
				}
				self.formChange();
			}).fail(function () {
				
			});
		},
		addTable: function($target){
			var self = this,
				index = this.opts.index,
				table_id = $target.attr("data-table_id"),
				price_val = $target.attr("data-price"),
				clone_input = pjQ.$('#rbCloneInput_' + index).html(),
				clone_holder = pjQ.$('#rbCloneHolder_' + index).html(),
				$form = pjQ.$('#rbSearchForm_' + index);
			var qs = {
					"locale": this.opts.locale,
					"hide": this.opts.hide,
					"index": this.opts.index,
					"table_id": table_id
				};
			if(self.opts.use_map == 1)
			{
				self.disableButtons.call(self);
			}
			
			pjQ.$('#rbMapContainer_' + self.opts.index).find(".pjRbTableHotspot").each(function (i, el) {
				pjQ.$(el).removeClass('pjRbTableHotspotChosen');
				$target.addClass('pjRbTableHotspotChosen');
			});
			
			pjQ.$.get([this.opts.folder, "index.php?controller=pjFront&action=pjActionAddTable", "&session_id=", self.opts.session_id].join(""), qs).done(function (data) {
				
				if (!hashBang("#!/Checkout")) {
					pjQ.$(window).trigger("loadCheckout");
				}
			});
		},
		removeTable: function(){
			var self = this,
				index = this.opts.index,
				$restaurant_holder = pjQ.$('#rbRestaurantHolder_' + index);
			var qs = {
					"locale": this.opts.locale,
					"hide": this.opts.hide,
					"index": this.opts.index
				};
			self.disableButtons.call(self);
			pjQ.$.get([this.opts.folder, "index.php?controller=pjFront&action=pjActionRemoveTable", "&session_id=", self.opts.session_id].join(""), qs).done(function (data) {
				
				pjQ.$('#rbSearchForm_' + self.opts.index).find("input[name='first_load']").val(0);
				self.loadSearch();
			});
		},
		loadCheckout: function () {
			var self = this,
				index = this.opts.index;
			var qs = {
					"locale": this.opts.locale,
					"hide": this.opts.hide,
					"index": this.opts.index
				};
			pjQ.$.get([this.opts.folder, "index.php?controller=pjFront&action=pjActionCheckout", "&session_id=", self.opts.session_id].join(""), qs).done(function (data) {
				self.$container.html(data);
				pjQ.$('.modal-dialog').css("z-index", "9999");
				self.bindCheckout();
			});
		},
		bindCheckout: function()
		{
			var self = this,
				index = this.opts.index;
			
			var $frmCheckout = pjQ.$('#rbCheckoutForm_' + self.opts.index);
			var $reCaptcha = self.$container.find('#g-recaptcha_' + index);
			if ($reCaptcha.length > 0)
            {
				
                grecaptcha.render($reCaptcha.attr('id'), {
                    sitekey: $reCaptcha.data('sitekey'),
                    callback: function(response) {
                        var elem = pjQ.$("input[name='recaptcha']");
                        elem.val(response);
                        elem.valid();
                    }
                });
            }
			$frmCheckout.validate({
                rules: {
                    "captcha": {
                        remote: self.opts.folder + "index.php?controller=pjFront&action=pjActionCheckCaptcha&session_id=" + self.opts.session_id
                    },
                    "recaptcha": {
                        remote: self.opts.folder + "index.php?controller=pjFront&action=pjActionCheckReCaptcha&session_id=" + self.opts.session_id
                    },
                    "agreement": {
						required: true
					}
                },
				messages: {
					"c_title": {
						required: self.opts.validation.required_field
					},
					"c_fname": {
						required: self.opts.validation.required_field
					},
					"c_lname": {
						required: self.opts.validation.required_field
					},
					"c_phone": {
						required: self.opts.validation.required_field
					},
					"c_email": {
						required: self.opts.validation.required_field,
						email: self.opts.validation.invalid_email
					},
					"c_company": {
						required: self.opts.validation.required_field
					},
					"c_notes": {
						required: self.opts.validation.required_field
					},
					"c_address": {
						required: self.opts.validation.required_field
					},
					"c_city": {
						required: self.opts.validation.required_field
					},
					"c_state": {
						required: self.opts.validation.required_field
					},
					"c_zip": {
						required: self.opts.validation.required_field
					},
					"c_country": {
						required: self.opts.validation.required_field
					},
					"cc_type": {
						required: self.opts.validation.required_field
					},
					"cc_num": {
						required: self.opts.validation.required_field
					},
					"cc_exp_month": {
						required: self.opts.validation.exp_month
					},
					"cc_exp_year": {
						required: self.opts.validation.exp_year
					},
					"captcha": {
						required: self.opts.validation.required_field,
						remote: self.opts.validation.incorrect_captcha
					},
                    "recaptcha": {
						required: self.opts.validation.required_field,
						remote: self.opts.validation.incorrect_captcha
					},
					"agreement": {
						required: self.opts.validation.required_field
					}
				},
                ignore: ":hidden:not(.recaptcha)",
				onkeyup: false,
				errorElement: 'li',
				errorPlacement: function (error, element) {
					if(element.attr('name') == 'captcha')
					{
						error.appendTo(element.parent().next().find('ul'));
					}else if(element.attr('name') == 'agreement'){
						error.appendTo(element.parent().parent().next().find('ul'));
					}else{
						error.appendTo(element.next().find('ul'));
					}
				},
	            highlight: function(ele, errorClass, validClass) {
	            	var element = pjQ.$(ele);
	            	if(element.attr('name') == 'captcha')
					{
						element.parent().parent().addClass('has-error');
					}else if(element.attr('name') == 'agreement'){
						element.parent().parent().parent().addClass('has-error');
					}else{
						element.parent().addClass('has-error');
					}
	            },
	            unhighlight: function(ele, errorClass, validClass) {
	            	var element = pjQ.$(ele);
	            	if(element.attr('name') == 'captcha')
					{
						element.parent().parent().removeClass('has-error').addClass('has-success');
					}else if(element.attr('name') == 'agreement'){
						element.parent().parent().parent().removeClass('has-error').addClass('has-success');
					}else{
						element.parent().removeClass('has-error').addClass('has-success');
					}
	            },
				submitHandler: function(form){
					self.disableButtons.call(self);
					pjQ.$.post([self.opts.folder, "index.php?controller=pjFront&action=pjActionSaveForm", "&session_id=", self.opts.session_id].join(""), $frmCheckout.serialize()).done(function (data) {
						if (data && data.status && data.status === "OK") {
							hashBang("#!/Preview");
						} else {
							self.enableButtons.call(self);	
						}
					}).fail(function () {
						self.enableButtons.call(self);
					});
					return false;
			    }
			});
		},
		addPromo: function (frm) {
			var self = this,
				index = this.opts.index,
				code = frm.promo_code.value,
				url = [self.opts.folder, "index.php?controller=pjFront&action=pjActionAddPromo", "&session_id=", self.opts.session_id, "&code=", code].join("");
			
			self.disableButtons();
			pjQ.$.get(url).done(function (data) {
				if (!data.code) {
					return;
				}
				var pc = pjQ.$('#rbPromoCode_' + index),
					pd = pjQ.$('#rbPromoDiscount_' + index),
					star = pjQ.$('#rbVoucherStar_' + index),
					cf = pjQ.$('#rbCodeField_' + index),
					pi = pjQ.$('#rbPromoInvalid_' + index),
					pa = pjQ.$('#rbPriceAfterPromo_' + index);
				switch (parseInt(data.code, 10)) {
					case 200:
						pi.html("");
						pi.parent().parent().css('display', 'none');
						
						pc.html(code);
						pc.css('display', '');
						pd.html(data.discount_text);
						pd.parent().parent().parent().css('display', '');
						pa.html(data.price_after_formatted);
						pa.parent().parent().parent().css('display', '');
						frm.promo_code.value = "";
						if(self.opts.include_voucher == '3'){
							star.html('');
							cf.removeClass('required');
						}
						if(parseFloat(data.price_after_discount) <= 0)
						{
							pjQ.$('#pjRbPaymentWrapper_' + index).css('display', 'none');
						}
						break;
					case 100:
						pc.html("");
						pc.css('display', 'none');
						pd.html("");
						pd.parent().parent().parent().css('display', 'none');
						pa.html("");
						pa.parent().parent().parent().css('display', 'none');
						
						pi.html(self.opts.invalid_voucher);
						pi.parent().parent().css('display', '');
						break;
					case 101:
						pc.html("");
						pc.css('display', 'none');
						pd.html("");
						pd.parent().parent().parent().css('display', 'none');
						pa.html("");
						pa.parent().parent().parent().css('display', 'none');
						
						pi.html(self.opts.out_of_range_voucher);
						pi.parent().parent().css('display', '');
						break;
				}
				self.enableButtons();
			});
			return self;
		},
		removePromo: function (frm) {
			var self = this,
				index = this.opts.index,
				code = frm.promo_code.value,
				url = [self.opts.folder, "index.php?controller=pjFront&action=pjActionRemovePromo", "&session_id=", this.opts.session_id].join("");
			pjQ.$.get(url).done(function (data) {
				if (!data.code) {
					return;
				}
				switch (parseInt(data.code, 10)) {
					case 200:
						var pc = pjQ.$('#rbPromoCode_' + index),
							star = pjQ.$('#rbVoucherStar_' + index),
							cf = pjQ.$('#rbCodeField_' + index),
							pa = pjQ.$('#rbPriceAfterPromo_' + index);
						
						pc.html('');
						pc.parent().parent().parent().css('display', 'none');
						pa.html("");
						pa.parent().parent().parent().css('display', 'none');
						if(self.opts.include_voucher == '3'){
							star.html('*');
							cf.addClass('required');
						}
						if(parseFloat(data.price) > 0)
						{
							pjQ.$('#pjRbPaymentWrapper_' + index).css('display', '');
						}
						break;
				}
			});
			return self;
		},
		loadPreview: function () {
			var self = this,
				index = this.opts.index;
			var qs = {
					"locale": this.opts.locale,
					"hide": this.opts.hide,
					"index": this.opts.index
				};
			pjQ.$.get([this.opts.folder, "index.php?controller=pjFront&action=pjActionPreview", "&session_id=", self.opts.session_id].join(""), qs).done(function (data) {
				self.$container.html(data);
			});
		},
		getPaymentForm: function(obj){
			var self = this,
				index = this.opts.index;
			var qs = {
					"locale": this.opts.locale,
					"hide": this.opts.hide,
					"index": this.opts.index,
					"booking_id": obj.booking_id, 
				    "payment_method": obj.payment
				};
			pjQ.$.get([this.opts.folder, "index.php?controller=pjFront&action=pjActionGetPaymentForm", "&session_id=", self.opts.session_id].join(""), qs).done(function (data) {
				self.$container.html(data);

				var $payment_form = self.$container.find("form[name='pjOnlinePaymentForm']").first();
				if ($payment_form.length > 0) {
					$payment_form.trigger('submit');
				}
			}).fail(function () {
				log("Deferred is rejected");
			});
		},
		enableSearchForm:function(){
			var self = this;
			pjQ.$('.rbSelectorDatepick').removeAttr('disabled');
			pjQ.$('.rbPeople').removeAttr('disabled');
		},
		disabledSearchForm:function(){
			var self = this;
			pjQ.$('.rbSelectorDatepick').prop( "disabled", true );
			pjQ.$('.rbPeople').prop( "disabled", true );
		},
		formChange: function(){
			var self = this;
			
			pjQ.$('.rbSelectorButton').css('display', 'none');
			pjQ.$('#rbCheckAvail_' + self.opts.index).css('display', 'block');
			pjQ.$('#rbPromptBooking_' + self.opts.index).parent().css('display', 'none');
			
			pjQ.$('#rbMapContainer_' + self.opts.index).find(".pjRbTableHotspot").each(function (i, el) {
				pjQ.$(el).removeClass('pjRbHotSpotAvailable');
				pjQ.$(el).removeClass('pjRbTableHotspotChosen').addClass('pjRbTableHotspotDisabled');
			});
		}
	};
	
	// expose
	window.RestaurantBooking = RestaurantBooking;
})(window);
