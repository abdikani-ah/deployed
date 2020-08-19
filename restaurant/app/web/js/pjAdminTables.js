var jQuery_1_8_2 = jQuery_1_8_2 || jQuery.noConflict();
(function ($, undefined) {
	$(function () {
		"use strict";
		var $frmCreateTable = $("#frmCreateTable"),
			$frmUpdateTable = $("#frmUpdateTable"),
            $document = $(document),
			datagrid = ($.fn.datagrid !== undefined);

		if($(".field-int").length > 0)
        {
            $(".field-int").TouchSpin({
                verticalbuttons: true,
                buttondown_class: 'btn btn-white',
                buttonup_class: 'btn btn-white',
                min: 1,
                max: 65535,
                step: 1
            });
        }

		$.validator.addMethod('validateMinimum', function (value) {
            var capacity = parseInt($('#seats').val(), 10) || 0,
                minimum = parseInt(value, 10) || 0;
            return capacity >= minimum;
        }, 'Error');
		
		if ($frmCreateTable.length > 0) {
			$frmCreateTable.validate({
				rules: {
					"name": {
						remote: "index.php?controller=pjAdminTables&action=pjActionCheckName"
					},
					"minimum": {
						validateMinimum: true
					}
				},
				onkeyup: false
			});
		}
		
		if ($frmUpdateTable.length > 0) {
			$frmUpdateTable.validate({
				rules: {
					"name": {
						remote: "index.php?controller=pjAdminTables&action=pjActionCheckName&id=" + $frmUpdateTable.find("input[name='id']").val()
					},
					"minimum": {
						validateMinimum: true
					}
				},
				onkeyup: false
			});
		}
		
		if ($("#grid").length > 0 && datagrid) {
			
			var buttons = [{type: "edit", url: "index.php?controller=pjAdminTables&action=pjActionUpdate&id={:id}"},
		          {type: "delete", url: "index.php?controller=pjAdminTables&action=pjActionDeleteTable&id={:id}"}];
			
			if (!pjGrid.has_update) {
				buttons.splice(0, 1);
			}
			
			var $grid = $("#grid").datagrid({
				buttons: buttons,
				columns: [{text: myLabel.name, type: "text", sortable: true, editable: true},
				          {text: myLabel.capacity, type: "text", sortable: true, editable: true},
				          {text: myLabel.mininum, type: "text", sortable: true, editable: true}],
				dataUrl: "index.php?controller=pjAdminTables&action=pjActionGetTable",
				dataType: "json",
				fields: ['name', 'seats', 'minimum'],
				paginator: {
					actions: [
					   {text: myLabel.delete_selected, url: "index.php?controller=pjAdminTables&action=pjActionDeleteTableBulk", render: true, confirmation: myLabel.delete_confirmation}
					],
					gotoPage: true,
					paginate: true,
					total: true,
					rowCount: true
				},
				saveUrl: "index.php?controller=pjAdminTables&action=pjActionSaveTable&id={:id}",
				select: {
					field: "id",
					name: "record[]"
				}
			});
		}
		
	});
})(jQuery_1_8_2);