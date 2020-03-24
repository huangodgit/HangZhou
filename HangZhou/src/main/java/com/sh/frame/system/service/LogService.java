/**
 * 
 */
package com.sh.frame.system.service;

import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sh.frame.system.domain.Log;
import com.sh.frame.system.domain.User;
import com.sh.frame.base.service.BaseServiceImpl;

/**
 * @packageName com.jc.system.service
 * @className LogService.java
 * @author WangChen
 * @date Jul 14, 2012
 * @instruction
 */
@Component(value = "logService")
public class LogService extends BaseServiceImpl<Log>implements ILogService {

	private static final long serialVersionUID = 3500587563897105576L;

	public LogService() {
		super(Log.class);
	}

	public Date getMaxDateByUser(User u) {
		DetachedCriteria criterion = DetachedCriteria.forClass(Log.class);
		criterion.createCriteria("user").add(Restrictions.eq("id", u.getId()));
		criterion.addOrder(Order.desc("vistdate"));
		List<Log> l = this.getLocalDao().findAllByCriteria(criterion);
		if (l.size() == 0)
			return null;
		else
			return l.get(0).getVistdate();
	}

}
