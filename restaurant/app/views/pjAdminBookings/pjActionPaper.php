<!doctype html>
<html>
	<head>
		<title><?php __('script_name') ?> diyaarso</title>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
		<link type="text/css" rel="stylesheet" href="<?php echo PJ_INSTALL_URL . PJ_CSS_PATH; ?>print.css" media="screen, print" />
		<style type="text/css" media="print">
		  	@page { size: landscape; }
		</style>
	</head>
	<body style="background-image: none; background-color: #fff;">
		<?php
		if(isset($tpl['arr']))
		{
			$date = $controller->_get->toString('date') ?: date($tpl['option_arr']['o_date_format']);
			if ($tpl['wt_arr'] === false)
			{
				pjUtil::printNotice(NULL, sprintf(__('lblDateIsDayOff', true, false), $date), false);
			} else { 
				$offset = pjUtil::getOffset($tpl['wt_arr']);
						
				$numOfHours = abs($tpl['wt_arr']['start_hour'] - $tpl['wt_arr']['end_hour'] - $offset);
				$hour_interval = 3600;
				$min_interval = 300;
				?>
				<div style="padding: 10px;">
					<div style="font-weight: bold;margin-bottom: 5px;"><?php __('lblDate');?>:&nbsp;<?php echo $date;?></div>
					<table class="table" cellpadding="0" cellspacing="0" style="width: 100%;">
						<thead>
							<tr>
								<th><?php __('lblTableHour');?></th>
								<?php
								$date = pjDateTime::formatDate($date, $tpl['option_arr']['o_date_format']);
								$stime = strtotime($date . ' ' . $tpl['wt_arr']['start_hour'] . ':' . $tpl['wt_arr']['start_minutes']);
								if($offset == 0)
								{
									$etime = strtotime($date . ' ' . $tpl['wt_arr']['end_hour'] . ':' . $tpl['wt_arr']['end_minutes']);
								}else{
									$etime = strtotime($date . ' ' . $tpl['wt_arr']['end_hour'] . ':' . $tpl['wt_arr']['end_minutes']) + 86400;
								}
								$limit = $etime - ($tpl['option_arr']['o_booking_length'] * 60);
								for ($i = $stime; $i < $etime; $i += $hour_interval)
								{
									$time = date($tpl['option_arr']['o_time_format'], $i);
									?><th colspan="12"><?php echo $time; ?> </th><?php
								}
								?>
							</tr>
						</thead>
						<tbody>
							<?php
							foreach ($tpl['arr'] as $k => $table)
							{
								?>
								<tr>
									<td><?php echo stripslashes($table['name']); ?></td>
									<?php
									$booking_id = null;
									$colspan = 1;
									$booking_detail = '';
									$full_name = '';
									for ($j = $stime; $j < $etime; $j += $hour_interval)
									{
										for($i = $j; $i < ($j + $hour_interval); $i += $min_interval)
										{	
											if (isset($table['hour_arr'][$i]) && count($table['hour_arr'][$i]) > 0)
				    	    				{
				    	    					$booking = $table['hour_arr'][$i];
				    	    					$fullname_arr = array();
				    	    					if(!empty($booking['c_fname'])){
				    	    						$fullname_arr[] = $booking['c_fname'];
				    	    					}
				    	    					if(!empty($booking['c_lname'])){
				    	    						$fullname_arr[] = $booking['c_lname'];
				    	    					}
				    	    					
				    	    					if($booking_id == null)
				    	    					{
				    	    						$booking_id = $booking['id'];
				    	    					}else{
				    	    						if($booking['id'] == $booking_id)
				    	    						{
				    	    							$colspan++;
				    	    						}else{
				    	    							?>
					    	    						<td colspan="<?php echo $colspan; ?>">
						    	    						<?php echo $full_name; ?><br/><?php echo $booking_detail;?>
						    	    					</td>
					    	    						<?php
					    	    						$colspan = 1;
					    	    						$booking_id = $booking['id'];
				    	    						}
				    	    					}
				    	    					$full_name = pjSanitize::clean(join(' ', $fullname_arr));
				    	    					$booking_detail = $booking['people'] . ' ' . ($booking['people'] > 1 ? __('lblPeople', true, false) : __('lblPerson', true, false));
				    	    					
				    	    				}else{
				    	    					if($booking_id != null)
				    	    					{
				    	    						?>
				    	    						<td colspan="<?php echo $colspan; ?>">
					    	    						<?php echo $full_name; ?><br/><?php echo $booking_detail;?>
					    	    					</td>
				    	    						<?php
				    	    						$booking_id = null;
				    	    						$colspan = 1;
				    	    						$booking_detail = '';
				    	    					}
				    	    					if($i <= $limit)
				    	    					{
				    	    						?><td>&nbsp;</td><?php
				    	    					}else{
				    	    						?><td>&nbsp;</td><?php
				    	    					}
				    	    				}
										}
									}
									$v = $i - $min_interval;
									if (isset($table['hour_arr'][$v]) && count($table['hour_arr'][$v]) > 0)
				    	    		{
				    	    			$booking = $table['hour_arr'][$v];
				    	    			$fullname_arr = array();
		    	    					if(!empty($booking['c_fname'])){
		    	    						$fullname_arr[] = $booking['c_fname'];
		    	    					}
		    	    					if(!empty($booking['c_lname'])){
		    	    						$fullname_arr[] = $booking['c_lname'];
		    	    					}
		    	    					$booking_detail = $booking['people'] . ' ' . ($booking['people'] > 1 ? __('lblPeople', true, false) : __('lblPerson', true, false));
		    	    					$colspan = intval(($tpl['option_arr']['o_booking_length'] * 60)/$min_interval);
		    	    					$mark = strtotime(date('Y-m-d H:i:s', strtotime($booking['dt_to'])));
				    	    			?>
				    	    			<td colspan="<?php echo $colspan; ?>">
				    	    				<?php echo $full_name; ?><br/><?php echo $booking_detail;?>
				    	    			</td>
				    	    			<?php
				    	    			for($last = $mark; $last < $etime; $last += $min_interval)
										{
											?><td>&nbsp;</td><?php
										}
				    	    		} 
									?>
								</tr>
								<?php
							} 
							?>
						</tbody>
					</table>
		        </div>
		        <?php
			}
		}else{
			__('lblMissingParameters');
		}
	    ?>
	</body>
</html>
<script type="text/javascript">
if (window.print) {
	window.print();
}
</script>