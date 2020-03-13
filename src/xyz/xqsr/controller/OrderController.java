package xyz.xqsr.controller;

import java.sql.ResultSet;
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

import xyz.xqsr.model.FinishOrder;
import xyz.xqsr.model.Order;
import xyz.xqsr.model.Ticket;
import xyz.xqsr.service.FinishOrderDaoService;
import xyz.xqsr.service.OrderDaoService;
import xyz.xqsr.service.TicketDaoService;
import xyz.xqsr.staticMethod.StaticLog;

@Controller
@RequestMapping("/OrderController")
public class OrderController {

	@Resource
	private OrderDaoService orderDaoService;
	@Resource
	private TicketDaoService ticketDaoService;
	@Resource
	private FinishOrderDaoService FinishOrderDaoService;

	// 用户购票
	@RequestMapping("/insertOrder")
	@ResponseBody
	public int insertOrder(int cid, HttpServletRequest request) {
		Order order = new Order();
		int num = 0;
		int status = 1;
		int uid = (Integer) request.getSession().getAttribute("uid");
		order.setCid(cid);
		order.setUid(uid);
		order.setStatus(status);
		try {
			num = orderDaoService.bind(order);
			ticketDaoService.buyTicket(order);
			System.out.println("num:" + num);
			String userName = (String) request.getSession().getAttribute("username");
			String time = StaticLog.nowTime();
			String log = time+",用户购买车票";
			StaticLog.insertLog(userName, log);
			return num;
		} catch (Exception e) {
			// TODO: handle exception
			return -1;
		}

	}

	Map<String, Object> result = new HashMap<String, Object>();

	// 查看所有订单
	@RequestMapping("/allOrder")
	@ResponseBody
	public Map<String, Object> allOrder(int page, int limit,HttpServletRequest request) {
		try {
			// 获取用户cid传入order调用查询所有订单
			int uid = (Integer) request.getSession().getAttribute("uid");
			Order order = new Order();
			order.setUid(uid);
			// pagehelper实现分页
			PageHelper.startPage(page, limit);
			List<Ticket> ticket = orderDaoService.allOrder(order);
			PageInfo<Ticket> pageInfo = new PageInfo<Ticket>(ticket);
			long total = pageInfo.getTotal();
			List<Ticket> data = pageInfo.getList();
			result.put("total", total);
			result.put("data", data);
			return result;

		} catch (Exception e) {
			return null;
		}

	}
	

	// 退单操作
	@RequestMapping("/backOrder")
	@ResponseBody
	public int backOrder(int cid, HttpServletRequest request) {
		int uid = (Integer) request.getSession().getAttribute("uid");
		String userName = (String) request.getSession().getAttribute("username");
		Order order = new Order();
		order.setCid(cid);
		order.setUid(uid);
		int num = orderDaoService.backOrder(order);
		System.out.println("修改了" + num + "条数据");
		String time = StaticLog.nowTime();
		String log = time+",用户申请退票";
		StaticLog.insertLog(userName, log);
		return num;
	}
	
	
	
	Map<String, Object> result2 = new HashMap<String, Object>();

	// 显示当前用户待审核的订单
	@RequestMapping("/showBackOrder")
	@ResponseBody
	public Map<String , Object> showBackOrder(int page,int limit ,HttpServletRequest request) {
		int uid = (Integer) request.getSession().getAttribute("uid");
		Order order = new Order();
		
		order.setUid(uid);
		// pagehelper实现分页
		PageHelper.startPage(page, limit);
		
		List<Ticket> ticket = orderDaoService.showBackOrder(order);
		
		PageInfo<Ticket> pageInfo = new PageInfo<Ticket>(ticket);

		long total = pageInfo.getTotal();

		List<Ticket> data = pageInfo.getList();

		result2.put("total", total);

		result2.put("data", data);

		return result2;

	}

	
	Map<String, Object> result3 = new HashMap<String, Object>();
	
	
	// 显示所有用户待审核订单
	@RequestMapping("/allBackOrder")
	@ResponseBody
	public Map<String, Object> allBackOrder(int page,int limit,HttpServletRequest request) {
		try {
			String adminName = (String) request.getSession().getAttribute("adminname");
			if (adminName != null) {
				// pagehelper实现分页
				PageHelper.startPage(page, limit);
				
				List<Ticket> ticket = orderDaoService.allBackOrder();
				
				PageInfo<Ticket> pageInfo = new PageInfo<Ticket>(ticket);

				long total = pageInfo.getTotal();

				List<Ticket> data = pageInfo.getList();

				result2.put("total", total);

				result2.put("data", data);

				return result2;
				
			} else {
				return null;
			}
		} catch (Exception e) {
			return null;
		}

	}

	// 管理确认退单
	@RequestMapping("/sureBackOrder")
	@ResponseBody
	public int sureBackOrder(FinishOrder finishOrder,HttpServletRequest request) {
		String aName = (String) request.getSession().getAttribute("adminname");
		Order order = new Order();
		order.setUid(finishOrder.getUid());
		order.setCid(finishOrder.getCid());

		int num1 = orderDaoService.removeOrder(order);
		int num2 = ticketDaoService.backTicket(order);
		int num3 = FinishOrderDaoService.addFinishOrder(finishOrder);
		if (num1 > 0 && num2 > 0 && num3 > 0) {
			String time = StaticLog.nowTime();
			String log = time+",用户同意退票";
			StaticLog.insertLog(aName+"-ad", log);
			return 1;
		} else {
			return -1;
		}
	}

	// 管理拒绝退单
	@RequestMapping("/noBackOrder")
	@ResponseBody
	public int noBackOrder(Order order,HttpServletRequest request) {
		String aName = (String) request.getSession().getAttribute("adminname");
		int num = orderDaoService.disBackOrder(order);
		if (num > 0) {
			String time = StaticLog.nowTime();
			String log = time+",用户拒绝退票";
			StaticLog.insertLog(aName+"-ad", log);
			return 1;
		} else {
			return 0;
		}
	}

	// 用户完成订单
	@RequestMapping("/finishOrder")
	@ResponseBody
	public int finishOrder(FinishOrder finishOrder, HttpServletRequest request) {
		System.out.println(finishOrder);
		Order order = new Order();
		order.setCid(finishOrder.getCid());
		order.setUid((Integer) request.getSession().getAttribute("uid"));
		finishOrder.setUid((Integer) request.getSession().getAttribute("uid"));
		int num1 = orderDaoService.removeOrder(order);
		int num2 = FinishOrderDaoService.addFinishOrder(finishOrder);
		if (num1 > 0 && num2 > 0) {
			String userName = (String) request.getSession().getAttribute("username");
			String time = StaticLog.nowTime();
			String log = time+",用户完成订单";
			StaticLog.insertLog(userName, log);
			return 1;
		} else {
			return -1;
		}
	}
}
