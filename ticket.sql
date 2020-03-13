/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50527
 Source Host           : localhost:3306
 Source Schema         : ticket

 Target Server Type    : MySQL
 Target Server Version : 50527
 File Encoding         : 65001

 Date: 26/12/2019 23:36:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `aid` int(11) NOT NULL,
  `aname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `apassword` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`aid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '123456');

-- ----------------------------
-- Table structure for carticket
-- ----------------------------
DROP TABLE IF EXISTS `carticket`;
CREATE TABLE `carticket`  (
  `cid` int(10) NOT NULL AUTO_INCREMENT,
  `start` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `end` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `quantity` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of carticket
-- ----------------------------
INSERT INTO `carticket` VALUES (35, '成都', '黄山', '4', '2019-12-03');
INSERT INTO `carticket` VALUES (36, '成都', '北京', '8', '2019-12-06');
INSERT INTO `carticket` VALUES (37, '成都', '深圳', '16', '2019-12-06');
INSERT INTO `carticket` VALUES (38, '成都', '广东', '11', '2019-12-06');
INSERT INTO `carticket` VALUES (39, '成都', '拉萨', '19', '2019-12-06');
INSERT INTO `carticket` VALUES (40, '成都', '重庆', '11', '2019-12-06');
INSERT INTO `carticket` VALUES (41, '成都', '内江', '17', '2019-12-06');
INSERT INTO `carticket` VALUES (42, '成都', '三亚', '10', '2019-12-06');
INSERT INTO `carticket` VALUES (43, '成都', '天津', '16', '2019-12-06');
INSERT INTO `carticket` VALUES (44, '成都', '西藏', '28', '2019-12-06');
INSERT INTO `carticket` VALUES (45, '成都', '上海', '24', '2019-12-03');
INSERT INTO `carticket` VALUES (46, '成都', '上海', '23', '2019-12-03');
INSERT INTO `carticket` VALUES (47, '成都', '新疆', '5', '2019-12-03');
INSERT INTO `carticket` VALUES (48, '成都', '黄山', '7', '2019-12-03');
INSERT INTO `carticket` VALUES (49, '成都', '北京', '10', '2019-12-06');
INSERT INTO `carticket` VALUES (50, '成都', '深圳', '20', '2019-12-06');
INSERT INTO `carticket` VALUES (51, '成都', '广东', '3', '2019-12-06');
INSERT INTO `carticket` VALUES (52, '成都', '拉萨', '20', '2019-12-06');
INSERT INTO `carticket` VALUES (53, '成都', '重庆', '12', '2019-12-06');
INSERT INTO `carticket` VALUES (54, '成都', '内江', '19', '2019-12-06');
INSERT INTO `carticket` VALUES (55, '成都', '三亚', '13', '2019-12-06');
INSERT INTO `carticket` VALUES (56, '成都', '天津', '16', '2019-12-06');
INSERT INTO `carticket` VALUES (57, '成都', '西藏', '28', '2019-12-06');
INSERT INTO `carticket` VALUES (58, '成都', '上海', '23', '2019-12-03');
INSERT INTO `carticket` VALUES (59, '上海', '成都', '20', '2019-12-17');
INSERT INTO `carticket` VALUES (60, '上海', '南京', '10', '2019-12-31');

-- ----------------------------
-- Table structure for finishorder
-- ----------------------------
DROP TABLE IF EXISTS `finishorder`;
CREATE TABLE `finishorder`  (
  `uid` int(10) NOT NULL,
  `start` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `end` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(1) NOT NULL,
  `time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of finishorder
-- ----------------------------
INSERT INTO `finishorder` VALUES (1, '成都', '上海', 1, '2019-12-02');
INSERT INTO `finishorder` VALUES (1, '成都', '新疆', 1, '2019-12-02');
INSERT INTO `finishorder` VALUES (2, '成都', '兰州', 1, '2019-12-02');
INSERT INTO `finishorder` VALUES (2, '成都', '北京', -1, '2019-12-02');
INSERT INTO `finishorder` VALUES (2, '成都', '深圳', 1, '2019-12-02');
INSERT INTO `finishorder` VALUES (1, '成都', '广东', 1, '2019-12-02');
INSERT INTO `finishorder` VALUES (2, '成都', '上海', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '新疆', 1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '三亚', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (2, '成都', '内江', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (2, '成都', '拉萨', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (2, '成都', '三亚', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (2, '成都', '内江', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (2, '成都', '拉萨', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (1, '成都', '上海', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '上海', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '新疆', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '上海', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '上海', 1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '上海', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '深圳', -1, '2019-12-06');
INSERT INTO `finishorder` VALUES (1, '成都', '内江', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (1, '成都', '三亚', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (1, '成都', '三亚', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (2, '成都', '新疆', 1, '2019-12-03');
INSERT INTO `finishorder` VALUES (1, '成都', '上海', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (1, '成都', '新疆', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (1, '成都', '黄山', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '深圳', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (2, '成都', '黄山', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '重庆', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (2, '成都', '上海', 1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '三亚', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (1, '成都', '黄山', 1, '2019-12-03');
INSERT INTO `finishorder` VALUES (1, '成都', '深圳', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (1, '成都', '上海', 1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '上海', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (2, '成都', '天津', -1, '2019-12-06');
INSERT INTO `finishorder` VALUES (2, '成都', '广东', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (2, '成都', '内江', 1, '2019-12-06');
INSERT INTO `finishorder` VALUES (1, '成都', '黄山', 1, '2019-12-03');
INSERT INTO `finishorder` VALUES (1, '成都', '上海', -1, '2019-12-03');
INSERT INTO `finishorder` VALUES (1, '成都', '黄山', 1, '2019-12-03');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `uid` int(10) NOT NULL AUTO_INCREMENT,
  `cid` int(10) NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`uid`, `cid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, 36, -1);
INSERT INTO `order` VALUES (1, 37, -1);
INSERT INTO `order` VALUES (2, 1, 1);
INSERT INTO `order` VALUES (2, 32, -1);
INSERT INTO `order` VALUES (2, 35, -1);
INSERT INTO `order` VALUES (2, 36, -1);
INSERT INTO `order` VALUES (2, 37, -1);
INSERT INTO `order` VALUES (2, 38, -1);
INSERT INTO `order` VALUES (2, 39, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `uid` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'user', '000000');
INSERT INTO `user` VALUES (2, 'admin', '000000');
INSERT INTO `user` VALUES (3, 'user2', '123456');

SET FOREIGN_KEY_CHECKS = 1;
