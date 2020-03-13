package xyz.xqsr.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import xyz.xqsr.dao.FinishOrderDao;
import xyz.xqsr.model.FinishOrder;
import xyz.xqsr.service.FinishOrderDaoService;
import xyz.xqsr.staticMethod.StaticLog;

@Controller
@RequestMapping("/logController")
public class LogController {
	//用户显示日志
	@RequestMapping("/showLog")
	@ResponseBody
	public List<Object> showLog(HttpServletRequest request) throws IOException{
        String userName = (String) request.getSession().getAttribute("username");
		List<Object> list = StaticLog.readFile1(userName);
		return list;
	}
	//管理员显示日志
	@RequestMapping("/adminshowLog")
	@ResponseBody
	public List<Object> adminShowLog(HttpServletRequest request) throws IOException{
        String userName = (String) request.getSession().getAttribute("adminname");
		List<Object> list = StaticLog.readFile1(userName+"-ad");
		return list;
	}
}
