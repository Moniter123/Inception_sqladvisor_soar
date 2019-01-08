<?php
/**
 * see项目调用api服务类
 * @author: qieangel2013 2018/12/12
 *
 */

namespace SqlAudit\Base;

use SqlAudit\Base\Service;

class SeeapiService extends Service
{

    private $token_url;
    private $user_token;
    private $user_url;
    private $auth_user;
    private $user_data = [
        "password" => "julive@",
        "is_superuser" => false,
        "username" => "test",
        "first_name" => "",
        "last_name" => "",
        "email" => "string",
        "is_staff" => true,
        "is_active" => true,
        "role" => "developer",
        "remark" => "string",
        "groups" => [2],
        "user_permissions" => []
    ];
    private $token;

    public function __construct()
    {
        $this->token_url = \Yii::$app->params['SeeapiUrl'] . '/api/api-token-auth/';
        $this->user_token = \Yii::$app->params['TokenUser'];
        $this->user_url = \Yii::$app->params['SeeapiUrl'] . '/api/account/users/';
        $this->auth_user = \Yii::$app->params['AuthUser'];
    }

    /*
     *获取token
     * @param 
     * @author: qieangel2013 2018/12/12
     */

    public function _init()
    {
        $this->token = $this->PostData($this->token_url, $this->user_token, true);
    }

    public function gettoken($username, $password = 'julive@')
    {
        return $this->PostData($this->token_url, ['username' => $username, 'password' => $password], true);
    }

    public function adduser($data)
    {
        if (!$this->token) {
            $this->_init();
        }
        $data && $this->expdata($data);
        return $this->PostData($this->user_url, $this->user_data, true, $this->token['token']);
    }

    private function expdata($data)
    {
        foreach ($this->user_data as $k => $v) {
            foreach ($data as $kk => $vv) {
                if ($k == $kk) {
                    $this->user_data[$k] = $vv;
                }
            }
        }

        if (in_array($data['username'], $this->auth_user)) {
            $this->user_data['is_superuser'] = true;
            $this->user_data['role'] = 'developer_manager';
        }

        return true;
    }

    /**
     * 名称:  请求接口提交数据
     * 参数:  string $key     接口地址
     * 参数:  array $data     提交数据
     * 参数： bool  $json    是否json提交
     * 参数： bool  $token     token值
     * 返回值: array   数据;
     */

    function PostData($url, $data, $json = false, $token = false)
    {
        $datastring = $json ? json_encode($data) : http_build_query($data);
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLINFO_HEADER_OUT, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 300);   //只需要设置一个秒的数量就可以
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSLVERSION, 3);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $datastring);
        if ($json) {
            curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                    'Content-Type: application/json; charset=utf-8',
                    'Content-Length: ' . strlen($datastring))
            );
        }
        if ($token) {
            curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                    'Content-Type: application/json; charset=utf-8',
                    'Content-Length: ' . strlen($datastring),
                    'Authorization:JWT ' . $token
                )
            );
        }
        $output = curl_exec($ch);
        if ($output === false)  //超时处理
        {
            if (curl_errno($ch) == CURLE_OPERATION_TIMEDOUT) {

            }
        }
        curl_close($ch);
        if (empty($output)) {
            return;
        }
        $result = json_decode($output, true);
        return $result;
    }


}

