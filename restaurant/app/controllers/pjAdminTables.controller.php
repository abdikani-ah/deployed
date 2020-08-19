<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminTables extends pjAdmin
{
	public function pjActionCheckName()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if (!$this->_get->toString('name'))
			{
				echo 'false';
				exit;
			}
			$pjTableModel = pjTableModel::factory()->where('t1.name', $this->_get->toString('name'));
			if ($this->_get->toInt('id') > 0)
			{
				$pjTableModel->where('t1.id !=', $this->_get->toInt('id'));
			}
			echo $pjTableModel->findCount()->getData() == 0 ? 'true' : 'false';
		}
		exit;
	}
	
	public function pjActionCreate()
	{
		if (self::isPost() && $this->_post->has('table_create', 'name', 'seats', 'minimum'))
		{
			$data = array();
			$data['name'] = $this->_post->toString('name') ?: ':NULL';
			$data['seats'] = $this->_post->toInt('seats') ?: ':NULL';
			$data['minimum'] = $this->_post->toInt('minimum') ?: ':NULL';
			$data['width'] = 30;
			$data['height'] = 30;
			$data['top'] = 0;
			$data['left'] = 0;

			$id = pjTableModel::factory($data)->insert()->getInsertId();
			$err = $id ? 'AT03' : 'AT04';
			
			pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminTables&action=pjActionIndex&err=$err");
		}
	}
	
	public function pjActionIndex()
	{
		if ($this->option_arr['o_use_map'] == 0)
		{
			$this->set('has_access_create', pjAuth::factory('pjAdminTables', 'pjActionCreate')->hasAccess());
			$this->set('has_access_update', pjAuth::factory('pjAdminTables', 'pjActionUpdate')->hasAccess());

			$this->appendJs('jquery.datagrid.js', PJ_FRAMEWORK_LIBS_PATH . 'pj/js/');
			$this->appendJs('pjAdminTables.js');
		}
	}
	
	public function pjActionGetTable()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$pjTableModel = pjTableModel::factory();
	
			$column = 'id';
			$direction = 'ASC';
			if ($this->_get->check('direction') && $this->_get->check('column') && in_array(strtoupper($this->_get->toString('direction')), array('ASC', 'DESC')))
			{
				$column = $this->_get->toString('column');
				$direction = strtoupper($this->_get->toString('direction'));
			}

			$total = $pjTableModel->findCount()->getData();
			$rowCount = $this->_get->toInt('rowCount') ?: 10;
			$pages = ceil($total / $rowCount);
			$page = $this->_get->toInt('page') ?: 1;
			$offset = ((int) $page - 1) * $rowCount;
			if ($page > $pages)
			{
				$page = $pages;
			}
			
			$data = $pjTableModel->select('t1.*')
				->orderBy("$column $direction")->limit($rowCount, $offset)->findAll()->getData();
				
			self::jsonResponse(compact('data', 'total', 'pages', 'page', 'rowCount', 'column', 'direction'));
		}
		exit;
	}
	
	public function pjActionUpdate()
	{
		if (self::isPost() && $this->_post->has('table_update', 'name', 'seats', 'minimum'))
		{
			$data = array();
			$data['name'] = $this->_post->toString('name') ?: ':NULL';
			$data['seats'] = $this->_post->toInt('seats') ?: ':NULL';
			$data['minimum'] = $this->_post->toInt('minimum') ?: ':NULL';

			pjTableModel::factory()->set('id', $this->_post->toInt('id'))->modify($data);

			$err = 'AT05';
			pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminTables&action=pjActionIndex&err=$err");
		}
		
		if (self::isGet() && $this->_get->has('id'))
		{
			$arr = pjTableModel::factory()->find($this->_get->toInt('id'))->getData();
			if (!$arr)
			{
				pjUtil::redirect(PJ_INSTALL_URL. "index.php?controller=pjAdminTables&action=pjActionIndex&err=AT08");
			}

			$this->set('arr', $arr);
			$this->appendJs('pjAdminTables.js');
		}
	}
	
	public function pjActionSaveTable()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'HTTP method not allowed.'));
		}

		$pjTableModel = pjTableModel::factory();
		if(in_array($this->_post->toString('column'), array('seats', 'minimum')))
		{
			$arr = $pjTableModel->find($this->_get->toInt('id'))->getData();
			if($this->_post->toString('column') == 'seats')
			{
				if($this->_post->toInt('value') >= $arr['minimum'])
				{
					$pjTableModel->reset()->where('id', $this->_get->toInt('id'))->limit(1)->modifyAll(array($this->_post->toString('column') => $this->_post->toInt('value')));
					self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Changes has been saved.'));
				}
				self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => __('lblValidateMinimum', true, true)));
			}
			if($this->_post->toString('column') == 'minimum')
			{
				if($this->_post->toInt('value') <= $arr['seats'])
				{
					$pjTableModel->reset()->where('id', $this->_get->toInt('id'))->limit(1)->modifyAll(array($this->_post->toString('column') => $this->_post->toInt('value')));
					self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Changes has been saved.'));
				}
				self::jsonResponse(array('status' => 'ERR', 'code' => 104, 'text' => __('lblValidateMinimum', true, true)));
			}
		}else{
			$pjTableModel->reset()->where('id', $this->_get->toInt('id'))->limit(1)->modifyAll(array($this->_post->toString('column') => $this->_post->toString('value')));
			self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Changes has been saved.'));
		}
	}
	
	public function pjActionDeleteTable()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'HTTP method not allowed.'));
		}
		
		if (!$this->_get->has('id'))
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Missing, empty or invalid data.'));
		}

		if (!pjTableModel::factory()->set('id', $this->_get->toInt('id'))->erase()->getAffectedRows())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Table has not been deleted.'));
		}

		self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Table has been deleted.'));
	}
	
	public function pjActionDeleteTableBulk()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'HTTP method not allowed.'));
		}
		
		if (!$this->_post->has('record') || !($record = $this->_post->toArray('record')))
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Missing, empty or invalid data.'));
		}

		if (!pjTableModel::factory()->whereIn('id', $record)->eraseAll()->getAffectedRows())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'No table has been deleted.'));
		}
		
		self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Tables has been deleted.'));
	}
}
?>