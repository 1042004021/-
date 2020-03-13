package xyz.xqsr.dao;

import java.util.List;

import xyz.xqsr.model.FinishOrder;

public interface FinishOrderDao {
	//显示当前用户所有已完成订单
	public List<FinishOrder> allFinishOrder(FinishOrder finishOrder);
	//添加完成订单
	public int addFinishOrder(FinishOrder finishOrder);
}
