/*
SQLyog v10.2 
MySQL - 5.7.17 : Database - lmt_user
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`lmt_user` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `lmt_user`;

/*Table structure for table `t_account` */

DROP TABLE IF EXISTS `t_account`;

CREATE TABLE `t_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `account_name` varchar(20) NOT NULL DEFAULT '' COMMENT '登陆账号(用户自定义)',
  `password` varchar(255) DEFAULT NULL,
  `manager_type` int(11) NOT NULL DEFAULT '0' COMMENT '管理员类别(0普通管理员 1超级管理员 系统用户使用)',
  `master` int(11) NOT NULL DEFAULT '0' COMMENT '是否被授权管理员(0否，1是 个人用户使用)',
  `register_type` int(11) NOT NULL DEFAULT '0' COMMENT '注册类型（0前台注册 1后台创建 2用户中心创建）',
  `lock_times` int(11) NOT NULL DEFAULT '0' COMMENT '锁定次数',
  `is_lock` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被锁定',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0正常 1禁用 2重置密码禁用)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='账号表';

/*Data for the table `t_account` */

insert  into `t_account`(`id`,`account_name`,`password`,`manager_type`,`master`,`register_type`,`lock_times`,`is_lock`,`state`,`create_time`) values 
(1,'liqing','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,0,1,NULL),
(2,'lait','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,0,1,NULL),
(3,'lex','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,0,1,NULL),
(4,'zhangzhen','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,0,1,NULL),
(5,'tangsimin','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,0,1,NULL),
(6,'wanglei','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,0,1,NULL);

/*Table structure for table `t_account_name` */

DROP TABLE IF EXISTS `t_account_name`;

CREATE TABLE `t_account_name` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `account_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '账号id',
  `account_name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `type` int(1) NOT NULL DEFAULT '0' COMMENT '类型（0主账号，1手机，2邮箱）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_name` (`account_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='账号名称表';

/*Data for the table `t_account_name` */

insert  into `t_account_name`(`id`,`account_id`,`account_name`,`type`,`create_time`) values 
(1,1,'liqing',0,'2018-09-05 11:32:13'),
(2,2,'lait',0,'2018-09-05 11:32:14'),
(3,3,'lex',0,'2018-09-05 11:33:08'),
(4,4,'zhangzhen',0,'2018-09-05 11:33:18'),
(5,5,'tangsimin',0,'2018-09-05 11:33:31'),
(6,6,'wanglei',0,'2018-09-05 11:33:45');

/*Table structure for table `t_account_role` */

DROP TABLE IF EXISTS `t_account_role`;

CREATE TABLE `t_account_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `account_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '账号id',
  `role_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id_role_id` (`account_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='账号角色表';

/*Data for the table `t_account_role` */

insert  into `t_account_role`(`id`,`account_id`,`role_id`,`create_time`) values 
(1,1,1,'2018-09-05 11:35:16'),
(2,2,1,'2018-09-05 11:35:20'),
(3,3,1,'2018-09-05 11:35:23'),
(4,4,1,'2018-09-05 11:35:25'),
(5,5,1,'2018-09-05 11:35:31'),
(6,6,1,'2018-09-05 11:35:34');

/*Table structure for table `t_accredit` */

DROP TABLE IF EXISTS `t_accredit`;

CREATE TABLE `t_accredit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `resource_id` bigint(20) DEFAULT NULL COMMENT '资源ID',
  `permissions` varchar(10) DEFAULT NULL COMMENT '权限',
  `permission_id` bigint(20) DEFAULT NULL COMMENT '权限ID',
  `state` int(1) unsigned zerofill NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id_resource_id` (`role_id`,`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

/*Data for the table `t_accredit` */

insert  into `t_accredit`(`id`,`role_id`,`resource_id`,`permissions`,`permission_id`,`state`) values 
(1,1,1,NULL,NULL,0),
(2,1,2,'1',NULL,1),
(3,1,3,'1',NULL,1),
(4,1,4,'1',NULL,1),
(5,1,5,'1',NULL,1),
(6,1,6,'1',NULL,1),
(7,1,7,'1',NULL,1),
(8,1,8,'1',NULL,1),
(9,1,9,'1',NULL,1),
(10,1,10,'1',NULL,1),
(11,1,11,'1',NULL,1),
(12,1,12,'1',NULL,1),
(13,1,13,'1',NULL,1),
(14,1,14,'1',NULL,1),
(15,1,15,'1',NULL,1),
(16,1,16,'1',NULL,1);

/*Table structure for table `t_company` */

DROP TABLE IF EXISTS `t_company`;

CREATE TABLE `t_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `group_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '组织ID',
  `name` varchar(50) NOT NULL DEFAULT '0' COMMENT '公司名',
  `organization_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '组织机构代码',
  `legal_person` varchar(20) NOT NULL DEFAULT '' COMMENT '拥有者/法人',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '公司类型（0个人独资 1有限责任公司 2股份制公司 3集团公司 4联营企业 5外商投资企业 6中外合资经营企业 7国有 8私营企业 9全民所有制 10集体所有制...）',
  `validity` varchar(25) NOT NULL DEFAULT '' COMMENT '经营期限',
  `business_scope` varchar(100) NOT NULL DEFAULT '' COMMENT '经营范围',
  `address` varchar(100) NOT NULL DEFAULT '' COMMENT '注册地',
  `capital` varchar(10) NOT NULL DEFAULT '' COMMENT '注册资金',
  `phone` varchar(30) NOT NULL DEFAULT '' COMMENT '公司电话',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '状态(0正常 1禁用)',
  `audit_state` int(1) NOT NULL DEFAULT '0' COMMENT '审核状态（0待审核 1审核通过2审核拒绝）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='公司表';

/*Data for the table `t_company` */

insert  into `t_company`(`id`,`group_id`,`name`,`organization_code`,`legal_person`,`type`,`validity`,`business_scope`,`address`,`capital`,`phone`,`state`,`audit_state`,`create_time`) values (1,1,'string-3','string-3','string-3',2,'string-3','string-3','string-3','string-3','string-3',0,1,'2018-07-31 07:01:49'),(2,41,'0','100-123','李进',0,'2018-2022','300226','闵行区','1000','021-2135856',0,0,'2018-08-01 10:46:02'),(3,43,'0','100-123','李进',0,'2018-2022','300226','闵行区','1000','021-2135856',0,0,'2018-08-01 10:49:15'),(4,44,'string','string','string',1,'string','string','string','string','string',0,0,'2018-08-06 14:12:11'),(5,45,'string-21111','string-2','string-2',1,'string-2','string-2','string-2','string-2','string-2',0,0,'2018-08-06 14:59:57'),(6,50,'string1','string','string',0,'string','string','string','string','string',0,0,'2018-08-29 17:10:47');

/*Table structure for table `t_company_img` */

DROP TABLE IF EXISTS `t_company_img`;

CREATE TABLE `t_company_img` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `company_id` bigint(20) NOT NULL COMMENT '组ID',
  `type` int(11) NOT NULL COMMENT '证件类型(0三证合一 1营业执照 2经营许可证 3税务登记证 4管理员授权书 5法人身份证）',
  `img_url` varchar(100) NOT NULL DEFAULT '' COMMENT '证件图片地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司图片表';

/*Data for the table `t_company_img` */

/*Table structure for table `t_group` */

DROP TABLE IF EXISTS `t_group`;

CREATE TABLE `t_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `type` int(1) NOT NULL DEFAULT '0' COMMENT '组类型（0公司 1部门）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='组表';

/*Data for the table `t_group` */

insert  into `t_group`(`id`,`type`) values (1,0);

/*Table structure for table `t_group_member` */

DROP TABLE IF EXISTS `t_group_member`;

CREATE TABLE `t_group_member` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_group_member` */

/*Table structure for table `t_group_role` */

DROP TABLE IF EXISTS `t_group_role`;

CREATE TABLE `t_group_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` bigint(20) NOT NULL COMMENT '组ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id_role_id` (`group_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='组角色关联表';

/*Data for the table `t_group_role` */

insert  into `t_group_role`(`id`,`group_id`,`role_id`,`create_time`) values 
(1,1,1,'2018-08-21 10:47:11'),
(2,1,2,'2018-08-21 10:47:11'),
(3,1,3,'2018-08-21 10:47:11'),
(4,1,4,'2018-08-21 10:47:11'),
(5,1,5,'2018-08-21 10:47:11'),
(6,1,6,'2018-08-21 11:14:16');

/*Table structure for table `t_group_user` */

DROP TABLE IF EXISTS `t_group_user`;

CREATE TABLE `t_group_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '公司ID或当前部门ID',
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `type` int(1) NOT NULL DEFAULT '0' COMMENT '组类型（0公司 1部门）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id_user_id` (`group_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='组用户关联表';

/*Data for the table `t_group_user` */

insert  into `t_group_user`(`id`,`group_id`,`user_id`,`type`,`create_time`) values 
(1,1,1,0,NULL),
(2,1,2,0,NULL),
(3,1,3,0,NULL),
(4,1,4,0,NULL),
(5,1,5,0,NULL),
(6,1,6,0,NULL);

/*Table structure for table `t_member` */

DROP TABLE IF EXISTS `t_member`;

CREATE TABLE `t_member` (
  `id` bigint(20) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_member` */

insert  into `t_member`(`id`,`icon`,`level`,`name`) values (0,'',0,'');

/*Table structure for table `t_permission` */

DROP TABLE IF EXISTS `t_permission`;

CREATE TABLE `t_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` bigint(20) DEFAULT NULL COMMENT '父节点ID',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `code` varchar(50) NOT NULL COMMENT '编码',
  `val` int(2) DEFAULT NULL COMMENT '权限值',
  `icon` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '状态（1正常，0禁用）',
  `descr` varchar(255) DEFAULT NULL COMMENT '描述',
  `parent_code` varchar(50) NOT NULL COMMENT '父级编码',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `VAL` (`val`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='权限表';

/*Data for the table `t_permission` */

insert  into `t_permission`(`id`,`pid`,`name`,`code`,`val`,`icon`,`state`,`descr`,`parent_code`,`create_time`) values 
(1,NULL,'可见','show',1,'qqqq',1,'','string','2018-08-06 18:31:22'),
(2,NULL,'查看','read',2,'string',1,NULL,'string','2018-07-25 16:42:45'),
(3,NULL,'修改','upd',3,'string',1,NULL,'string','2018-07-25 16:42:45'),
(4,NULL,'新增','add',4,'string',1,NULL,'string','2018-07-25 16:42:45'),
(4,NULL,'删除','del',5,'string',1,NULL,'string','2018-07-25 16:42:45');


/*Table structure for table `t_resources` */

DROP TABLE IF EXISTS `t_resources`;

CREATE TABLE `t_resources` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` bigint(20) DEFAULT NULL COMMENT '父节点ID',
  `name` varchar(20) DEFAULT NULL COMMENT '资源名称',
  `path` varchar(20) DEFAULT NULL COMMENT '资源路径',
  `component` varchar(100) DEFAULT NULL COMMENT '组件',
  `leaf` tinyint(1) DEFAULT NULL COMMENT '是否叶子节点(判断是否展开)',
  `data` varchar(200) DEFAULT NULL COMMENT '资源数据(可能是文本，或者有path不能表示的有规律可被解析的数据)',
  `icon` varchar(20) DEFAULT NULL COMMENT '资源图标',
  `resource_id` bigint(20) DEFAULT NULL COMMENT '资源id',
  `typ` varchar(1) DEFAULT NULL COMMENT '资源类型（0URL资源 1图片资源 2数据资源）',
  `sort` int(2) DEFAULT NULL COMMENT '排序',
  `state` int(1) DEFAULT NULL COMMENT '状态(0正常 1禁用)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='资源表';

/*Data for the table `t_resources` */

insert  into `t_resources`(`id`,`pid`,`name`,`path`,`component`,`leaf`,`data`,`icon`,`resource_id`,`typ`,`sort`,`state`,`create_time`) values 
(1,0,'系统管理','/system','layout/Layout',0,NULL,NULL,0,'1',0,1,'2018-08-06 17:09:07'),
(2,1,'账户管理','account','account/index',1,NULL,NULL,1,'1',0,1,'2018-07-24 14:38:59'),
(3,1,'角色管理','role','role/index',1,NULL,NULL,0,'1',0,1,'2018-07-24 14:38:59'),
(4,1,'权限管理','permission','permission/index',1,NULL,NULL,0,'1',0,1,'2018-07-24 14:38:59'),
(5,1,'资源管理','resources','resources/index',1,NULL,NULL,0,'1',0,1,'2018-07-24 14:38:59'),
(6,1,'授权管理','accredit','accredit/index',1,NULL,NULL,0,'1',0,1,'2018-07-24 14:38:59'),
(7,1,'用户管理','user','user/index',0,NULL,NULL,0,'1',0,1,'2018-07-24 14:38:59'),
(8,0,'商户管理','/merchant','layout/Layout',0,NULL,NULL,0,'1',0,1,'2018-08-06 17:02:35'),
(9,8,'商户审核','audit','merchant/audit',1,NULL,NULL,0,'1',0,1,'2018-08-09 10:15:10'),
(10,0,'产品管理','/product','layout/Layout',0,NULL,NULL,0,'1',0,1,'2018-08-10 09:43:16'),
(11,10,'模型管理','index','product/model',1,NULL,NULL,0,'1',0,1,'2018-08-13 10:17:07'),
(12,10,'品类管理','categories','product/categories/index',1,'string','string',0,'1',0,1,'2018-08-23 14:46:54');

/*Table structure for table `t_role` */

DROP TABLE IF EXISTS `t_role`;

CREATE TABLE `t_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `icon` varchar(100) NOT NULL COMMENT '角色对应的图标地址',
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `state` int(1) NOT NULL COMMENT '状态(0正常 1禁用)',
  `descr` varchar(100) DEFAULT NULL COMMENT '描述',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Data for the table `t_role` */

insert  into `t_role`(`id`,`icon`,`name`,`state`,`descr`,`create_time`) values
(1,'','超级管理员',1,'拥有所有权限','2018-08-30 15:06:32'),
(2,'','系统管理员',1,'拥有系统权限','2018-08-30 15:06:32'),
(3,'','用户管理员',1,'拥有用户权限','2018-09-03 14:12:55'),
(4,'','产品管理员',1,'拥有产品权限','2018-09-03 14:12:55'),
(5,'','订单管理员',1,'拥有订单权限','2018-09-03 14:12:55'),
(6,'','仓库管理员',1,'拥有仓库权限','2018-09-03 14:12:55');

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '姓名',
  `age` int(11) NOT NULL DEFAULT '0' COMMENT '年龄',
  `domicile` varchar(200) NOT NULL DEFAULT '' COMMENT '户籍地',
  `id_card` varchar(30) NOT NULL DEFAULT '' COMMENT '身份证号',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `qq` varchar(20) NOT NULL DEFAULT '' COMMENT 'QQ',
  `sex` int(11) NOT NULL COMMENT '性别(0男 1女)',
  `phone` varchar(30) NOT NULL DEFAULT '' COMMENT '座机',
  `mobile` varchar(15) NOT NULL DEFAULT '' COMMENT '手机号',
  `is_supplement` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已经补全信息',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '状态(0正常 1禁用)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`name`,`age`,`domicile`,`id_card`,`email`,`qq`,`sex`,`phone`,`mobile`,`is_supplement`,`state`,`create_time`) values 
(1,'张亮',18,'中国','123','email','qq',0,'15801818092','',1,0,'2018-07-05 15:12:18'),
(2,'张振',18,'中国','123','email','qq',1,'15801818092','',0,1,'2018-07-06 09:35:53'),
(3,'孟黎明',18,'中国','123','email','qq',0,'15801818092','',0,0,'2018-07-10 12:01:22'),
(4,'李清',18,'中国','123','email','qq',0,'15801818092','',0,0,'2018-07-10 12:01:22'),
(5,'唐思敏',18,'中国','123','email','qq',1,'15801818092','',1,0,'2018-07-10 12:01:22'),
(6,'王雷',18,'中国','123','email','',0,'15801818092','',0,0,'2018-07-10 12:01:22');

/*Table structure for table `t_user_account` */

DROP TABLE IF EXISTS `t_user_account`;

CREATE TABLE `t_user_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `account_id` bigint(20) NOT NULL COMMENT '账号ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='用户账号关联表';

/*Data for the table `t_user_account` */

insert  into `t_user_account`(`id`,`account_id`,`user_id`,`create_time`) values 
(1,1,1,'0000-00-00 00:00:00'),
(2,2,2,'0000-00-00 00:00:00'),
(3,3,3,'0000-00-00 00:00:00'),
(4,4,4,'0000-00-00 00:00:00'),
(5,5,5,'0000-00-00 00:00:00'),
(6,6,6,'0000-00-00 00:00:00'),
(7,7,7,'0000-00-00 00:00:00');

/*Table structure for table `t_user_address` */

DROP TABLE IF EXISTS `t_user_address`;

CREATE TABLE `t_user_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `address` varchar(100) NOT NULL DEFAULT '',
  `phone` varchar(30) NOT NULL DEFAULT '' COMMENT '电话',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '姓名',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序优先级',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '状态(0正常 1禁用)',
  `create_time` bigint(20) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户地址信息表';

/*Data for the table `t_user_address` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
