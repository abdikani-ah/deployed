<?php
$booking_statuses = __('booking_statuses', true);
$today = date($tpl['option_arr']['o_date_format']);
?>

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-lg-4 col-sm-6">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <span class="label label-primary pull-right"><?php __('lblToday') ?></span>

                    <h5><?php __('menuBookings') ?></h5>
                </div>

                <div class="ibox-content">
                    <div class="row m-t-md m-b-sm">
                        <div class="col-xs-6">
                            <p class="h1 no-margins"><a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionIndex&amp;date_from=<?php echo $today ?>&amp;date_to=<?php echo $today ?>&amp;status=confirmed"><?php echo $tpl['today_reservations'] ?></a></p>
                            <small class="text-info"><?php __('dashboard_total_reservations') ?></small>
                        </div><!-- /.col-xs-6 -->

                        <div class="col-xs-6">
                            <p class="h1 no-margins"><a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionIndex&amp;today=1&amp;status=confirmed"><?php echo $tpl['today_new_reservations'] ?></a></p>
                            <small class="text-info"><?php __('dashboard_new_reservations') ?></small>
                        </div><!-- /.col-xs-6 -->
                    </div><!-- /.row -->
                </div>
            </div>
        </div>

        <div class="col-lg-4 col-sm-6">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <span class="label label-primary pull-right"><?php __('lblToday') ?></span>

                    <h5><?php __('lblGuests') ?></h5>
                </div>

                <div class="ibox-content">
                    <div class="row m-t-md m-b-sm">
                        <div class="col-xs-6">
                            <p class="h1 no-margins"><a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionIndex&amp;date_from=<?php echo $today ?>&amp;date_to=<?php echo $today ?>&amp;status=confirmed"><?php echo $tpl['today_guests'] ?></a></p>
                            <small class="text-info"><?php __('dashboard_guests_coming') ?></small>
                        </div><!-- /.col-xs-6 -->

                        <div class="col-xs-6">
                            <p class="h1 no-margins"><a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionIndex&amp;date_from=<?php echo $today ?>&amp;date_to=<?php echo $today ?>&amp;status=confirmed"><?php echo $tpl['today_tables'] ?></a></p>
                            <small class="text-info"><?php __('dashboard_tables_booked') ?></small>
                        </div><!-- /.col-xs-6 -->
                    </div><!-- /.row -->
                </div>
            </div>
        </div>

        <div class="col-lg-4 col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5><?php __('dashboard_next_days') ?></h5>
                </div>

                <div class="ibox-content">
                    <div class="row m-t-md m-b-sm">
                        <div class="col-sm-3 col-xs-6">
                            <p class="h1 no-margins"><a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionIndex&amp;next_week=1&amp;status=confirmed"><?php echo $tpl['next_week_reservations'] ?></a></p>
                            <small class="text-info"><?php __('dashboard_reservations') ?></small>
                        </div><!-- /.col-sm-3 -->

                        <div class="col-sm-3 col-xs-6">
                            <p class="h1 no-margins"><a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionIndex&amp;next_week=1&amp;status=confirmed"><?php echo $tpl['next_week_guests'] ?></a></p>
                            <small class="text-info"><?php __('dashboard_guests') ?></small>
                        </div><!-- /.col-sm-3 -->

                        <div class="col-sm-6 col-xs-12">
                            <p class="h1 no-margins"><a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionIndex&amp;next_week=1&amp;status=confirmed"><?php echo pjCurrency::formatPrice($tpl['next_week_total'], ' ', 3) ?></a></p>
                            <small class="text-info"><?php __('dashboard_deposit') ?></small>
                        </div><!-- /.col-sm-6 -->
                    </div><!-- /.row -->
                </div>
            </div>
        </div>
    </div><!-- /.row -->

    <div class="row">
        <div class="col-lg-4">
            <div class="ibox float-e-margins">
                <div class="ibox-content ibox-heading clearfix">
                    <div class="pull-left">
                        <h3><?php __('dashboard_latest_reservations') ?></h3>
                        <small><?php echo str_replace('{X}', $tpl['today_total_reservations'], __('dashboard_x_reservations_received', true)) ?></small>
                    </div><!-- /.pull-left -->

                    <div class="pull-right m-t-md">
                        <a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionSchedule" class="btn btn-primary btn-sm btn-outline m-n"><?php __('dashboard_view_schedule') ?></a>
                    </div><!-- /.pull-right -->
                </div>

                <div class="ibox-content inspinia-timeline">
                    <?php if ($tpl['latest_reservation_arr']): ?>
                        <?php foreach ($tpl['latest_reservation_arr'] as $reservation): ?>
                            <div class="timeline-item">
                                <div class="row">
                                    <div class="col-xs-3 date">
                                        <i class="fa fa-clock-o"></i>
                                        <?php echo date('jS, M', strtotime($reservation['dt'])) . ' ' . date($tpl['option_arr']['o_time_format'], strtotime($reservation['dt'])); ?>
                                        <div class="badge bg-<?php echo $reservation['status'] ?> b-r-sm pull-right m-t-md"><?php echo $booking_statuses[$reservation['status']] ?></div>
                                    </div>

                                    <div class="col-xs-8 content">
                                        <a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionUpdate&amp;id=<?php echo $reservation['id'] ?>">
                                            <p class="m-b-xs"><strong><?php echo pjSanitize::html($reservation['c_fname'] . ' ' . $reservation['c_lname']); ?></strong></p>
                                            <p class="m-n"><?php __('lblDateTimeFrom') ?>: <em><?php echo date($tpl['option_arr']['o_date_format'], strtotime($reservation['dt'])) . ', ' . date($tpl['option_arr']['o_time_format'], strtotime($reservation['dt'])); ?></em></p>
                                            <p class="m-n"><?php __('lblDateTimeTo') ?>: <em><?php echo date($tpl['option_arr']['o_date_format'], strtotime($reservation['dt_to'])) . ', ' . date($tpl['option_arr']['o_time_format'], strtotime($reservation['dt_to'])); ?></em></p>
                                            <p class="m-n"><?php __('lblPeople') ?>: <em><?php echo $reservation['people'] ?></em></p>
                                            <p class="m-n"><?php __('lblTableName') ?>: <em><?php echo $reservation['table_name'] ?></em></p>
                                            <p class="m-b-sm"><?php __('lblDepositFee') ?>: <em><?php echo pjCurrency::formatPrice($reservation['total']) ?></em></p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <?php __('lblNoBookings') ?>
                    <?php endif; ?>
                </div>
            </div>
        </div><!-- /.col-lg-4 -->

        <div class="col-lg-4">
            <div class="ibox float-e-margins">
                <div class="ibox-content ibox-heading clearfix">
                    <div class="pull-left">
                        <h3><?php __('dashboard_available_tables') ?></h3>
                        <small><?php echo str_replace('{X}', $tpl['total_appointments'], __('dashboard_x_appointments_made', true)) ?></small>
                    </div><!-- /.pull-left -->

                    <div class="pull-right m-t-md">
                        <a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionSchedule" class="btn btn-primary btn-sm btn-outline m-n"><?php __('dashboard_view_bookings') ?></a>
                    </div><!-- /.pull-right -->
                </div>

                <div class="ibox-content">
                    <div class="table-responsive table-responsive-secondary" style="max-height: 400px; overflow: auto;">
                        <table class="table table-striped table-hover no-margins">
                            <thead>
                                <tr>
                                    <th><?php __('lblTable') ?></th>
                                    <th><?php __('lblCapacity') ?></th>
                                    <th><?php __('dashboard_booked') ?></th>
                                    <th>&nbsp;</th>
                                </tr>
                            </thead>

                            <tbody>
                                <?php if ($tpl['table_arr']): ?>
                                    <?php foreach ($tpl['table_arr'] as $table): ?>
                                        <tr>
                                            <td><?php echo $table['name'] ?></td>
                                            <td><?php echo $table['seats'] ?></td>
                                            <td>
                                                <?php if($table['booking_hours']): ?>
                                                    <?php echo implode(', ', $table['booking_hours']) ?>
                                                <?php else: ?>
                                                    <?php __('dashboard_available') ?>
                                                <?php endif; ?>
                                            </td>
                                            <td><a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionCreate&amp;table_id=<?php echo $table['id'] ?>">+</a></td>
                                        </tr>
                                    <?php endforeach; ?>
                                <?php else: ?>
                                    <tr>
                                        <td colspan="2"><?php __('lblNoTable') ?></td>
                                    </tr>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div><!-- /.col-lg-8 -->

        <div class="col-lg-4">
            <div class="ibox float-e-margins">
                <div class="ibox-content ibox-heading clearfix">
                    <div class="pull-left">
                        <h3><?php __('dashboard_table_by_capacity') ?></h3>
                        <small><?php __('dashboard_reservations_by_guest_count') ?></small>
                    </div><!-- /.pull-left -->

                    <div class="pull-right m-t-md">
                        <a href="<?php echo $_SERVER['PHP_SELF'] ?>?controller=pjAdminBookings&amp;action=pjActionSchedule" class="btn btn-primary btn-sm btn-outline m-n"><?php __('dashboard_view_bookings') ?></a>
                    </div><!-- /.pull-right -->
                </div>

                <div class="ibox-content">
                    <div class="m-t-lg m-b-lg">
                        <br>

                        <div id="stocked"></div>
                    </div><!-- /.m-t-lg -->
                </div>
            </div>
        </div><!-- /.col-lg-8 -->
    </div><!-- /.row -->
</div><!-- /.wrapper wrapper-content -->

<?php $nearest_5 = $tpl['tables_by_capacity_arr'] ? 5 * ceil(max($tpl['tables_by_capacity_arr']) / 5): 5; ?>
<script type="text/javascript">
    var pjChart = {};
    pjChart.columns_labels = ['x'];
    pjChart.columns_data = [<?php x__encode('dashboard_booked'); ?>];
    pjChart.tooltips = [];

    pjChart.y_axis_max = <?php echo $nearest_5 ?>;
    pjChart.y_axis_values = [];
    for (var i = 1; i <= pjChart.y_axis_max; i++)
    {
        pjChart.y_axis_values.push(i);
    }

    <?php foreach ($tpl['tables_by_capacity_arr'] as $seats => $bookings): ?>
        pjChart.columns_labels.push('<?php echo str_replace('{X}', $seats, __('dashboard_x_guests', true)) ?>');
        pjChart.columns_data.push(<?php echo (int) $bookings ?>);
        pjChart.tooltips.push('<?php echo str_replace('{X}', $seats, __('dashboard_x_guests_tables', true)) ?>');
    <?php endforeach; ?>
</script>