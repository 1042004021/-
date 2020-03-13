package xyz.xqsr.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.support.HttpRequestHandlerServlet;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import net.sf.jsqlparser.statement.select.Limit;
import xyz.xqsr.dao.UserDao;
import xyz.xqsr.model.Admin;
import xyz.xqsr.model.Ticket;
import xyz.xqsr.model.User;
import xyz.xqsr.service.UserDaoService;
import xyz.xqsr.staticMethod.StaticLog;

@Controller
@RequestMapping("/UserController")
public class UserController {

	//注入Service
	@Resource
	private UserDaoService userDaoService;
	
	
	//验证用户是否登录
	@RequestMapping("/logined")
	@ResponseBody
	public int logined(HttpServletRequest request) {
		String username = (String) request.getSession().getAttribute("username");
		System.out.println("username:"+username);
		if(username!=null) {
			return 1;
		}else {
			return 0;
		}
		
	}

	
	//验证管理是否登录
	@RequestMapping("/adminLogined")
	@ResponseBody
	public int adminLogined(HttpServletRequest request) {
		String username = (String) request.getSession().getAttribute("adminname");
		System.out.println("username:"+username);
		if(username!=null) {
			return 1;
		}else {
			return 0;
		}
		
	}
	
	Map<String, Object> result = new HashMap<String, Object>();
	
	
	//查询所有用户
	@RequestMapping("/allUser")
	@ResponseBody
	public Map<String, Object> list(int page,int limit){
		// pagehelper实现分页
		PageHelper.startPage(page, limit);

		List<User> user1 = userDaoService.select();
		
		PageInfo<User> pageInfo = new PageInfo<User>(user1);

		long total = pageInfo.getTotal();

		List<User> data = pageInfo.getList();

		result.put("total", total);

		result.put("data", data);

		return result;
		
	}
	//用户登录
	@RequestMapping("/login")
	public void login(User user,HttpServletRequest request,HttpServletResponse response) throws IOException {
		User user1 =  userDaoService.selectUser(user);
		if(user1!=null) {
			String time = StaticLog.nowTime();
			String log = time+",用户登录";
			StaticLog.insertLog(user.getUsername(), log);
			request.getSession().setAttribute("uid", user1.getUid());
			request.getSession().setAttribute("username", user1.getUsername());
			request.getSession().setAttribute("password", user1.getPassword());
			response.sendRedirect("../page2.jsp");
		}else {
			request.getSession().setAttribute("error", "账号或密码错误！");
			response.sendRedirect("../login.jsp");
		}
		
	}
	//用户修改密码
	@RequestMapping("/alertPass")
	@ResponseBody
	public int alertPass(User user,String pass) {
		System.out.println(user+pass);
		User user2 = userDaoService.selectUser(user);
		if(user2==null) {
			return -1;
		}else {
			user.setPassword(pass);
			int num = userDaoService.alertPass(user);
			if(num>0) {
				String time = StaticLog.nowTime();
				String log = time+",用户修改密码";
				StaticLog.insertLog(user.getUsername(), log);
				return 1;
			}else {
				return 0;
			}
		}
		
	}
	//管理员修改密码
		@RequestMapping("/alertAdminPass")
		@ResponseBody
		public int alertAdminPass(User user,String pass) {
			Admin admin = userDaoService.selectAdmin(user);
			System.out.println(user+pass);
			if(admin==null) {
				return -1;
			}else {
				user.setPassword(pass);
				int num = userDaoService.alertAdminPass(user);
				if(num>0) {
					String time = StaticLog.nowTime();
					String log = time+",用户修改密码";
					StaticLog.insertLog(user.getUsername()+"-ad", log);
					return 1;
				}else {
					return 0;
				}
			}
			
		}
	//管理员登录验证
	@RequestMapping("/adminLogin")
	public void adminLogin(User user,HttpServletRequest request,HttpServletResponse response) throws IOException {
		Admin admin = userDaoService.selectAdmin(user);
		if(admin != null) {
			request.getSession().setAttribute("adminname", admin.getAname());
			request.getSession().setAttribute("apassword", admin.getApassword());
			String time = StaticLog.nowTime();
			String log = time+",用户登录";
			StaticLog.insertLog(admin.getAname()+"-ad", log);
			response.sendRedirect("../manager.jsp");
		}else {
			request.getSession().setAttribute("error", "账号或密码错误！");
			response.sendRedirect("../login.jsp");
		}
		System.out.println(admin);
	}
	//获取用户信息
	@RequestMapping("/userInfo")
	@ResponseBody
	public User userInfo(HttpServletRequest request) {
		User user = new User();
		user.setUsername((String) request.getSession().getAttribute("username"));
		user.setPassword((String) request.getSession().getAttribute("password"));
		return user;
	}
	//获取管理信息
		@RequestMapping("/adminInfo")
		@ResponseBody
		public Admin adminInfo(HttpServletRequest request) {
			Admin admin = new Admin();
			admin.setAname((String) request.getSession().getAttribute("adminname"));
			admin.setApassword((String) request.getSession().getAttribute("apassword"));
			return admin;
		}
	//移除session中的username adminname
	@RequestMapping("/logout")
	@ResponseBody
	public int logOut(HttpServletRequest request) {
		try {
			String userName = (String) request.getSession().getAttribute("username");
			request.getSession().removeAttribute("username");
			String time = StaticLog.nowTime();
			String log = time+",用户退出登录";
			StaticLog.insertLog(userName, log);
			try {
				String adminName = (String) request.getSession().getAttribute("adminname");
				request.getSession().removeAttribute("adminname");
				String time2 = StaticLog.nowTime();
				String log2 = time2+",用户退出登录";
				StaticLog.insertLog(adminName+"-ad", log2);
				return 1;
			} catch (Exception e) {
				return 1;
			}
			
		} catch (Exception e) {
			
			return -1;
		}
	
		
	}
	// 购票用户注册
		@RequestMapping("/register")
		@ResponseBody
		public void addUser(User user,HttpServletRequest request,HttpServletResponse response) throws IOException {
			String username=request.getParameter("username");
			String password=request.getParameter("password");
			int statu = 0;
			response.setCharacterEncoding("utf-8");
			PrintWriter out=response.getWriter();
			List<User> allUser = userDaoService.select();
			for (User user2 : allUser) {
				//System.out.println(user2);
				if(user2.getUsername().equals(username)) {
					response.setHeader("content-type", "text/html;charset=UTF-8");
					out.print("<script language='javascript'>alert('注册失败，用户已存在');window.location.href='../register.jsp'</script>");
					statu = 1;
				}
			}
		
		  if(statu==0) {
		  
		  int num = userDaoService.addUser(user);
		  System.out.println(num); 
		  response.setHeader("content-type","text/html;charset=utf-8"); 
		  if (num > 0) { 
			  out.print("<script language='javascript'>alert('注册成功');window.location.href='../login.jsp'</script>"); 
		  } else { 
			  request.getSession().setAttribute("error", "用户已存在");
			  response.sendRedirect("../register.jsp"); }
		  }
		 	
		}
}
