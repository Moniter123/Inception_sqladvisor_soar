<?php
/**
 * passport认证服务基类
 * @author: qieangel2013 2018/12/12
 *
 */

namespace SqlAudit\Base;

use SqlAudit\Base\Service;


class PassportService extends Service
{

    private static $client;
    public static $key;
    private static $_attributemap;

    /*
     *初始化
     * @param 
     * @author: qieangel2013 2018/12/12
     */

    public static function _init()
    {
        defined('SIMPLE_SAML_PATH') or define('SIMPLE_SAML_PATH', dirname(dirname(__DIR__)) . '/passport');
        require_once(SIMPLE_SAML_PATH . '/lib/_autoload.php');
        require_once(SIMPLE_SAML_PATH . '/attributemap/oid2name.php');
        $attributemap && self::$_attributemap = $attributemap;
        self::$key = \Yii::$app->params['SpKey'];
        self::$client = new \SimpleSAML\Auth\Simple(self::$key);
    }

    /**
     * 认证
     *
     * @param
     * @author: qieangel2013 2018/12/12
     *
     */
    public static function auth()
    {
        self::_init();
        $attributes = self::$client->getAttributes();
        // 已经登录 SSO
        if (!self::$client->isAuthenticated()) {
            self::$client->requireAuth();
        }
        foreach ($attributes as $k => $v) {
            if ($v[0]) {
                if (in_array($k, array_keys(self::$_attributemap))) {
                    $userinfo[self::$_attributemap[$k]] = $v[0];
                } else {
                    $userinfo[$k] = $v[0];
                }
            }
        }
        return $userinfo ? $userinfo : [];
    }

    /**
     * 退出
     *
     * @param
     * @author: qieangel2013 2018/12/12
     *
     */
    public static function logout()
    {
        self::_init();
        header('Location:' . self::$client->getLogoutURL('/'));
    }


}

