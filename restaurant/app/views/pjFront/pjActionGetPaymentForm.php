<?php
$front_messages = __('front_messages', true, false);
?>
<div class="panel panel-default pjRbMain">
	<header class="panel-heading clearfix pjRbHeader">
		<?php include PJ_VIEWS_PATH . 'pjFront/elements/locale.php';?>
		<div class="text-center pjRbHeaderTitle"><?php __('front_thank_you');?></div><!-- /.text-center pjRbHeaderTitle -->
	</header><!-- /.panel-heading clearfix pjRbHeader -->

	<div class="panel-body pjRbBody">
		<section class="pjRbSection">
			<header class="pjRbSectionHead">

				<?php
				if ($tpl['booking_arr']['status'] != 'enquiry' && !empty($tpl['booking_arr']['payment_method']))
				{
				    if(isset($tpl['params']['plugin']) && !empty($tpl['params']['plugin']))
                    {
                        $payment_messages = __('payment_plugin_messages');
                        ?><p class="text-center pjRbSectionSubTitle"><?php echo isset($payment_messages[$tpl['booking_arr']['payment_method']]) ? $payment_messages[$tpl['booking_arr']['payment_method']]: $front_messages[1]; ?><p><?php
                        if (pjObject::getPlugin($tpl['params']['plugin']) !== NULL)
                        {
                            $controller->requestAction(array('controller' => $tpl['params']['plugin'], 'action' => 'pjActionForm', 'params' => $tpl['params']));
                        }
                    }else{
				        switch ($tpl['booking_arr']['payment_method'])
                        {
                            case 'bank':
                                ?>
                                <p class="text-center pjRbSectionSubTitle">
                                    <?php
                                    $system_msg = str_replace("[STAG]", "<a href='#' class='rbStartOver'>", $front_messages[3]);
                                    $system_msg = str_replace("[ETAG]", "</a>", $system_msg);
                                    echo $system_msg;
                                    ?>
                                    <br />
                                    <b><?php __('front_bank_account');?></p>
                                    <br />
                                    <?php echo nl2br(pjSanitize::html($tpl['bank_account'])); ?>
                                <p>
                                <?php
                                break;
                            case 'creditcard':
                            case 'cash':
                            default:
                                ?>
                                <p class="text-center pjRbSectionSubTitle">
                                    <?php
                                    $system_msg = str_replace("[STAG]", "<a href='#' class='rbStartOver'>", $front_messages[3]);
                                    $system_msg = str_replace("[ETAG]", "</a>", $system_msg);
                                    echo $system_msg;
                                    ?>
                                <p>
                                <?php
                        }
                    }
				}else if($tpl['booking_arr']['status'] == 'enquiry'){
					?>
					<p class="text-center pjRbSectionSubTitle">
						<?php
						$system_msg = str_replace("[STAG]", "<a href='#' class='rbStartOver'>", $front_messages[5]);
						$system_msg = str_replace("[ETAG]", "</a>", $system_msg); 
						echo $system_msg; 
						?>
					<p>
					<?php	
				}else if(empty($tpl['booking_arr']['payment_method'])){
					?>
					<p class="text-center pjRbSectionSubTitle">
						<?php
						$system_msg = str_replace("[STAG]", "<a href='#' class='rbStartOver'>", $front_messages[3]);
						$system_msg = str_replace("[ETAG]", "</a>", $system_msg); 
						echo $system_msg; 
						?>
					<p>
					<?php	
				} 
				?>
			</header><!-- /.pjRbSectionHead -->
		</section><!-- /.pjRbSection -->
	</div><!-- /.panel-body pjRbBody -->
</div><!-- /.panel panel-default pjRbMain -->