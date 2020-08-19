<table class="table" cellpadding="0" cellspacing="0">
	<tbody>
		<tr>
			<td><?php __('lblReservationID'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['uuid']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblFromDateTime'); ?></td>
			<td><?php echo date($tpl['option_arr']['o_date_format'], strtotime($tpl['arr']['dt'])) . ', ' . date($tpl['option_arr']['o_time_format'], strtotime($tpl['arr']['dt'])); ?></td>
		</tr>
		<tr>
			<td><?php __('lblPeople'); ?></td>
			<td><?php echo (int) $tpl['arr']['people']; ?></td>
		</tr>
		<?php
		foreach ($tpl['table_arr'] as $k => $v)
		{
			if (!array_key_exists($v['id'], $tpl['bt_arr']))
			{
				continue;
			}
			?>
			<tr>
				<td><?php __('lblTable'); ?></td>
				<td><?php echo pjSanitize::html($v['name']); ?></td>
			</tr>
			<?php
		}
		?>
		<tr>
			<td><?php __('lblPaymentMethod');?></td>
			<td><?php $payment_methods = __('payment_methods', true, false); echo @$payment_methods[$tpl['arr']['payment_method']]; ?></td>
		</tr>
		<tr>
			<td><?php __('lblDepositPaid'); ?></td>
			<td><?php $is_paids = __('plugin_base_yesno', true, false); echo @$is_paids[$tpl['arr']['is_paid']]; ?></td>
		</tr>
		<tr style="display: <?php echo $tpl['arr']['payment_method'] != 'creditcard' ? 'none' : 'block'; ?>">
			<td><?php __('lblCCType'); ?></td>
			<td><?php $cc_types = __('cc_types', true, false); echo @$cc_types[$tpl['arr']['cc_type']]; ?></td>
		</tr>
		<tr style="display: <?php echo $tpl['arr']['payment_method'] != 'creditcard' ? 'none' : 'block'; ?>">
			<td><?php __('lblCCNum'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['cc_num']); ?></td>
		</tr>
		<tr style="display: <?php echo $tpl['arr']['payment_method'] != 'creditcard' ? 'none' : 'block'; ?>">
			<td><?php __('lblCCExp'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['cc_exp']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblDepositFee'); ?></td>
			<td><?php echo pjCurrency::formatPrice($tpl['arr']['total']) ?></td>
		</tr>
		
		<tr>
			<td><?php __('plugin_vouchers_voucher_code'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['code']); ?></td>
		</tr>
		<?php
		if(!empty($tpl['discount']))
		{ 
			?>
			<tr>
				<td><?php __('plugin_vouchers_discount'); ?></td>
				<td><?php echo pjSanitize::html($tpl['discount']); ?></td>
			</tr>
			<?php
		} 
		?>
		<tr>
			<td><?php __('plugin_base_status'); ?></td>
			<td><?php $b_statuses = __('booking_statuses', true, false); echo @$b_statuses[$tpl['arr']['status']]; ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingTitle'); ?></td>
			<td><?php $name_titles = __('name_titles', true, false); echo @$name_titles[$tpl['arr']['c_title']]; ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingFname'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['c_fname']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingLname'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['c_lname']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingPhone'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['c_phone']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingEmail'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['c_email']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingCompany'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['c_company']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingAddress'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['c_address']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingCity'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['c_city']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingState'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['c_state']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingZip'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['c_zip']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingCountry'); ?></td>
			<td><?php echo pjSanitize::html($tpl['arr']['country_title']); ?></td>
		</tr>
		<tr>
			<td><?php __('lblBookingCreated'); ?></td>
			<td><?php echo date($tpl['option_arr']['o_date_format'], strtotime($tpl['arr']['created'])) . ', ' . date($tpl['option_arr']['o_time_format'], strtotime($tpl['arr']['created'])); ?></td>
		</tr>
		<?php
		if(!empty($tpl['arr']['txn_id']))
		{ 
			?>
			<tr>
				<td><?php __('lblBookingTxnID'); ?></td>
				<td><?php echo pjSanitize::html($tpl['arr']['txn_id']); ?></td>
			</tr>
			<?php
		} 
		?>
        <?php
		if(!empty($tpl['arr']['processed_on']))
		{
			?>
			<tr>
				<td><?php __('lblBookingProcessedOn'); ?></td>
				<td><?php echo !empty($tpl['arr']['processed_on']) ? date($tpl['option_arr']['o_date_format'], strtotime($tpl['arr']['processed_on'])) . ', ' . date($tpl['option_arr']['o_time_format'], strtotime($tpl['arr']['processed_on'])) : NULL; ?></td>
			</tr>
			<?php
		}
		?>
	</tbody>
</table>