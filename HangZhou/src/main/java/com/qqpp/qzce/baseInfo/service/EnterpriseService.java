package com.qqpp.qzce.baseInfo.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.qqpp.qzce.baseInfo.domain.Enterprise;

@Component(value = "enterpriseService")
public class EnterpriseService extends BaseServiceImpl<Enterprise> implements IEnterpriseService {

	private static final long serialVersionUID = 1L;

	public EnterpriseService() {
		super(Enterprise.class);
	}

	@Override
	public List<Enterprise> findAllByBoundary(String minX, String minY, String maxX, String maxY) {
		DetachedCriteria criterion = DetachedCriteria.forClass(Enterprise.class);
		criterion.add(Restrictions.ge("longitude", minX));
		criterion.add(Restrictions.le("longitude", maxX));
		criterion.add(Restrictions.ge("latitude", minY));
		criterion.add(Restrictions.le("latitude", maxY));
		return this.getLocalDao().findAllByCriteria(criterion);
	}

}
