<?php
/**
 *.
 * User: qieangel2013
 * Date: 2018/12/20
 * Time: 14:35
 */

namespace console\controllers;

use console\models\slowquery_slowlog;
use console\models\slowquery_slowrecord;
use SqlAudit\Base\SeeapiService;
use SqlAudit\Base\SlowlogService;
use yii;

class IndexController extends \yii\console\Controller
{
    private $slow_map = [
              'DescribeSlowLogs'=>[
                  'class' =>'console\models\slowquery_slowlog',
                  'log'   =>'SQLSlowLog'
              ],              
              'DescribeSlowLogRecords'=>[
                  'class' =>'console\models\slowquery_slowrecord',
                  'log'   =>'SQLSlowRecord'
              ]
    ];
    private function sortKeyData($fields,$data){
        $result = [];
        foreach ($fields as $v) {
            foreach ($data as $kk => $vv) {
                if($v==$kk){
                    $result[$v]=$vv;
                }
            }
        }
        return $result;
    }

    private function composeInsertData(&$data,$slowtype){
        $sql_id_data=[];
        $fields_slowlog=(new $this->slow_map[$slowtype]['class'])->attributes();
        $fields_slowlog && array_shift($fields_slowlog);
        if($data){
            foreach ($data as &$v) {
                if ($slowtype=='DescribeSlowLogs'){
                    $v['CreateTime'] = date('Y-m-d',strtotime($v['CreateTime']));
                    $data_tmp[] = $this->sortKeyData($fields_slowlog,$v);
                    $sqlid[] = $v['SQLId'];
                }else{
                    $timetmp = strtotime($v['ExecutionStartTime']);
                    $v['ExecutionStartTime'] = date('Y-m-d H:i:s',$timetmp);
                    $data_tmp[]=array_merge(['SQLId' => $timetmp],$this->sortKeyData($fields_slowlog,$v));
                    $sqlid[] = $timetmp;
                }    
            }
       }
       $sqlid && $sqlid = array_unique($sqlid);
        //去除重复数据
        $sqlid && $sqlid_tmp = $this->slow_map[$slowtype]['class']::getsqlidexits($sqlid);
        $sqlid_diff = isset($sqlid_tmp) && $sqlid_tmp ? array_diff($sqlid,$sqlid_tmp) : $sqlid;
        if(isset($sqlid_diff)){
            foreach ($sqlid_diff as $m => $n) {
                foreach ($data_tmp as $vv) {
                    if($n==$vv['SQLId']){
                        $sql_id_data[]=$vv;
                    }
                }
            }
        }
       return $sql_id_data;
    }

    private function batchInsert($slowlog,$startstr,$endstr,$data,$slowtype){
       $data && $insertData = $this->composeInsertData($data,$slowtype);
        isset($insertData) && $insertData && $this->slow_map[$slowtype]['class']::batchInsert($insertData);
    }

    private function pageData($Page,$PageSize,$startstr,$endstr,$slowlog,$slowtype='DescribeSlowLogs'){
        $result = json_decode($slowlog->setAction($slowtype)->setStartTime($startstr)->setEndTime($endstr)->setPageSize($PageSize)->setPageNumber($Page)->composeData(),true);
        if(isset($result['Items'][$this->slow_map[$slowtype]['log']])){
            echo $this->slow_map[$slowtype]['log'].'在第'.$Page.'页获取总条数为：'.count($result['Items'][$this->slow_map[$slowtype]['log']]).'条!'.PHP_EOL;
        }
        isset($result['Items'][$this->slow_map[$slowtype]['log']]) && $result['Items'][$this->slow_map[$slowtype]['log']] && $this->batchInsert($slowlog,$startstr,$endstr,$result['Items'][$this->slow_map[$slowtype]['log']],$slowtype);
        return $result;
    }

    public function actionRecord($startstr='',$endstr=''){
       $slowlog = new SlowlogService;
       if($startstr=='' && $endstr==''){
          $startstr = date("Y-m-d");
          $endstr = date("Y-m-d",strtotime("+1 day"));
       }
       $Page = 1;
       $PageSize =100;
       $result = $this->pageData($Page,$PageSize,$startstr,$endstr,$slowlog,'DescribeSlowLogRecords');
       if(isset($result['TotalRecordCount']) && $result['TotalRecordCount']>($Page * $PageSize)){
            $page_total=ceil($result['TotalRecordCount']/$result['PageRecordCount']);
            echo 'slowlogRecord开始执行 '.date('Y-m-d H:i:s').'!'.PHP_EOL;
            echo 'slowlogRecord总页数'.$page_total.'!'.PHP_EOL;
            echo 'slowlogRecord获取第'.$Page.'页成功!'.PHP_EOL;
            for ($i=0; $i <$page_total-1; $i++) { 
                $Page++;
                echo 'slowlogRecord获取第'.$Page.'页成功!'.PHP_EOL;
                $this->pageData($Page,$PageSize,$startstr,$endstr,$slowlog,'DescribeSlowLogRecords');
            }
       }
       echo 'slowlogRecord succ'.PHP_EOL;
       exit;
    }

    public function actionIndex($startstr='',$endstr=''){
       $slowlog = new SlowlogService;
       if($startstr=='' && $endstr==''){
          $startstr = date("Y-m-d");
          $endstr = date("Y-m-d",strtotime("+1 day"));
       }
       $Page = 1;
       $PageSize =30;
       $result = $this->pageData($Page,$PageSize,$startstr,$endstr,$slowlog);
       if(isset($result['TotalRecordCount']) && $result['TotalRecordCount']>($Page * $PageSize)){
            $page_total=ceil($result['TotalRecordCount']/$result['PageRecordCount']);
            echo 'slowlog开始执行 '.date('Y-m-d H:i:s').'!'.PHP_EOL;
            echo 'slowlog总页数'.$page_total.'!'.PHP_EOL;
            echo 'slowlog获取第'.$Page.'页成功!'.PHP_EOL;
            for ($i=0; $i <$page_total-1; $i++) { 
                $Page++;
                echo 'slowlog获取第'.$Page.'页成功!'.PHP_EOL;
                $this->pageData($Page,$PageSize,$startstr,$endstr,$slowlog);
            }
       }
       echo 'slowlog succ'.PHP_EOL;
       exit;
    }

    public function actionDel($days=60,$startstr='',$endstr=''){
       if($startstr=='' && $endstr==''){
          $endstr = date("Y-m-d",strtotime("-".$days." day"));
       }
       $this->slow_map['DescribeSlowLogs']['class']::deldata($startstr,$endstr);
       echo 'slowlog删除数据成功！'.PHP_EOL;
       $this->slow_map['DescribeSlowLogRecords']['class']::deldata($startstr,$endstr);
       echo 'slowlogRecord删除数据成功！'.PHP_EOL;
       echo 'del succ'.PHP_EOL;
       exit;
    }



}