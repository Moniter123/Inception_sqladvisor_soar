/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : sqlweb

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2018-12-13 14:23:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `account_user`
-- ----------------------------
DROP TABLE IF EXISTS `account_user`;
CREATE TABLE `account_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `role` varchar(32) NOT NULL,
  `remark` varchar(128) NOT NULL,
  `admin_mail_id` int(11) DEFAULT NULL,
  `leader_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `account_user_admin_mail_id_48d44ad0_fk_account_user_id` (`admin_mail_id`),
  KEY `account_user_leader_id_71d1273b_fk_account_user_id` (`leader_id`),
  CONSTRAINT `account_user_admin_mail_id_48d44ad0_fk_account_user_id` FOREIGN KEY (`admin_mail_id`) REFERENCES `account_user` (`id`),
  CONSTRAINT `account_user_leader_id_71d1273b_fk_account_user_id` FOREIGN KEY (`leader_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_user
-- ----------------------------
INSERT INTO `account_user` VALUES ('1', 'pbkdf2_sha256$100000$OLDhGMw3geoz$qkNJ5sJcIAae0Y4CowwUaDHD7E/6Us5kYPrmhQ2/CSg=', null, '1', 'admin', '', '', 'admin@domain.com', '1', '1', '2018-12-13 11:48:45.010683', 'developer', '', null, null);

-- ----------------------------
-- Table structure for `account_user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `account_user_groups`;
CREATE TABLE `account_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_user_groups_user_id_group_id_4d09af3e_uniq` (`user_id`,`group_id`),
  KEY `account_user_groups_group_id_6c71f749_fk_auth_group_id` (`group_id`),
  CONSTRAINT `account_user_groups_group_id_6c71f749_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `account_user_groups_user_id_14345e7b_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `account_user_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `account_user_user_permissions`;
CREATE TABLE `account_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_user_user_permis_user_id_permission_id_48bdd28b_uniq` (`user_id`,`permission_id`),
  KEY `account_user_user_pe_permission_id_66c44191_fk_auth_perm` (`permission_id`),
  CONSTRAINT `account_user_user_pe_permission_id_66c44191_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `account_user_user_pe_user_id_cc42d270_fk_account_u` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES ('2', '研发中心');
INSERT INTO `auth_group` VALUES ('1', '管理员');

-- ----------------------------
-- Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
INSERT INTO `auth_group_permissions` VALUES ('1', '1', '1');
INSERT INTO `auth_group_permissions` VALUES ('2', '1', '2');
INSERT INTO `auth_group_permissions` VALUES ('3', '1', '3');
INSERT INTO `auth_group_permissions` VALUES ('4', '1', '4');
INSERT INTO `auth_group_permissions` VALUES ('5', '1', '5');
INSERT INTO `auth_group_permissions` VALUES ('6', '1', '6');
INSERT INTO `auth_group_permissions` VALUES ('7', '1', '7');
INSERT INTO `auth_group_permissions` VALUES ('8', '1', '8');
INSERT INTO `auth_group_permissions` VALUES ('9', '1', '9');
INSERT INTO `auth_group_permissions` VALUES ('10', '1', '10');
INSERT INTO `auth_group_permissions` VALUES ('11', '1', '11');
INSERT INTO `auth_group_permissions` VALUES ('12', '1', '12');
INSERT INTO `auth_group_permissions` VALUES ('13', '1', '13');
INSERT INTO `auth_group_permissions` VALUES ('14', '1', '14');
INSERT INTO `auth_group_permissions` VALUES ('15', '1', '15');
INSERT INTO `auth_group_permissions` VALUES ('16', '1', '16');
INSERT INTO `auth_group_permissions` VALUES ('17', '1', '17');
INSERT INTO `auth_group_permissions` VALUES ('18', '1', '18');
INSERT INTO `auth_group_permissions` VALUES ('19', '1', '19');
INSERT INTO `auth_group_permissions` VALUES ('20', '1', '20');
INSERT INTO `auth_group_permissions` VALUES ('21', '1', '21');
INSERT INTO `auth_group_permissions` VALUES ('22', '1', '22');
INSERT INTO `auth_group_permissions` VALUES ('23', '1', '23');
INSERT INTO `auth_group_permissions` VALUES ('24', '1', '24');
INSERT INTO `auth_group_permissions` VALUES ('25', '1', '25');
INSERT INTO `auth_group_permissions` VALUES ('26', '1', '26');
INSERT INTO `auth_group_permissions` VALUES ('27', '1', '27');
INSERT INTO `auth_group_permissions` VALUES ('28', '1', '28');
INSERT INTO `auth_group_permissions` VALUES ('29', '1', '29');
INSERT INTO `auth_group_permissions` VALUES ('30', '1', '30');
INSERT INTO `auth_group_permissions` VALUES ('31', '1', '31');
INSERT INTO `auth_group_permissions` VALUES ('32', '1', '32');
INSERT INTO `auth_group_permissions` VALUES ('33', '1', '33');
INSERT INTO `auth_group_permissions` VALUES ('34', '1', '34');
INSERT INTO `auth_group_permissions` VALUES ('35', '1', '35');
INSERT INTO `auth_group_permissions` VALUES ('36', '1', '36');
INSERT INTO `auth_group_permissions` VALUES ('37', '1', '37');
INSERT INTO `auth_group_permissions` VALUES ('38', '1', '38');
INSERT INTO `auth_group_permissions` VALUES ('39', '1', '39');
INSERT INTO `auth_group_permissions` VALUES ('40', '1', '40');
INSERT INTO `auth_group_permissions` VALUES ('41', '1', '41');
INSERT INTO `auth_group_permissions` VALUES ('42', '1', '42');
INSERT INTO `auth_group_permissions` VALUES ('43', '1', '43');
INSERT INTO `auth_group_permissions` VALUES ('44', '1', '44');
INSERT INTO `auth_group_permissions` VALUES ('45', '1', '45');
INSERT INTO `auth_group_permissions` VALUES ('46', '1', '46');
INSERT INTO `auth_group_permissions` VALUES ('47', '1', '47');
INSERT INTO `auth_group_permissions` VALUES ('48', '1', '48');
INSERT INTO `auth_group_permissions` VALUES ('49', '1', '49');
INSERT INTO `auth_group_permissions` VALUES ('50', '1', '50');
INSERT INTO `auth_group_permissions` VALUES ('51', '1', '51');
INSERT INTO `auth_group_permissions` VALUES ('52', '1', '52');
INSERT INTO `auth_group_permissions` VALUES ('53', '1', '53');
INSERT INTO `auth_group_permissions` VALUES ('54', '1', '54');
INSERT INTO `auth_group_permissions` VALUES ('55', '1', '55');
INSERT INTO `auth_group_permissions` VALUES ('56', '1', '56');
INSERT INTO `auth_group_permissions` VALUES ('57', '1', '57');
INSERT INTO `auth_group_permissions` VALUES ('58', '1', '58');
INSERT INTO `auth_group_permissions` VALUES ('59', '1', '59');
INSERT INTO `auth_group_permissions` VALUES ('60', '1', '60');
INSERT INTO `auth_group_permissions` VALUES ('61', '1', '61');
INSERT INTO `auth_group_permissions` VALUES ('62', '1', '62');
INSERT INTO `auth_group_permissions` VALUES ('63', '1', '63');
INSERT INTO `auth_group_permissions` VALUES ('64', '1', '64');
INSERT INTO `auth_group_permissions` VALUES ('65', '1', '65');
INSERT INTO `auth_group_permissions` VALUES ('66', '1', '66');
INSERT INTO `auth_group_permissions` VALUES ('67', '1', '67');
INSERT INTO `auth_group_permissions` VALUES ('68', '1', '68');
INSERT INTO `auth_group_permissions` VALUES ('69', '1', '69');
INSERT INTO `auth_group_permissions` VALUES ('70', '1', '70');
INSERT INTO `auth_group_permissions` VALUES ('71', '1', '71');
INSERT INTO `auth_group_permissions` VALUES ('72', '1', '72');
INSERT INTO `auth_group_permissions` VALUES ('73', '1', '73');
INSERT INTO `auth_group_permissions` VALUES ('74', '1', '74');
INSERT INTO `auth_group_permissions` VALUES ('75', '1', '75');
INSERT INTO `auth_group_permissions` VALUES ('76', '1', '76');
INSERT INTO `auth_group_permissions` VALUES ('77', '1', '77');
INSERT INTO `auth_group_permissions` VALUES ('78', '1', '78');
INSERT INTO `auth_group_permissions` VALUES ('79', '2', '13');
INSERT INTO `auth_group_permissions` VALUES ('80', '2', '14');
INSERT INTO `auth_group_permissions` VALUES ('81', '2', '15');

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('11', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('13', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('14', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('16', 'Can add crontab', '6', 'add_crontabschedule');
INSERT INTO `auth_permission` VALUES ('17', 'Can change crontab', '6', 'change_crontabschedule');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete crontab', '6', 'delete_crontabschedule');
INSERT INTO `auth_permission` VALUES ('19', 'Can add interval', '7', 'add_intervalschedule');
INSERT INTO `auth_permission` VALUES ('20', 'Can change interval', '7', 'change_intervalschedule');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete interval', '7', 'delete_intervalschedule');
INSERT INTO `auth_permission` VALUES ('22', 'Can add periodic task', '8', 'add_periodictask');
INSERT INTO `auth_permission` VALUES ('23', 'Can change periodic task', '8', 'change_periodictask');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete periodic task', '8', 'delete_periodictask');
INSERT INTO `auth_permission` VALUES ('25', 'Can add periodic tasks', '9', 'add_periodictasks');
INSERT INTO `auth_permission` VALUES ('26', 'Can change periodic tasks', '9', 'change_periodictasks');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete periodic tasks', '9', 'delete_periodictasks');
INSERT INTO `auth_permission` VALUES ('28', 'Can add task state', '10', 'add_taskmeta');
INSERT INTO `auth_permission` VALUES ('29', 'Can change task state', '10', 'change_taskmeta');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete task state', '10', 'delete_taskmeta');
INSERT INTO `auth_permission` VALUES ('31', 'Can add saved group result', '11', 'add_tasksetmeta');
INSERT INTO `auth_permission` VALUES ('32', 'Can change saved group result', '11', 'change_tasksetmeta');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete saved group result', '11', 'delete_tasksetmeta');
INSERT INTO `auth_permission` VALUES ('34', 'Can add task', '12', 'add_taskstate');
INSERT INTO `auth_permission` VALUES ('35', 'Can change task', '12', 'change_taskstate');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete task', '12', 'delete_taskstate');
INSERT INTO `auth_permission` VALUES ('37', 'Can add worker', '13', 'add_workerstate');
INSERT INTO `auth_permission` VALUES ('38', 'Can change worker', '13', 'change_workerstate');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete worker', '13', 'delete_workerstate');
INSERT INTO `auth_permission` VALUES ('40', 'Can add user', '14', 'add_user');
INSERT INTO `auth_permission` VALUES ('41', 'Can change user', '14', 'change_user');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete user', '14', 'delete_user');
INSERT INTO `auth_permission` VALUES ('43', 'Can add auth rules', '15', 'add_authrules');
INSERT INTO `auth_permission` VALUES ('44', 'Can change auth rules', '15', 'change_authrules');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete auth rules', '15', 'delete_authrules');
INSERT INTO `auth_permission` VALUES ('46', 'Can add cluster', '16', 'add_cluster');
INSERT INTO `auth_permission` VALUES ('47', 'Can change cluster', '16', 'change_cluster');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete cluster', '16', 'delete_cluster');
INSERT INTO `auth_permission` VALUES ('49', 'Can add dbconf', '17', 'add_dbconf');
INSERT INTO `auth_permission` VALUES ('50', 'Can change dbconf', '17', 'change_dbconf');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete dbconf', '17', 'delete_dbconf');
INSERT INTO `auth_permission` VALUES ('52', 'Can add forbidden words', '18', 'add_forbiddenwords');
INSERT INTO `auth_permission` VALUES ('53', 'Can change forbidden words', '18', 'change_forbiddenwords');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete forbidden words', '18', 'delete_forbiddenwords');
INSERT INTO `auth_permission` VALUES ('55', 'Can add inception connection', '19', 'add_inceptionconnection');
INSERT INTO `auth_permission` VALUES ('56', 'Can change inception connection', '19', 'change_inceptionconnection');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete inception connection', '19', 'delete_inceptionconnection');
INSERT INTO `auth_permission` VALUES ('58', 'Can add inception variables', '20', 'add_inceptionvariables');
INSERT INTO `auth_permission` VALUES ('59', 'Can change inception variables', '20', 'change_inceptionvariables');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete inception variables', '20', 'delete_inceptionvariables');
INSERT INTO `auth_permission` VALUES ('61', 'Can add inceptsql', '21', 'add_inceptsql');
INSERT INTO `auth_permission` VALUES ('62', 'Can change inceptsql', '21', 'change_inceptsql');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete inceptsql', '21', 'delete_inceptsql');
INSERT INTO `auth_permission` VALUES ('64', 'Can add mail actions', '22', 'add_mailactions');
INSERT INTO `auth_permission` VALUES ('65', 'Can change mail actions', '22', 'change_mailactions');
INSERT INTO `auth_permission` VALUES ('66', 'Can delete mail actions', '22', 'delete_mailactions');
INSERT INTO `auth_permission` VALUES ('67', 'Can add strategy', '23', 'add_strategy');
INSERT INTO `auth_permission` VALUES ('68', 'Can change strategy', '23', 'change_strategy');
INSERT INTO `auth_permission` VALUES ('69', 'Can delete strategy', '23', 'delete_strategy');
INSERT INTO `auth_permission` VALUES ('70', 'Can add suggestion', '24', 'add_suggestion');
INSERT INTO `auth_permission` VALUES ('71', 'Can change suggestion', '24', 'change_suggestion');
INSERT INTO `auth_permission` VALUES ('72', 'Can delete suggestion', '24', 'delete_suggestion');
INSERT INTO `auth_permission` VALUES ('73', 'Can add step', '25', 'add_step');
INSERT INTO `auth_permission` VALUES ('74', 'Can change step', '25', 'change_step');
INSERT INTO `auth_permission` VALUES ('75', 'Can delete step', '25', 'delete_step');
INSERT INTO `auth_permission` VALUES ('76', 'Can add workorder', '26', 'add_workorder');
INSERT INTO `auth_permission` VALUES ('77', 'Can change workorder', '26', 'change_workorder');
INSERT INTO `auth_permission` VALUES ('78', 'Can delete workorder', '26', 'delete_workorder');

-- ----------------------------
-- Table structure for `celery_taskmeta`
-- ----------------------------
DROP TABLE IF EXISTS `celery_taskmeta`;
CREATE TABLE `celery_taskmeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `result` longtext,
  `date_done` datetime(6) NOT NULL,
  `traceback` longtext,
  `hidden` tinyint(1) NOT NULL,
  `meta` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `celery_taskmeta_hidden_23fd02dc` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of celery_taskmeta
-- ----------------------------

-- ----------------------------
-- Table structure for `celery_tasksetmeta`
-- ----------------------------
DROP TABLE IF EXISTS `celery_tasksetmeta`;
CREATE TABLE `celery_tasksetmeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskset_id` varchar(255) NOT NULL,
  `result` longtext NOT NULL,
  `date_done` datetime(6) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `taskset_id` (`taskset_id`),
  KEY `celery_tasksetmeta_hidden_593cfc24` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of celery_tasksetmeta
-- ----------------------------

-- ----------------------------
-- Table structure for `django_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_account_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('14', 'account', 'user');
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('6', 'djcelery', 'crontabschedule');
INSERT INTO `django_content_type` VALUES ('7', 'djcelery', 'intervalschedule');
INSERT INTO `django_content_type` VALUES ('8', 'djcelery', 'periodictask');
INSERT INTO `django_content_type` VALUES ('9', 'djcelery', 'periodictasks');
INSERT INTO `django_content_type` VALUES ('10', 'djcelery', 'taskmeta');
INSERT INTO `django_content_type` VALUES ('11', 'djcelery', 'tasksetmeta');
INSERT INTO `django_content_type` VALUES ('12', 'djcelery', 'taskstate');
INSERT INTO `django_content_type` VALUES ('13', 'djcelery', 'workerstate');
INSERT INTO `django_content_type` VALUES ('5', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('15', 'sqlmng', 'authrules');
INSERT INTO `django_content_type` VALUES ('16', 'sqlmng', 'cluster');
INSERT INTO `django_content_type` VALUES ('17', 'sqlmng', 'dbconf');
INSERT INTO `django_content_type` VALUES ('18', 'sqlmng', 'forbiddenwords');
INSERT INTO `django_content_type` VALUES ('19', 'sqlmng', 'inceptionconnection');
INSERT INTO `django_content_type` VALUES ('20', 'sqlmng', 'inceptionvariables');
INSERT INTO `django_content_type` VALUES ('21', 'sqlmng', 'inceptsql');
INSERT INTO `django_content_type` VALUES ('22', 'sqlmng', 'mailactions');
INSERT INTO `django_content_type` VALUES ('23', 'sqlmng', 'strategy');
INSERT INTO `django_content_type` VALUES ('24', 'sqlmng', 'suggestion');
INSERT INTO `django_content_type` VALUES ('25', 'workflow', 'step');
INSERT INTO `django_content_type` VALUES ('26', 'workflow', 'workorder');

-- ----------------------------
-- Table structure for `django_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2018-12-13 11:46:45.405851');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0002_remove_content_type_name', '2018-12-13 11:46:45.534624');
INSERT INTO `django_migrations` VALUES ('3', 'auth', '0001_initial', '2018-12-13 11:46:45.952598');
INSERT INTO `django_migrations` VALUES ('4', 'auth', '0002_alter_permission_name_max_length', '2018-12-13 11:46:46.017331');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0003_alter_user_email_max_length', '2018-12-13 11:46:46.057999');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0004_alter_user_username_opts', '2018-12-13 11:46:46.091742');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0005_alter_user_last_login_null', '2018-12-13 11:46:46.125629');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0006_require_contenttypes_0002', '2018-12-13 11:46:46.133975');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0007_alter_validators_add_error_messages', '2018-12-13 11:46:46.174431');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0008_alter_user_username_max_length', '2018-12-13 11:46:46.219157');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0009_alter_user_last_name_max_length', '2018-12-13 11:46:46.253377');
INSERT INTO `django_migrations` VALUES ('12', 'account', '0001_initial', '2018-12-13 11:46:46.780497');
INSERT INTO `django_migrations` VALUES ('13', 'admin', '0001_initial', '2018-12-13 11:46:46.963829');
INSERT INTO `django_migrations` VALUES ('14', 'admin', '0002_logentry_remove_auto_add', '2018-12-13 11:46:47.013927');
INSERT INTO `django_migrations` VALUES ('15', 'djcelery', '0001_initial', '2018-12-13 11:46:47.878244');
INSERT INTO `django_migrations` VALUES ('16', 'sessions', '0001_initial', '2018-12-13 11:46:48.009837');
INSERT INTO `django_migrations` VALUES ('17', 'workflow', '0001_initial', '2018-12-13 11:46:48.289342');
INSERT INTO `django_migrations` VALUES ('18', 'sqlmng', '0001_initial', '2018-12-13 11:46:49.823609');

-- ----------------------------
-- Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for `djcelery_crontabschedule`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_crontabschedule`;
CREATE TABLE `djcelery_crontabschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minute` varchar(64) NOT NULL,
  `hour` varchar(64) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  `day_of_month` varchar(64) NOT NULL,
  `month_of_year` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_crontabschedule
-- ----------------------------

-- ----------------------------
-- Table structure for `djcelery_intervalschedule`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_intervalschedule`;
CREATE TABLE `djcelery_intervalschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_intervalschedule
-- ----------------------------

-- ----------------------------
-- Table structure for `djcelery_periodictask`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_periodictask`;
CREATE TABLE `djcelery_periodictask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime(6) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime(6) DEFAULT NULL,
  `total_run_count` int(10) unsigned NOT NULL,
  `date_changed` datetime(6) NOT NULL,
  `description` longtext NOT NULL,
  `crontab_id` int(11) DEFAULT NULL,
  `interval_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `djcelery_periodictas_crontab_id_75609bab_fk_djcelery_` (`crontab_id`),
  KEY `djcelery_periodictas_interval_id_b426ab02_fk_djcelery_` (`interval_id`),
  CONSTRAINT `djcelery_periodictas_crontab_id_75609bab_fk_djcelery_` FOREIGN KEY (`crontab_id`) REFERENCES `djcelery_crontabschedule` (`id`),
  CONSTRAINT `djcelery_periodictas_interval_id_b426ab02_fk_djcelery_` FOREIGN KEY (`interval_id`) REFERENCES `djcelery_intervalschedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_periodictask
-- ----------------------------

-- ----------------------------
-- Table structure for `djcelery_periodictasks`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_periodictasks`;
CREATE TABLE `djcelery_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime(6) NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_periodictasks
-- ----------------------------

-- ----------------------------
-- Table structure for `djcelery_taskstate`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_taskstate`;
CREATE TABLE `djcelery_taskstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(64) NOT NULL,
  `task_id` varchar(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `tstamp` datetime(6) NOT NULL,
  `args` longtext,
  `kwargs` longtext,
  `eta` datetime(6) DEFAULT NULL,
  `expires` datetime(6) DEFAULT NULL,
  `result` longtext,
  `traceback` longtext,
  `runtime` double DEFAULT NULL,
  `retries` int(11) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  `worker_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `djcelery_taskstate_state_53543be4` (`state`),
  KEY `djcelery_taskstate_name_8af9eded` (`name`),
  KEY `djcelery_taskstate_tstamp_4c3f93a1` (`tstamp`),
  KEY `djcelery_taskstate_hidden_c3905e57` (`hidden`),
  KEY `djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_workerstate_id` (`worker_id`),
  CONSTRAINT `djcelery_taskstate_worker_id_f7f57a05_fk_djcelery_workerstate_id` FOREIGN KEY (`worker_id`) REFERENCES `djcelery_workerstate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_taskstate
-- ----------------------------

-- ----------------------------
-- Table structure for `djcelery_workerstate`
-- ----------------------------
DROP TABLE IF EXISTS `djcelery_workerstate`;
CREATE TABLE `djcelery_workerstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) NOT NULL,
  `last_heartbeat` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `djcelery_workerstate_last_heartbeat_4539b544` (`last_heartbeat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of djcelery_workerstate
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_authrules`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_authrules`;
CREATE TABLE `sqlmng_authrules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  `is_manual_review` tinyint(1) NOT NULL,
  `role` varchar(32) NOT NULL,
  `env` varchar(8) NOT NULL,
  `reject` tinyint(1) NOT NULL,
  `execute` tinyint(1) NOT NULL,
  `rollback` tinyint(1) NOT NULL,
  `approve` tinyint(1) NOT NULL,
  `disapprove` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_authrules
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_cluster`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_cluster`;
CREATE TABLE `sqlmng_cluster` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sqlmng_cluster_name_53206632_uniq` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_cluster
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_dbconf`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_dbconf`;
CREATE TABLE `sqlmng_dbconf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  `user` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `host` varchar(64) NOT NULL,
  `port` varchar(5) NOT NULL,
  `env` varchar(8) NOT NULL,
  `cluster_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sqlmng_dbconf_name_host_env_cluster_id_93f6f0ea_uniq` (`name`,`host`,`env`,`cluster_id`),
  KEY `sqlmng_dbconf_cluster_id_d798a5a0_fk_sqlmng_cluster_id` (`cluster_id`),
  CONSTRAINT `sqlmng_dbconf_cluster_id_d798a5a0_fk_sqlmng_cluster_id` FOREIGN KEY (`cluster_id`) REFERENCES `sqlmng_cluster` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_dbconf
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_dbconf_related_user`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_dbconf_related_user`;
CREATE TABLE `sqlmng_dbconf_related_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dbconf_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sqlmng_dbconf_related_user_dbconf_id_user_id_2e06059f_uniq` (`dbconf_id`,`user_id`),
  KEY `sqlmng_dbconf_related_user_user_id_5d91d765_fk_account_user_id` (`user_id`),
  CONSTRAINT `sqlmng_dbconf_relate_dbconf_id_84df827d_fk_sqlmng_db` FOREIGN KEY (`dbconf_id`) REFERENCES `sqlmng_dbconf` (`id`),
  CONSTRAINT `sqlmng_dbconf_related_user_user_id_5d91d765_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_dbconf_related_user
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_forbiddenwords`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_forbiddenwords`;
CREATE TABLE `sqlmng_forbiddenwords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  `forbidden_words` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_forbiddenwords
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_inceptionconnection`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_inceptionconnection`;
CREATE TABLE `sqlmng_inceptionconnection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  `host` varchar(64) DEFAULT NULL,
  `port` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_inceptionconnection
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_inceptionvariables`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_inceptionvariables`;
CREATE TABLE `sqlmng_inceptionvariables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  `param` varchar(64) DEFAULT NULL,
  `default` varchar(16) DEFAULT NULL,
  `instructions` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_inceptionvariables
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_inceptsql`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_inceptsql`;
CREATE TABLE `sqlmng_inceptsql` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  `is_manual_review` tinyint(1) NOT NULL,
  `commiter` varchar(64) DEFAULT NULL,
  `sql_content` longtext NOT NULL,
  `env` varchar(8) NOT NULL,
  `type` varchar(32) DEFAULT NULL,
  `treater` varchar(64) NOT NULL,
  `status` int(11) NOT NULL,
  `execute_errors` longtext,
  `exe_affected_rows` varchar(10) DEFAULT NULL,
  `roll_affected_rows` varchar(10) DEFAULT NULL,
  `rollback_opid` longtext,
  `rollback_db` varchar(100) DEFAULT NULL,
  `rollback_able` tinyint(1) NOT NULL,
  `handle_result` longtext,
  `handle_result_check` longtext,
  `handle_result_execute` longtext,
  `handle_result_rollback` longtext,
  `db_id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `workorder_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `workorder_id` (`workorder_id`),
  KEY `sqlmng_inceptsql_db_id_c6dfc4d0_fk_sqlmng_dbconf_id` (`db_id`),
  KEY `sqlmng_inceptsql_group_id_7df4c675_fk_auth_group_id` (`group_id`),
  CONSTRAINT `sqlmng_inceptsql_db_id_c6dfc4d0_fk_sqlmng_dbconf_id` FOREIGN KEY (`db_id`) REFERENCES `sqlmng_dbconf` (`id`),
  CONSTRAINT `sqlmng_inceptsql_group_id_7df4c675_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `sqlmng_inceptsql_workorder_id_3d841cb9_fk_workflow_workorder_id` FOREIGN KEY (`workorder_id`) REFERENCES `workflow_workorder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_inceptsql
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_inceptsql_users`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_inceptsql_users`;
CREATE TABLE `sqlmng_inceptsql_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inceptsql_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sqlmng_inceptsql_users_inceptsql_id_user_id_348f2e23_uniq` (`inceptsql_id`,`user_id`),
  KEY `sqlmng_inceptsql_users_user_id_151f9eaa_fk_account_user_id` (`user_id`),
  CONSTRAINT `sqlmng_inceptsql_use_inceptsql_id_d3a56d8a_fk_sqlmng_in` FOREIGN KEY (`inceptsql_id`) REFERENCES `sqlmng_inceptsql` (`id`),
  CONSTRAINT `sqlmng_inceptsql_users_user_id_151f9eaa_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_inceptsql_users
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_mailactions`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_mailactions`;
CREATE TABLE `sqlmng_mailactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  `value` tinyint(1) NOT NULL,
  `desc_cn` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_mailactions
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_strategy`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_strategy`;
CREATE TABLE `sqlmng_strategy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  `is_manual_review` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_strategy
-- ----------------------------

-- ----------------------------
-- Table structure for `sqlmng_suggestion`
-- ----------------------------
DROP TABLE IF EXISTS `sqlmng_suggestion`;
CREATE TABLE `sqlmng_suggestion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  `user_id` int(11) DEFAULT NULL,
  `work_order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sqlmng_suggestion_user_id_bdc90196_fk_account_user_id` (`user_id`),
  KEY `sqlmng_suggestion_work_order_id_b3dfa32d_fk_sqlmng_inceptsql_id` (`work_order_id`),
  CONSTRAINT `sqlmng_suggestion_user_id_bdc90196_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`),
  CONSTRAINT `sqlmng_suggestion_work_order_id_b3dfa32d_fk_sqlmng_inceptsql_id` FOREIGN KEY (`work_order_id`) REFERENCES `sqlmng_inceptsql` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmng_suggestion
-- ----------------------------

-- ----------------------------
-- Table structure for `workflow_step`
-- ----------------------------
DROP TABLE IF EXISTS `workflow_step`;
CREATE TABLE `workflow_step` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  `status` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `work_order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_step_user_id_a328bc4c_fk_account_user_id` (`user_id`),
  KEY `workflow_step_work_order_id_7f0dc19f_fk_workflow_workorder_id` (`work_order_id`),
  CONSTRAINT `workflow_step_user_id_a328bc4c_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`),
  CONSTRAINT `workflow_step_work_order_id_7f0dc19f_fk_workflow_workorder_id` FOREIGN KEY (`work_order_id`) REFERENCES `workflow_workorder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of workflow_step
-- ----------------------------

-- ----------------------------
-- Table structure for `workflow_workorder`
-- ----------------------------
DROP TABLE IF EXISTS `workflow_workorder`;
CREATE TABLE `workflow_workorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `createtime` datetime(6) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  `remark` longtext,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of workflow_workorder
-- ----------------------------
-- ----------------------------
-- Table structure for `slowquery_slowlog`
-- ----------------------------
DROP TABLE IF EXISTS `slowquery_slowlog`;
CREATE TABLE `slowquery_slowlog` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `ParseMaxRowCount` bigint(30) DEFAULT NULL,
  `MySQLTotalExecutionCounts` bigint(30) NOT NULL DEFAULT '0',
  `SQLId` bigint(50) NOT NULL DEFAULT '0',
  `SQLText` text,
  `MaxLockTime` int(11) DEFAULT NULL,
  `ReturnTotalRowCounts` bigint(30) DEFAULT NULL,
  `SQLIdStr` varchar(50) DEFAULT NULL,
  `TotalLockTimes` int(11) DEFAULT NULL,
  `MaxExecutionTime` int(11) DEFAULT NULL,
  `CreateTime` date DEFAULT NULL,
  `SlowLogId` varchar(50) DEFAULT NULL,
  `ParseTotalRowCounts` bigint(30) DEFAULT NULL,
  `MySQLTotalExecutionTimes` int(11) DEFAULT NULL,
  `DBName` varchar(50) DEFAULT NULL,
  `ReturnMaxRowCount` bigint(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_createtime` (`CreateTime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of slowquery_slowlog
-- ----------------------------

- ----------------------------
-- Table structure for `slowquery_slowlogcomment`
-- ----------------------------
CREATE TABLE `slowquery_slowlogcomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slowid` int(11) DEFAULT NULL,
  `content` longtext,
  `commentor` varchar(50) DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of slowquery_slowlogcomment
-- ----------------------------
-- ----------------------------
-- Table structure for `slowquery_slowlogorder`
-- ----------------------------
CREATE TABLE `slowquery_slowlogorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `MySQLTotalExecutionCounts` int(30) NOT NULL,
  `MaxLockTime` int(11) NOT NULL,
  `SQLText` text NOT NULL,
  `ReturnTotalRowCounts` int(30) NOT NULL,
  `ParseTotalRowCounts` int(30) NOT NULL,
  `MySQLTotalExecutionTimes` int(11) NOT NULL,
  `DBName` varchar(50) NOT NULL,
  `status` int(1) NOT NULL,
  `content` text NOT NULL,
  `createtime` datetime(6) NOT NULL,
  `distributor` varchar(100) NOT NULL,
  `executor` varchar(100) NOT NULL,
  `updatetime` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_createtime` (`createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `slowquery_slowrecord`
-- ----------------------------
DROP TABLE IF EXISTS `slowquery_slowrecord`;
CREATE TABLE `slowquery_slowrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `SQLId` varchar(50) NOT NULL,
  `ReturnRowCounts` bigint(30) DEFAULT NULL,
  `HostAddress` varchar(100) DEFAULT NULL,
  `SQLText` text,
  `LockTimes` int(11) DEFAULT NULL,
  `ExecutionStartTime` datetime DEFAULT NULL,
  `ParseRowCounts` bigint(30) DEFAULT NULL,
  `QueryTimes` int(11) DEFAULT NULL,
  `DBName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ExecutionStartTime` (`ExecutionStartTime`) USING BTREE,
  KEY `idx_sqlid` (`SQLId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of slowquery_slowrecord
-- ----------------------------