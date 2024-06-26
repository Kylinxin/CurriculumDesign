CREATE TABLE `sys_user` (
                            `id` int(9) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                            `username` varchar(16) NOT NULL COMMENT '用户名',
                            `password` varchar(32) NOT NULL COMMENT '用户密码',
                            `user_avatar` varchar(255) DEFAULT NULL COMMENT '用户头像',
                            `register_time` datetime DEFAULT NULL COMMENT '注册时间',
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `idx_sys_user_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='系统用户表';

INSERT INTO `sys_user` VALUES ('1', 'admin', '123456', '/res/images/avatar/default.png', '2020-05-05 17:21:27'), ('2', 'test', '123456', '/res/images/avatar/default.png', '2020-05-06 18:27:10'), ('3', 'root', '123456', '/res/images/avatar/default.png', '2020-05-06 18:28:27'), ('4', 'user', '123456', '/res/images/avatar/default.png', '2020-05-06 18:31:34'), ('5', 'rasp', '123456', '/res/images/avatar/default.png', '2020-05-06 18:32:08');
