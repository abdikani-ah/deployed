<?php
$controller_name = $controller->_get->toString('controller');
$action_name = $controller->_get->toString('action');

// Dashboard
$isScriptDashboard = in_array($controller_name, array('pjAdmin')) && in_array($action_name, array('pjActionIndex'));

// Reservations
$isScriptBookingsController = in_array($controller_name, array('pjAdminBookings'));

$isScriptScheduleIndex = $isScriptBookingsController && in_array($action_name, array('pjActionSchedule'));
$isScriptBookingsIndex = $isScriptBookingsController && in_array($action_name, array('pjActionIndex', 'pjActionCreate', 'pjActionUpdate'));

// Vouchers
$isScriptVouchersController = in_array($controller_name, array('pjVouchers'));

// Restaurant
$isScriptTimeController     = in_array($controller_name, array('pjAdminTime'));
$isScriptMapsController     = in_array($controller_name, array('pjAdminMaps'));
$isScriptTablesController   = in_array($controller_name, array('pjAdminTables'));

$isScriptTimeIndex      = $isScriptTimeController && in_array($action_name, array('pjActionIndex', 'pjActionCustom'));
$isScriptMapsIndex      = $isScriptMapsController && in_array($action_name, array('pjActionIndex'));
$isScriptTablesIndex    = $isScriptTablesController && in_array($action_name, array('pjActionIndex', 'pjActionUpdate'));

// Settings
$isScriptOptionsController = in_array($controller_name, array('pjAdminOptions')) && !in_array($action_name, array('pjActionPreview', 'pjActionInstall'));

$isScriptOptionsBooking         = $isScriptOptionsController && in_array($action_name, array('pjActionBooking'));
$isScriptOptionsPayments        = $isScriptOptionsController && in_array($action_name, array('pjActionPayments'));
$isScriptOptionsBookingForm     = $isScriptOptionsController && in_array($action_name, array('pjActionBookingForm'));
$isScriptOptionsTerm            = $isScriptOptionsController && in_array($action_name, array('pjActionTerm'));
$isScriptOptionsNotifications   = $isScriptOptionsController && in_array($action_name, array('pjActionNotifications'));
$isScriptOptionsReminder        = $isScriptOptionsController && in_array($action_name, array('pjActionReminder'));

// Permissions - Dashboard
$hasAccessScriptDashboard = pjAuth::factory('pjAdmin', 'pjActionIndex')->hasAccess();

// Permissions - Reservations
$hasAccessScriptBookings            = pjAuth::factory('pjAdminBookings')->hasAccess();
$hasAccessScriptBookingsSchedule    = pjAuth::factory('pjAdminBookings', 'pjActionSchedule')->hasAccess();
$hasAccessScriptBookingsIndex       = pjAuth::factory('pjAdminBookings', 'pjActionIndex')->hasAccess();

// Permissions - Restaurant
$hasAccessScriptTime        = pjAuth::factory('pjAdminTime')->hasAccess();
$hasAccessScriptDefaultTime = pjAuth::factory('pjAdminTime', 'pjActionIndex')->hasAccess();
$hasAccessScriptCustomTime  = pjAuth::factory('pjAdminTime', 'pjActionCustom')->hasAccess();
$hasAccessScriptSeatMap     = pjAuth::factory('pjAdminMaps', 'pjActionIndex')->hasAccess();
$hasAccessScriptTables      = pjAuth::factory('pjAdminTables')->hasAccess() && $tpl['option_arr']['o_use_map'] == 0;

// Permissions - Vouchers
$hasAccessScriptVouchers = pjAuth::factory('pjVouchers')->hasAccess();

// Permissions - Settings
$hasAccessScriptOptions                 = pjAuth::factory('pjAdminOptions')->hasAccess();
$hasAccessScriptOptionsBooking          = pjAuth::factory('pjAdminOptions', 'pjActionBooking')->hasAccess();
$hasAccessScriptOptionsPayments         = pjAuth::factory('pjAdminOptions', 'pjActionPayments')->hasAccess();
$hasAccessScriptOptionsBookingForm      = pjAuth::factory('pjAdminOptions', 'pjActionBookingForm')->hasAccess();
$hasAccessScriptOptionsTerm             = pjAuth::factory('pjAdminOptions', 'pjActionTerm')->hasAccess();
$hasAccessScriptOptionsNotifications    = pjAuth::factory('pjAdminOptions', 'pjActionNotifications')->hasAccess();
$hasAccessScriptOptionsReminder         = pjAuth::factory('pjAdminOptions', 'pjActionReminder')->hasAccess();
?>

<?php if ($hasAccessScriptDashboard): ?>
    <li<?php echo $isScriptDashboard ? ' class="active"' : NULL; ?>>
        <a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdmin&amp;action=pjActionIndex"><i class="fa fa-th-large"></i> <span class="nav-label"><?php __('plugin_base_menu_dashboard');?></span></a>
    </li>
<?php endif; ?>

<?php if ($hasAccessScriptBookings): ?>
    <li<?php echo $isScriptBookingsController ? ' class="active"' : NULL; ?>>
        <a href="#"><i class="fa fa-list"></i> <span class="nav-label"><?php __('menuBookings');?></span><span class="fa arrow"></span></a>
        <ul class="nav nav-second-level collapse">
            <?php if ($hasAccessScriptBookingsSchedule): ?>
                <li<?php echo $isScriptScheduleIndex ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionSchedule"><?php __('menuSchedule');?></a></li>
            <?php endif; ?>

            <?php if ($hasAccessScriptBookingsIndex): ?>
                <li<?php echo $isScriptBookingsIndex ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminBookings&amp;action=pjActionIndex"><?php __('menuBookingList');?></a></li>
            <?php endif; ?>
        </ul>
    </li>
<?php endif; ?>

<?php if ($hasAccessScriptTime || $hasAccessScriptDefaultTime || $hasAccessScriptCustomTime || $hasAccessScriptSeatMap || $hasAccessScriptTables): ?>
    <li<?php echo $isScriptTimeController || $isScriptMapsController || $isScriptTablesController ? ' class="active"' : NULL; ?>>
        <a href="#"><i class="fa fa-cutlery"></i> <span class="nav-label"><?php __('menuRestaurant');?></span><span class="fa arrow"></span></a>
        <ul class="nav nav-second-level collapse">
            <?php if ($hasAccessScriptDefaultTime): ?>
                <li<?php echo $isScriptTimeIndex ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminTime&amp;action=pjActionIndex"><?php __('menuWorkingTime');?></a></li>
            <?php elseif ($hasAccessScriptCustomTime) : ?>
            	<li<?php echo $isScriptTimeIndex ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminTime&amp;action=pjActionCustom"><?php __('menuWorkingTime');?></a></li>
            <?php endif; ?>

            <?php if ($hasAccessScriptSeatMap): ?>
                <li<?php echo $isScriptMapsIndex ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminMaps&amp;action=pjActionIndex"><?php __('menuSeatMap');?></a></li>
            <?php endif; ?>

            <?php if ($hasAccessScriptTables): ?>
                <li<?php echo $isScriptTablesIndex ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminTables&amp;action=pjActionIndex"><?php __('menuTables');?></a></li>
            <?php endif; ?>
        </ul>
    </li>
<?php endif; ?>

<?php if (pjObject::getPlugin('pjVouchers') !== NULL): ?>
    <?php if ($hasAccessScriptVouchers): ?>
        <li<?php echo $isScriptVouchersController ? ' class="active"' : NULL; ?>>
            <a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjVouchers&amp;action=pjActionIndex"><i class="fa fa-gift"></i> <span class="nav-label"><?php __('plugin_vouchers_menu_vouchers');?></span></a>
        </li>
    <?php endif; ?>
<?php endif; ?>

<?php if ($hasAccessScriptOptions): ?>
    <li<?php echo $isScriptOptionsController ? ' class="active"' : NULL; ?>>
        <a href="#"><i class="fa fa-cogs"></i> <span class="nav-label"><?php __('script_menu_settings');?></span><span class="fa arrow"></span></a>
        <ul class="nav nav-second-level collapse">
            <?php if ($hasAccessScriptOptionsBooking): ?>
                <li<?php echo $isScriptOptionsBooking ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminOptions&amp;action=pjActionBooking"><?php __('menuBooking');?></a></li>
            <?php endif; ?>

            <?php if ($hasAccessScriptOptionsPayments): ?>
                <li<?php echo $isScriptOptionsPayments ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminOptions&amp;action=pjActionPayments"><?php __('script_menu_payments');?></a></li>
            <?php endif; ?>

            <?php if ($hasAccessScriptOptionsBookingForm): ?>
                <li<?php echo $isScriptOptionsBookingForm ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminOptions&amp;action=pjActionBookingForm"><?php __('menuBookingForm');?></a></li>
            <?php endif; ?>

            <?php if ($hasAccessScriptOptionsTerm): ?>
                <li<?php echo $isScriptOptionsTerm ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminOptions&amp;action=pjActionTerm"><?php __('menuTerms');?></a></li>
            <?php endif; ?>

            <?php if ($hasAccessScriptOptionsNotifications): ?>
                <li<?php echo $isScriptOptionsNotifications ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminOptions&amp;action=pjActionNotifications"><?php __('script_menu_notifications');?></a></li>
            <?php endif; ?>

            <?php if ($hasAccessScriptOptionsReminder): ?>
                <li<?php echo $isScriptOptionsReminder ? ' class="active"' : NULL; ?>><a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminOptions&amp;action=pjActionReminder"><?php __('menuReminder');?></a></li>
            <?php endif; ?>
        </ul>
    </li>
<?php endif; ?>