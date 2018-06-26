/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50547
Source Host           : localhost:3306
Source Database       : house

Target Server Type    : MYSQL
Target Server Version : 50547
File Encoding         : 65001

Date: 2018-02-24 10:18:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for xjc_admin
-- ----------------------------
DROP TABLE IF EXISTS `xjc_admin`;
CREATE TABLE `xjc_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `username` varchar(13) NOT NULL DEFAULT 'admin' COMMENT '用户名',
  `password` varchar(256) DEFAULT NULL COMMENT '密码',
  `tel` varchar(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(33) DEFAULT NULL COMMENT '邮箱',
  `user_img` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态:0表示禁用,1表示启用',
  `add_time` int(11) DEFAULT NULL COMMENT '添加时间',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1表示中介,2表示管理员',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of xjc_admin
-- ----------------------------
INSERT INTO `xjc_admin` VALUES ('1', 'xjc', 'b7cce09eb8da2fe90447198be415e8de3eed8e3a80ba62ee8a9f9f6c5f7ffe3e', '13665994204', '982215226@qq.com', '20171224\\c1bd9da4382e4f5681e2077d49223ef2.jpg', '2', '1513692555', '2');
INSERT INTO `xjc_admin` VALUES ('2', 'admin', 'aaffebecec560fec66e75f24062224ffa4e07696d2ae9a1fee3707c3f8fd9373', '13665994204', '982215226@qq.com', '20171224\\6bc317e388eababef9cd59a8e7d1c0ed.jpg', '2', '1513692555', '1');

-- ----------------------------
-- Table structure for xjc_admin_common
-- ----------------------------
DROP TABLE IF EXISTS `xjc_admin_common`;
CREATE TABLE `xjc_admin_common` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `admin_id` int(11) DEFAULT NULL COMMENT 'admin表的主键id作为该表的外键',
  `truename` varchar(33) DEFAULT NULL COMMENT '真实姓名',
  `company` varchar(100) DEFAULT NULL COMMENT '所属公司',
  `store` varchar(100) DEFAULT NULL COMMENT '所属门店',
  `work_region` varchar(100) DEFAULT NULL COMMENT '工作区域',
  `sex` tinyint(1) NOT NULL DEFAULT '1' COMMENT '性别:1表示男,2表示女',
  `card` varchar(18) DEFAULT NULL COMMENT '身份证',
  `card_img` varchar(255) DEFAULT NULL COMMENT '身份证图片',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员-关联表';

-- ----------------------------
-- Records of xjc_admin_common
-- ----------------------------
INSERT INTO `xjc_admin_common` VALUES ('1', '1', '思明', '麦田房产', '福州分店', '福州地区', '1', '350521199505255235', null);

-- ----------------------------
-- Table structure for xjc_admin_oath
-- ----------------------------
DROP TABLE IF EXISTS `xjc_admin_oath`;
CREATE TABLE `xjc_admin_oath` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `controller` varchar(33) DEFAULT NULL COMMENT '控制器',
  `name` varchar(33) DEFAULT NULL COMMENT '名称',
  `summary` varchar(255) DEFAULT NULL COMMENT '描述',
  `type` tinyint(1) DEFAULT '1' COMMENT '类型:1表示中介，2表示管理员',
  `add_time` int(11) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1165 DEFAULT CHARSET=utf8 COMMENT='管理员权限表';

-- ----------------------------
-- Records of xjc_admin_oath
-- ----------------------------
INSERT INTO `xjc_admin_oath` VALUES ('1', 'adminoath', '权限管理-权限列表', '管理管理员和中介权限', '2', '1514008853');
INSERT INTO `xjc_admin_oath` VALUES ('2', 'admin', '系统管理员-管理员列表', '管理后台管理员', '2', '1514000000');
INSERT INTO `xjc_admin_oath` VALUES ('1150', 'agency', '用户管理-中介用户列表', '管理中介用户', '2', '1514217875');
INSERT INTO `xjc_admin_oath` VALUES ('1151', 'user', '用户管理-普通用户列表', '管理普通用户', '2', '1514217911');
INSERT INTO `xjc_admin_oath` VALUES ('1152', 'house', '房屋管理-房屋列表', '管理房屋信息', '2', '1514217939');
INSERT INTO `xjc_admin_oath` VALUES ('1153', 'housecheck', '房屋管理-房屋审核列表', '管理房屋的审核状态', '2', '1514217979');
INSERT INTO `xjc_admin_oath` VALUES ('1154', 'house', '房屋管理-房屋列表', '管理房屋信息', '1', '1514219904');
INSERT INTO `xjc_admin_oath` VALUES ('1162', 'housedepute', '房屋管理-房屋委托列表', '管理房屋委托新信息', '1', '1514381877');
INSERT INTO `xjc_admin_oath` VALUES ('1163', 'housedepute', '房屋管理-房屋委托列表', '管理房屋委托信息', '2', '1514381898');
INSERT INTO `xjc_admin_oath` VALUES ('1164', 'houseconfig', '房屋管理-房屋配置列表', '房屋管理-房屋配置列表', '2', '1518415427');

-- ----------------------------
-- Table structure for xjc_house
-- ----------------------------
DROP TABLE IF EXISTS `xjc_house`;
CREATE TABLE `xjc_house` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `admin_id` int(11) DEFAULT NULL COMMENT 'admin表的主键id',
  `title` varchar(50) NOT NULL COMMENT '房屋名称',
  `desc` text COMMENT '房屋描述',
  `type1` int(11) DEFAULT NULL COMMENT '室',
  `type2` int(11) DEFAULT NULL COMMENT '厅',
  `type3` int(11) DEFAULT NULL COMMENT '卫',
  `acreage` int(11) DEFAULT NULL COMMENT '面积',
  `direction` varchar(33) DEFAULT NULL COMMENT '朝向',
  `decoration` tinyint(1) DEFAULT '1' COMMENT '装修：1表示精装修，2表示普通装修，3表示毛坯房',
  `floor1` int(11) DEFAULT '1' COMMENT '楼',
  `floor2` int(11) DEFAULT '1' COMMENT '层',
  `way` tinyint(1) DEFAULT NULL COMMENT '1表示整租，2表示合租',
  `config` varchar(255) NOT NULL DEFAULT '无' COMMENT '房屋配置',
  `money` double(10,2) DEFAULT '0.00' COMMENT '租金',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核状态:0表示审核中，1表示通过，2表示不通过',
  `username` varchar(50) DEFAULT NULL COMMENT '发布者姓名',
  `on_sale` tinyint(1) DEFAULT '0' COMMENT '0表示下架,1表示上架',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='房屋表';

-- ----------------------------
-- Records of xjc_house
-- ----------------------------
INSERT INTO `xjc_house` VALUES ('1', '1', '丽景天成二期', '房东人很好', '2', '1', '1', '65', '东', '1', '1', '1', null, '阳台,热水器,油烟机,空调,冰箱,洗衣机,椅子,衣柜,书桌,床头柜,宽带,床,书架,电视,沙发', '3000.00', '0', 'xjc', '0', '1519196450', '福州市仓山区丽景天成2期');
INSERT INTO `xjc_house` VALUES ('3', '1', '闽侯大学城中海寰宇天下', '闽侯大学城，交通便利，拎包入住，房东人超好', '2', '2', '1', '80', '东', '1', '1', '1', null, '阳台,热水器,空调,洗衣机,椅子,衣柜,书桌,宽带,床,书架,电视,沙发', '2500.00', '0', 'xjc', '0', '1519283336', '');
INSERT INTO `xjc_house` VALUES ('2', '1', '象山公寓（二区）', '临近西湖，交通方便。拎包入住', '1', '0', '1', '20', '东', '1', '1', '1', null, '阳台,热水器,空调,洗衣机,衣柜,书桌,床头柜,宽带,床', '1500.00', '0', 'xjc', '0', '1519277550', '福州市鼓楼区洪山镇');
INSERT INTO `xjc_house` VALUES ('4', '1', '金达花园', '', '1', '0', '1', '14', '东南', '1', '1', '1', null, '热水器,空调,洗衣机,书桌,宽带,床', '900.00', '0', 'xjc', '0', '1519283803', '福州市鼓楼区洪山镇');

-- ----------------------------
-- Table structure for xjc_house_config
-- ----------------------------
DROP TABLE IF EXISTS `xjc_house_config`;
CREATE TABLE `xjc_house_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(33) DEFAULT NULL COMMENT '名称',
  `filename` varchar(255) DEFAULT NULL COMMENT '图片路径',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='房屋配置表';

-- ----------------------------
-- Records of xjc_house_config
-- ----------------------------
INSERT INTO `xjc_house_config` VALUES ('1', '沙发', '20180212\\530764f94115ff358401acbd8f6f4655.png', '1518421088');
INSERT INTO `xjc_house_config` VALUES ('2', '电视', '20180212\\dde03b0169e00d48783d92f6426acb34.png', '1518421104');
INSERT INTO `xjc_house_config` VALUES ('3', '书架', '20180212\\6a19c5635471a60c6c54061c434ad674.png', '1518421123');
INSERT INTO `xjc_house_config` VALUES ('4', '床', '20180212\\7fb9fa4a2a65920386465c55222a428c.png', '1518421134');
INSERT INTO `xjc_house_config` VALUES ('5', '宽带', '20180212\\2942109991aab303309807cdc1bf63b6.png', '1518421147');
INSERT INTO `xjc_house_config` VALUES ('6', '床头柜', '20180212\\31e7dfdfa128eca445e6f3075fc03738.png', '1518421165');
INSERT INTO `xjc_house_config` VALUES ('7', '书桌', '20180212\\9ad17b1034a8567a4dfd7acd33c38d93.png', '1518421174');
INSERT INTO `xjc_house_config` VALUES ('8', '衣柜', '20180212\\d04ed9110afd53b6d83f88cd31bd00c1.png', '1518421188');
INSERT INTO `xjc_house_config` VALUES ('9', '椅子', '20180212\\05d4243262859ac9a71326955e72e53d.png', '1518421210');
INSERT INTO `xjc_house_config` VALUES ('10', '洗衣机', '20180212\\a2c91fa7eb00604274e2ea2bc2da4ec1.png', '1518421222');
INSERT INTO `xjc_house_config` VALUES ('11', '冰箱', '20180212\\f5007d7089d2b86482a158a7214fe710.png', '1518421238');
INSERT INTO `xjc_house_config` VALUES ('12', '空调', '20180212\\81f6ef971ad0014c24328acda6c2603d.png', '1518421256');
INSERT INTO `xjc_house_config` VALUES ('13', '油烟机', '20180212\\ebdcaf0ca16e7cf29754a9bf823d6887.png', '1518421275');
INSERT INTO `xjc_house_config` VALUES ('14', '热水器', '20180212\\f2d854ae74c3ebb700946f5c864758c6.png', '1518421323');
INSERT INTO `xjc_house_config` VALUES ('15', '阳台', '20180212\\991657837ae8bde99dd2a0b8127ee2b6.png', '1518421334');

-- ----------------------------
-- Table structure for xjc_house_depute
-- ----------------------------
DROP TABLE IF EXISTS `xjc_house_depute`;
CREATE TABLE `xjc_house_depute` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `title` varchar(255) DEFAULT NULL COMMENT '小区名称',
  `acreage` int(11) DEFAULT NULL COMMENT '面积',
  `money` double(10,2) DEFAULT NULL COMMENT '售价',
  `house_type` varchar(100) DEFAULT NULL COMMENT '户型',
  `username` varchar(100) DEFAULT NULL COMMENT '联系人姓名',
  `tel` varchar(11) DEFAULT NULL COMMENT '电话',
  `is_take` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1表示未接单,2表示已接单',
  `take_name` varchar(100) DEFAULT NULL COMMENT '接单人',
  `take_id` int(11) DEFAULT '0' COMMENT '接单人id',
  `add_time` int(11) DEFAULT NULL COMMENT '添加时间',
  `take_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '接单人类型:1表示中介，２表示管理员',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='房屋-委托表';

-- ----------------------------
-- Records of xjc_house_depute
-- ----------------------------
INSERT INTO `xjc_house_depute` VALUES ('1', '丽景天成2期', '100', '5000.00', '3室', '张三', '13665994204', '2', 'admin', '2', '1514380375', '1');

-- ----------------------------
-- Table structure for xjc_house_img
-- ----------------------------
DROP TABLE IF EXISTS `xjc_house_img`;
CREATE TABLE `xjc_house_img` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `house_id` int(11) DEFAULT NULL COMMENT '房屋id',
  `filename` varchar(255) DEFAULT NULL COMMENT '图片路径',
  `add_time` int(11) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='房屋-图片关联表';

-- ----------------------------
-- Records of xjc_house_img
-- ----------------------------
INSERT INTO `xjc_house_img` VALUES ('41', '1', '20180222\\1211b99400e576bd64168e447402692f.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('40', '1', '20180222\\52418afa3dbde7268970aeffac05aa53.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('39', '1', '20180222\\04c3ee3f79e134804b4b5af4bdbdbd67.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('38', '1', '20180222\\4ed223982d134c39c9049f2a99e5d1b2.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('37', '1', '20180222\\0502fd4e808cabe7b75711b24d861264.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('36', '1', '20180222\\2a04c3e10e49f1fa4a68ab5a964670f9.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('35', '2', '20180222\\c1f55eb14fc37ea5b6f03887bee199f4.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('34', '2', '20180222\\b45adeda24b5934e8bfcc34f9f697a3a.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('33', '2', '20180222\\99a16bf4b909789d69f33b02e39462d7.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('32', '2', '20180222\\0d45dae9fb8129eac0a2066dd3781a4d.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('31', '2', '20180222\\4da01183c4fbbbfa5b184329b3015966.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('30', '2', '20180222\\cb2e0ec020d02e444415bad5a154b036.jpg', null);
INSERT INTO `xjc_house_img` VALUES ('42', '3', '20180222\\eee80d8927f4c8a0e2ace150b65d19d3.jpg', '1519283336');
INSERT INTO `xjc_house_img` VALUES ('43', '3', '20180222\\1e3d2fe6e3a484e4617c8773432d860e.jpg', '1519283336');
INSERT INTO `xjc_house_img` VALUES ('44', '3', '20180222\\b2b1522e1dc00ae1169d438ce7283630.jpg', '1519283336');
INSERT INTO `xjc_house_img` VALUES ('45', '3', '20180222\\06f0e4bf054b755dd1f210c30af548f6.jpg', '1519283336');
INSERT INTO `xjc_house_img` VALUES ('46', '3', '20180222\\fb8e4e1e3c1c75a9452132a8d14cc0a8.jpg', '1519283336');
INSERT INTO `xjc_house_img` VALUES ('47', '4', '20180222\\f13798204b489e834c625746a074f867.jpg', '1519283803');
INSERT INTO `xjc_house_img` VALUES ('48', '4', '20180222\\265ee7b9b314cb54654d2e10eed6e96c.jpg', '1519283803');
INSERT INTO `xjc_house_img` VALUES ('49', '4', '20180222\\7f8b72a651ba3d63e16aaa2d38d1c045.jpg', '1519283803');
INSERT INTO `xjc_house_img` VALUES ('50', '4', '20180222\\008423b4d87ab07bf1638499f8c3f5a6.jpg', '1519283803');

-- ----------------------------
-- Table structure for xjc_user
-- ----------------------------
DROP TABLE IF EXISTS `xjc_user`;
CREATE TABLE `xjc_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `username` varchar(25) DEFAULT NULL COMMENT '用户名称',
  `password` varchar(256) DEFAULT NULL COMMENT '密码',
  `tel` varchar(11) DEFAULT NULL COMMENT '用户账号（手机号）',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `card` varchar(18) DEFAULT NULL COMMENT '身份证',
  `user_img` varchar(255) DEFAULT NULL COMMENT '头像',
  `add_time` int(11) DEFAULT NULL COMMENT '添加时间',
  `sex` tinyint(1) DEFAULT '1' COMMENT '性别：1表示男,2表示女',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态:1表示启用，2表示禁用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xjc_user
-- ----------------------------
INSERT INTO `xjc_user` VALUES ('1', '张伟江', null, '13665994204', '982215226@qq.com', '350524488785488565', null, '1514051846', '1', '1');
