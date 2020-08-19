var jQuery_1_8_2 = jQuery_1_8_2 || jQuery.noConflict();
(function ($, undefined) {
	$(function () {
		"use strict";
		var $frmCreateBooking = $('#frmCreateBooking'),
			$frmUpdateBooking = $('#frmUpdateBooking'),
			$modalCancellation = $("#modalCancellation"),
			$modalConfirmation = $("#modalConfirmation"),
			datetimeOptions = null,
			datepicker = ($.fn.datepicker !== undefined),
			datagrid = ($.fn.datagrid !== undefined),
			select2 = ($.fn.select2 !== undefined),
            multilang = ($.fn.multilang !== undefined),
			keyPressTimeout;

		if (multilang && 'pjCmsLocale' in window) {
            $(".multilang").multilang({
                langs: pjCmsLocale.langs,
                flagPath: pjCmsLocale.flagPath,
                tooltip: "",
                select: function (event, ui) {
                    $("input[name='locale_id']").val(ui.index);
                }
            });
		}

		if($('.frm-filter-advanced .date').length > 0 && datepicker)
        {
            $('.frm-filter-advanced .date').datepicker();
        }
		$(".field-int").TouchSpin({
            verticalbuttons: true,
            buttondown_class: 'btn btn-white',
            buttonup_class: 'btn btn-white',
            min: 1,
            max: 4294967295
		});

		if ($(".select-countries").length > 0 && select2) {
            $(".select-countries").select2({
                placeholder: myLabel.select,
                allowClear: true
            });
        };

		function showSchedule()
		{
			var number_rows = $('.dTable tr').length - 1;
			for(var i = 0; i < number_rows; i ++)
			{
				var headCol_height = $('#dHeadCol_' + i).height();
				var max_height = headCol_height;
				$('#dHeadCol_' + i).each(function( index ) {
					var cell_height = $( this ).height();
					if(cell_height > max_height)
					{
						max_height = cell_height;
					}
				});
				$('#dHeadCol_' + i).height(max_height);
				$('.dSlot_' + i).height(max_height);
			}
		}
		function changeValidate()
		{
			 var rand = Math.ceil(Math.random() * 999999);
			 $("#validate_datetime").val(rand);
		}
		function validateTable()
		{
			var valid = false;
			$( ".rbTable" ).each(function(){
				if($(this).val() != '')
				{
					valid = true;
				}
			});
			if(valid == true)
			{
				var rand = Math.ceil(Math.random() * 999999);
				 $("#validate_table").val(rand).valid();
			}else{
				$("#validate_table").val("");
			}

			if($('tbody tr:not(.tblEmptyRow)', $("#tblBookingTables")).length == 0)
            {
                $(".tblEmptyRow", $("#tblBookingTables")).show();
            }
		}
		if($('.boxScheduleOuter').length > 0)
		{

			showSchedule();
		}
		
		if ($frmCreateBooking.length > 0 || $frmUpdateBooking.length > 0) {
		    var validatorOpts = {
				rules: {
					"uuid": {
						remote: "index.php?controller=pjAdminBookings&action=pjActionCheckUID"
					},
					"validate_datetime":{
						remote: {
							url: "index.php?controller=pjAdminBookings&action=pjActionCheckDate",
							type: "post",
							data: {
								date: function() {
									return $( "#date" ).val();
								},
								hour: function() {
									return $( "#hour" ).val();
								},
								minute: function() {
									return $( "#minute" ).val();
								},
								ampm: function() {
									if($( "#ampm" ).length > 0)
									{
										return $( "#ampm" ).val();
									}else{
										return '';
									}
								},
								date_to: function() {
									return $( "#date_to" ).val();
								},
								hour_to: function() {
									return $( "#hour_to" ).val();
								},
								minute_to: function() {
									return $( "#minute_to" ).val();
								},
								ampm_to: function() {
									if($( "#ampm_to" ).length > 0)
									{
										return $( "#ampm_to" ).val();
									}else{
										return '';
									}
								}
							}
						}
					}
				},
                ignore: "",
                invalidHandler: function (event, validator) {
				    if (validator.numberOfInvalids()) {
				    	var index = $(validator.errorList[0].element, this).closest(".tab-pane").index();
				    	if (index !== -1) {
				    	    $('.nav-tabs li:nth-child(' + (index + 1) + ') a').tab('show');
				    	}
				    }
				}
			};

		    if($frmCreateBooking.length > 0)
            {
                $frmCreateBooking.validate(validatorOpts);
            }else{
                validatorOpts.rules["uuid"].remote += "&id=" + $frmUpdateBooking.find("input[name='id']").val();
			    $frmUpdateBooking.validate(validatorOpts);
            }
		    
		    $(".decimal").keyup(function(){
				var $this = $(this);
				var value = $this.val();
				if(value.indexOf(".") >= 0)
				{
					var number = ($this.val().split('.'));
				    if (number[1].length > 2)
				    {
				        var salary = parseFloat($this.val());
				        $this.val( salary.toFixed(2));
				    }
				}
			   
			});
		}
		
		function getSchedule(dateText) {
			$.get("index.php?controller=pjAdminBookings&action=pjActionGetSchedule", {
				date: dateText
			}).done(function (data) {
				$("#boxSchedule").html(data);
				showSchedule();
			});
		}
		
		function getPaper(dateText) {
			$.get("index.php?controller=pjAdminBookings&action=pjActionGetPaper", {
				date: dateText
			}).done(function (data) {
				$("#boxPaper").html(data);
			});
		}
		function addPromo(frm)
		{
            $.post("index.php?controller=pjAdminBookings&action=pjActionAddPromo", frm.serialize()).done(function (data) {
                $('#total').val(data.total);
                if(data.discount != '')
                {
                    $('#discount_format').html(data.discount);
                    $('#discount_format').css('display', 'inline');
                }else{
                    $('#discount_format').html('');
                    $('#discount_format').css('display', 'none');
                }
            });
		}

		function formatStatus (str, obj) {
			switch (obj.status)
            {
                case 'confirmed':
                    return '<i class="fa fa-check"></i> ' + str;
                    break;
                case 'pending':
                    return '<i class="fa fa-exclamation-triangle"></i> ' + str;
                    break;
                case 'cancelled':
                    return '<i class="fa fa-times"></i> ' + str;
                    break;
                case 'enquiry':
                    return '<i class="fa fa-envelope-o"></i> ' + str;
                    break;
            }

			return str;
		}
		
		function formatName (str, obj) {
			return obj.full_name;
		} 

		if ($("#grid").length > 0 && datagrid) {
			var $grid = $("#grid").datagrid({
				buttons: [{type: "edit", url: "index.php?controller=pjAdminBookings&action=pjActionUpdate&id={:id}"},
				          {type: "delete", url: "index.php?controller=pjAdminBookings&action=pjActionDeleteBooking&id={:id}"}
						  ],
				columns: [
				          {text: myLabel.from_datetime, type: "text", sortable: true},
				          {text: myLabel.people, type: "text", sortable: true},
				          {text: myLabel.table, type: "text", sortable: true},
				          {text: myLabel.name, type: "text", sortable: true, renderer: formatName},
				          {text: myLabel.email, type: "text", sortable: true},
				          {text: myLabel.status, type: "select", sortable: true, editable: true, width: 120, renderer: formatStatus, options: [
				                                                                                     {label: myLabel.pending, value: "pending"}, 
				                                                                                     {label: myLabel.confirmed, value: "confirmed"},
				                                                                                     {label: myLabel.cancelled, value: "cancelled"},
				                                                                                     {label: myLabel.enquiry, value: "enquiry"}
				                                                                                     ], applyClass: "btn btn-xs no-margin bg"}],
				dataUrl: "index.php?controller=pjAdminBookings&action=pjActionGetBooking" + pjGrid.queryString,
				dataType: "json",
				fields: ['dt', 'people', 'table_name', 'c_fname', 'c_email', 'status'],
				paginator: {
					actions: [
					   {text: myLabel.delete_selected, url: "index.php?controller=pjAdminBookings&action=pjActionDeleteBookingBulk", render: true, confirmation: myLabel.delete_confirmation},
					   {text: myLabel.exported, url: "index.php?controller=pjAdminBookings&action=pjActionExportBooking", ajax: false}
					],
					gotoPage: true,
					paginate: true,
					total: true,
					rowCount: true
				},
				saveUrl: "index.php?controller=pjAdminBookings&action=pjActionSaveBooking&id={:id}",
				select: {
					field: "id",
					name: "record[]",
					cellClass: 'cell-width-2'
				}
			});
		}
		function DisableSpecificDates(date) 
		{
			var m = date.getMonth();
			var d = date.getDate();
			var y = date.getFullYear();
			var day = date.getDay();
			var currentdate = (m + 1) + '-' + d + '-' + y ;
			if ($.inArray(currentdate, disabledDates) != -1 ) {
				return false;
			}
			if ($.inArray(currentdate, enabledDates) != -1 ) {
				return true;
			}
			if ($.inArray(day, disabledWeekDays) != -1 ) {
				return false;
			}
			return true;
		}

		if(($('.date', $frmCreateBooking).length > 0 || $('.date', $frmUpdateBooking).length > 0 || $('#schedule_date').length > 0) && datepicker)
        {
            var $parent = null;
            if($frmCreateBooking.length > 0)
            {
                $parent = $frmCreateBooking;
            } else if($frmUpdateBooking.length > 0) {
                $parent = $frmUpdateBooking;
            } else if($('#schedule_date').length > 0) {
                $parent = $('#schedule_date').parent().parent();
            }

            var custom = {};
            var opt = {
                beforeShowDay: DisableSpecificDates
            };
            if ($frmCreateBooking.length > 0 || $('#boxSchedule').length > 0)
			{
				custom.startDate = '0d';
			}

            var $optionsEle = $('#dateTimePickerOptions');
            if($optionsEle.length > 0)
            {
	            $.fn.datepicker.dates['en'] = {
	        	    days: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
	        	    daysShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
	        	    daysMin: $optionsEle.data('days').split("_"),
	        	    months: $optionsEle.data('months').split("_"),
	        	    monthsShort: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
	        	    today: "Today",
	        	    clear: "Clear",
	        	    format: "mm/dd/yyyy",
	        	    titleFormat: "MM yyyy", 
	        	    weekStart: parseInt($optionsEle.data('wstart'), 10)
	        	};
            }
            
            $('.date', $parent).datepicker($.extend({}, opt, custom))
                .on('changeDate', function(e) {
                    var dateText = e.format();
                    var $this = $(this).find('input');

                    if($this.attr("id") == 'schedule_date'){
                        getSchedule(dateText);
                        var print_href = $this.attr('data-href');
                        print_href = print_href.replace("[DATE]", dateText);
                        $('.btnPrint').attr('href', print_href);
                    }
                    if($this.attr("id") == 'paper_date'){
                        getPaper(dateText);
                    }
                    if($this.attr("id") == 'date'){
                        if($frmUpdateBooking.length > 0 || $frmCreateBooking.length > 0)
                        {
                            addPromo($frmUpdateBooking);
                            changeValidate();
                        }
                        $('#tblBookingTables')
                            .find('tbody tr:not(.tblEmptyRow)').remove()
                            .end()
                            .find('.tblEmptyRow').show();
                        
                        $("#validate_table").val("");
                    }
                    if($this.attr("id") == 'date_to'){
                        if($frmUpdateBooking.length > 0 || $frmCreateBooking.length > 0)
                        {
                            changeValidate();
                        }
                        $('#tblBookingTables')
	                        .find('tbody tr:not(.tblEmptyRow)').remove()
	                        .end()
	                        .find('.tblEmptyRow').show();
                    
                        $("#validate_table").val("");
                    }
                });
        }

		$(document).on("click", ".pj-button-detailed", function (e) {
			e.stopPropagation();
			$(this).find('i').toggleClass('fa-caret-up').toggleClass('fa-caret-down');
			$(".pj-form-filter-advanced").toggle();
		}).on("submit", ".frm-filter-advanced", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			var obj = {},
				$this = $(this),
				arr = $this.serializeArray(),
				content = $grid.datagrid("option", "content"),
				cache = $grid.datagrid("option", "cache");
			for (var i = 0, iCnt = arr.length; i < iCnt; i++) {
				obj[arr[i].name] = arr[i].value;
			}
			$.extend(cache, obj);
			$grid.datagrid("option", "cache", cache);
			$grid.datagrid("load", "index.php?controller=pjAdminBookings&action=pjActionGetBooking", "created", "DESC", content.page, content.rowCount);
			return false;
		}).on("reset", ".frm-filter-advanced", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			$(".pj-button-detailed").trigger("click");
			
			$("#date_from").val('');
			$("#date_to").val('');
			$('#table_id').val('');
			$('#email').val('');
			$('#name').val('');
			$('#phone').val('');
		}).on("change", "#filter_status", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			var $this = $(this),
				content = $grid.datagrid("option", "content"),
				cache = $grid.datagrid("option", "cache"),
				obj = {};
			obj.status = $this.val();
			$.extend(cache, obj);
			$grid.datagrid("option", "cache", cache);
			$grid.datagrid("load", "index.php?controller=pjAdminBookings&action=pjActionGetBooking", "created", "DESC", content.page, content.rowCount);
			return false;
		}).on("submit", ".frm-filter", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			var $this = $(this),
				content = $grid.datagrid("option", "content"),
				cache = $grid.datagrid("option", "cache");
			$.extend(cache, {
				q: $this.find("input[name='q']").val(),
				date_from: "",
				date_to: "",
				table_id: "",
				name: "",
				phone: "",
				email: ""
			});
			$grid.datagrid("option", "cache", cache);
			$grid.datagrid("load", "index.php?controller=pjAdminBookings&action=pjActionGetBooking", "created", "DESC", content.page, content.rowCount);
			return false;
		}).on("change", "#status", function (e) {
			if ($(this).val() === 'enquiry')
            {
                $('#payment_method, #validate_table').removeClass('required');
            }
            else
            {
                $('#payment_method').toggleClass('required', isPaymentDisabled !== 'Yes');
                $('#validate_table').addClass('required');
            }
		}).on("change", "#payment_method", function (e) {
			switch ($("option:selected", this).val()) {
				case 'creditcard':
					$(".boxCC").show();
					break;
				default:
					$(".boxCC").hide();
			}
		}).on("click", ".btnRemoveTable", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			$(this).parent().parent().remove();
			validateTable();
			return false;
		}).on("click", ".btnAddTable", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			if($frmCreateBooking.length > 0 || $frmUpdateBooking.length > 0)
            {
                var $form = $frmCreateBooking.length > 0? $frmCreateBooking: $frmUpdateBooking;
                $.post("index.php?controller=pjAdminBookings&action=pjActionGetTables", $form.serialize()).done(function (data) {
					$(".tblEmptyRow", $("#tblBookingTables")).hide();
					$("tbody", $("#tblBookingTables")).append(data);
				});
            }
			return false;
		}).on("click", ".btnFilter", function (e) {
			var dateText = $(this).attr('rev'),
				print_href = $(this).attr('data-href');
			$('#schedule_date').parent('.date').datepicker('setDate', dateText);
			print_href = print_href.replace("[DATE]", dateText);
			$('.btnPrint').attr('href', print_href);
			getSchedule(dateText);
		}).on("keydown", "#code", function (e) {
			if($frmCreateBooking.length > 0)
			{
				clearTimeout(keyPressTimeout);
				keyPressTimeout = setTimeout( function() {
					addPromo($frmCreateBooking);
		        },500);
			}
			if($frmUpdateBooking.length > 0)
			{
				clearTimeout(keyPressTimeout);
				keyPressTimeout = setTimeout( function() {
					addPromo($frmUpdateBooking);
		        },500);
			}
		}).on("change", ".pj-booking-time", function (e) {
			if($frmCreateBooking.length > 0)
			{
				addPromo($frmCreateBooking);
			}
			if($frmUpdateBooking.length > 0)
			{
				addPromo($frmUpdateBooking);
			}
			var id = $(this).attr('id');
			if(id == 'hour' || id == 'minute' || id == 'ampm' || id == 'hour_to' || id == 'minute_to' || id == 'ampm_to') {
				$('#tblBookingTables').find('tbody').empty();
				$("#validate_table").val("");
			}
		}).on("change", "#hour, #minute, #ampm, #hour_to, #minute_to, #ampm_to", function (e) {
			changeValidate();
		}).on("change", ".rbTable", function (e) {
			changeValidate();
			validateTable();
		}).on("click", "#clientDetailsLink", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			$('a[href="#client-details"]').tab('show');
		}).on('focusin', function(e) {
		    // Workaround for TinyMCE bug (https://github.com/tinymce/tinymce/issues/782) that prevents inserting links and images if the editor is in a bootstrap modal.
            if ($(e.target).closest(".mce-window").length) {
                e.stopImmediatePropagation();
            }
        });

		if($('#tmp_table_id').length > 0 && $frmCreateBooking.length > 0)
		{
			var $tbody = $("tbody", $("#tblBookingTables"));
			$.post("index.php?controller=pjAdminBookings&action=pjActionGetTables", $frmCreateBooking.serialize()).done(function (data) {
				$tbody.append(data);
				var $firstRow = $tbody.find('tr:eq(1)');
				var $select = $firstRow.find('select:eq(0)');
				$select.val($('#tmp_table_id').val());
				var rand = Math.ceil(Math.random() * 999999);
				$("#validate_table").val(rand);
			});
			
		}

		function attachTinyMce(options) {
			if (window.tinyMCE !== undefined) {
				tinymce.EditorManager.editors = [];
				var defaults = {
                    relative_urls : false,
                    remove_script_host : false,
                    convert_urls : true,
                    selector: "textarea.mceEditor",
                    theme: "modern",
                    browser_spellcheck : true,
                    contextmenu: false,
                    height: 330,
                    plugins: [
                        "advlist autolink link image lists charmap print preview hr anchor pagebreak",
                        "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
                        "save table contextmenu directionality emoticons template paste textcolor"
                    ],
                    toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | print preview media fullpage | forecolor backcolor emoticons",
                    image_advtab: true,
                    menubar: "file edit insert view table tools",
                    setup: function (editor) {
                        editor.on('change', function (e) {
                            editor.editorManager.triggerSave();
                        });
                    }
                };

				var settings = $.extend({}, defaults, options);

				tinymce.init(settings);
			}
		}

		if ($modalConfirmation.length > 0) {
            $modalConfirmation.on("show.bs.modal", function(e) {
                var link = $(e.relatedTarget);

                $(this).find(".modal-body").load(link.attr("href"), function (e) {
                    var $frmConfirmation = $('form', $modalConfirmation);

                    if ($modalConfirmation.find('.multilang').length) {
                    	var locale = $frmConfirmation.data("locale"),
                    		$el = $modalConfirmation.find('.pj-form-langbar-item[data-index="' + locale + '"]');
                    	if ($el.length) {
                    		$el.trigger('click');
                    	} else {
                    		$modalConfirmation.find('.pj-form-langbar-item[data-index]:first').trigger('click');                    		
                    	}
                    }
                    
                    $frmConfirmation.validate({
                        ignore: "",
                        submitHandler: function(e) {
                            $.post("index.php?controller=pjAdminBookings&action=pjActionConfirmation", $frmConfirmation.serialize()).done(function (resp) {
                                if (resp.code !== undefined && parseInt(resp.code, 10) === 200) {
                                    $modalConfirmation.modal('hide');
                                    swal("Success!", resp.text, "success");
                                } else {
                                    swal("Error!", resp.text, "error");
                                }
                            });
                        }
                    });

                    attachTinyMce.call(null);
                });
            }).on('click', '.btn-primary', function (e) {
                $modalConfirmation.find('form').trigger('submit');
            });
		}

		if ($modalCancellation.length > 0) {
            $modalCancellation.on("show.bs.modal", function(e) {
                var link = $(e.relatedTarget);

                $(this).find(".modal-body").load(link.attr("href"), function (e) {
                    var $frmCancellation = $('form', $modalCancellation);

                    if ($modalCancellation.find('.multilang').length) {
                    	var locale = $frmCancellation.data("locale"),
                    		$el = $modalCancellation.find('.pj-form-langbar-item[data-index="' + locale + '"]');
                    	if ($el.length) {
                    		$el.trigger('click');
                    	} else {
                    		$modalCancellation.find('.pj-form-langbar-item[data-index]:first').trigger('click');                    		
                    	}
                    }
                    
                    $frmCancellation.validate({
                        ignore: "",
                        submitHandler: function(e) {
                            $.post("index.php?controller=pjAdminBookings&action=pjActionCancellation", $frmCancellation.serialize()).done(function (resp) {
                                if (resp.code !== undefined && parseInt(resp.code, 10) === 200) {
                                    $modalCancellation.modal('hide');
                                    swal("Success!", resp.text, "success");
                                } else {
                                    swal("Error!", resp.text, "error");
                                }
                            });
                        }
                    });

                    attachTinyMce.call(null);
                });
            }).on('click', '.btn-primary', function (e) {
                $modalCancellation.find('form').trigger('submit');
            });
		}
	});
})(jQuery_1_8_2);