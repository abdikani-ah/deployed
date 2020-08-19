<?php
$STORE = @$_SESSION[$controller->defaultStore];

$FORM = @$_SESSION[$controller->defaultForm];

$check_result = $STORE['check_result'];

$href = pjUtil::getReferer() . '#!/Search';
if($check_result['action'] == 'table')
{
	$href = pjUtil::getReferer() . '#!/Tables';
}

if($tpl['status'] == 'OK')
{
	?>
	<div class="panel panel-default pjRbMain">
		<header class="panel-heading clearfix pjRbHeader">
			<a href="<?php echo $href;?>" class="btn pjRbBtnBack pull-left"><?php __('front_label_back');?></a>

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
							?>
						</ul><!-- /.list-unstyled -->

						<div class="text-center pjRbReservationDetailsActions">
							<a href="<?php echo $href;?>" class="btn btn-link"><?php __('front_label_change', false, true); ?></a>
						</div><!-- /.text-center pjRbReservationDetailsActions -->
					</div><!-- /.pjRbReservationDetails -->
				</div><!-- /.pjRbSectionBody -->
			</section><!-- /.pjRbSection -->

			<section class="pjRbSection">
				<header class="pjRbSectionHead">
					<?php
					if($check_result['action'] == 'enquiry')
					{ 
						?>
						<p class="text-center pjRbSectionTitle pjRbSectionTitleSmall"><?php __('front_enquiry_form');?></p><!-- /.text-center pjRbSectionTitle pjRbSectionTitleSmall -->
	
						<p class="text-center pjRbSectionSubTitle"><?php __('front_fill_to_make');?></p><!-- /.text-center pjRbSectionSubTitle -->
						<?php
					}else{
						?>
						<p class="text-center pjRbSectionTitle pjRbSectionTitleSmall"><?php __('front_reservation_form');?></p><!-- /.text-center pjRbSectionTitle pjRbSectionTitleSmall -->
	
						<p class="text-center pjRbSectionSubTitle"><?php __('front_fill_to_reserve');?></p><!-- /.text-center pjRbSectionSubTitle -->
						<?php
					} 
					?>
				</header><!-- /.pjRbSectionHead -->

				<div class="pjRbSectionBody">
					<div class="pjRbForm pjRbFormReservation">
						<form id="rbCheckoutForm_<?php echo $controller->_get->toInt('index') ?>" action="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&amp;action=pjActionCheckout" method="post" data-toggle="validator" role="form">
						
							<input type="hidden" name="step_checkout" value="1" />
							
							<div class="row">
								<?php 
								if (in_array($tpl['option_arr']['o_bf_include_title'], array(2, 3)))
								{ 
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_title'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_title'] === 3 ? ' *' : NULL; ?></label>
											<select id="c_title" name="c_title" class="form-control<?php echo (int) $tpl['option_arr']['o_bf_include_title'] === 3 ? ' required' : null;?>">
												<option value=""></option>
												<?php
												$title_arr = pjUtil::getTitles();
												$name_titles = __('name_titles', true, false);
												foreach ($title_arr as $v)
												{
													?><option value="<?php echo $v;?>"<?php echo isset($FORM['c_title']) ? ($FORM['c_title'] == $v ? ' selected="selected"' : null) : null;?>><?php echo @$name_titles[$v];?></option><?php
												}
												?>
											</select>
											<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-12 -->
									<?php
								}
								if (in_array((int) $tpl['option_arr']['o_bf_include_fname'], array(2,3)))
								{
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_fname'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_fname'] === 3 ? ' *' : NULL; ?></label>
											<input type="text" id="c_fname" name="c_fname" class="form-control<?php echo (int) $tpl['option_arr']['o_bf_include_fname'] === 3 ? ' required' : NULL; ?>" value="<?php echo pjSanitize::html(@$FORM['c_fname']); ?>">
							    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-12 -->
									<?php
								}
								if (in_array((int) $tpl['option_arr']['o_bf_include_lname'], array(2,3)))
								{
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_lname'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_lname'] === 3 ? ' *' : NULL; ?></label>
											<input type="text" id="c_lname" name="c_lname" class="form-control<?php echo (int) $tpl['option_arr']['o_bf_include_fname'] === 3 ? ' required' : NULL; ?>" value="<?php echo pjSanitize::html(@$FORM['c_lname']); ?>">
							    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-12 -->
									<?php
								}
								if (in_array((int) $tpl['option_arr']['o_bf_include_email'], array(2,3)))
								{
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_email'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_email'] === 3 ? ' *' : NULL; ?></label>
											<input type="text" id="c_email" name="c_email" class="form-control email<?php echo (int) $tpl['option_arr']['o_bf_include_email'] === 3 ? ' required' : NULL; ?>" value="<?php echo pjSanitize::html(@$FORM['c_email']); ?>">
							    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-12 -->
									<?php
								}
								if (in_array((int) $tpl['option_arr']['o_bf_include_phone'], array(2,3)))
								{
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_phone'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_phone'] === 3 ? ' *' : NULL; ?></label>
											<input type="text" id="c_phone" name="c_phone" class="form-control<?php echo (int) $tpl['option_arr']['o_bf_include_phone'] === 3 ? ' required' : NULL; ?>" value="<?php echo pjSanitize::html(@$FORM['c_phone']); ?>">
							    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-4 col-md-4 col-sm-6 col-xs-6 -->
									<?php
								}
								if (in_array((int) $tpl['option_arr']['o_bf_include_company'], array(2,3)))
								{
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_company'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_company'] === 3 ? ' *' : NULL; ?></label>
											<input type="text" id="c_company" name="c_company" class="form-control<?php echo (int) $tpl['option_arr']['o_bf_include_company'] === 3 ? ' required' : NULL; ?>" value="<?php echo pjSanitize::html(@$FORM['c_company']); ?>">
							    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-4 col-md-4 col-sm-6 col-xs-6 -->
									<?php
								}
								if (in_array((int) $tpl['option_arr']['o_bf_include_notes'], array(2,3)))
								{
									?>
									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_notes'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_notes'] === 3 ? ' *' : NULL; ?></label>
											<textarea id="c_notes" name="c_notes" cols="30" rows="10" class="form-control<?php echo (int) $tpl['option_arr']['o_bf_include_notes'] === 3 ? ' required' : NULL; ?>" style="height: 100px;"><?php echo pjSanitize::html(@$FORM['c_notes']); ?></textarea>
							    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-8 col-md-8 col-sm-12 col-xs-12 -->
									<?php
								}
								if (in_array((int) $tpl['option_arr']['o_bf_include_address'], array(2,3)))
								{
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_address'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_address'] === 3 ? ' *' : NULL; ?></label>
											<input type="text" id="c_address" name="c_address" class="form-control<?php echo (int) $tpl['option_arr']['o_bf_include_address'] === 3 ? ' required' : NULL; ?>" value="<?php echo pjSanitize::html(@$FORM['c_address']); ?>">
							    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-4 col-md-4 col-sm-6 col-xs-6 -->
									<?php
								}
								if (in_array((int) $tpl['option_arr']['o_bf_include_city'], array(2,3)))
								{ 
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_city'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_city'] === 3 ? ' *' : NULL; ?></label>
											<input type="text" id="c_city" name="c_city" class="form-control<?php echo (int) $tpl['option_arr']['o_bf_include_city'] === 3 ? ' required' : NULL; ?>" value="<?php echo pjSanitize::html(@$FORM['c_city']); ?>">
							    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-4 col-md-4 col-sm-6 col-xs-6 -->
									<?php
								}
								if (in_array((int) $tpl['option_arr']['o_bf_include_state'], array(2,3)))
								{ 
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_state'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_state'] === 3 ? ' *' : NULL; ?></label>
											<input type="text" id="c_state" name="c_state" class="form-control<?php echo (int) $tpl['option_arr']['o_bf_include_state'] === 3 ? ' required' : NULL; ?>" value="<?php echo pjSanitize::html(@$FORM['c_state']); ?>">
							    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-4 col-md-4 col-sm-6 col-xs-6 -->
									<?php
								}
								if (in_array((int) $tpl['option_arr']['o_bf_include_zip'], array(2,3)))
								{ 
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_zip'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_zip'] === 3 ? ' *' : NULL; ?></label>
											<input type="text" id="c_zip" name="c_zip" class="form-control<?php echo (int) $tpl['option_arr']['o_bf_include_zip'] === 3 ? ' required' : NULL; ?>" value="<?php echo pjSanitize::html(@$FORM['c_zip']); ?>">
							    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-4 col-md-4 col-sm-6 col-xs-6 -->
									<?php
								}
								if (in_array((int) $tpl['option_arr']['o_bf_include_country'], array(2,3)))
								{ 
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<label for=""><?php __('front_label_country'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_country'] === 3 ? ' *' : NULL; ?></label>
											<select id="c_country" name="c_country" class="form-control<?php echo (int) $tpl['option_arr']['o_bf_include_country'] === 3 ? ' required' : null;?>">
												<option value="">-- <?php __('plugin_base_choose');?> --</option>
												<?php
												foreach($tpl['country_arr'] as $k => $v) 
												{
													?><option value="<?php echo $v['id'];?>"<?php echo isset($FORM['c_country']) ? ($FORM['c_country'] == $v['id'] ? ' selected="selected"' : null) : null;?>><?php  echo $v['country_title'];?></option><?php
												}
												?>
											</select>
											<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-4 col-md-4 col-sm-6 col-xs-6 -->
									<?php
								} 
								?>
							</div><!-- /.row -->
							
							<?php
							if (isset($STORE['table_id']) && $tpl['option_arr']['o_payment_disable'] == 'No' && (float) $tpl['option_arr']['o_booking_price'] > 0 && (float) $tpl['price_arr']['price'] > 0)
							{
								$showDeposit = $depositFlag = false;
								if ((float) $tpl['option_arr']['o_booking_price'] > 0 && (float) $tpl['price_arr']['price'] > 0)
								{
									$showDeposit = true;
									$depositFlag = true;
								}
								$price = $tpl['price_arr']['total'];
								if(isset($STORE['code']) && !empty($STORE['code']))
								{
									$price = $tpl['price_arr']['price_before_discount'];
								}
								?>
								<div id="rbDepositBox" style="display: <?php echo !$showDeposit ? 'none' : 'block'; ?>">
									<p class="text-center"><?php __('front_label_deposit_note', false, true);?></p>
		
									<dl class="dl-horizontal">
										<dt><?php __('front_label_price'); ?></dt>
										<dd><?php echo pjCurrency::formatPrice($price) ?></dd>
									</dl><!-- /.dl-horizontal -->
								</div>
								
								<?php
								if (in_array($tpl['option_arr']['o_bf_include_promo'], array(2, 3)))
								{ 
									?>
									<div class="row">
										<div class="col-lg-4 col-md-4 col-sm-8 col-xs-12">
											<div class="form-group pjRbFormVoucher">
												<label for=""><?php __('plugin_vouchers_front_label_voucher'); ?>:<?php echo (int) $tpl['option_arr']['o_bf_include_promo'] === 3 ? ' *' : NULL; ?></label>
		
												<div class="pjRbFormVoucherActions">
													<a href="#" id="rbBtnAddVoucher_<?php echo $controller->_get->toInt('index') ?>"  class="btn btn-default"><?php __('plugin_vouchers_front_label_add_voucher'); ?></a>
												</div><!-- /.pjRbFormVoucherActions -->
		
												<div class="pjRbFormVoucherField">
													<input type="text" id="rbCodeField_<?php echo $controller->_get->toInt('index') ?>" name="promo_code"  class="form-control<?php echo ($tpl['option_arr']['o_bf_include_promo'] == 3) && !isset($STORE['code']) ? ' required' : NULL; ?>" />
												</div><!-- /.pjRbFormVoucherField -->
											</div><!-- /.form-group pjRbFormVoucher -->
										</div><!-- /.col-lg-6 col-md-6 col-sm-12 col-xs-12 -->
										
										<div class="col-lg-4 col-md-4 col-sm-8 col-xs-12" style="display: <?php echo isset($STORE['code']) && !empty($STORE['code']) ? "block" : "none"; ?>">
											<div class="form-group pjRbFormVoucher">
												<label for=""><?php __('plugin_vouchers_front_label_added_voucher'); ?>: </label>
												<div>
													<span id="rbPromoCode_<?php echo $controller->_get->toInt('index') ?>"><?php echo isset($STORE['code']) ? $STORE['code'] : NULL; ?></span>
													<span id="rbPromoDiscount_<?php echo $controller->_get->toInt('index') ?>"><?php echo @$tpl['price_arr']['discount_text']; ?></span>
													<a href="#" id="rbBtnRemoveVoucher_<?php echo $controller->_get->toInt('index') ?>" class="rbFloatLeft"><?php __('plugin_vouchers_front_label_remove_voucher'); ?></a>
												</div>
											</div>
										</div>
										<div class="col-lg-4 col-md-4 col-sm-8 col-xs-12" style="display: <?php echo isset($STORE['code']) && !empty($STORE['code']) ? "block" : "none"; ?>">
											<div class="form-group pjRbFormVoucher">
												<label><?php __('front_price_after_discount'); ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="rbPriceAfterPromo_<?php echo $controller->_get->toInt('index') ?>"><?php echo pjCurrency::formatPrice($tpl['price_arr']['price_after_discount']) ?></span></label>
											</div>
										</div>
										<div class="col-lg-4 col-md-4 col-sm-8 col-xs-12" style="display:none;">
											<label for="">&nbsp;</label>
											<div class="form-group pjRbFormVoucher">
												<div id="rbPromoInvalid_<?php echo $controller->_get->toInt('index') ?>" class="rbFormItemLabel"></div>
											</div>
										</div>
									</div>
									<?php
								}
								?>
								<div id="pjRbPaymentWrapper_<?php echo $controller->_get->toInt('index') ?>" style="display: <?php echo (float) $tpl['price_arr']['total'] > 0 ? '' : "none"; ?>">
									<div class="row">
										<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                            <?php
                                            $plugins_payment_methods = pjObject::getPlugin('pjPayments') !== NULL? pjPayments::getPaymentMethods(): array();
                                            $haveOnline = $haveOffline = false;
                                            foreach ($tpl['payment_titles'] as $k => $v)
                                            {
                                            	if($k == 'creditcard') continue;
                                            	if (array_key_exists($k, $plugins_payment_methods))
                                            	{
                                            		if(!isset($tpl['payment_option_arr'][$k]['is_active']) || (isset($tpl['payment_option_arr']) && $tpl['payment_option_arr'][$k]['is_active'] == 0) )
                                            		{
                                            			continue;
                                            		}
                                            	}else if( (isset($tpl['option_arr']['o_allow_'.$k]) && $tpl['option_arr']['o_allow_'.$k] == 'No') || $k == 'cash' || $k == 'bank' ){
                                            		continue;
                                            	}
                                            	$haveOnline = true;
                                            	break;
                                            }
                                            foreach ($tpl['payment_titles'] as $k => $v)
                                            {
                                            	if($k == 'creditcard') continue;
                                            	if( $k == 'cash' || $k == 'bank' )
                                            	{
                                            		if( (isset($tpl['option_arr']['o_allow_'.$k]) && $tpl['option_arr']['o_allow_'.$k] == 'Yes'))
                                            		{
                                            			$haveOffline = true;
                                            			break;
                                            		}
                                            	}
                                            }
                                            ?>
											<div class="form-group">
												<label for=""><?php __('front_label_payment_medthod'); ?>: *</label>

                                                <select id="rbPaymentMethod_<?php echo $controller->_get->toInt('index') ?>" name="payment_method" class="form-control required">
                                                    <option value="">-- <?php __('plugin_base_choose');?> --</option>
                                                    <?php 
		                                            if ($haveOnline && $haveOffline)
		                                            {
			                                            ?><optgroup label="<?php __('script_online_payment_gateway', false, true); ?>"><?php 
		                                            }
		                                            ?>
                                                        <?php
                                                        foreach ($tpl['payment_titles'] as $k => $v)
                                                        {
                                                            if($k == 'creditcard') continue;
                                                            if (array_key_exists($k, $plugins_payment_methods))
                                                            {
                                                                if(!isset($tpl['payment_option_arr'][$k]['is_active']) || (isset($tpl['payment_option_arr']) && $tpl['payment_option_arr'][$k]['is_active'] == 0) )
                                                                {
                                                                    continue;
                                                                }
                                                            }else if( (isset($tpl['option_arr']['o_allow_'.$k]) && $tpl['option_arr']['o_allow_'.$k] == 'No') || $k == 'cash' || $k == 'bank' ){
                                                                continue;
                                                            }
                                                            ?><option value="<?php echo $k; ?>"<?php echo isset($FORM['payment_method']) && $FORM['payment_method']==$k ? ' selected="selected"' : NULL;?>><?php echo $v; ?></option><?php
                                                        }
                                                        ?>
                                                    <?php
		                                            if ($haveOnline && $haveOffline)
		                                            {
		                                            	?>
		                                            	</optgroup>
		                                            	<optgroup label="<?php __('script_offline_payment', false, true); ?>">
		                                            	<?php 
		                                            }
		                                            ?>
                                                        <?php
                                                        foreach ($tpl['payment_titles'] as $k => $v)
                                                        {
                                                            if($k == 'creditcard') continue;
                                                            if( $k == 'cash' || $k == 'bank' )
                                                            {
                                                                if( (isset($tpl['option_arr']['o_allow_'.$k]) && $tpl['option_arr']['o_allow_'.$k] == 'Yes'))
                                                                {
                                                                    ?><option value="<?php echo $k; ?>"<?php echo isset($FORM['payment_method']) && $FORM['payment_method']==$k ? ' selected="selected"' : NULL;?>><?php echo $v; ?></option><?php
                                                                }
                                                            }
                                                        }
                                                        ?>
                                                    <?php
		                                            if ($haveOnline && $haveOffline)
		                                            {
		                                            	?></optgroup><?php 
		                                            }
		                                            ?>
                                                </select>
												<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
											</div><!-- /.form-group -->
										</div><!-- /.col-lg-6 col-md-6 col-sm-12 col-xs-12 -->
										<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 pjRbBankWrap" style="display: <?php echo @$FORM['payment_method'] != 'bank' ? 'none' : 'block'; ?>">
											<div class="form-group">
												<label class="text-muted"><strong><?php echo nl2br(pjSanitize::html($tpl['bank_account'])); ?></strong></label>
											</div><!-- /.form-group -->
										</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-6 -->
									</div>
									<div class="row pjRbCcWrap" style="display: <?php echo @$FORM['payment_method'] != 'creditcard' ? 'none' : 'block'; ?>">
										<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
											<div class="form-group">
												<label for=""><?php __('front_label_cc_type')?>: *</label>
												<select name="cc_type" class="form-control required">
										    		<option value="">---</option>
										    		<?php
													foreach (__('cc_types', true) as $k => $v)
													{
														?><option value="<?php echo $k; ?>"<?php echo @$FORM['cc_type'] != $k ? NULL : ' selected="selected"'; ?>><?php echo $v; ?></option><?php
													}
													?>
										    	</select>
										    	<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
											</div><!-- /.form-group -->
										</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-6 -->
			
										<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
											<div class="form-group">
												<label for=""><?php __('front_label_cc_num')?>: *</label>
												<input type="text" name="cc_num" class="form-control required" value="<?php echo pjSanitize::html(@$FORM['cc_num']); ?>"  autocomplete="off"/>
								    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
											</div><!-- /.form-group -->
										</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-6 -->
			
										<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
											<div class="form-group">
												<label for=""><?php __('front_label_cc_code')?>: *</label>
												<input type="text" name="cc_code" class="form-control required" value="<?php echo pjSanitize::html(@$FORM['cc_code']); ?>"  autocomplete="off"/>
								    			<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
											</div><!-- /.form-group -->
										</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-6 -->
			
										<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
											<div class="form-group">
												<label for=""><?php __('front_label_cc_exp')?>: *</label>
												
												<div class="row">
													<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
														<?php
														$rand = rand(1, 99999);
														$time = pjDateTime::factory()
															->attr('name', 'cc_exp_month')
															->attr('id', 'cc_exp_month_' . $rand)
															->attr('class', 'form-control required')
															->prop('format', 'F');
														if (isset($FORM['cc_exp_month']) && !is_null($FORM['cc_exp_month']))
														{
															$time->prop('selected', $FORM['cc_exp_month']);
														}
														echo $time->month();
														?>
													</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-6 -->
			
													<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
														<?php
														$time = pjDateTime::factory()
															->attr('name', 'cc_exp_year')
															->attr('id', 'cc_exp_year_' . $rand)
															->attr('class', 'form-control required')
															->prop('left', 0)
															->prop('right', 10);
														if (isset($FORM['cc_exp_year']) && !is_null($FORM['cc_exp_year']))
														{
															$time->prop('selected', $FORM['cc_exp_year']);
														}
														echo $time->year();
														?>
													</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-6 -->
												</div><!-- /.row -->
											</div><!-- /.form-group -->
										</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-6 -->
									</div><!-- /.row -->
								</div>
								<?php
							}
							?>
							<div class="row">
								<?php
								if (in_array($tpl['option_arr']['o_bf_include_captcha'], array(2, 3)))
								{ 
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                        <?php if($tpl['option_arr']['o_captcha_type_front'] == 'system'): ?>
                                            <div class="form-group pjRbFormCaptcha">
                                                <label for=""><?php __('front_label_captcha'); ?>: </label>

                                                <img src="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&action=pjActionCaptcha&rand=<?php echo rand(1, 9999); ?><?php echo $controller->_get->check('session_id') ? '&session_id=' . $controller->_get->toString('session_id') : NULL;?>" alt="Captcha" class="rbCaptcha" title="<?php __('front_label_reload_captcha', false, true); ?>">

                                                <div class="pjRbFormCaptchaField">
                                                    <input type="text" id="rbCaptcha_<?php echo $controller->_get->toInt('index') ?>" name="captcha" maxlength="<?php echo $tpl['option_arr']['o_captcha_mode_front'] == 'string'? (int) $tpl['option_arr']['o_captcha_length_front']: 10 ?>" class="form-control<?php echo ($tpl['option_arr']['o_bf_include_captcha'] == 3) ? ' required' : NULL; ?>" autocomplete="off"/>
                                                </div><!-- /.pjRbFormCaptchaField -->

                                                <div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
                                            </div><!-- /.form-group pjRbFormCaptcha -->
                                        <?php else: ?>
                                            <div class="form-group">
                                                <div id="g-recaptcha_<?php echo $controller->_get->toInt('index') ?>" class="g-recaptcha" data-sitekey="<?php echo $tpl['option_arr']['o_captcha_site_key_front'] ?>"></div>
                                                <input type="hidden" id="recaptcha" name="recaptcha" class="required recaptcha" autocomplete="off" />
                                                <div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
                                            </div>
                                        <?php endif; ?>
									</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-12 -->
									<?php
								}
								if (in_array($tpl['option_arr']['o_bf_include_terms'], array(2, 3)))
								{
									?>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
										<div class="form-group">
											<div class="checkbox">
												<label for="rbAgree_<?php echo $controller->_get->toInt('index') ?>">
													<input id="rbAgree_<?php echo $controller->_get->toInt('index') ?>" name="agreement" type="checkbox" class="required"/>&nbsp;<?php __('front_label_agree');?>
													<?php
													if(!empty($tpl['terms_conditions']))
													{ 
														?>
														<br/><a href="#" class="btn btn-link" data-toggle="modal" data-target="#pjRbModalTerms"><?php __('front_label_terms_conditions');?></a>
														<?php
													} 
													?>
												</label>
											</div><!-- /.checkbox -->
	
											<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
										</div><!-- /.form-group -->
									</div><!-- /.col-lg-6 col-md-6 col-sm-6 col-xs-12 -->
									<?php 
								}
								?>
							</div><!-- /.row -->
								
							<div class="clearfix pjRbFormActions">
								<a href="<?php echo $href;?>" class="btn btn-default pull-left"><?php __('front_button_cancel'); ?></a>

								<button type="submit" id="rbBtnCheckout_<?php echo $controller->_get->toInt('index') ?>" class="btn btn-primary pull-right"><?php __('front_label_checkout'); ?></button>
							</div><!-- /.clearfix pjRbFormActions -->
						</form>
					</div><!-- /.pjRbForm pjRbFormReservation -->
				</div><!-- /.pjRbSectionBody -->
			</section><!-- /.pjRbSection -->
		</div><!-- /.panel-body pjRbBody -->
	</div><!-- /.panel panel-default pjRbMain -->
	
	<?php
	if(!empty($tpl['terms_conditions']))
	{ 
		?>
		<div class="modal fade pjRbModal pjRbModalTerms" id="pjRbModalTerms" tabindex="-1" role="dialog" aria-labelledby="pjRbModalTermsLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<header class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
	
						<p class="modal-title" id="pjRbModalTermsLabel"><?php __('front_label_terms_conditions');?></p><!-- /#pjRbModalTermsLabel.modal-title -->
					</header><!-- /.modal-header -->
	
					<div class="modal-body">
						<?php echo stripslashes($tpl['terms_conditions']);?>
					</div><!-- /.modal-body -->
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /#pjRbModalTerms.modal fade pjRbModal pjRbModalTerms -->
		<?php
	}
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