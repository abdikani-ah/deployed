<!doctype html>
<html>
	<head>
		<title><?php __('front_label_cancel_note'); ?></title>
		<?php
		foreach ($controller->getCss() as $css)
		{
			echo '<link type="text/css" rel="stylesheet" href="'.(isset($css['remote']) && $css['remote'] ? NULL : PJ_INSTALL_URL).$css['path'].htmlspecialchars($css['file']).'" />';
		}
		?>
	</head>
	<body>
		<div style="margin: 0 auto; width: 450px">
		<?php
		$cancel_err = __('cancel_err', true, false);
		if (isset($tpl['status']))
		{
			switch ($tpl['status'])
			{
				case 1:
					?><p><?php echo $cancel_err[1]; ?></p><?php
					break;
				case 2:
					?><p><?php echo $cancel_err[2]; ?></p><?php
					break;
				case 3:
					?><p><?php echo $cancel_err[3]; ?></p><?php
					break;
				case 4:
					?><p><?php echo $cancel_err[4]; ?></p><?php
					break;
			}
		} else {

			if ($controller->_get->check('err'))
			{
				switch ($controller->_get->toInt('err'))
				{
					case 200:
						?><p><?php echo $cancel_err[200]; ?></p><?php
						break;
				}
			}

			if (isset($tpl['arr']))
			{
				$name_titles = __('name_titles', true, false);
				?>
				<table cellspacing="2" cellpadding="5" style="width: 100%">
					<thead>
						<tr>
							<th colspan="2" style="text-transform: uppercase; text-align: left"><?php __('front_label_cancel_heading'); ?></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><?php __('lblReservationID'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['uuid']); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_from'); ?></td>
							<td><?php echo date($tpl['option_arr']['o_date_format'], strtotime($tpl['arr']['dt'])) . ', ' . date($tpl['option_arr']['o_time_format'], strtotime($tpl['arr']['dt'])); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_people'); ?></td>
							<td><?php echo $tpl['arr']['people']; ?></td>
						</tr>

						<?php
						foreach ($tpl['arr']['table_arr'] as $k => $v)
						{
							?><tr><td><?php __('front_label_cancel_table'); ?> <?php echo $k + 1; ?></td><td><?php
							$cell = array();
							$cell[] = stripslashes($v['name']);
							echo join(" / ", $cell);
							?></td></tr><?php
						}
						?>
						<tr>
							<td><?php __('lblPaymentMethod');?></td>
							<td><?php echo $tpl['payment_titles'][$tpl['arr']['payment_method']]; ?></td>
						</tr>
						<tr style="display: <?php echo $tpl['arr']['payment_method'] != 'creditcard' ? 'none' : 'block'; ?>">
							<td><?php __('lblCCType'); ?></td>
							<td><?php $cc_types = __('cc_types', true, false); echo $cc_types[$tpl['arr']['cc_type']]; ?></td>
						</tr>
						<tr style="display: <?php echo $tpl['arr']['payment_method'] != 'creditcard' ? 'none' : 'block'; ?>">
							<td><?php __('lblCCNum'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['cc_num']); ?></td>
						</tr>
						<tr style="display: <?php echo $tpl['arr']['payment_method'] != 'creditcard' ? 'none' : 'block'; ?>">
							<td><?php __('lblCCExp'); ?></td>
							<td><?php echo $tpl['arr']['cc_exp']; ?></td>
						</tr>
						<tr>
							<td><?php __('lblDepositFee'); ?></td>
							<td><?php echo pjCurrency::formatPrice($tpl['arr']['total']); ?></td>
						</tr>

						<tr>
							<td><?php __('plugin_vouchers_voucher_code'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['code']); ?></td>
						</tr>
						<?php
						if(!empty($tpl['discount']))
						{
							?>
							<tr>
								<td><?php __('plugin_vouchers_discount'); ?></td>
								<td><?php echo stripslashes($tpl['discount']); ?></td>
							</tr>
							<?php
						}
						?>
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
								<td><?php echo stripslashes($tpl['arr']['txn_id']); ?></td>
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
						<tr>
							<td colspan="2" style="font-weight: bold"><?php __('front_label_cancel_personal'); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_title'); ?></td>
							<td><?php echo $name_titles[$tpl['arr']['c_title']]; ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_fname'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['c_fname']); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_lname'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['c_lname']); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_phone'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['c_phone']); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_email'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['c_email']); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_company'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['c_company']); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_address'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['c_address']); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_city'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['c_city']); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_state'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['c_state']); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_zip'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['c_zip']); ?></td>
						</tr>
						<tr>
							<td><?php __('front_label_cancel_country'); ?></td>
							<td><?php echo stripslashes($tpl['arr']['country_title']); ?></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2">
								<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjFront&amp;action=pjActionCancel" method="post">
									<input type="hidden" name="booking_cancel" value="1" />
									<input type="hidden" name="id" value="<?php echo $controller->_get->toInt('id') ?>" />
									<input type="hidden" name="hash" value="<?php echo $controller->_get->toString('hash') ?>" />
									<input type="submit" value="<?php __('front_label_cancel_confirm'); ?>" />
								</form>
							</td>
						</tr>
					</tfoot>
				</table>
				<?php
			}
		}
		?>
		</div>
	</body>
</html>