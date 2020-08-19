var jQuery_1_8_2 = jQuery_1_8_2 || jQuery.noConflict();
(function ($, undefined) {
	$(function () {
		"use strict";
		var $frmTimeCustom = $("#frmTimeCustom"),
			$frmDefaultTime = $("#frmDefaultTime"),
			datagrid = ($.fn.datagrid !== undefined);

		function compareTime(start_hour, start_min, end_hour, end_min) {
			if (end_hour < start_hour) {
				return false;
			}
			
			if (end_hour == start_hour) {
				return end_min > start_min;
			}

			return true;
		}
		
		$.validator.addMethod('greaterThan', function (value, element) {
			
			var sh = "#start_hour",
				sm = "#start_minute",
				eh = "#end_hour",
				em = "#end_minute",
				sa = "#start_ampm",
				ea = "#end_ampm",
				element = element instanceof jQuery ? element : $(element),
				match = element.attr("id").match(/^(\w+)_hour_to$/);
			
			if (match !== null) {
				sh = "#" + match[1] + "_hour_from";
				sm = "#" + match[1] + "_minute_from";
				eh = "#" + match[1] + "_hour_to";
				em = "#" + match[1] + "_minute_to";
				sa = "#" + match[1] + "_ampm_from";
				ea = "#" + match[1] + "_ampm_to";
			}
			
			var start_hour = parseInt($(sh).val(), 10),
			    start_min = parseInt($(sm).val(), 10),
			    end_hour = parseInt($(eh).val(), 10),
			    end_min = parseInt($(em).val(), 10),
			    $start_ampm = $(sa),
			    $end_ampm = $(ea);

			if (!($start_ampm.length && $end_ampm.length)) {
				
				return compareTime(start_hour, start_min, end_hour, end_min);
				
			} else {
				var s = $start_ampm.find("option:selected").val().toUpperCase(),
					e = $end_ampm.find("option:selected").val().toUpperCase();
				
				if (s === e) { 
					// AM === AM or PM === PM
					if ((start_hour === 12 && end_hour !== 12) || (start_hour !== 12 && end_hour === 12)) {
						return !compareTime(start_hour, start_min, end_hour, end_min);
					}
					
					return compareTime(start_hour, start_min, end_hour, end_min);
				}
				
				if (s === "AM") {
					// e === PM
					return true;
				}
				
				// s === PM, e === AM
				return false;
			}
		}, 'End Time cannot precede Start Time.');
		
		if ($frmDefaultTime.length > 0) {
			$frmDefaultTime.validate({
				ignore: "",
				errorPlacement: function (error, element) {
					error.insertAfter(element.closest(".input-group"));
				},
				highlight: function(element) {
					$(element).closest('.input-group').parent().addClass('has-error');
				},
				unhighlight: function(element) {
					$(element).closest('.input-group').parent().removeClass('has-error');
				}
			});
		}
		
		if ($frmTimeCustom.length > 0) {
			$frmTimeCustom.validate({
				ignore: "",
				errorPlacement: function (error, element) {
					error.insertAfter(element.closest(".input-group"));
				}
			});
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
            $frmTimeCustom.find('.date').datepicker({
            	startDate: '0d'
            });
		}
		
		if ($("#grid").length > 0 && datagrid) {
			var $grid = $("#grid").datagrid({
				buttons: [{type: "edit", url: "index.php?controller=pjAdminTime&action=pjActionUpdate&id={:id}"},
				          {type: "delete", url: "index.php?controller=pjAdminTime&action=pjActionDeleteDate&id={:id}"}
				          ],
				columns: [{text: myLabel.date, type: "date", sortable: true, editable: false, renderer: $.datagrid._formatDate, dateFormat: pjGrid.jsDateFormat},
				          {text: myLabel.start_time, type: "text", sortable: true, editable: false},
				          {text: myLabel.end_time, type: "date", sortable: true, editable: false},
				          {text: myLabel.is_day_off, type: "text", sortable: true, editable: false}],
				dataUrl: "index.php?controller=pjAdminTime&action=pjActionGetDate",
				dataType: "json",
				fields: ['date', 'start_time', 'end_time', 'is_dayoff'],
				paginator: {
					actions: [
							   {text: myLabel.delete_selected, url: "index.php?controller=pjAdminTime&action=pjActionDeleteDateBulk", render: true, confirmation: myLabel.delete_confirmation}
							],
					gotoPage: true,
					paginate: true,
					total: true,
					rowCount: true
				},
				select: {
					field: "id",
					name: "record[]",
					cellClass: 'cell-width-2'
				}
			});
		}
		
		$(document).on("change", ".working-day", function (e) {
			$(this).closest("tr").find("select, input[type='text']").attr("disabled", $(this).is(":checked"));
		}).on("click", "#is_dayoff", function (e) {
			if($(this).is(":checked"))
			{
				$('#end_hour').removeClass('greaterThan');
				$('.customeTimeRow').hide();
			}else{
				$('#end_hour').addClass('greaterThan');
				$('.customeTimeRow').show();
			}
		});
	});
})(jQuery_1_8_2);