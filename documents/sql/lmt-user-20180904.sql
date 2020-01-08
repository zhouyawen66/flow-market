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
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8 COMMENT='账号表';

/*Data for the table `t_account` */

insert  into `t_account`(`id`,`account_name`,`password`,`manager_type`,`master`,`register_type`,`lock_times`,`is_lock`,`state`,`create_time`) values 
(1,'admin','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,1,1,'2018-07-10 00:00:00'),
(2,'lait','d9b1d7db4cd6e70935368a1efb10e377',1,0,0,0,1,1,'2018-07-10 00:00:00'),
(3,'lex','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,0,1,'2018-07-10 00:00:00'),
(4,'zhangzhen','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,0,1,'2018-07-10 16:03:27'),
(5,'liqing','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,0,1,'2018-07-16 18:24:38'),
(6,'wanglei','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,0,1,'2018-07-10 00:00:00'),
(7,'tangsimin','d9b1d7db4cd6e70935368a1efb10e377',0,0,0,0,0,0,'2018-07-10 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='账号名称表';

/*Data for the table `t_account_name` */

insert  into `t_account_name`(`id`,`account_id`,`account_name`,`type`,`create_time`) values 
(1,1,'admin',0,'2018-08-20 18:39:21'),
(2,2,'lait',1,'2018-08-20 18:39:21'),
(3,3,'lex',0,'2018-08-20 18:39:21'),
(4,4,'zhangzhen',0,'2018-08-20 18:39:21'),
(5,5,'liqing',0,'2018-08-28 15:45:57'),
(6,6,'wanglei',0,'2018-08-28 15:46:23'),
(7,7,'tangsimin',0,'2018-08-20 18:39:21');

/*Table structure for table `t_account_role` */

DROP TABLE IF EXISTS `t_account_role`;

CREATE TABLE `t_account_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `account_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '账号id',
  `role_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id_role_id` (`account_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='账号角色表';

/*Data for the table `t_account_role` */

insert  into `t_account_role`(`id`,`account_id`,`role_id`,`create_time`) values 
(1,1,1,'2018-08-20 18:49:18'),
(2,2,1,'2018-08-20 18:49:18'),
(3,3,1,'2018-08-20 18:49:18'),
(4,4,1,'2018-08-20 18:49:18'),
(5,5,1,'2018-08-20 18:54:14'),
(6,6,1,'2018-08-21 17:08:15'),
(7,7,1,'2018-08-31 14:12:19');
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

/*Data for the table `t_accredit` */

insert  into `t_accredit`(`id`,`role_id`,`resource_id`,`permissions`,`permission_id`,`state`) values 
(1,1,1,'1',NULL,1),
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
(16,1,16,'1',NULL,1),
(17,1,17,'1',NULL,1),
(18,1,18,'1',NULL,0),
(19,1,19,'1',NULL,0),
(20,1,20,'1',NULL,0),
(21,1,21,'1',NULL,1),
(22,1,22,'1',NULL,1),
(23,1,23,'1',NULL,1),
(24,1,24,'1',NULL,1);

/*Table structure for table `t_company` */

DROP TABLE IF EXISTS `t_company`;

CREATE TABLE `t_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `group_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '组织ID',
  `name` varchar(50) NOT NULL DEFAULT '0' COMMENT '公司名',
  `organization_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '组织机构代码',
  `legal_person` varchar(20) NOT NULL DEFAULT '' COMMENT '拥有者/法人',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '公司类型（0个人独资 1有限责任公司 2股份制公司 3集团公司 4联营企业 5外商投资企业 6中外合资经营企业 7国有 8私营企业 9全民所有制 10集体所有制...）',
  `business_start_date` varchar(20) NOT NULL DEFAULT '' COMMENT '经营开始时间',
  `business_end_date` varchar(20) NOT NULL DEFAULT '' COMMENT '经营结束时间',
  `business_scope` varchar(100) NOT NULL DEFAULT '' COMMENT '经营范围',
  `address` varchar(100) NOT NULL DEFAULT '' COMMENT '注册地',
  `capital` varchar(10) NOT NULL DEFAULT '' COMMENT '注册资金',
  `phone` varchar(30) NOT NULL DEFAULT '' COMMENT '公司电话',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '状态(0正常 1禁用)',
  `version` int(10) NOT NULL DEFAULT '0' COMMENT '版本号，跟applyRecord表最新一条审核通过数据保存一致',
  `imgs` TEXT NOT NULL COMMENT '图片,JSON格式，{"imgUrl"："图片地址"，"type"："证件类型(0三证合一 1营业执照 2经营许可证 3税务登记证 4管理员授权书 5法人身份证）"}',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='公司表';

/*Data for the table `t_company` */

-- insert  into `t_company`(`id`,`group_id`,`name`,`organization_code`,`legal_person`,`type`,`validity`,`business_scope`,`address`,`capital`,`phone`,`state`,`audit_state`,`create_time`) values
--  (1,1,'string-3','string-3','string-3',2,'string-3','string-3','string-3','string-3','string-3',0,1,'2018-07-31 07:01:49'),
--  (2,2,'0','100-123','李进',0,'2018-2022','300226','闵行区','1000','021-2135856',0,0,'2018-08-01 10:46:02'),
--  (3,3,'0','100-123','李进',0,'2018-2022','300226','闵行区','1000','021-2135856',0,0,'2018-08-01 10:49:15'),
--  (4,4,'string','string','string',1,'string','string','string','string','string',0,0,'2018-08-06 14:12:11'),
--  (5,5,'string-21111','string-2','string-2',1,'string-2','string-2','string-2','string-2','string-2',0,0,'2018-08-06 14:59:57'),
--  (6,6,'string11','string1','string1',0,'string1','string1','string1','string1','string',0,0,'2018-08-29 17:10:47');
--  (7,7,'string1','string','string',0,'string','string','string','string','string',0,0,'2018-08-29 17:10:47');
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='组表';

/*Data for the table `t_group` */

-- insert  into `t_group`(`id`,`type`) values (1,0),(6,0),(7,0),(8,0),(10,0),(11,1),(12,1),(15,1),(18,1),(19,1),(24,0),(25,0),(26,0),(27,0),(28,0),(30,0),(31,0),(33,0),(36,0),(43,1),(44,0),(45,0),(46,0),(47,0),(48,0),(49,0),(50,0);

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

-- insert  into `t_group_role`(`id`,`group_id`,`role_id`,`create_time`) values (1,2,0,'2018-08-21 10:47:11'),(4,33,1,'2018-08-21 10:47:11'),(7,34,2,'2018-08-21 10:47:11'),(8,0,1,'2018-08-21 10:47:11'),(9,0,2,'2018-08-21 10:47:11'),(17,1,1,'2018-08-21 11:14:16');

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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='组用户关联表';

/*Data for the table `t_group_user` */

-- insert  into `t_group_user`(`id`,`group_id`,`user_id`,`type`,`create_time`) values (11,1,1,0,'2018-07-18 11:27:24'),(12,5,1,0,'2018-07-18 11:27:31'),(13,6,1,0,'2018-07-18 11:27:24'),(14,7,10,0,'2018-07-18 11:27:24'),(15,7,13,0,'2018-07-18 11:27:24'),(16,1,13,0,'2018-07-24 09:48:31'),(17,1,0,0,'2018-07-25 10:40:27'),(18,7,1,0,NULL),(24,1,90,0,'2018-07-30 11:41:09'),(25,2,90,0,'2018-07-30 11:41:09'),(26,1,97,0,'2018-07-31 11:24:51'),(32,1,98,0,'2018-07-31 18:44:23'),(33,10,98,0,'2018-07-31 18:44:23'),(34,1,52,0,'2018-07-31 18:53:40'),(35,1,99,0,'2018-07-31 19:01:37'),(36,1,89,0,'2018-08-06 13:49:38'),(37,1,61,0,'2018-08-06 14:56:38'),(39,1,2,0,'2018-08-27 16:32:51'),(42,1,9,0,'2018-08-27 16:32:51');

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

-- insert  into `t_member`(`id`,`icon`,`level`,`name`) values (0,'',0,'');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='权限表';

/*Data for the table `t_permission` */

-- insert  into `t_permission`(`id`,`pid`,`name`,`code`,`val`,`icon`,`state`,`descr`,`parent_code`,`create_time`) values (1,NULL,'可见','show',1,'qqqq',1,'','string','2018-08-06 18:31:22'),(2,NULL,'查看','read',2,'string',1,NULL,'string','2018-07-25 16:42:45'),(3,NULL,'修改','update',3,'string',1,NULL,'string','2018-07-25 16:42:45'),(4,NULL,'产品权限','string',4,'string',1,NULL,'string','2018-07-25 16:42:45'),(5,4,'新增产品','string',5,'string',1,NULL,'string','2018-07-25 16:42:45'),(6,4,'修改产品','string',6,'string',1,NULL,'string','2018-07-25 16:42:45'),(7,4,'发布产品','string',7,'string',1,NULL,'string','2018-07-25 16:42:45'),(8,4,'删除产品','string',8,'string',1,NULL,'string','2018-07-25 16:42:45'),(9,4,'其他产品','string',9,'string',1,NULL,'string','2018-08-06 18:18:09');

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
(11,11,'模型管理','index','product/model',1,NULL,NULL,0,'1',0,1,'2018-08-13 10:17:07'),
(12,11,'品类管理','categories','product/categories/index',1,'string','string',0,'0',0,0,'2018-08-23 14:46:54');

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
(1,'','超级管理员',1,NULL,'2018-08-30 15:06:32'),
(2,'','管理员',1,'ddd','2018-08-30 15:06:32'),
(3,'','仓管员',1,'仓库管理','2018-09-03 14:12:55');

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

-- insert  into `t_user`(`id`,`name`,`age`,`domicile`,`id_card`,`email`,`qq`,`sex`,`phone`,`mobile`,`is_supplement`,`state`,`create_time`) values (1,'string',10,'string','string','string','string',0,'string','',1,0,'2018-07-05 15:12:18'),(2,'name',0,'s','m','','',1,'','',0,1,'2018-07-06 09:35:53'),(3,'string',0,'string','string','','',0,'','',0,0,'2018-07-10 12:01:22'),(4,'string',0,'string','string','','',0,'','',0,0,'2018-07-10 12:01:22'),(5,'name',10,'domicile','idCard','email','email',1,'phone','',1,0,'2018-07-10 12:01:22'),(6,'string',0,'string','string','','',0,'','',0,0,'2018-07-10 12:01:22'),(7,'string',0,'string','string','','',0,'','',0,0,'2018-07-10 12:01:22'),(8,'唐思敏',0,'','','','',0,'','',0,0,'2018-07-17 15:30:29'),(9,'唐思敏',0,'','','','',0,'','',0,1,'2018-07-17 15:41:12'),(23,'zhangsan',40,'string','string','zs@lmt21.com','971741275',0,'13658954283','',0,0,'2018-07-25 06:23:34'),(49,'李思',25,'上海','string','l12@163.com','l12@163.com',0,'136159753465','',0,0,'2018-07-26 03:14:15'),(52,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-26 03:26:49'),(60,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-26 03:36:09'),(61,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-26 03:36:46'),(75,'张三',0,'','','','',0,'','',0,0,'2018-07-26 12:01:31'),(85,'??',28,'????','string','sn13@lmt21.com','369258147',0,'18916549528','',0,0,'2018-07-27 07:45:13'),(86,'??',28,'????','string','sn13@lmt21.com','369258147',0,'18916549528','',0,0,'2018-07-27 09:47:13'),(87,'??',28,'????','string','sn13@lmt21.com','369258147',0,'18916549528','',0,0,'2018-07-27 09:51:14'),(88,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-30 10:23:17'),(89,'老王',0,'','','aa@aa.aa','aaaa',0,'12111222','',1,0,'2018-07-30 10:28:43'),(90,'李四1',10,'12','14','13','13',1,'15','',1,0,'2018-07-30 11:03:06'),(91,'??',28,'????','string','sn13@lmt21.com','369258147',0,'18916549528','',0,0,'2018-07-30 03:55:52'),(92,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-30 18:10:55'),(93,'张三三',0,'string','string','string','string',0,'string','',0,0,'2018-07-30 18:11:13'),(94,'吴磊',0,'','','','',0,'','',0,0,'2018-07-31 10:53:03'),(95,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-31 11:13:47'),(96,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-31 11:13:52'),(97,'风大大',0,'','','','',0,'','',0,0,'2018-07-31 11:24:51'),(98,'string',20,'string','string','string','string',0,'string','',1,0,'2018-07-31 18:33:14'),(99,'韩梅梅',0,'','','','',0,'22222','',0,0,'2018-07-31 19:01:37'),(100,'',0,'','','','',0,'','',0,0,'2018-08-06 14:27:40'),(101,'',0,'','','','',0,'','',0,0,'2018-08-06 15:01:19'),(102,'',12,'','','','',0,'','',1,0,'2018-08-13 10:57:47'),(103,'',0,'','','','',0,'','1111',0,0,'2018-08-22 18:12:40'),(104,'',0,'','','','',0,'','18000000004',0,0,'2018-08-29 15:38:16'),(105,'abc',0,'','','abc@lmt.com','asdf',0,'123','18000000005',1,0,'2018-08-29 15:44:13'),(106,'',0,'','','','',0,'','18000000006',0,0,'2018-08-29 15:45:56'),(107,'',0,'','','','',0,'','18011111111',0,0,'2018-09-04 03:37:42');

/*Table structure for table `t_user_account` */

DROP TABLE IF EXISTS `t_user_account`;

CREATE TABLE `t_user_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `account_id` bigint(20) NOT NULL COMMENT '账号ID',
  `user_id` varchar(255) NOT NULL COMMENT '用户ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='用户账号关联表';

/*Data for the table `t_user_account` */

-- insert  into `t_user_account`(`id`,`account_id`,`user_id`,`create_time`) values (6,1,'1','2018-07-17 17:39:20'),(7,141,'89','2018-07-25 10:40:27'),(8,129,'90','2018-07-30 11:03:06'),(9,130,'97','2018-07-31 11:24:51'),(10,134,'98','2018-07-31 18:33:14'),(11,77,'99','2018-07-31 19:01:37'),(12,143,'100','2018-08-06 14:27:40'),(13,87,'75','2018-07-17 17:39:20'),(14,144,'101','2018-08-06 15:01:19'),(15,145,'102','2018-08-13 10:57:47'),(16,146,'103','2018-08-22 18:12:40'),(19,2,'2','2018-07-31 18:33:14'),(20,148,'96','2018-07-31 19:01:37'),(21,156,'104','2018-08-29 15:38:16'),(22,157,'105','2018-08-29 15:44:13'),(23,158,'106','2018-08-29 15:45:56'),(24,149,'9','2018-07-31 19:01:37'),(25,159,'107','2018-09-04 03:37:42');

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

CREATE TABLE `t_apply_record` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`foreign_key` BIGINT(20) NOT NULL COMMENT '外键',
	`apply_type` INT(10) NOT NULL DEFAULT '0' COMMENT '申请类型（0企业商户 1管理员授权）',
	`operate_type` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '操作类型（0新增 1变更）',
	`data` LONGTEXT NOT NULL COMMENT '变更数据，JSON格式',
	`classpath` VARCHAR(500) NOT NULL DEFAULT '' COMMENT '当前文件路径',
	`keyword` VARCHAR(30) NOT NULL DEFAULT '' COMMENT '关键字',
	`audit_state` INT(30) NOT NULL DEFAULT '0' COMMENT '审核状态（0待审核 1审核通过2审核拒绝）',
	`audit_time` DATETIME NOT NULL COMMENT '审核时间',
	`note` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '备注',
	`version` INT(10) NOT NULL DEFAULT '0' COMMENT '版本',
	`state` INT(1) NOT NULL DEFAULT '0' COMMENT '状态(0正常 1禁用)',
	`create_time` DATETIME NOT NULL COMMENT '创建时间',
	PRIMARY KEY (`id`)
)
COMMENT='申请记录表（企业商户 管理员授权）'
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

