package xyz.xqsr.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.support.HttpRequestHandlerServlet;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import xyz.xqsr.dao.TicketDao;
import xyz.xqsr.model.Ticket;
import xyz.xqsr.model.User;
import xyz.xqsr.service.TicketDaoService;
import xyz.xqsr.service.UserDaoService;
import xyz.xqsr.staticMethod.StaticLog;

@Controller
@RequestMapping("/TicketServlet")
public class TicketController {
	
	//设计Map聚合存储需要给页面的对象数据
	private Map<String,Object> result = new HashMap<String,Object>();

	// 注入Service
	@Resource
	private TicketDaoService ticketDaoService;

	//返回所有车票信息
	@RequestMapping("/allTicket")
	@ResponseBody
	public Map<String, Object> list(int page, int limit) {
		PageHelper.startPage(page, limit);
		List<Ticket> allTicket = ticketDaoService.allTicket();
		PageInfo<Ticket> pageInfo = new PageInfo<Ticket>(allTicket);
		long total = pageInfo.getTotal();
		List<Ticket> data = pageInfo.getList();
		result.put("total", total);
		result.put("data", data);
		return result;
	}

	/**
	 * @param ticket
	 * @return
	 */
	
	private Map<String, Object> result2 = new HashMap<String, Object>();
	//返回指定的车票信息
	@RequestMapping("/searchTicket")
	@ResponseBody
	public Map<String, Object> searchList(int page,int limit,String start,String end) {
		Ticket ticket = new Ticket();
		ticket.setStart(start);
		ticket.setEnd(end);
		PageHelper.startPage(page, limit);
		List<Ticket> searchTicket = ticketDaoService.searchTicket(ticket);
		PageInfo<Ticket> pageInfo = new PageInfo<Ticket>(searchTicket);
		long total = pageInfo.getTotal();
		List<Ticket> data = pageInfo.getList();
		result.put("total", total);
		result.put("data", data);
		System.out.println(page+"---"+limit);
		System.out.println(result);
		return result;
	}

	
	@RequestMapping("/selectTicket")
	@ResponseBody
	public Ticket selectTicket(Ticket ticket) {
		Ticket ticket1 = ticketDaoService.selectTicket(ticket);
		return ticket1;
	}

	// 管理修改票数
	@RequestMapping("/updateTicket")
	@ResponseBody
	public int updateTicket(Ticket ticket,HttpServletRequest request) {
		System.out.println(ticket);
		String aName = (String) request.getSession().getAttribute("adminname");
		int num = ticketDaoService.updateTicket(ticket);
		if (num > 0) {
			String time = StaticLog.nowTime();
			String log = time+",用户修改车票";
			StaticLog.insertLog(aName+"-ad", log);
			return 1;
		} else {
			return -1;
		}
	}

	// 新增车票
	@RequestMapping("/addTicket")
	@ResponseBody
	public int addTicket(Ticket ticket,HttpServletRequest request) {
		System.out.println(ticket);
		String aName = (String) request.getSession().getAttribute("adminname");
		int num = ticketDaoService.addTicket(ticket);
		if (num > 0) {
			String time = StaticLog.nowTime();
			String log = time+",用户添加车票";
			StaticLog.insertLog(aName+"-ad", log);
			return 1;
		} else {
			return -1;
		}
	}
	// 删除车票
	@RequestMapping("/deleteTicket")
	@ResponseBody
	public int deleteTicket(Ticket ticket,HttpServletRequest request) {
		String aName = (String) request.getSession().getAttribute("adminname");
		int num = ticketDaoService.deleteTicket(ticket);
		if (num > 0) {
			String time = StaticLog.nowTime();
			String log = time+",用户删除车票";
			StaticLog.insertLog(aName+"-ad", log);
			return 1;
		} else {
			return -1;
		}
	}
}
