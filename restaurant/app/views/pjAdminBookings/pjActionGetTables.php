<tr>
	<td>
		<select name="table_id[]" class="form-control rbTable">
			<option value="">---</option>
			<?php
			foreach ($tpl['table_arr'] as $table)
			{
				?>
					<option value="<?php echo $table['id']; ?>">
						<?php echo stripslashes($table['name']); ?>, <?php echo $table['seats'] . ' ' . ($table['seats'] > 1 ? __('lblPeople', true, false) : __('lblPerson', true, false)); ?>
					</option>
				<?php
			}
			?>
		</select>
	</td>
	<td><a href="" class="btn btn-danger btn-outline btn-sm m-l-xs btnRemoveTable"><i class="fa fa-times"></i></a></td>
</tr>