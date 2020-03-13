package xyz.xqsr.service;

import java.util.List;

import xyz.xqsr.dao.FinishOrderDao;
import xyz.xqsr.model.FinishOrder;

public interface FinishOrderDaoService {

	// 显示当前用户所有已完成订单
	public List<FinishOrder> allFinishOrder(FinishOrder finishOrder);

	// 添加完成订单
	public int addFinishOrder(FinishOrder finishOrder);

}
