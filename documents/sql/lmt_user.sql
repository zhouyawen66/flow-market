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
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8 COMMENT='账号表';

/*Data for the table `t_account` */

insert  into `t_account`(`id`,`account_name`,`password`,`manager_type`,`master`,`register_type`,`lock_times`,`is_lock`,`state`,`create_time`) values (1,'15800000003','string',1,0,0,0,1,1,NULL),(2,'admin','eeeee',0,0,0,0,0,0,NULL),(3,'tansiming','12122',0,0,0,0,0,0,'2018-07-10 00:00:00'),(77,'string1',NULL,0,0,0,0,0,0,'2018-07-10 16:03:27'),(78,'1234',NULL,0,0,0,0,0,0,'2018-07-16 18:24:38'),(79,'123',NULL,0,0,0,0,0,0,'2018-07-16 18:25:41'),(80,'12345',NULL,0,0,0,0,0,0,'2018-07-16 18:46:11'),(81,'15811111111',NULL,0,0,1,0,0,0,'2018-07-17 15:27:35'),(83,'15801111111',NULL,0,0,1,0,0,0,'2018-07-17 15:41:12'),(84,'15800000001',NULL,0,0,1,0,0,0,'2018-07-17 15:43:03'),(85,'4451234',NULL,0,0,2,0,0,0,'2018-07-17 17:38:22'),(86,'string',NULL,0,0,0,0,0,0,'2018-07-18 14:25:04'),(87,'lait',NULL,0,0,0,0,0,0,'2018-07-18 14:50:39'),(88,'lait1',NULL,0,0,0,0,0,0,'2018-07-18 14:52:57'),(89,'lait11',NULL,0,0,0,0,0,0,'2018-07-18 14:59:42'),(90,'lait111',NULL,0,0,0,0,0,0,'2018-07-18 15:14:05'),(91,'lait1111',NULL,0,0,0,0,0,0,'2018-07-18 15:15:24'),(92,'string11',NULL,0,0,0,0,0,0,'2018-07-18 15:26:08'),(93,'string111',NULL,0,0,0,0,0,0,'2018-07-18 15:37:22'),(94,'string1111',NULL,0,0,0,0,0,0,'2018-07-18 15:39:16'),(95,'string11111',NULL,0,0,0,0,0,0,'2018-07-18 16:20:06'),(96,'string111111',NULL,0,0,0,0,0,0,'2018-07-18 16:39:29'),(97,'string1111111',NULL,0,0,0,0,0,0,'2018-07-18 16:55:28'),(98,'string11111112',NULL,0,0,0,0,0,0,'2018-07-18 17:37:13'),(99,'string111111121',NULL,0,0,0,0,0,0,'2018-07-18 17:37:43'),(100,'string1111111219',NULL,0,0,0,0,0,0,'2018-07-18 17:45:32'),(101,'1',NULL,0,0,0,0,0,0,'2018-07-19 09:32:11'),(102,'2',NULL,0,0,0,0,0,0,'2018-07-19 09:32:55'),(103,'loll',NULL,0,0,0,0,0,0,'2018-07-19 02:01:56'),(104,'abx',NULL,0,0,0,0,0,0,'2018-07-19 10:10:04'),(105,'abx2',NULL,0,0,0,0,0,0,'2018-07-19 10:12:10'),(106,'abx3',NULL,0,0,0,0,0,0,'2018-07-19 10:14:20'),(107,'abx4',NULL,0,0,0,0,0,0,'2018-07-19 10:15:12'),(108,'3333',NULL,0,0,0,0,0,0,'2018-07-19 03:09:47'),(109,'lait111111',NULL,0,0,0,0,0,0,'2018-07-19 03:14:54'),(110,'00',NULL,0,0,0,0,0,0,'2018-07-20 18:04:21'),(111,'001',NULL,0,0,0,0,0,0,'2018-07-20 18:05:39'),(112,'0011',NULL,0,0,0,0,0,0,'2018-07-20 18:06:49'),(113,'string1112',NULL,0,0,0,0,0,0,'2018-07-23 08:29:13'),(114,'string11122',NULL,0,0,0,0,0,0,'2018-07-23 09:53:04'),(115,'string111223',NULL,0,0,0,0,0,0,'2018-07-23 10:18:34'),(116,'wanglei',NULL,0,0,0,0,0,0,'2018-07-23 10:49:26'),(117,'string343434',NULL,0,0,0,0,0,0,'2018-07-24 06:38:14'),(118,'string3434341',NULL,0,0,0,0,0,0,'2018-07-24 06:47:44'),(119,'string343434111',NULL,0,0,0,0,0,0,'2018-07-24 06:48:17'),(120,'menglm',NULL,0,0,0,0,0,0,'2018-07-25 02:14:58'),(121,'21',NULL,0,0,0,0,0,0,'2018-07-25 16:22:03'),(122,'1234567890',NULL,0,0,1,0,0,0,'2018-07-25 10:40:27'),(123,'1350258762453',NULL,1,0,1,0,0,0,'2018-07-26 03:32:22'),(124,'15812000000',NULL,0,0,1,0,0,0,'2018-07-26 12:01:31'),(125,'15812000001',NULL,0,0,1,0,0,0,'2018-07-26 12:02:35'),(128,'3210','string',0,0,2,0,0,0,'2018-07-30 10:32:03'),(129,'lisi','ss7X8VfZ',0,0,1,0,0,0,'2018-07-30 11:03:06'),(130,'黄昊','1Xh8qwRm',1,0,1,0,0,0,'2018-07-31 11:24:51'),(131,'','',0,0,0,0,1,0,'2018-07-31 13:28:13'),(132,'lex','',0,0,0,0,0,0,'2018-07-31 15:32:13'),(133,'lex2','abc',0,0,0,0,0,0,'2018-07-31 15:52:27'),(134,'lijingjing','ausSZhtn',0,0,1,0,0,0,'2018-07-31 18:33:14'),(135,'hanmeimei','1',0,0,2,0,0,0,'2018-07-31 19:01:37'),(136,'18012345678','123',0,0,0,0,0,0,'2018-08-01 13:38:39'),(137,'sdrfafsdfsfsdfsdfsdf','',0,0,0,0,1,0,'2018-08-02 15:15:41'),(138,'ffff','',0,0,0,0,1,0,'2018-08-02 15:16:47'),(139,'dfsdfsdfd','',0,0,0,0,1,0,'2018-08-02 16:38:28'),(140,'eeeee','',0,0,0,0,1,0,'2018-08-02 16:44:46'),(141,'18011111111','202cb962ac59075b964b07152d234b70',0,0,0,0,0,2,'2018-08-06 11:12:05'),(142,'AN_supxb4tf2748o2ba','',0,0,0,0,0,0,'2018-08-06 13:40:46'),(143,'AN_06x8ci2ai050q26f','123',0,0,0,0,0,2,'2018-08-06 14:27:39'),(144,'AN_o5lajnqfu536yw0r','3eca5d8a28a24ab24adfdc666f1525f0',0,0,0,0,0,0,'2018-08-06 15:01:19'),(145,'AN_9opird4gn821u7qw','c8ffe9a587b126f152ed3d89a146b445',0,0,0,0,0,2,'2018-08-13 10:57:47');

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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='账号名称表';

/*Data for the table `t_account_name` */

insert  into `t_account_name`(`id`,`account_id`,`account_name`,`type`,`create_time`) values (1,1,'15800000003',1,'2018-08-20 18:39:21'),(3,2,'admin',0,'2018-08-20 18:39:21'),(4,1,'zhang_yingli@163.com',0,'2018-08-20 18:39:21'),(5,1,'wb-acc',0,'2018-08-20 18:39:21'),(6,1,'tsm',0,'2018-08-20 18:39:21'),(8,2,'tsm-1',0,'2018-08-20 18:39:21'),(9,2,'tsm-2',0,'2018-08-20 18:39:21'),(10,2,'TSM-3',0,'2018-08-20 18:39:21'),(11,1,'string',0,'2018-08-20 18:39:21'),(12,1,'lait111',0,'2018-08-20 18:39:21'),(13,1,'lait1111',0,'2018-08-20 18:39:21'),(14,1,'string1111',0,'2018-08-20 18:39:21'),(15,1,'string11111',0,'2018-08-20 18:39:21'),(16,1,'string11111112',0,'2018-08-20 18:39:21'),(17,1,'string111111121',0,'2018-08-20 18:39:21'),(18,1,'string1111111219',0,'2018-08-20 18:39:21'),(19,1,'1',0,'2018-08-20 18:39:21'),(20,1,'2',0,'2018-08-20 18:39:21'),(21,1,'sss',0,'2018-08-20 18:39:21'),(22,1,'aaa',0,'2018-08-20 18:39:21'),(23,1,'aaa2',0,'2018-08-20 18:39:21'),(24,1,'aaa3',0,'2018-08-20 18:39:21'),(25,108,'srrrrss',0,'2018-08-20 18:39:21'),(26,109,'vvvv',0,'2018-08-20 18:39:21'),(27,0,'00',0,'2018-08-20 18:39:21'),(28,0,'001',0,'2018-08-20 18:39:21'),(29,0,'0011',0,'2018-08-20 18:39:21'),(30,116,'wlpaul',0,'2018-08-20 18:39:21'),(32,0,'21',0,'2018-08-20 18:39:21'),(33,0,'ls',0,'2018-08-20 18:39:21'),(34,0,'hk',0,'2018-08-20 18:39:21'),(35,0,'zhangsan',0,'2018-08-20 18:39:21'),(36,0,'3210',0,'2018-08-20 18:39:21'),(37,129,'lisi',0,'2018-08-20 18:39:21'),(38,130,'黄昊',0,'2018-08-20 18:39:21'),(39,132,'',0,'2018-08-20 18:39:21'),(40,133,'lex2',0,'2018-08-20 18:39:21'),(41,134,'lijingjing',0,'2018-08-20 18:39:21'),(42,135,'hanmeimei',0,'2018-08-20 18:39:21'),(43,136,'lex3',1,'2018-08-20 18:39:21'),(44,1,'15800000004',1,'2018-08-20 18:39:21'),(45,1,'15800000006',1,'2018-08-20 18:39:21'),(46,141,'18011111111',1,'2018-08-20 18:39:21'),(47,143,'18011111112',1,'2018-08-20 18:39:21'),(48,87,'lait',0,'2018-08-20 18:39:21'),(49,87,'lait-1',0,'2018-08-20 18:39:21'),(50,144,'18011111113',1,'2018-08-20 18:39:21'),(51,145,'15821870741',1,'2018-08-20 18:39:21');

/*Table structure for table `t_account_role` */

DROP TABLE IF EXISTS `t_account_role`;

CREATE TABLE `t_account_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `account_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '账号id',
  `role_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id_role_id` (`account_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='账号角色表';

/*Data for the table `t_account_role` */

insert  into `t_account_role`(`id`,`account_id`,`role_id`,`create_time`) values (3,2,2,'2018-08-20 18:49:18'),(5,2,6,'2018-08-20 18:49:18'),(10,135,2,'2018-08-20 18:49:18'),(12,2,5,'2018-08-20 18:49:18'),(14,135,4,'2018-08-20 18:54:14'),(15,1,1,'2018-08-21 17:08:15'),(16,1,2,'2018-08-21 17:08:15');

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

/*Data for the table `t_accredit` */

insert  into `t_accredit`(`id`,`role_id`,`resource_id`,`permissions`,`permission_id`,`state`) values (14,2,1,'134',0,0),(15,2,2,'1',0,0),(16,2,3,'1',1,0),(17,2,4,'1',10,0),(18,2,5,'1',NULL,0),(19,2,6,'1',NULL,0),(20,2,7,'1',NULL,0),(21,2,8,'1',NULL,0),(22,2,9,'1',NULL,0),(23,2,10,'1',NULL,0),(24,2,11,'1',NULL,0),(25,2,12,'1',NULL,0),(26,2,13,'1',NULL,0),(27,2,14,'1',NULL,0),(28,2,15,'1',NULL,0),(29,2,16,'1',NULL,0),(30,2,17,'1',NULL,0);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='公司表';

/*Data for the table `t_company` */

insert  into `t_company`(`id`,`group_id`,`name`,`organization_code`,`legal_person`,`type`,`validity`,`business_scope`,`address`,`capital`,`phone`,`state`,`audit_state`,`create_time`) values (1,1,'string-3','string-3','string-3',2,'string-3','string-3','string-3','string-3','string-3',0,1,'2018-07-31 07:01:49'),(2,41,'0','100-123','李进',0,'2018-2022','300226','闵行区','1000','021-2135856',0,0,'2018-08-01 10:46:02'),(3,43,'0','100-123','李进',0,'2018-2022','300226','闵行区','1000','021-2135856',0,0,'2018-08-01 10:49:15'),(4,44,'string','string','string',1,'string','string','string','string','string',0,0,'2018-08-06 14:12:11'),(5,45,'string-21111','string-2','string-2',1,'string-2','string-2','string-2','string-2','string-2',0,0,'2018-08-06 14:59:57');

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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='组表';

/*Data for the table `t_group` */

insert  into `t_group`(`id`,`type`) values (1,0),(6,0),(7,0),(8,0),(10,0),(11,1),(12,1),(15,1),(18,1),(19,1),(24,0),(25,0),(26,0),(27,0),(28,0),(30,0),(31,0),(33,0),(36,0),(43,1),(44,0),(45,0),(46,0),(47,0),(48,0),(49,0);

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

insert  into `t_group_role`(`id`,`group_id`,`role_id`,`create_time`) values (1,2,0,'2018-08-21 10:47:11'),(4,33,1,'2018-08-21 10:47:11'),(7,34,2,'2018-08-21 10:47:11'),(8,0,1,'2018-08-21 10:47:11'),(9,0,2,'2018-08-21 10:47:11'),(17,1,1,'2018-08-21 11:14:16');

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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='组用户关联表';

/*Data for the table `t_group_user` */

insert  into `t_group_user`(`id`,`group_id`,`user_id`,`type`,`create_time`) values (11,1,1,0,'2018-07-18 11:27:24'),(12,5,1,0,'2018-07-18 11:27:31'),(13,6,1,0,'2018-07-18 11:27:24'),(14,7,10,0,'2018-07-18 11:27:24'),(15,7,13,0,'2018-07-18 11:27:24'),(16,1,13,0,'2018-07-24 09:48:31'),(17,1,0,0,'2018-07-25 10:40:27'),(18,7,1,0,NULL),(24,1,90,0,'2018-07-30 11:41:09'),(25,2,90,0,'2018-07-30 11:41:09'),(26,1,97,0,'2018-07-31 11:24:51'),(32,1,98,0,'2018-07-31 18:44:23'),(33,10,98,0,'2018-07-31 18:44:23'),(34,1,52,0,'2018-07-31 18:53:40'),(35,1,99,0,'2018-07-31 19:01:37'),(36,1,89,0,'2018-08-06 13:49:38'),(37,1,61,0,'2018-08-06 14:56:38');

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
  `name` varchar(20) NOT NULL COMMENT '名称',
  `code` varchar(50) NOT NULL COMMENT '编码',
  `val` int(2) NOT NULL COMMENT '权限值',
  `icon` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '状态（0正常，1禁用）',
  `descr` varchar(255) DEFAULT NULL COMMENT '描述',
  `parent_code` varchar(50) NOT NULL COMMENT '父级编码',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='权限表';

/*Data for the table `t_permission` */

insert  into `t_permission`(`id`,`name`,`code`,`val`,`icon`,`state`,`descr`,`parent_code`,`create_time`) values (1,'新增','write',2,'qqqq',1,'下午下午 ddd','string','2018-08-06 18:31:22'),(2,'查看','read',2,'string',0,NULL,'string','2018-07-25 16:42:45'),(3,'修改','update',3,'string',0,NULL,'string','2018-07-25 16:42:45'),(4,'string','string',0,'string',0,NULL,'string','2018-07-25 16:42:45'),(5,'string','string',0,'string',0,NULL,'string','2018-07-25 16:42:45'),(6,'string','string',0,'string',0,NULL,'string','2018-07-25 16:42:45'),(7,'string','string',0,'string',0,NULL,'string','2018-07-25 16:42:45'),(8,'string','string',0,'string',0,NULL,'string','2018-07-25 16:42:45'),(10,'string','string',0,'string',0,'','string','2018-08-06 18:18:09');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='资源表';

/*Data for the table `t_resources` */

insert  into `t_resources`(`id`,`pid`,`name`,`path`,`component`,`leaf`,`data`,`icon`,`resource_id`,`typ`,`sort`,`state`,`create_time`) values (1,0,'系统管理','/system','layout/Layout',0,'1','string',1,'1',0,1,'2018-08-06 17:09:07'),(2,1,'account','account','account/index',1,NULL,'string',1,'1',NULL,1,'2018-07-24 14:38:59'),(3,1,'role','role','role/index',1,NULL,'string',0,'1',NULL,1,'2018-07-24 14:38:59'),(4,1,'permission','permission','permission/index',1,NULL,'string',0,'1',NULL,1,'2018-07-24 14:38:59'),(5,1,'resources','resources','Resouces',1,NULL,'string',0,'1',NULL,1,'2018-07-24 14:38:59'),(6,1,'accredit','accredit','accredit/index',1,NULL,'string',0,'1',NULL,1,'2018-07-24 14:38:59'),(7,0,'用户管理','/user','layout/Layout',0,NULL,'string',10,'1',NULL,1,'2018-07-24 14:38:59'),(8,7,'list','list','user/index',1,'string','string',0,'1',0,1,'2018-08-06 17:02:35'),(10,0,'产品管理','/product','layout/Layout',0,'string1','string1',0,'1',0,1,'2018-08-09 10:15:10'),(11,10,'list','list','product/index',1,'string1111','string111',0,'1',0,1,'2018-08-10 09:43:16'),(12,10,'categories','categories','product/categories/index',1,'111','111',111,'1',11,1,'2018-08-13 10:17:07');

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Data for the table `t_role` */

insert  into `t_role`(`id`,`icon`,`name`,`state`,`descr`,`create_time`) values (5,'string1eeee','aaaaaa1111',0,'aaaaaa','2018-07-20 15:29:53'),(6,'string','string',0,'ssss','2018-07-20 16:48:10'),(7,'','ssss',1,'ssss','2018-07-23 14:54:43'),(8,'','dddd',1,'ss','2018-07-23 16:08:13'),(9,'','asdasd',1,'','2018-07-23 16:12:59'),(10,'asdasd','asdasdasd',1,'','2018-07-23 16:46:25'),(11,'icon1','lmt',0,'','2018-07-27 03:25:17'),(12,'','测试',0,'测试-2','2018-08-01 16:27:45'),(13,'RRR','RRRRR',1,'','2018-08-10 10:52:33');

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
  `mobile` varchar(10) NOT NULL DEFAULT '' COMMENT '手机号',
  `is_supplement` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已经补全信息',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '状态(0正常 1禁用)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`name`,`age`,`domicile`,`id_card`,`email`,`qq`,`sex`,`phone`,`mobile`,`is_supplement`,`state`,`create_time`) values (1,'string',10,'string','string','string','string',0,'string','',1,0,'2018-07-05 15:12:18'),(2,'name',0,'s','m','','',1,'','',0,1,'2018-07-06 09:35:53'),(3,'string',0,'string','string','','',0,'','',0,0,'2018-07-10 12:01:22'),(4,'string',0,'string','string','','',0,'','',0,0,'2018-07-10 12:01:22'),(5,'name',10,'domicile','idCard','email','email',1,'phone','',1,0,'2018-07-10 12:01:22'),(6,'string',0,'string','string','','',0,'','',0,0,'2018-07-10 12:01:22'),(7,'string',0,'string','string','','',0,'','',0,0,'2018-07-10 12:01:22'),(8,'唐思敏',0,'','','','',0,'','',0,0,'2018-07-17 15:30:29'),(9,'唐思敏',0,'','','','',0,'','',0,1,'2018-07-17 15:41:12'),(23,'zhangsan',40,'string','string','zs@lmt21.com','971741275',0,'13658954283','',0,0,'2018-07-25 06:23:34'),(49,'李思',25,'上海','string','l12@163.com','l12@163.com',0,'136159753465','',0,0,'2018-07-26 03:14:15'),(52,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-26 03:26:49'),(60,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-26 03:36:09'),(61,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-26 03:36:46'),(75,'张三',0,'','','','',0,'','',0,0,'2018-07-26 12:01:31'),(85,'??',28,'????','string','sn13@lmt21.com','369258147',0,'18916549528','',0,0,'2018-07-27 07:45:13'),(86,'??',28,'????','string','sn13@lmt21.com','369258147',0,'18916549528','',0,0,'2018-07-27 09:47:13'),(87,'??',28,'????','string','sn13@lmt21.com','369258147',0,'18916549528','',0,0,'2018-07-27 09:51:14'),(88,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-30 10:23:17'),(89,'aaa',0,'','','aa@aa.aa','aaaa',0,'12111','',1,0,'2018-07-30 10:28:43'),(90,'李四1',10,'12','14','13','13',1,'15','',1,0,'2018-07-30 11:03:06'),(91,'??',28,'????','string','sn13@lmt21.com','369258147',0,'18916549528','',0,0,'2018-07-30 03:55:52'),(92,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-30 18:10:55'),(93,'张三三',0,'string','string','string','string',0,'string','',0,0,'2018-07-30 18:11:13'),(94,'吴磊',0,'','','','',0,'','',0,0,'2018-07-31 10:53:03'),(95,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-31 11:13:47'),(96,'string',0,'string','string','string','string',0,'string','',0,0,'2018-07-31 11:13:52'),(97,'风大大',0,'','','','',0,'','',0,0,'2018-07-31 11:24:51'),(98,'string',20,'string','string','string','string',0,'string','',1,0,'2018-07-31 18:33:14'),(99,'韩梅梅',0,'','','','',0,'22222','',0,0,'2018-07-31 19:01:37'),(100,'',0,'','','','',0,'','',0,0,'2018-08-06 14:27:40'),(101,'',0,'','','','',0,'','',0,0,'2018-08-06 15:01:19'),(102,'',12,'','','','',0,'','',1,0,'2018-08-13 10:57:47');

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='用户账号关联表';

/*Data for the table `t_user_account` */

insert  into `t_user_account`(`id`,`account_id`,`user_id`,`create_time`) values (6,1,'1','2018-07-17 17:39:20'),(7,141,'89','2018-07-25 10:40:27'),(8,129,'90','2018-07-30 11:03:06'),(9,130,'97','2018-07-31 11:24:51'),(10,134,'98','2018-07-31 18:33:14'),(11,135,'99','2018-07-31 19:01:37'),(12,143,'100','2018-08-06 14:27:40'),(13,87,'75','2018-07-17 17:39:20'),(14,144,'101','2018-08-06 15:01:19'),(15,145,'102','2018-08-13 10:57:47');

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
