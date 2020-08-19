<?php
$STORE = @$_SESSION[$controller->defaultStore];
$check_result = $STORE['check_result'];
$FORM = @$_SESSION[$controller->defaultForm];

$search_href = pjUtil::getReferer() . '#!/Search';
$checkout_href = pjUtil::getReferer() . '#!/Checkout';
if($check_result['action'] == 'table')
{
	$search_href = pjUtil::getReferer() . '#!/Tables';
}
if($tpl['status'] == 'OK')
{
	?>
	<div class="panel panel-default pjRbMain">
		<header class="panel-heading clearfix pjRbHeader">
			<a href="<?php echo $checkout_href;?>" class="btn pjRbBtnBack pull-left"><?php __('front_label_back');?></a>

			<?php include PJ_VIEWS_PATH . 'pjFront/elements/locale.php';?>

			<div class="text-center pjRbHeaderTitle"><?php
					if($check_result['action'] == 'enquiry')
					{ 
						?><?php __('front_enquiry_details', false, false);?><!-- /.text-center pjRbSectionTitle --><?php
					}else{
						?><?php __('front_label_your_booking', false, false);?><!-- /.text-center pjRbSectionTitle --><?php
					} 
					?></div><!-- /.text-center pjRbHeaderTitle -->
		</header><!-- /.panel-heading clearfix pjRbHeader -->

		<div class="panel-body pjRbBody">
			<section class="pjRbSection">
				<div class="pjRbSectionBody">
					<div class="pjRbReservationDetails">
						<ul class="list-unstyled">
							<li>
								<dl class="dl-horizontal">
									<dt><?php __('front_label_date_time', false, true)?>: </dt>
									<dd><?php echo date($tpl['option_arr']['o_date_format'], $STORE['actual_datetime']) . ', ' . date($tpl['option_arr']['o_time_format'], $STORE['actual_datetime']); ?></dd>
								</dl><!-- /.dl-horizontal -->
							</li>
							<?php
							if(isset($STORE['table_id']))
							{ 
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php echo sprintf(__('front_label_table_for', true, false), $STORE['people'])?>:</dt>
										
										<dd>
											<span><?php echo stripslashes($tpl['table']['name']); ?></span>
										</dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}else if($check_result['action'] == 'enquiry'){
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_table'); ?>:</dt>
										
										<dd><?php echo sprintf(__('front_for_persons', true, false), $STORE['people'])?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							} 
							if (in_array($tpl['option_arr']['o_bf_include_title'], array(2, 3)) && !empty($FORM['c_title']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_title'); ?>: </dt>
										<dd>
											<?php
											if (isset($FORM['c_title']))
											{
												$name_titles = __('personal_titles', true, false);
												echo @$name_titles[$FORM['c_title']];
											}
											?>
										</dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if (in_array($tpl['option_arr']['o_bf_include_fname'], array(2, 3)) && !empty($FORM['c_fname']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_fname'); ?>: </dt>
										<dd><?php echo pjSanitize::clean($FORM['c_fname']);?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if (in_array($tpl['option_arr']['o_bf_include_lname'], array(2, 3)) && !empty($FORM['c_lname']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_lname'); ?>: </dt>
										<dd><?php echo pjSanitize::clean($FORM['c_lname']);?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if (in_array($tpl['option_arr']['o_bf_include_phone'], array(2, 3)) && !empty($FORM['c_phone']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_phone'); ?>: </dt>
										<dd><?php echo pjSanitize::clean($FORM['c_phone']);?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if (in_array($tpl['option_arr']['o_bf_include_email'], array(2, 3)) && !empty($FORM['c_email']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_email'); ?>: </dt>
										<dd><?php echo pjSanitize::clean($FORM['c_email']);?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if (in_array($tpl['option_arr']['o_bf_include_company'], array(2, 3)) && !empty($FORM['c_company']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_company'); ?>: </dt>
										<dd><?php echo pjSanitize::clean($FORM['c_company']);?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if (in_array($tpl['option_arr']['o_bf_include_notes'], array(2, 3)) && !empty($FORM['c_notes']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_notes'); ?>: </dt>
										<dd><?php echo nl2br(pjSanitize::clean($FORM['c_notes']));?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if (in_array($tpl['option_arr']['o_bf_include_address'], array(2, 3)) && !empty($FORM['c_address']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_address'); ?>: </dt>
										<dd><?php echo pjSanitize::clean($FORM['c_address']);?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if (in_array($tpl['option_arr']['o_bf_include_city'], array(2, 3)) && !empty($FORM['c_city']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_city'); ?>: </dt>
										<dd><?php echo pjSanitize::clean($FORM['c_city']);?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if (in_array($tpl['option_arr']['o_bf_include_state'], array(2, 3)) && !empty($FORM['c_state']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_state'); ?>: </dt>
										<dd><?php echo pjSanitize::clean($FORM['c_state']);?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if (in_array($tpl['option_arr']['o_bf_include_zip'], array(2, 3)) && !empty($FORM['c_zip']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_zip'); ?>: </dt>
										<dd><?php echo pjSanitize::clean($FORM['c_zip']);?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if (in_array($tpl['option_arr']['o_bf_include_country'], array(2, 3)) && !empty($FORM['c_country']))
							{
								?>
								<li>
									<dl class="dl-horizontal">
										<dt><?php __('front_label_country'); ?>: </dt>
										<dd><?php echo $tpl['country_arr']['country_title'];?></dd>
									</dl><!-- /.dl-horizontal -->
								</li>
								<?php
							}
							if(isset($STORE['table_id']))
							{
								if ($tpl['option_arr']['o_payment_disable'] == 'No' && isset($STORE['table_id']) && (float) $tpl['option_arr']['o_booking_price'] > 0 && (float) $tpl['price_arr']['total'] > 0)
								{
									$showDeposit = $depositFlag = false;
									if ((float) $tpl['option_arr']['o_booking_price'] > 0 && (float) $tpl['price_arr']['total'] > 0)
									{
										$showDeposit = true;
										$depositFlag = true;
									}
									$price = $tpl['price_arr']['total'];
									if(isset($STORE['code']) && !empty($STORE['code']))
									{
										$price = $tpl['price_arr']['price_before_discount'];
									}
									if($showDeposit == true)
									{
										?>
										<li>
											<dl class="dl-horizontal">
												<dt><?php __('front_label_price'); ?>: </dt>
												<dd><?php echo pjCurrency::formatPrice($price) ?></dd>
											</dl><!-- /.dl-horizontal -->
										</li>
										<?php
									} 
									if (in_array($tpl['option_arr']['o_bf_include_promo'], array(2, 3)) && isset($STORE['table_id']) && isset($STORE['code']) && !empty($STORE['code']))
									{
										?>
										<li>
											<dl class="dl-horizontal">
												<dt><?php __('plugin_vouchers_front_label_added_voucher'); ?>: </dt>
												<dd><?php echo isset($STORE['code']) ? $STORE['code'] : NULL; ?> (<?php echo @$tpl['price_arr']['discount_text']; ?>)</dd>
											</dl><!-- /.dl-horizontal -->
										</li>
										<li>
											<dl class="dl-horizontal">
												<dt><?php __('front_price_after_discount'); ?>: </dt>
												<dd><?php echo pjCurrency::formatPrice($tpl['price_arr']['price_after_discount']) ?></dd>
											</dl><!-- /.dl-horizontal -->
										</li>
										<?php
									}
									?>
									<li>
										<dl class="dl-horizontal">
											<dt><?php __('front_label_payment_medthod'); ?>: </dt>
											<dd>
												<?php 
												echo $tpl['payment_titles'][$FORM['payment_method']];
												?>
											</dd>
										</dl><!-- /.dl-horizontal -->
									</li>
									<?php
									if(isset($FORM['payment_method']) && $FORM['payment_method'] == 'bank')
									{
										?>
										<li>
											<dl class="dl-horizontal">
												<dt><?php __('front_bank_account'); ?>: </dt>
												<dd>
													<?php echo nl2br(pjSanitize::html($tpl['bank_account'])); ?>
												</dd>
											</dl><!-- /.dl-horizontal -->
										</li>
										<?php
									}
									if(isset($FORM['payment_method']) && $FORM['payment_method'] == 'creditcard')
									{
										?>
										<li>
											<dl class="dl-horizontal">
												<dt><?php __('front_label_cc_type'); ?>: </dt>
												<dd>
													<?php 
													$cc_types = __('cc_types', true, false);
													echo $cc_types[$FORM['cc_type']];
													?>
												</dd>
											</dl><!-- /.dl-horizontal -->
										</li>
										<li>
											<dl class="dl-horizontal">
												<dt><?php __('front_label_cc_num'); ?>: </dt>
												<dd>
													<?php echo pjSanitize::clean($FORM['cc_num']);?>
												</dd>
											</dl><!-- /.dl-horizontal -->
										</li>
										<li>
											<dl class="dl-horizontal">
												<dt><?php __('front_label_cc_exp'); ?>: </dt>
												<dd>
													<?php
													$month_arr = __('months', true, false);
													echo $month_arr[(int) $FORM['cc_exp_month']] . ' ' . $FORM['cc_exp_year'];
													?>
												</dd>
											</dl><!-- /.dl-horizontal -->
										</li>
										<li>
											<dl class="dl-horizontal">
												<dt><?php __('front_label_cc_code'); ?>: </dt>
												<dd>
													<?php echo pjSanitize::clean($FORM['cc_code']);?>
												</dd>
											</dl><!-- /.dl-horizontal -->
										</li>
										<?php
									}
								}
							}
							
							$front_messages = __('front_messages', true, false);
							$failed_msg = str_replace("[STAG]", "<a href='#' class='rbStartOver'>", $front_messages[6]);
							$failed_msg = str_replace("[ETAG]", "</a>", $failed_msg);
							?>
							
						</ul><!-- /.list-unstyled -->
						
						<input type="hidden" id="rbFailMessage_<?php echo $controller->_get->toInt('index') ?>" value="<?php echo $failed_msg;?>" />
						
						<div class="text-center pjRbReservationDetailsActions" style="display:none;">
							<div id="rbBookingMsg_<?php echo $controller->_get->toInt('index') ?>" class="rbBookingMsg"></div>
						</div>
						
						<div class="text-center pjRbReservationDetailsActions">
							<a href="<?php echo $search_href;?>" class="btn btn-link"><?php __('front_label_change', false, true); ?></a>

							<?php
							if(isset($STORE['table_id']))
							{ 
								?>
								<button type="button" id="rbBtnConfirm_<?php echo $controller->_get->toInt('index') ?>" class="btn btn-primary"><?php __('front_label_confirm'); ?></button>
								<?php
							}else if($check_result['action'] == 'enquiry'){
								?>
								<button type="button" id="rbBtnConfirm_<?php echo $controller->_get->toInt('index') ?>" class="btn btn-primary"><?php __('front_label_send_enquiry'); ?></button>
								<?php
							} 
							?>
						</div><!-- /.text-center pjRbReservationDetailsActions -->
					</div><!-- /.pjRbReservationDetails -->
				</div><!-- /.pjRbSectionBody -->
			</section><!-- /.pjRbSection -->
		</div><!-- /.panel-body pjRbBody -->
	</div><!-- /.panel panel-default pjRbMain -->
	<?php
}else{
	$system_msg = __('front_label_start_over', true, false);
	$system_msg = str_replace("[STAG]", "<a href='#' class='rbStartOver'>", $system_msg);
	$system_msg = str_replace("[ETAG]", "</a>", $system_msg);
	?>
	<div class="panel panel-default pjRbMain">
		<div class="panel-body pjRbBody">
			<section class="pjRbSection">
				<div class="text-danger"><?php echo $system_msg;?></div>
			</section>
		</div>
	</div>
	<?php
} 
?>