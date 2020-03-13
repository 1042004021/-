package xyz.xqsr.dao;

import java.util.List;

import xyz.xqsr.model.Order;
import xyz.xqsr.model.Ticket;

public interface OrderDao {
	//将订单与用户绑定
	public int bind(Order order);
	//查询当前用户所有订单
	public List<Ticket> allOrder(Order order);
	//退单
	public int backOrder(Order order);
	//显示退单
	public List<Ticket> showBackOrder(Order order);
	//显示所有退单
	public List<Ticket> allBackOrder();
	//移除订单
	public int removeOrder(Order order);
	//拒绝退单
	public int disBackOrder(Order order);
	
}
