package xyz.xqsr.dao;

import java.util.List;

import xyz.xqsr.model.Order;
import xyz.xqsr.model.Ticket;

public interface TicketDao {
	//查询所有票
	public List<Ticket> allTicket();
	//查询指定票
	public List<Ticket> searchTicket(Ticket ticket);
	//购买票数
	public int buyTicket(Order order);
	//票数加一
	public int backTicket(Order order);
	//回显票
	public Ticket selectTicket(Ticket ticket);
	//修改票数
	public int updateTicket(Ticket ticket);
	//新增车票
	public int addTicket(Ticket ticket);
	//删除车票
	public int deleteTicket(Ticket ticket);
}
