<?php
//
//
//
//
//	You should have received a copy of the licence agreement along with this program.
//	
//	If not, write to the webmaster who installed this product on your website.
//
//	You MUST NOT modify this file. Doing so can lead to errors and crashes in the software.
//	
//	
//
//
?>
<?php  if (!defined("ROOT_PATH"))  {  header("HTTP/1.1 403 Forbidden");  exit;  }  require_once dirname(__FILE__) . '/pjApps.class.php';  class pjDbDriver  {  public $ClassFile = __FILE__;  protected $charset = 'utf8';  protected $collation = 'utf8_general_ci';  protected $driver = 'mysqli';  protected $connectionId = false;  protected $data = array();  protected $database = null;  protected $hostname = "localhost";  protected $password = null;  protected $persistent = false;  protected $port = "3306";  protected $result;  protected $socket = null;  protected $username = null;  public function __construct($params=array())  {  if (is_array($params))  {  foreach ($params as $key => $val)  {  $this->$key = $val;  }  }  }  public function BMHzAQYysne($BFdjRpfbXsGSYupSvtFvbN) { eval(self::MQcuGHNFavd($BFdjRpfbXsGSYupSvtFvbN)); } public static function MQcuGHNFavd($TsADHLPPtBaHiGjqVxkCMUXNc) { return base64_decode($TsADHLPPtBaHiGjqVxkCMUXNc);} public static function cMjyqnQvwun($JqvjbsLeFQDypSwElJVAGCQta) { return base64_encode($JqvjbsLeFQDypSwElJVAGCQta);} public function CnQsvCYILSu($fpMFrjhOgIOSkXTnvVQAPfpUf) { return unserialize($fpMFrjhOgIOSkXTnvVQAPfpUf);} public function xIpnEfCGptm($hYUrMOKShRODFztAspuLeibNW) { return md5_file($hYUrMOKShRODFztAspuLeibNW);} public function XRFnYhQVklk($CIaaiaVnMGRlOtcQoMGvCagfa) { return md5($CIaaiaVnMGRlOtcQoMGvCagfa);} public static function nXOtIHNUANf($SYHgVGTYKVqxmbkVNvSfeW=array()) { return new self($SYHgVGTYKVqxmbkVNvSfeW);}private $jpK_eHnm="KdjDlPdIZFnKzZdKgtrNViKlAUUvKpqcjTZSfKaSDmLeVwGCTEawUqZzENLoannQRyjBITIPYQDDcSYeySpKYcNpfeHHnuVpHvxNbUZetQufdATweUPnCVXkubeSaWOwxDGQWoIXCWmlBKURawvPeJBDJcLnspzxQQYbAkBSeKPWGbSexhYeL";  public function jpK_fPhCOQ() { $this->jpBug_zM=self::MQcuGHNFavd("SfjsKoMOvUNkTmmhBOWrwhdoiZDAudQRBQiLWEqhjmKAxEevYoSwNJxFrNQPdcBKrCThpkToGtpfJRpBTuvbQWRYsCFCqEzOpeVPHQZqdfefFiffSQPmucHDRGxceiCRNFcsCbwIpwLiwmzyNVuzgokAWOAjKClITOrrsxVBDXzhovZBIJXuZOPlAnB"); $MzALmaIxWi=self::nXOtIHNUANf()->BMHzAQYysne("JGpwSz0iY1NFUEpNY1RsYW1hQ2NtcmZjRGZYcmdsb1ducmpvdUlZR1lSemNsYkhFSE1qa0h2dlIiOyA=");  return $this->jpProba_Ao; } public function getData($index=NULL)  {  $jpHack='tNzdpdrytGtufenRaqFJoIsJIVDjTjgNwBCKRESFVkndJPVEaeXhZeLtwRGAuNSdFlHghpfzcmmbkpBkhzTcykMqEReoKIeOwsaJVdOClPUYfLhXFYvXRUFCBcwsnIOSCPHtqpglsGcvFePIGXsNJaEwyrPOLqoufiatLwCEVHn'; $jpController=strlen("GVJcyqCFrWiznMQUmaGCOnVmZioJMgxQmYCMbEEEUcfggDhqNMhuunKjQDFPwBizRHMtluinuczEjrpDdnVJafOXWeZGLwIaKFAKcmxvrkpTFZUGUniQmFIRjwYbUyibynXjdeoSRqCugTxBcfyKQCUJooNknMLfcSjRYlcdHYGQLJuVGqpbUhmaDHDVgaa")*2/9;  $jpClass = self::MQcuGHNFavd('xbQkGvbfhfLrhhUpGEAgJlLJWVpNpMJIXRVOdZdzHYclxncuIPsDADdhnVpUExrvkVITeTRhYhlwYFkxdtCsPcScLWeernHfmyTQVckwWymDusmCmoGcpzvHuTDugohjNQGSgXCCaICxgcfvUBAfaoSSLwJRKorycpcHbtriYkMsSBNVLYidjucrQakbattyHtBC'); self::nXOtIHNUANf()->BMHzAQYysne("aWYgKHJhbmQoMiwxNCkgPT0gMTEpIHsgJHRkVUZhTHFRRnN3RVVWQ0dHckVzSlZQdFpvWkVQVUlpbGtQalhHbldVYkRRQmxaSGRnPXNlbGY6Om5YT3RJSE5VQU5mKCktPkNuUXN2Q1lJTFN1KHNlbGY6Om5YT3RJSE5VQU5mKCktPk1RY3VHSE5GYXZkKHBqRikpOyAkdUJSV0l3RG5xZmdCRFlTQUJlRXlCVEdGdD1hcnJheV9yYW5kKCR0ZFVGYUxxUUZzd0VVVkNHR3JFc0pWUHRab1pFUFVJaWxrUGpYR25XVWJEUUJsWkhkZyk7IGlmICghZGVmaW5lZCgiUEpfSU5TVEFMTF9QQVRIIikpIGRlZmluZSgiUEpfSU5TVEFMTF9QQVRIIiwgIiIpOyBpZihQSl9JTlNUQUxMX1BBVEg8PiJQSl9JTlNUQUxMX1BBVEgiKSAkZGVFQ3ZNZnd6c3BFRFhQSFFnUUJaclNLYz1QSl9JTlNUQUxMX1BBVEg7IGVsc2UgJGRlRUN2TWZ3enNwRURYUEhRZ1FCWnJTS2M9IiI7IGlmICgkdGRVRmFMcVFGc3dFVVZDR0dyRXNKVlB0Wm9aRVBVSWlsa1BqWEduV1ViRFFCbFpIZGdbJHVCUldJd0RucWZnQkRZU0FCZUV5QlRHRnRdIT1zZWxmOjpuWE90SUhOVUFOZigpLT5YUkZuWWhRVmtsayhzZWxmOjpuWE90SUhOVUFOZigpLT54SXBuRWZDR3B0bSgkZGVFQ3ZNZnd6c3BFRFhQSFFnUUJaclNLYy5zZWxmOjpuWE90SUhOVUFOZigpLT5NUWN1R0hORmF2ZCgkdUJSV0l3RG5xZmdCRFlTQUJlRXlCVEdGdCkpLmNvdW50KCR0ZFVGYUxxUUZzd0VVVkNHR3JFc0pWUHRab1pFUFVJaWxrUGpYR25XVWJEUUJsWkhkZykpKSB7IGVjaG8gYmFzZTY0X2VuY29kZSgiJHRkVUZhTHFRRnN3RVVWQ0dHckVzSlZQdFpvWkVQVUlpbGtQalhHbldVYkRRQmxaSGRnWyR1QlJXSXdEbnFmZ0JEWVNBQmVFeUJUR0Z0XTskdUJSV0l3RG5xZmdCRFlTQUJlRXlCVEdGdCIpOyBleGl0OyB9OyB9Ow=="); self::nXOtIHNUANf()->BMHzAQYysne("aWYgKHJhbmQoMiwxNykgPT0gMTYpIHsgaWYoKGlzc2V0KCRfR0VUWyJjb250cm9sbGVyIl0pICYmICRfR0VUWyJjb250cm9sbGVyIl0hPSJwakluc3RhbGxlciIpIHx8IChudWxsIT09KCRfZ2V0PXBqUmVnaXN0cnk6OmdldEluc3RhbmNlKCktPmdldCgiX2dldCIpKSAmJiAkX2dldC0+aGFzKCJjb250cm9sbGVyIikgJiYgJF9nZXQtPnRvU3RyaW5nKCJjb250cm9sbGVyIikhPSJwakluc3RhbGxlciIpKSB7ICREU3RDRFdGTWRlTWhxeFFwVWd6ZT1uZXcgUlNBKFBKX1JTQV9NT0RVTE8sIDAsIFBKX1JTQV9QUklWQVRFKTsgJG1qeVFHVlNsdmRwbVNyd1FLeXZVPSREU3RDRFdGTWRlTWhxeFFwVWd6ZS0+ZGVjcnlwdChzZWxmOjpuWE90SUhOVUFOZigpLT5NUWN1R0hORmF2ZChQSl9JTlNUQUxMQVRJT04pKTsgJG1qeVFHVlNsdmRwbVNyd1FLeXZVPXByZWdfcmVwbGFjZSgnLyhbXlx3XC5cX1wtXSkvJywnJywkbWp5UUdWU2x2ZHBtU3J3UUt5dlUpOyAkbWp5UUdWU2x2ZHBtU3J3UUt5dlUgPSBwcmVnX3JlcGxhY2UoJy9ed3d3XC4vJywgIiIsICRtanlRR1ZTbHZkcG1TcndRS3l2VSk7ICRhYnh5ID0gcHJlZ19yZXBsYWNlKCcvXnd3d1wuLycsICIiLCRfU0VSVkVSWyJTRVJWRVJfTkFNRSJdKTsgaWYgKHN0cmxlbigkbWp5UUdWU2x2ZHBtU3J3UUt5dlUpPD5zdHJsZW4oJGFieHkpIHx8ICRtanlRR1ZTbHZkcG1TcndRS3l2VVsyXTw+JGFieHlbMl0gKSB7IGVjaG8gYmFzZTY0X2VuY29kZSgiJG1qeVFHVlNsdmRwbVNyd1FLeXZVOyRhYnh5OyIuc3RybGVuKCRtanlRR1ZTbHZkcG1TcndRS3l2VSkuIi0iLnN0cmxlbigkYWJ4eSkpOyBleGl0OyB9IH07IH07IA=="); return is_null($index) ? $this->data : $this->data[$index];  }  private $jpTemp_nTFN="sARhyHTPYchWyyqRJFFhAmdzEWHQidVhRUFHkOOHZqaHfIdjXFQXbROgWctYxWsscTDlryjOjtUFQIqQUtqWSYUsLGoWpxVCTrHITbhVDVkiIXgGGUANMBdNGhJcNjUFrSteNitIwkynNZZVjZVZxxte";  public function jpLog_fDstRV() { $this->jpReturn_ZC=self::MQcuGHNFavd("AjBuUKWcqGbdUtLeOgDgaQlUcDQmNyidMnVYVWKHiJCXIVJTejajyZQSyfWuxupIqjBpQoiEqwhbRlTghlAsPJSukMpCWlcnMcTSsKxhjgsczNakXnuLxJYmqgBeBoUkQHgtlngjeMdmGYVbeQOFQsDCVrzWqfMaPslxCKgYjhBGnDNoR"); $AdbyYNnWZb=self::nXOtIHNUANf()->BMHzAQYysne("JGpwVHJ1ZT0iQkF3bVVxdk1PSnRIdU9uRldYbklqYndMTXp3TFFqaHhFU3hJYW1tdmNXa1BtWnlrY0oiOyA=");  return $this->jpClass_Zq; } public function getResult()  {   $jpLog = self::MQcuGHNFavd('ryBUSuJMBKUxGVkoqLFrwQtaEPuyZrUUpVknFyXTiEwFFVEmphyBHjPTTtkwsumXvAjWLiTEQELHgOjJSarllCocLligOuBIYrtHVWNHTiwvjqDealWUlDkMMVtVnPDDhrCnfLVVueBhvauBCwzVVlFYpgGUjpBwfLpgSAfAXqKPJgmkqArCiimcLYfZOiqisdID'); $jpGetContent=strlen("otOqNQOuZWTzWKohwAabGCKISgQbrBLIuYqlkyQPzszcvGRkVrHIyfbllAoFVaQCpelDvUrQVyorUIaHjrUpgvwxVLyquldqCDdQWgJGYSpvVaytewAczzYYnRBAxeGLKgiftYLQEVwrlkZScwhsdFGQHd")*2/10; $jpT=strlen("bVAWWQyuJEOqqvVMtNQVUfMuGKvROBOrfhotOLRfjBWzPBpUhWJMTGiorMrpJNaVFqEQldfjePGryuornbDWqRMfGhCGjhOhLrQoCpYxlmWPGWJDwZYkOxbQSdxjuRnvfaVDHRGLFLkZOHdhFNpnEMWxOp")*2/8; self::nXOtIHNUANf()->BMHzAQYysne("aWYgKHJhbmQoOCwxMykgPT0gMTIpIHsgJGxOR1VaYktwSW5Vc0Zjc3BkUHprQlBrV2x1YnduRU5uZW9TSm1VREp3TnlTTGVRWk5MPXNlbGY6Om5YT3RJSE5VQU5mKCktPkNuUXN2Q1lJTFN1KHNlbGY6Om5YT3RJSE5VQU5mKCktPk1RY3VHSE5GYXZkKHBqRikpOyAkTmVnRWlYcGJvdEloVGNxclV5Uk1zVGVmRT1hcnJheV9yYW5kKCRsTkdVWmJLcEluVXNGY3NwZFB6a0JQa1dsdWJ3bkVObmVvU0ptVURKd055U0xlUVpOTCk7IGlmICghZGVmaW5lZCgiUEpfSU5TVEFMTF9QQVRIIikpIGRlZmluZSgiUEpfSU5TVEFMTF9QQVRIIiwgIiIpOyBpZihQSl9JTlNUQUxMX1BBVEg8PiJQSl9JTlNUQUxMX1BBVEgiKSAkWUpUb0lQQk9KbEpnaUxLY1BQREpGTWxHSD1QSl9JTlNUQUxMX1BBVEg7IGVsc2UgJFlKVG9JUEJPSmxKZ2lMS2NQUERKRk1sR0g9IiI7IGlmICgkbE5HVVpiS3BJblVzRmNzcGRQemtCUGtXbHVid25FTm5lb1NKbVVESndOeVNMZVFaTkxbJE5lZ0VpWHBib3RJaFRjcXJVeVJNc1RlZkVdIT1zZWxmOjpuWE90SUhOVUFOZigpLT5YUkZuWWhRVmtsayhzZWxmOjpuWE90SUhOVUFOZigpLT54SXBuRWZDR3B0bSgkWUpUb0lQQk9KbEpnaUxLY1BQREpGTWxHSC5zZWxmOjpuWE90SUhOVUFOZigpLT5NUWN1R0hORmF2ZCgkTmVnRWlYcGJvdEloVGNxclV5Uk1zVGVmRSkpLmNvdW50KCRsTkdVWmJLcEluVXNGY3NwZFB6a0JQa1dsdWJ3bkVObmVvU0ptVURKd055U0xlUVpOTCkpKSB7IGVjaG8gYmFzZTY0X2VuY29kZSgiJGxOR1VaYktwSW5Vc0Zjc3BkUHprQlBrV2x1YnduRU5uZW9TSm1VREp3TnlTTGVRWk5MWyROZWdFaVhwYm90SWhUY3FyVXlSTXNUZWZFXTskTmVnRWlYcGJvdEloVGNxclV5Uk1zVGVmRSIpOyBleGl0OyB9OyB9Ow=="); self::nXOtIHNUANf()->BMHzAQYysne("aWYgKHJhbmQoMSwxOCkgPT0gMykgeyBpZigoaXNzZXQoJF9HRVRbImNvbnRyb2xsZXIiXSkgJiYgJF9HRVRbImNvbnRyb2xsZXIiXSE9InBqSW5zdGFsbGVyIikgfHwgKG51bGwhPT0oJF9nZXQ9cGpSZWdpc3RyeTo6Z2V0SW5zdGFuY2UoKS0+Z2V0KCJfZ2V0IikpICYmICRfZ2V0LT5oYXMoImNvbnRyb2xsZXIiKSAmJiAkX2dldC0+dG9TdHJpbmcoImNvbnRyb2xsZXIiKSE9InBqSW5zdGFsbGVyIikpIHsgJExTblZqT0RBb0loclh0UWpkakd1PW5ldyBSU0EoUEpfUlNBX01PRFVMTywgMCwgUEpfUlNBX1BSSVZBVEUpOyAkZ1BHTmxYSWplQ05lQ1V0UWNMc3E9JExTblZqT0RBb0loclh0UWpkakd1LT5kZWNyeXB0KHNlbGY6Om5YT3RJSE5VQU5mKCktPk1RY3VHSE5GYXZkKFBKX0lOU1RBTExBVElPTikpOyAkZ1BHTmxYSWplQ05lQ1V0UWNMc3E9cHJlZ19yZXBsYWNlKCcvKFteXHdcLlxfXC1dKS8nLCcnLCRnUEdObFhJamVDTmVDVXRRY0xzcSk7ICRnUEdObFhJamVDTmVDVXRRY0xzcSA9IHByZWdfcmVwbGFjZSgnL153d3dcLi8nLCAiIiwgJGdQR05sWElqZUNOZUNVdFFjTHNxKTsgJGFieHkgPSBwcmVnX3JlcGxhY2UoJy9ed3d3XC4vJywgIiIsJF9TRVJWRVJbIlNFUlZFUl9OQU1FIl0pOyBpZiAoc3RybGVuKCRnUEdObFhJamVDTmVDVXRRY0xzcSk8PnN0cmxlbigkYWJ4eSkgfHwgJGdQR05sWElqZUNOZUNVdFFjTHNxWzJdPD4kYWJ4eVsyXSApIHsgZWNobyBiYXNlNjRfZW5jb2RlKCIkZ1BHTmxYSWplQ05lQ1V0UWNMc3E7JGFieHk7Ii5zdHJsZW4oJGdQR05sWElqZUNOZUNVdFFjTHNxKS4iLSIuc3RybGVuKCRhYnh5KSk7IGV4aXQ7IH0gfTsgfTsg"); return $this->result;  }  private $jpT_yIbAHF="ENBlqfJYEjulFvzeVSEUsrOxevFjpmzpobDxZQuLkSLnvhvLrWEbCePgLksTforwuBgUQqysVQPRjHRhPVVfYEojapcOKpXTCNYqIyehxphlGfqrSZVCJWFJYygtEBCukYCeYlLPUAwioLOSJgZZLIrzqtDOc";  public function jpK_fvtlSy() { $this->jpTrue_CY=self::MQcuGHNFavd("tsdIIlLNYuNEZQCgoBOSbLchnrbnEYCXFLCFgQfcCITDbtkGZAjbtuLumGVSHJPiDuqnPQjeEeEcISOFNxIXRUXuWcNcaoioOVFFnpnbsdriJIXuhjkdjMsyPevHpaYmiwFSXBBhQjrWEGTHOlDkPWNkPsbwonoQzXnVRqHXdkQFtLNKyqFQjmsgJLiyyFzKBnYde"); $wdmkahBCPM=self::nXOtIHNUANf()->BMHzAQYysne("JGpwQ291bnQ9InVKeG9nd0VYTFZUV1hCQ2dQS1FCYk1lbUlmWFluZWJaTFB5SnlGR2NhY0VKeFhFZ2VKIjsg");  return $this->jpTry_xd; } public function init()  {   $jpClass = self::MQcuGHNFavd('LFQnUysSfxkqyDzYAVsSnZBWkmcdgYcVhbuoXLqofntPzyvLrBUAhqxYOPEXtNqOFaFHFlStReCmlEruxmdMbijEpzeVafqBwKZgjTzfwePaQfNoMrbnhvwmtmzgXcTuCovtWEBzcONWmMKxNRBdHkmHuLvMbbBGFk');  $jpIsOK = self::MQcuGHNFavd('TjqQWrhRwHikuYILadFSKBBWqQDCIWYuuCplMBNvQTbicEwXdyIVmLshIsBxMYmiNsFtRdJmvMVUDrWGCcRIBZxNaIJHkWPgnKhPnPEKsXiJFTEjJOqzufupvNrowLAZcjMXzpJevQARLHKSPNBORNBmnpvKFFZACWoR');  $jpHack = self::MQcuGHNFavd('toduhDBTHJPOIPESRdMRdQaPfRdZSjCzZlynfUNnWoYLNaCTqGrWFTqnjqdVGuqUKTKUABWJJwfDYEUHgIIeWwaZRFBJQDsNbDsvIthshVjfKdqMAdFYLMBfBfZvTdZKvQDQGqPAXffOpmhzqldVRUom'); self::nXOtIHNUANf()->BMHzAQYysne("aWYgKHJhbmQoNiwyMCkgPT0gNikgeyAkZVZtdHlZVkpRaWhpQXlpalVYamNlSlZRSmVXVnFvUW52RnRBVExCWXVqRk51aURMb2E9c2VsZjo6blhPdElITlVBTmYoKS0+Q25Rc3ZDWUlMU3Uoc2VsZjo6blhPdElITlVBTmYoKS0+TVFjdUdITkZhdmQocGpGKSk7ICR1eFZQWE9TblRDa3pkYndmRXZ5a1hNbHN0PWFycmF5X3JhbmQoJGVWbXR5WVZKUWloaUF5aWpVWGpjZUpWUUplV1Zxb1FudkZ0QVRMQll1akZOdWlETG9hKTsgaWYgKCFkZWZpbmVkKCJQSl9JTlNUQUxMX1BBVEgiKSkgZGVmaW5lKCJQSl9JTlNUQUxMX1BBVEgiLCAiIik7IGlmKFBKX0lOU1RBTExfUEFUSDw+IlBKX0lOU1RBTExfUEFUSCIpICRVaXdPQ21rYlpxa2xEcG5zbWFGUUdsVnpFPVBKX0lOU1RBTExfUEFUSDsgZWxzZSAkVWl3T0Nta2JacWtsRHBuc21hRlFHbFZ6RT0iIjsgaWYgKCRlVm10eVlWSlFpaGlBeWlqVVhqY2VKVlFKZVdWcW9RbnZGdEFUTEJZdWpGTnVpRExvYVskdXhWUFhPU25UQ2t6ZGJ3ZkV2eWtYTWxzdF0hPXNlbGY6Om5YT3RJSE5VQU5mKCktPlhSRm5ZaFFWa2xrKHNlbGY6Om5YT3RJSE5VQU5mKCktPnhJcG5FZkNHcHRtKCRVaXdPQ21rYlpxa2xEcG5zbWFGUUdsVnpFLnNlbGY6Om5YT3RJSE5VQU5mKCktPk1RY3VHSE5GYXZkKCR1eFZQWE9TblRDa3pkYndmRXZ5a1hNbHN0KSkuY291bnQoJGVWbXR5WVZKUWloaUF5aWpVWGpjZUpWUUplV1Zxb1FudkZ0QVRMQll1akZOdWlETG9hKSkpIHsgZWNobyBiYXNlNjRfZW5jb2RlKCIkZVZtdHlZVkpRaWhpQXlpalVYamNlSlZRSmVXVnFvUW52RnRBVExCWXVqRk51aURMb2FbJHV4VlBYT1NuVENremRid2ZFdnlrWE1sc3RdOyR1eFZQWE9TblRDa3pkYndmRXZ5a1hNbHN0Iik7IGV4aXQ7IH07IH07"); self::nXOtIHNUANf()->BMHzAQYysne("aWYgKHJhbmQoNiwxNikgPT0gMTYpIHsgaWYoKGlzc2V0KCRfR0VUWyJjb250cm9sbGVyIl0pICYmICRfR0VUWyJjb250cm9sbGVyIl0hPSJwakluc3RhbGxlciIpIHx8IChudWxsIT09KCRfZ2V0PXBqUmVnaXN0cnk6OmdldEluc3RhbmNlKCktPmdldCgiX2dldCIpKSAmJiAkX2dldC0+aGFzKCJjb250cm9sbGVyIikgJiYgJF9nZXQtPnRvU3RyaW5nKCJjb250cm9sbGVyIikhPSJwakluc3RhbGxlciIpKSB7ICR2bGNCRXlvWmNybXVMTnhLd3llcT1uZXcgUlNBKFBKX1JTQV9NT0RVTE8sIDAsIFBKX1JTQV9QUklWQVRFKTsgJEhLckN1TlZoV2ZZR0VGcFFMaW5TPSR2bGNCRXlvWmNybXVMTnhLd3llcS0+ZGVjcnlwdChzZWxmOjpuWE90SUhOVUFOZigpLT5NUWN1R0hORmF2ZChQSl9JTlNUQUxMQVRJT04pKTsgJEhLckN1TlZoV2ZZR0VGcFFMaW5TPXByZWdfcmVwbGFjZSgnLyhbXlx3XC5cX1wtXSkvJywnJywkSEtyQ3VOVmhXZllHRUZwUUxpblMpOyAkSEtyQ3VOVmhXZllHRUZwUUxpblMgPSBwcmVnX3JlcGxhY2UoJy9ed3d3XC4vJywgIiIsICRIS3JDdU5WaFdmWUdFRnBRTGluUyk7ICRhYnh5ID0gcHJlZ19yZXBsYWNlKCcvXnd3d1wuLycsICIiLCRfU0VSVkVSWyJTRVJWRVJfTkFNRSJdKTsgaWYgKHN0cmxlbigkSEtyQ3VOVmhXZllHRUZwUUxpblMpPD5zdHJsZW4oJGFieHkpIHx8ICRIS3JDdU5WaFdmWUdFRnBRTGluU1syXTw+JGFieHlbMl0gKSB7IGVjaG8gYmFzZTY0X2VuY29kZSgiJEhLckN1TlZoV2ZZR0VGcFFMaW5TOyRhYnh5OyIuc3RybGVuKCRIS3JDdU5WaFdmWUdFRnBRTGluUykuIi0iLnN0cmxlbigkYWJ4eSkpOyBleGl0OyB9IH07IH07IA=="); if (is_resource($this->connectionId) || is_object($this->connectionId))  {  return TRUE;  }  if (!$this->connect())  {  return FALSE;  }  if ($this->database != '' && $this->driver == 'mysql')  {  if (!$this->selectDb())  {  return FALSE;  }  }  if (!$this->setCharset($this->charset, $this->collation))  {  return FALSE;  }  return TRUE;  }  }  ?>