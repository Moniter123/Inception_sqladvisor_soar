#!/usr/bin/python
#-\*-coding: utf-8-\*-
import smtplib
from email.mime.text import MIMEText

class Mail(object):

    smtp_host = "smtp.exmail.qq.com"  # 设置服务器
    smtp_port = 465  # SMTP协议默认端口是25
    mail_user = "system@comjia.com"  # 用户名
    mail_pass = "RfUvW2cgdCCTkxYe"  # 授权码
    see_addr = 'http://testsqlaudit.julive.com'  # see项目访问地址

    @classmethod
    def get_desc(cls, action_type):
        desc_map = {
            '--enable-check': '提交',
            '--enable-execute': '执行',
            'approve': '审批',
            'disapprove': '驳回',
            'reject': '放弃',
            'rollback': '回滚'
        }
        return desc_map.get(action_type)

    @classmethod
    def get_mail_template(cls, to_list, action_type, sqlid, sqlcontent, personnel, note, dbname):
        #to_list.append(cls.mail_user)
        title = '{} SQL工单-{}'.format(cls.get_desc(action_type), sqlid)
        sql_html = ''
        for s in sqlcontent[0:1024].split(';'):
            if s:
                sql_html = sql_html + '<div>' + s + ';' + '</div>'
        content_html = "<span style='margin-right:20px'>{} {}</span> <a href='{}/inceptionsql/{}'>【查看详情】</a> <p>备注：{}</p> <p>数据库（生产环境）：{} </p>".format(personnel, title, cls.see_addr, sqlid, note, dbname)
        if len(sqlcontent) > 1024:
            sql_html = sql_html + '<div>' + '略... ...（内容较多，可查看详情）' + '</div>'
        return title, content_html, sql_html, to_list

    @classmethod
    def send(cls, to_list, personnel, sqlid, note, action_type, sqlcontent, dbname):  # to_list：收件人；sub：主题；content：邮件内容
        title, content_html, sql_html, to_list = cls.get_mail_template(to_list, action_type, sqlid, sqlcontent, personnel, note, dbname)
        msg = MIMEText(content_html + sql_html, _subtype='html', _charset='utf-8')  # 创建一个实例，这里设置为html格式邮件
        msg['Subject'] = '{} {} [{}]'.format(personnel, title, note)  # 设置主题
        msg['From'] = cls.mail_user
        msg['To'] = ";".join(to_list)
        try:
        	smtp = smtplib.SMTP_SSL(cls.smtp_host, cls.smtp_port)
        	#smtp.set_debuglevel(1)
        	smtp.login(cls.mail_user, cls.mail_pass)  # 登陆服务器
        	smtp.sendmail(cls.mail_user, to_list, msg.as_string())  # 发送邮件
        	smtp.quit()
        	return True
        except Exception as e:
            print(e)
            return False

print(Mail.send('zhangqiufang@julive.com', 'zqf', 1234, '56565', 'approve','测试邮件', 'v9'))
