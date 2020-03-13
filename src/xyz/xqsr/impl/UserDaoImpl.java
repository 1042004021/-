package xyz.xqsr.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xyz.xqsr.dao.UserDao;
import xyz.xqsr.model.Admin;
import xyz.xqsr.model.User;
import xyz.xqsr.service.UserDaoService;

@Service("UserDaoService")
@Transactional
public class UserDaoImpl implements UserDaoService {

	@Resource
	private UserDao userDao;
	public User selectUser(User user) {
		return userDao.selectUser(user);
	}
	public List<User> select() {

		return userDao.select();
	}
	public Admin selectAdmin(User user) {
		return userDao.selectAdmin(user);
	}
	public int addUser(User user) {
		return userDao.addUser(user);
	}
	public int alertPass(User user) {
		return userDao.alertPass(user);
	}
	public int alertAdminPass(User user) {
		return userDao.alertAdminPass(user);
	}
}
