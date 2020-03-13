package xyz.xqsr.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import xyz.xqsr.dao.TicketDao;
import xyz.xqsr.model.Order;
import xyz.xqsr.model.Ticket;
import xyz.xqsr.service.TicketDaoService;


@Service("TicketDaoService")
@Transactional
public class TicketDaoImpl implements TicketDaoService {
	@Resource
	private TicketDao ticketDao;

	//查询所有车票
	public List<Ticket> allTicket() {
		
		return ticketDao.allTicket();
	}
	//查询指定地点车票
	public List<Ticket> searchTicket(Ticket ticket) {
		return ticketDao.searchTicket(ticket);
	}
	public int buyTicket(Order order) {
		
		return ticketDao.buyTicket(order);
	}
	public int backTicket(Order order) {
		
		return ticketDao.backTicket(order);
	}
	public Ticket selectTicket(Ticket ticket) {

		return ticketDao.selectTicket(ticket);
	}
	public int updateTicket(Ticket ticket) {

		return ticketDao.updateTicket(ticket);
	}
	public int addTicket(Ticket ticket) {
		
		return ticketDao.addTicket(ticket);
	}
	public int deleteTicket(Ticket ticket) {
		
		return ticketDao.deleteTicket(ticket);
	}
	
	
}
