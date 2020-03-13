package xyz.xqsr.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xyz.xqsr.dao.FinishOrderDao;
import xyz.xqsr.model.FinishOrder;
import xyz.xqsr.service.FinishOrderDaoService;

@Service("FinishOrderDaoService")
@Transactional
public class FinishOrderImpl implements FinishOrderDaoService {

	
	@Resource
	private FinishOrderDao finishOrderDao;

	public List<FinishOrder> allFinishOrder(FinishOrder finishOrder) {
		
		return finishOrderDao.allFinishOrder(finishOrder);
	}

	public int addFinishOrder(FinishOrder finishOrder) {
		
		return finishOrderDao.addFinishOrder(finishOrder);
	}

	
}
