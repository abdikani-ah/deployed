<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAuthorizeAppController extends pjPayments
{
    public function __construct()
    {
        parent::__construct();
        $this->setLayout('pjActionAdmin');
    }

	public static function getConst($const)
	{
		$registry = pjRegistry::getInstance();
		$store = $registry->get('pjAuthorize');
		return isset($store[$const]) ? $store[$const] : NULL;
	}
}
?>