package xyz.xqsr.controller;

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

@Controller
@RequestMapping("/FinishOrderController")
public class FinishOrderController {

	
	@Resource
	private FinishOrderDaoService finishOrderDaoService;
	
	Map<String, Object> result = new HashMap<String, Object>();
	
	
	//查询当前用户所有完成订单
	@RequestMapping("/allFinishOrder")
	@ResponseBody
	public Map<String, Object> allFinishOrder(int page, int limit, HttpServletRequest request) {
		FinishOrder finishOrder = new FinishOrder();
		try {
			int uid = (Integer) request.getSession().getAttribute("uid");
			
			System.out.println("uid:" + uid);
			
			finishOrder.setUid(uid);

			// pagehelper实现分页
			PageHelper.startPage(page, limit);

			List<FinishOrder> finishOrder2 = finishOrderDaoService.allFinishOrder(finishOrder);
			
			PageInfo<FinishOrder> pageInfo = new PageInfo<FinishOrder>(finishOrder2);

			long total = pageInfo.getTotal();
			System.out.println("total:"+total);

			List<FinishOrder> data = pageInfo.getList();

			System.out.println("data:"+data);
			result.put("total", total);

			result.put("data", data);
			System.out.println(result);
			return result;
			
		} catch (Exception e) {
			return null;
		}

	}
	
	
	//添加完成订单
	@RequestMapping("/addFinishOrder")
	@ResponseBody
	public int addFinishOrder(FinishOrder finishOrder) {
		int num = finishOrderDaoService.addFinishOrder(finishOrder);
		System.out.println(num);
		if(num>0) {
			return 1;
		}else{
			return -1;
		}
	}
	
}
