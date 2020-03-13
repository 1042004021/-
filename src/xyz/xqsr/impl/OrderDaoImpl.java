package xyz.xqsr.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xyz.xqsr.dao.OrderDao;
import xyz.xqsr.model.Order;
import xyz.xqsr.model.Ticket;
import xyz.xqsr.service.OrderDaoService;

@Service("OrderDaoService")
@Transactional
public class OrderDaoImpl implements OrderDaoService {

	@Resource
	private OrderDao orderDao;
	
	public int bind(Order order) {
		return orderDao.bind(order);
	}

	public List<Ticket> allOrder(Order order) {
		
		return orderDao.allOrder(order);
	}

	public int backOrder(Order order) {
		
		return orderDao.backOrder(order);
	}

	public List<Ticket> showBackOrder(Order order) {

		return orderDao.showBackOrder(order);
	}

	public List<Ticket> allBackOrder() {
		
		return orderDao.allBackOrder();
	}

	public int removeOrder(Order order) {

		return orderDao.removeOrder(order);
	}

	public int disBackOrder(Order order) {

		return orderDao.disBackOrder(order);
	}

}
