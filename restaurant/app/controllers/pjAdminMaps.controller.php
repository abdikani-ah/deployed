<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminMaps extends pjAdmin
{
	public function pjActionIndex()
	{
		$this->set('has_access_use_map', pjAuth::factory()->hasAccess('use_map'));
		$this->set('has_access_delete', pjAuth::factory('pjAdminMaps', 'pjActionDeleteFile')->hasAccess());
		$this->set('has_access_manage', pjAuth::factory('pjAdminMaps', 'pjActionSaveSeat')->hasAccess());

		if (self::isPost() && $this->_post->check('map_update'))
		{
			$pjTableModel = pjTableModel::factory();

			if (isset($_FILES['path']))
			{
				$pjImage = new pjImage();
				if ($pjImage->getErrorCode() !== 200)
				{
					$pjImage->setAllowedTypes(array('image/jpg', 'image/jpeg', 'image/pjpeg'));
					if ($pjImage->load($_FILES['path']))
					{
						$resp = $pjImage->isConvertPossible();
						if ($resp['status'] === true)
						{
							$path = PJ_UPLOAD_PATH . 'maps/map.jpg';
							$pjImage->loadImage();
							$pjImage->saveImage($path);
						} else {
							pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminMaps&action=pjActionIndex&err=AM02");
						}
					} else {
						pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminMaps&action=pjActionIndex&err=AM03");
					}
				}
			}

			if ($this->_post->check('use_map') && $this->get('has_access_use_map') && $this->_post->toInt('use_map') != $this->option_arr['o_use_map'])
			{
				pjOptionModel::factory()
					->where('foreign_id', $this->getForeignId())
					->where('`key`', 'o_use_map')
					->limit(1)
					->modifyAll(array('value' => '1|0::' . $this->_post->toInt('use_map')));
			}

			if (!$this->_post->check('seats'))
			{
				$pjTableModel->reset()->truncate($pjTableModel->getTable());
			} else {
				
				if ($this->_post->has('seats_new'))
				{
					$names = array();
					foreach ($this->_post->toArray('seats_new') as $seat)
					{
						list(, , , , , $names[], , ) = explode("|", $seat);
					}
				
					if ($names && $pjTableModel->reset()->whereIn('t1.name', $names)->findCount()->getData())
					{
						pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminMaps&action=pjActionIndex&err=AM04");
					}
				}
				
				
				$seat1_arr = array_values($pjTableModel->findAll()->getDataPair('id', 'id'));
				$seat2_arr = array();
				$sdata = array();
				foreach ($this->_post->toArray('seats') as $seat)
				{
					list($id, $sdata['width'], $sdata['height'], $sdata['left'], $sdata['top'], $sdata['name'], $sdata['seats'], $sdata['minimum']) = explode("|", $seat);
					$seat2_arr[] = $id;
					$pjTableModel->reset()->set('id', $id)->modify($sdata);
				}
				$diff = array_diff($seat1_arr, $seat2_arr);
				if (count($diff) > 0)
				{
					$pjTableModel->reset()->whereIn('id', $diff)->eraseAll();
				}
			}

			if ($this->_post->check('seats_new'))
			{
				$sdata = array();
				foreach ($this->_post->toArray('seats_new') as $seat)
				{
					list(, $sdata['width'], $sdata['height'], $sdata['left'], $sdata['top'], $sdata['name'], $sdata['seats'], $sdata['minimum']) = explode("|", $seat);
					$pjTableModel->reset()->setAttributes($sdata)->insert();
				}
			}

			pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminMaps&action=pjActionIndex&err=AM01");
		}

		$this->set('seat_arr', pjTableModel::factory()->findAll()->getData());

		$this->appendCss('jasny-bootstrap.min.css', PJ_THIRD_PARTY_PATH . 'jasny/');
		$this->appendJs('jasny-bootstrap.min.js',  PJ_THIRD_PARTY_PATH . 'jasny/');
		$this->appendCss('jquery-ui.min.css', PJ_THIRD_PARTY_PATH . 'jquery_ui/');
		$this->appendJs('jquery-ui.min.js', PJ_THIRD_PARTY_PATH . 'jquery_ui/');
		$this->appendJs('pjAdminMaps.js');
	}
	
	public function pjActionGetFileUpload()
	{
		$this->setAjax(true);
	}
	
	public function pjActionDeleteFile()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'Invalid request.'));
		}
		
		$map = PJ_UPLOAD_PATH . 'maps/map.jpg';
		if (is_file($map))
		{
			@unlink($map);
			pjTableModel::factory()->truncate();

			self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'The image file has been deleted.'));
		}
		self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'The image file has not been deleted.'));
	}

	public function pjActionCheckName()
	{
		$this->setAjax(true);

		if ($this->isXHR())
		{
			if (!$this->_get->check('seat_name') || !$this->_get->toString('seat_name'))
			{
				echo 'false';
				exit;
			}
			$pjTableModel = pjTableModel::factory()->where('t1.name', $this->_get->toString('seat_name'));
			if ($this->_get->check('id') && $this->_get->toInt('id') > 0)
			{
				$pjTableModel->where('t1.id !=', $this->_get->toInt('id'));
			}
			echo $pjTableModel->findCount()->getData() == 0 ? 'true' : 'false';
		}
		exit;
	}
	
	public function pjActionSaveSeat()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing header.'));
		}
		
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'Invalid request.'));
		}
		
		if (!($this->_post->has('name', 'seats', 'minimum', 'hidden', 'map_id')
			&& !$this->_post->isEmpty('name')
			&& !$this->_post->isEmpty('seats')
			&& !$this->_post->isEmpty('minimum')
			&& !$this->_post->isEmpty('hidden')
			&& $this->_post->toInt('seats') >= $this->_post->toInt('minimum')
		))
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Missing, empty or invalid data.'));
		}
		
		$pjTableModel = pjTableModel::factory();
		
		$sdata = $resp = array();
		$sdata['name'] = $this->_post->toString('name') ?: ':NULL';
		$sdata['seats'] = $this->_post->toInt('seats') ?: ':NULL';
		$sdata['minimum'] = $this->_post->toInt('minimum') ?: ':NULL';
		list($id, $sdata['width'], $sdata['height'], $sdata['left'], $sdata['top'],) = explode("|", $this->_post->toString('hidden'));
		
		if ((int) $id > 0)
		{
			$pjTableModel->where('t1.id !=', $id);
		}
		if ($pjTableModel->where('t1.name', $this->_post->toString('name'))->findCount()->getData())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Name is already in use.'));
		}
		
		if ((int) $id > 0)
		{
			# Update
			$pjTableModel->reset()->set('id', $id)->modify($sdata);
			$resp = array('status' => 'OK', 'code' => 201, 'id' => $id);
		} else {
			# Save
			$insert_id = $pjTableModel->reset()->setAttributes($sdata)->insert()->getInsertId();
			if ($insert_id)
			{
				$resp = array('status' => 'OK', 'code' => 200, 'id' => $insert_id);
			} else {
				$resp = array('status' => 'ERR', 'code' => 104);
			}
		}
		self::jsonResponse($resp);
	}

	public function pjActionToggle()
	{
		$this->setAjax(true);
		
		if (!pjAuth::factory('pjAdminMaps', 'pjActionIndex')->hasAccess('use_map'))
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Access denied.'));
		}
		
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing header.'));
		}
		
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'Invalid request.'));
		}
		
		if (!$this->_post->has('use_map'))
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Missing, empty or invalid data.'));
		}
		
		pjOptionModel::factory()
			->where('foreign_id', $this->getForeignId())
			->where('`key`', 'o_use_map')
			->limit(1)
			->modifyAll(array('value' => '1|0::' . $this->_post->toInt('use_map')));
		
		self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Setting has been saved.'));
	}
}
?>