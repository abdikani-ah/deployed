var jQuery_1_8_2 = jQuery_1_8_2 || jQuery.noConflict();
(function ($, undefined) {
	$(function () {
		"use strict";
		var $frmUpdateMap = $("#frmUpdateMap"),
		    $frmUpdateSeat = $("#frmUpdateSeat"),
            $modalUpdateMap = $("#modalUpdateMap"),
			$boxMap = $("#boxMap");

		$.validator.addMethod('validateMinimum', function (value) {
            var capacity = parseInt($('#seat_seats').val(), 10) || 0,
                minimum = parseInt(value, 10) || 0;
            return capacity >= minimum;
        }, 'Error');

		function collisionDetect(o) {
			var i, pos, horizontalMatch, verticalMatch, collision = false;
			$("#mapHolder").children("span").each(function (i) {
				pos = getPositions(this);
				horizontalMatch = comparePositions([o.left, o.left + o.width], pos[0]);
				verticalMatch = comparePositions([o.top, o.top + o.height], pos[1]);			
				if (horizontalMatch && verticalMatch) {
					collision = true;
					return false;
				}
			});
			if (collision) {
				return true;
			}
			return false;
		}

		function getPositions(box) {
			var $box = $(box);
			var pos = $box.position();
			var width = $box.width();
			var height = $box.height();
			return [[pos.left, pos.left + width], [pos.top, pos.top + height]];
		}
		
		function comparePositions(p1, p2) {
			var x1 = p1[0] < p2[0] ? p1 : p2;
			var x2 = p1[0] < p2[0] ? p2 : p1;
			return x1[1] > x2[0] || x1[0] === x2[0] ? true : false;
		}
		
		function updateElem(event, ui) {
			var $this = $(this),
				rel = $this.attr("rel"),
				$hidden = $("#" + rel),
				val = $hidden.val().split("|");				
			$hidden.val([val[0], parseInt($this.width(), 10), parseInt($this.height(), 10), ui.position.left, ui.position.top, $this.text(), val[6], val[7]].join("|"));
		}

		function getMax() {
			var index = 0;
			index = $("span.empty").length;
			return index;
		}
		
		function isDuplicate(name) {
			var result = false;
			
			$(".rbInnerRect").each(function () {
				if ($(this).text() === name.toString()) {
					result = true;
				}
			});
			
			return result;
		}
		
		function getName(name) {
			
			if (!isDuplicate(name)) {
				return name;
			}
			
			var i = 0,
				j = 0,
				newName = name,
				separators = ['', '.', ' ', ',', '#'],
				chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
			
			while (isDuplicate(newName)) {
				if (i > chars.length - 1) {
					i = 0;
					j += 1;
				}
				newName = name + separators[j] + chars.charAt(i);
				i += 1;
			}
			
			return newName;
		}
		
		if ($frmUpdateMap.length > 0) {
			$frmUpdateMap.validate();

			if($modalUpdateMap.length > 0)
            {
                $frmUpdateSeat.validate({
                    rules: {
                        "seat_name": {
                            remote: {
                                url: "index.php?controller=pjAdminMaps&action=pjActionCheckName",
                                data: {
                                    id: function () {
                                        return $frmUpdateSeat.find("input[name='seat_id']").val();
                                    }
                                }
                            }
                        },
                        "seat_minimum": {
                            validateMinimum: true
                        }
                    },
                    onkeyup: false,
                    submitHandler: function(e) {
                        var rel = $modalUpdateMap.data("rel"),
                            pName = $("#seat_name").val(),
                            pSeats = parseInt($("#seat_seats").val(), 10),
                            pMin = parseInt($("#seat_minimum").val(), 10),
                            pHidden = $("#" + rel, $frmUpdateMap).val();

                        $.post("index.php?controller=pjAdminMaps&action=pjActionSaveSeat", {
                            "map_id": $(":input[name='id']", $frmUpdateMap).val(),
                            "hidden": pHidden,
                            "name": pName,
                            "seats": pSeats,
                            "minimum": pMin
                        }).done(function (data) {
                            if (!(data && data.status)) {
                                swal("Error!", '', "error");
                                return;
                            }
                            switch (data.status) {
                                case "OK":
                                    var a = pHidden.split("|");
                                    var $rect_inner = $(".rbInnerRect[data-name='" + rel + "']", $frmUpdateMap);
                                    $rect_inner.text(pName);
                                    $("#rbInner_" + rel).text(pName);
                                    $("#" + rel).attr('name', 'seats[]');
                                    $("#" + rel).val([data.id, a[1], a[2], a[3], a[4], pName, pSeats, pMin].join("|"));
                                    $("input[name='m_name[" + data.id + "]']", $frmUpdateMap).val(pName);
                                    $("input[name='m_seats[" + data.id + "]']", $frmUpdateMap).val(pSeats);

                                    $modalUpdateMap.modal('hide');
                                    break;
                                case "ERR":
                                    $modalUpdateMap.modal('hide');
                                    swal("Error!", data.text, "error");
                                    break;
                            }
                        });
                    }
                });

                if($(".field-int", $frmUpdateSeat).length > 0)
                {
                    $(".field-int", $frmUpdateSeat).TouchSpin({
                        verticalbuttons: true,
                        buttondown_class: 'btn btn-white',
                        buttonup_class: 'btn btn-white',
                        min: 1,
                        max: 65535,
                        step: 1
                    });
                }
                
                $modalUpdateMap.on("show.bs.modal", function (e) {
                    var rel = $(this).data("rel"),
                        arr = $("#" + rel).val().split("|");
                    $("#seat_id").val(arr[0]);
                    $("#seat_name").val(arr[5]);
                    $("#seat_seats").val(arr[6]);
                    $("#seat_minimum").val(arr[7]);
                }).on("hidden.bs.modal", function (e) {
                    $frmUpdateSeat.data('validator').resetForm();
                    $frmUpdateSeat.find('.has-error').removeClass('has-error');
                }).on('click', '.btn-primary', function (e) {
                    $frmUpdateSeat.trigger('submit');
                }).on('click', '.btn-danger', function (e) {
                    var rel = $modalUpdateMap.data('rel');
                    $("#" + rel, $("#hiddenHolder")).remove();
                    $(".rect-selected[rel='"+ rel +"']", $("#mapHolder")).remove();

                    $modalUpdateMap.modal('hide');
                });
            }

			var $map = $("#map"),
				dragOpts = {
					containment: "parent",
					stop: function (event, ui) {
						updateElem.apply(this, [event, ui]);
					}
				};
			$("span.empty").draggable(dragOpts).resizable({
				resize: function(e, ui) {
					var height = $(this).height();
					$(this).css("line-height", height + "px"); 
		        },
				stop: function(e, ui) {
					var height = $(this).height();
					$(this).css("line-height", height + "px");
					updateElem.apply(this, [e, ui]);
		        }
			}).bind("click", function (e) {
			    $modalUpdateMap.data('rel', $(this).attr("rel")).modal('show');
				$(this).siblings(".rect").removeClass("rect-selected").end().addClass("rect-selected");
			});
			
			$(document).on("click", "#mapHolder.has_access_manage", function (e) {
				
				var $this = $(this),
					offset = $map.offset(),
					index = getMax(),
					t = Math.ceil(e.pageY - offset.top - 13),
					l = Math.ceil(e.pageX - offset.left),
					w = 30,
					h = 30,
					o = {top: t, left: l, width: w, height: h};
				
				if (!collisionDetect(o)) {
					index++;
					var name = getName(index);
					$("<span>", {
						css: {
							"top": t + "px",
							"left": l + "px",
							"width": w + "px",
							"height": h + "px",
							"line-height": h + "px",
							"position": "absolute"
						},
						html: '<span class="rbInnerRect" data-name="hidden_' + index + '">' + name + '</span>',
						rel: "hidden_" + index
					}).addClass("rect empty new").draggable(dragOpts).resizable({
						resize: function(e, ui) {
							var height = $(this).height();
							$(this).css("line-height", height + "px"); 
				        },
						stop: function(e, ui) {
							var height = $(this).height();
							$(this).css("line-height", height + "px"); 
							updateElem.apply(this, [e, ui]);
				        }
					}).bind("click", function (e) {
						$modalUpdateMap.data('rel', $(this).attr("rel")).modal('show');
						$(this).siblings(".rect").removeClass("rect-selected").end().addClass("rect-selected");
					}).appendTo($this);
					
					$("<input>", {
						type: "hidden",
						name: "seats_new[]",
						id: "hidden_" + index
					}).val(['x', w, h, l, t, name, '1', '1'].join("|")).appendTo($("#hiddenHolder"));
					
				} else {
					//if (window.console && window.console.log) {
						//console.log('Collision detected');
					//}
				}
			});
		}

		$(document).on('change', '#use_map', function (e) {
			
			var $this = $(this),
				isChecked = $this.is(':checked');
			
			$this.prop("disabled", true);
			
			$.post("index.php?controller=pjAdminMaps&action=pjActionToggle", {
				"use_map": (isChecked ? 1 : 0)
			}).done(function (data) {
				if (data && data.status && data.status === "OK") {
					if (isChecked) {
						$(".box-map-related").removeClass("hidden");
		                $('input[name="use_map"]').val(1);
		                $('#boxManageTables').slideUp('fast', function () {
		                    $boxMap.slideDown('slow');
		                });
		            } else {
		            	$(".box-map-related").addClass("hidden");
		                $('input[name="use_map"]').val(0);
		                $boxMap.slideUp('slow', function () {
		                    $('#boxManageTables').slideDown('fast');
		                });
		            }
					$this.prop("disabled", false);
				}
			}).fail(function () {
				$this.prop("disabled", true);
			});
		    
		}).on("click", "#btnDeleteMap", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}

			swal({
                title: myLabel.delete_map_title,
                text: myLabel.delete_map_text,
                type: "warning",
                showCancelButton: true,
                confirmButtonText: myLabel.btn_delete,
                cancelButtonText: myLabel.btn_cancel,
                closeOnConfirm: false,
                showLoaderOnConfirm: true
            }, function () {
                $.post("index.php?controller=pjAdminMaps&action=pjActionDeleteFile").done(function (data) {
                    if (!(data && data.status)) {
                        swal("Error!", '', "error");
                    }
                    switch (data.status) {
                        case "OK":
                            $('#btnDeleteMap').remove();
                            swal("Deleted!", data.text, "success");
                            
                            $.get("index.php?controller=pjAdminMaps&action=pjActionGetFileUpload").done(function (data) {
                        		$boxMap.html(data);
                        	});
                            break;
                        case "ERR":
                            swal("Error!", data.text, "error");
                            break;
                    }
                });
            });

			return false;
		});
	});
})(jQuery_1_8_2);