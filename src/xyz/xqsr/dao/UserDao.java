package xyz.xqsr.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import xyz.xqsr.model.Admin;
import xyz.xqsr.model.User;

public interface UserDao {
	//查询用户是否存在
	public User selectUser(User user);
	//查询所有用户
	public List<User> select();
	//查询管理员用户是否存在
	public Admin selectAdmin(User user);
	//购票用户注册
	public int addUser(User user);
	//修改用户密码
	public int alertPass(User user);
	//修改管理员密码
	public int alertAdminPass(User user);
}
