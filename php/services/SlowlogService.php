<?php
/**
 * 慢查询日志调用api服务类
 * @author: qieangel2013 2018/12/19
 *
 */

namespace SqlAudit\Base;

use SqlAudit\Base\Service;

class SlowlogService extends Service
{

    private $rds_url='https://rds.aliyuncs.com/?';

    private $Action;

    private $DBInstanceId;

    private $endTime;

    private $startTime;

    private $Format='json';

    private $Version='2014-08-15';

    private $Signature;

    private $SignatureMethod='HMAC-SHA1';

    private $SignatureNonce;

    private $SignatureVersion='1.0';

    private $AccessKeyId;

    private $AccessKeySecret;

    private $Timestamp;

    protected $queryParameters = array();

    private $dateTimeFormat = 'Y-m-d\TH:i:s\Z';

    private $dTimeFormat = 'Y-m-d\TH:i\Z';

    private $dateFormat = 'Y-m-d\Z';

    private $method='GET';

    private $SQLId;

    private $pageSize;

    private $pageNumber;

    public function __construct()
    {
        $this->setAccessKeyId(\Yii::$app->params['AccessKeyID']);
        $this->setAccessKeySecret(\Yii::$app->params['AccessKeySecret']);
        $this->setDBInstanceId(\Yii::$app->params['DBInstanceId']);
    }

    public function getAction() {
        return $this->Action;
    }

    public function setAction($Action) {
        $this->Action = $Action;
        return $this;
    }

    public function getSQLId() {
        return $this->SQLId;
    }

    public function setSQLId($SQLId) {
        $this->SQLId = $SQLId;
        $this->queryParameters["SQLId"]=$SQLId;
        return $this;
    }

    public function getPageSize() {
        return $this->pageSize;
    }

    public function setPageSize($pageSize) {
        $this->pageSize = $pageSize;
        $this->queryParameters["PageSize"]=$pageSize;
        return $this;
    }

    public function getPageNumber() {
        return $this->pageNumber;
    }

    public function setPageNumber($pageNumber) {
        $this->pageNumber = $pageNumber;
        $this->queryParameters["PageNumber"]=$pageNumber;
        return $this;
    }

    public function getEndTime() {
        return $this->endTime;
    }

    public function setEndTime($endTime) {
        $this->Action && $this->Action=='DescribeSlowLogs'?$endTime=gmdate($this->dateFormat,strtotime($endTime)):$endTime=gmdate($this->dTimeFormat,strtotime($endTime.' 23:59:59'));
        $this->endTime = $endTime;
        $this->queryParameters["EndTime"]=$endTime;
        return $this;
    }

    public function getStartTime() {
        return $this->startTime;
    }

    public function setStartTime($startTime) {        
        $this->Action && $this->Action=='DescribeSlowLogs'?$startTime=gmdate($this->dateFormat,strtotime($startTime)):$startTime=gmdate($this->dTimeFormat,strtotime($startTime.' 00:00:00'));
        $this->startTime = $startTime;
        $this->queryParameters["StartTime"]=$startTime;
        return $this;
    }

    public function getDBInstanceId() {
        return $this->dBInstanceId;
    }

    public function setDBInstanceId($dBInstanceId) {
        $this->dBInstanceId = $dBInstanceId;
        $this->queryParameters["DBInstanceId"]=$dBInstanceId;
    }

    public function getAccessKeyId() {
        return $this->AccessKeyId;
    }

    public function setAccessKeyId($AccessKeyId) {
        $this->AccessKeyId = $AccessKeyId;
    }

    public function getAccessKeySecret() {
        return $this->AccessKeySecret;
    }

    public function setAccessKeySecret($AccessKeySecret) {
        $this->AccessKeySecret = $AccessKeySecret;
    }

    private function prepareValue($value)
    {
        if (is_bool($value)) {
            if ($value) {
                return "true";
            } else {
                return "false";
            }
        } else {
            return $value;
        }
    }

   public function composeData()
    {
        foreach ($this->queryParameters as $key => $value) {
            $apiParams[$key] = $this->prepareValue($value);
        }
        $apiParams["AccessKeyId"] = $this->getAccessKeyId();
        $apiParams["Format"] = $this->Format;
        $apiParams["SignatureMethod"] = $this->SignatureMethod;
        $apiParams["SignatureVersion"] = $this->SignatureVersion;
        $apiParams["SignatureNonce"] = md5(uniqid(mt_rand(), true));
        $apiParams["Timestamp"] = gmdate($this->dateTimeFormat);
        $apiParams["Action"] = $this->getAction();
        $apiParams["Version"] = $this->Version;
        $this->SQLId && $apiParams["SQLId"] = $this->SQLId;
        $apiParams["Signature"] = $this->computeSignature($apiParams, $this->getAccessKeySecret());
        $requestUrl = $this->rds_url;
        foreach ($apiParams as $apiParamKey => $apiParamValue) {
            $requestUrl .= "$apiParamKey=" . urlencode($apiParamValue) . "&";
        }
        return $this->GetData(substr($requestUrl, 0, -1));
    }
    
    private function computeSignature($parameters, $accessKeySecret)
    {
        ksort($parameters);
        $canonicalizedQueryString = '';
        foreach ($parameters as $key => $value) {
            $canonicalizedQueryString .= '&' . $this->percentEncode($key). '=' . $this->percentEncode($value);
        }
        $stringToSign = $this->method.'&%2F&' . $this->percentencode(substr($canonicalizedQueryString, 1));
        $signature = $this->signString($stringToSign, $accessKeySecret."&");
        return $signature;
    }

    private function signString($source, $accessSecret){
        return base64_encode(hash_hmac('sha1', $source, $accessSecret, true));
    }
    
    protected function percentEncode($str)
    {
        $res = urlencode($str);
        $res = preg_replace('/\+/', '%20', $res);
        $res = preg_replace('/\*/', '%2A', $res);
        $res = preg_replace('/%7E/', '~', $res);
        return $res;
    }

    /**
     * 名称:  请求接口获取数据
     * 参数:  string $key     接口地址
     * 返回值: array   数据;
     */

    private function GetData($url)
    {
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1) ;
        curl_setopt($ch, CURLOPT_TIMEOUT, 300);   //只需要设置一个秒的数量就可以
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_DNS_USE_GLOBAL_CACHE, false );
        curl_setopt($ch, CURLOPT_SSLVERSION, 3);
        curl_setopt($ch, CURLOPT_BINARYTRANSFER, true) ;
        $output = curl_exec($ch);
        if($output === false){ 
            if(curl_errno($ch) == CURLE_OPERATION_TIMEDOUT){   
            }else{
            }
        }
        curl_close($ch);
        if (empty($output)) {
            return ;
        }
        return $output;
    }
}

