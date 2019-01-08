<style scoped>
    .inner {
      margin-top:20px
    }
</style>

<template>
  <div>
    <Card>
      <div>
        <Tabs size="small">
          <TabPane label="基本信息">
             <div>
              <div style="margin-top:10px;margin-bottom:10px">
                <Row>
                  <Col span="2">
                    <p> <b>ID：</b> </p>
                  </Col>
                  <Col span="10">
                    <p> {{row.id}} </p>
                  </Col>
                  <Col span="2">
                    <p> <b>解析总行数：</b>  </p>
                  </Col>
                  <Col span="10">
                    <p> {{row.ParseTotalRowCounts}} </p>
                  </Col>
                </Row>

                <Row>
                  <Col span="2">
                    <p> <b>执行总次数：</b> </p>
                  </Col>
                  <Col span="10">
                    <p> {{row.MySQLTotalExecutionCounts}} </p>
                  </Col>
                  <Col span="2">
                    <p> <b>返回总行数：</b>  </p>
                  </Col>
                  <Col span="10">
                    <p> {{row.ReturnTotalRowCounts}} </p>
                  </Col>
                </Row>

                <Row>
                  <Col span="2">
                    <p> <b>执行总时长，单位：秒：</b> </p>
                  </Col>
                  <Col span="10">
                    <p> {{row.MySQLTotalExecutionTimes}} </p>
                  </Col>
                  <Col span="2">
                    <p> <b>数据库名称：</b>  </p>
                  </Col>
                  <Col span="10">
                    <p> {{row.DBName}} </p>
                  </Col>
                </Row>

                <Row>
                  <Col span="2">
                    <p> <b>问题描述：</b> </p>
                  </Col>
                  <Col span="10">
                    <p> {{row.content}} </p>
                  </Col>
                  <Col span="2">
                    <p> <b>工单状态：</b>  </p>
                  </Col>
                  <Col span="10">
                    <p v-if="row.status == 0" > <Tag color="red">待处理</Tag> </p>
                    <p v-else-if="row.status == 1" > <Tag color="green">已解决</Tag> </p>
                    <p v-else-if="row.status == 2" > <Tag color="blue">已关闭</Tag> </p>
                  </Col>
                </Row>
                <Row>
                  <Col span="2">
                    <p> <b>创建时间：</b> </p>
                  </Col>
                  <Col span="10">
                    <p> {{row.createtime}} </p>
                  </Col>
                  <Col span="2">
                    <p> <b>指定人：</b> </p>
                  </Col>
                  <Col span="10">
                    <p> {{row.distributor}} </p>
                  </Col>
                </Row>
                 <Row>
                  <Col span="2">
                    <p> <b>执行人：</b> </p>
                  </Col>
                  <Col span="10">
                    <p> {{row.executor}} </p>
                  </Col>
                  <Col span="2">
                    <p> <b>更新时间：</b> </p>
                  </Col>
                  <Col span="10">
                    <p> {{row.updatetime}} </p>
                  </Col>
                </Row>
              </div>
            </div>
          </TabPane>
          <TabPane label="SQL语句">
            <div>
              <div>
                <Row>
                  <Col span="24">
                    <Scroll height=280>
                      <div class="inner">{{ row.SQLText }}</div>
                    </Scroll>
                  </Col>
                </Row>
              </div>
            </div>
          </TabPane>
          <TabPane :label="suggestionLabel" name="suggestion">
             <div>
                <br/>
                  <Row>
                    <Col span="16">
                      <Scroll height=280>
                        <div>
                          <Table :columns="columnsSuggestion" :data="results"></Table>
                        </div>
                        <div>
                          <p></p>
                          <Page :total=counts :current=getPar.page @on-change="pageChanges" @on-page-size-change="sizeChanges"></Page>
                        </div>
                      </Scroll>
                    </Col>
                    <Col span="8">
                      <Form class="step-form" ref="checkSuggestion" :model="suggestionData" :rules="ruleSuggestionData" :label-width="100">
                        <FormItem label="问题描述：">
                          <div>{{row.content}}</div>
                        </FormItem>

                        <FormItem label="回复意见">
                          <Input v-model="formdata.replay" type="textarea" :rows="6" placeholder="请输入回复意见..."></Input>
                        </FormItem>
                        <FormItem label="操作" v-if="(identity==1 || iusername==row.distributor) && row.status !=2">
                            <Button type="primary" @click="handleCommit">回复</Button>
                        </FormItem>
                      </Form>
                    </Col>
                  </Row>
                </div>
          </TabPane>
        </Tabs>
      </div>
      <div class="inner">
        <p></p>
        <Alert show-icon>工单流</Alert>
        <Steps :current="row.status" :status="stepCurrentStatus">
          <step v-for="(item, index) in stepList" :title="item.title" :content="item.content" :key="index"> </step>
        </Steps>
      </div>
      <div class="inner" v-if="row.status == 0 && row.executor == iusername || row.status == 1 && row.distributor == iusername">
        <p></p>
        <Alert show-icon>操作</Alert>
        <Row>
          <Col span="24">
            <Dropdown v-show="showBtn" @on-click='showAction'>
              <Button type="primary">
                操作
                <Icon type="arrow-down-b"></Icon>
              </Button>
              <DropdownMenu v-if="row.status == 0" slot="list">
                <DropdownItem name='approve'>解决</DropdownItem>
              </DropdownMenu>
              <DropdownMenu v-else-if="row.status == 1 && row.distributor == iusername"  slot="list">
                <DropdownItem name='closed'>关闭</DropdownItem>
              </DropdownMenu>
            </Dropdown>
          </Col>
        </Row>
      </div>
    </Card>
    <copyRight> </copyRight>

    <Modal
        v-model="modalAction.show"
        width="450"
        title="慢查询工单操作"
        ok-text="是"
        cancel-text="否"
        @on-ok="handleAction"
        @on-cancel="cancel">
        <div>
          <center> {{modalAction.content}} </center>
        </div>
    </Modal>  

    <Modal
        v-model="stepsModal"
        width="400"
        title="流程"
        @on-cancel="cancel">
        <div>
          <Scroll height=450>
            <Timeline>
              <TimelineItem v-for="(item, index) in steps" :value="item.value" :key="index" :color="getColor(item.status)">
                <p class="time">{{ item.updatetime | formatTime }}</p>
                <p class="content">{{item.username}} <Tag :color="stepStatusMap[item.status]['color']" style="margin-left:10px">{{ stepStatusMap[item.status]['desc'] }}</Tag> </p>
              </TimelineItem>
            </Timeline>
          </Scroll>
        </div>
    </Modal>  

  </div>
</template>

<script>
    import {SqlUpdateAction} from '@/api/sql/sloworder'
    import {GetSlowDetail, SqlAction} from '@/api/sql/slowquery'
    import {GetSlowList,Putdata,SqlsAction} from '@/api/sql/slowcomment'
    import {getSqlContent, handleBadgeData} from '@/utils/sql/inception'
    import copyRight from '../my-components/public/copyright'
    import baseInfo from './components/baseInfo'
    import sqlContentInfo from './components/sqlContentInfo'
    import handleResult from './components/handleResult'
    import suggestionInfo from './components/suggestionInfo'

    export default {
      components: {copyRight, baseInfo, sqlContentInfo, handleResult, suggestionInfo},
      filters:{
        formatTime:function(value){
          if(value != '') {
            return value.slice(0,19).replace('T',' ')
          }
        },
      },
      data () {
        return {
          showHeader:false,
          page:1,
          counts:1,
          results:[],
          columnsSuggestion: [
            {
              title: '时间',
              key: 'createtime',
              width: 100,
              render: (h, params) => {
                return h('div', {}, [params.row.createtime.split('.')[0].replace('T',' ')])
              }
            },
            {
              title: '回复内容',
              width: 120,
              key: 'content'
            },
            {
              title: '回复人',
              width: 80,
              key: 'commentor'
            },
            {
              title: '邮箱',
              width: 100,
              key: 'email'
            }
          ],
          suggestionData:{
            remark:''
          },
          ruleSuggestionData:{
            remark:[{ required: true, message: '请输入回复意见', trigger: 'blur' }],
          },
          flag:false,
          stepList:[
            {"title":"待处理","content":"等待执行人处理"},
            {"title":"已解决","content":"等待指定人关闭"},
            {"title":"已关闭","content":"该工单已完成"}
          ],
          stepCurrent:0,
          stepCurrentStatus:'finish',
          res:{},
          count:'',
          suggestionLabel:(h) => {
            return h('div', [
              h('span', '回复意见'),
              h('Badge', {
                props: {
                  count: this.count
                }
              })
            ])
          },
          row:{},
          iusername:'',
          identity:0,
          getPar:{
          id:'',
          sorttype:'asc',
          sortfield:'',
          page:1,
          pagesize:10,
          search:'',
          daterange:''
        },
        formdata:{
            id:'',
            content:'',
            replay:''
        },
        updateformdata:{
            id:'',
            status:''
        },
          handle_result_check:[],
          handle_result_execute:[],
          handle_result_rollback:[],
          sqlContent:[],
          steps:[],
          stepsModal:false,
          stepStatusMap:{
            '-1':{color:'gray', desc:'终止', stepStatus:'wait'},
            0:{color:'gray', desc:'待处理', stepStatus:'wait'},
            1:{color:'green', desc:'通过', stepStatus:'finish'}, 
            2:{color:'red', desc:'驳回', stepStatus:'error'},
            3:{color:'red', desc:'放弃', stepStatus:'error'}
          },
          badgeData:{count:'', badgeStatus:''},
          modalAction: 
          {
            show:false,
            id:'',
            action:'',
            content:'',
          },
          descMap:{
            execute: {name: '解决'},
            reject: {name: '放弃'},
            rollback: {name: '回滚'},
            approve: {name: '此慢查询工单是否已解决'},
            closed: {name: '此慢查询工单已解决,确认是否要关闭'}
          }
        }
      },

      created () {
        this.handleGetSqlDetail()
        this.formdata.id =  this.$route.params.id
        this.handleGetSlowList()
      },

      computed: {
        showBtn: function () {
          if (this.row.status == 0 || this.row.status == 1) {
            return true
          } else {
            return false
          }
        }, 
        showItem: function () {
          const row = this.row
          if (row.is_manual_review == true && row.env == 'prd' && row.status != -2 && row.handleable == false) {
            return true
          } else {
            return false
          }
        },
        env: function () {
          if (this.row.env == 'prd') {
            return '生产'
          } else if (this.row.env == 'test') {
            return '测试'
          }
        },
        labelResult: function () {
          if (this.row.type == 'select') {
            return '查询结果' 
          } else {
            return 'Inception结果'
          }
        }

      },

      methods: {

        cancel () {
          this.$Message.info('Clicked cancel');
        },

        showStep () {
          this.stepsModal = true
        },

        handleCommit(){
          Putdata(this.formdata)
         .then(response => {
            console.log(response)
            let httpstatus = response.status
            if (httpstatus == 201) {
              let title = '服务器提示'
              let msg = '回复成功'
              this.notice(title, msg)
            }
            this.handleGetSlowList()
          })
        },
        getColor(status){
          return this.stepStatusMap[status]['color']
        },

        is_has_flow (row) {
          const env = row.env
          const is_manual_review = row.is_manual_review
          if (env == 'prd' && is_manual_review == true) {
            return true
          } else {
            return false
          }
        },

        handleGetList (page) {
          const params = {page:page, pagesize:10, work_order_id:this.$route.params.id}
          GetSuggestionList(params)
          .then(
            response => {
              console.log(response)
              this.res = response
              this.count = response.data.count
            }
          )
        },

        alertSuccess (title, sqlid, execute_time, affected_rows) {
          this.$Notice.success({
            title: title,
            render: h => {
              let id = h('p', {}, 'ID：' + sqlid) 
              let time = execute_time ? h('p', {}, '耗时（秒）：' + execute_time) : ''
              let rows = affected_rows ? h('p', {}, '影响的行数：' + affected_rows) : ''
              let subtags = [id, time, rows]
              return h('div', subtags)
            }
          });
        },

        alertWarning (title, paramId) {
          this.$Notice.warning({
            title: title,
            duration: 0,
            render: h => {
              let id = h('p', {}, 'ID：' + paramId) 
              let desc = h('p', {}, '具体查看工单详情[inception结果]') 
              let subTags = [id, desc]
              return h('div', subTags)
            }
          });
        },

        showAction (name) {
          this.modalAction.id = this.row.id
          this.modalAction.action = name
          this.modalAction.show = true
          this.modalAction.content = this.descMap[name].name + '?'
        },

        getStepData () {
          if (this.is_has_flow(this.row) == false ) {
            return false
          }
          let current = -1
          alert(111);
          this.stepList = []
          for (let i in this.steps) {
            const item = this.steps[i]
            const statusCode = item.status
            if (statusCode != 0 && statusCode != -1) {
              current += 1
            }

            const desc = ' [' + this.stepStatusMap[statusCode]['desc'] + '] '
            const dateTime = item.updatetime.split('.')[0].replace('T',' ')
            this.stepList.push(
              {
                title: item.group,
                content: item.username + desc + dateTime
              }
            )
          }
          this.stepCurrent = current
          let currentStatus = this.steps[current].status 
          this.stepCurrentStatus = this.stepStatusMap[currentStatus]['stepStatus']  // 数字转换成组件状态
        },


      handleGetSlowList () {
        GetSlowList(this.getPar)
        .then(response => {
          this.spinShow = false
          this.results = response.data.data
          this.counts = response.data.counts
        })
      },

      pageChanges (page) {
        this.getPar.page = page
        this.handleGetSlowList()
      },

      sizeChanges(size){
        this.getPar.pagesize = size
        this.handleGetSlowList()
      },
        parseHandleResult(handle_result){
          console.log(handle_result, typeof(handle_result))
          if (handle_result == "") {
            return
          }
          const data = JSON.parse(handle_result)
          let ret = []
          for (let i in data){
            ret.push(
              {
                value:JSON.stringify(data[i])
              }
            )
            
          }
          return ret
        },

        handleAction () {
          let action = this.modalAction.action
          if (action == 'closed') {
              this.updateformdata.status=2
          }else{
              this.updateformdata.status=1
          }
          this.updateformdata.id = this.modalAction.id
          SqlUpdateAction(this.updateformdata)
          .then(response => {
            console.log(response)
            const status = response.data.status
            if(status ==201 ){
              this.$Notice.success({
                title:"执行成功",
              });
              location.reload()
            }

            // const data = response.data.data
            // if (status == 0) {
            //   if (action == 'execute') {
            //     this.alertSuccess('执行成功', id, data.execute_time, data.affected_rows)
            //   } else if (action == 'rollback') {
            //     this.alertSuccess('回滚成功', id, '', data.affected_rows)
            //   } else if (action == 'approve') {
            //     this.alertSuccess('审批通过', id, '', '')
            //   } else if (action == 'disapprove') {
            //     this.alertSuccess('审批驳回', id, '', '')
            //   } 
            //   this.handleGetSqlDetail()
            // } else {
            //   let msg = response.data.msg
            //   this.alertWarning('任务失败', id)
            // } 
          })
        },

        handleGetSqlDetail () {
          GetSlowDetail(this.$route.params.id)
          .then(response => {
             this.row = response.data.data[0]
             this.formdata.content = this.row.content
             this.formdata.id = this.$route.params.id
             this.identity = response.data.identity
             this.iusername = response.data.username
            // this.steps = this.row.steps
            // this.handle_result_check = this.parseHandleResult(this.row.handle_result_check)
            // this.handle_result_execute = this.parseHandleResult(this.row.handle_result_execute)
            // this.handle_result_rollback = this.parseHandleResult(this.row.handle_result_rollback)
            // this.sqlContent = getSqlContent(this.row.sql_content)
            // this.badgeData = handleBadgeData(this.steps)
            // this.handleGetList(1)
            // this.getStepData()
            // this.flag = true
          })
        },

      }
    }    
</script>