package com.sh.frame.system.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.sh.frame.system.domain.DictType;

@Component(value = "dicttypeService")
public class DictTypeService extends BaseServiceImpl<DictType>implements IDictTypeService {

	private static final long serialVersionUID = 1L;

	public DictTypeService() {
		super(DictType.class);
	}

	public List<DictType> findAllValid() {
		DetachedCriteria dc = DetachedCriteria.forClass(DictType.class);
		return this.getLocalDao().findAllByCriteria(dc);
	}

	public DictType findByCode(String code) {
		DetachedCriteria criterion = DetachedCriteria.forClass(DictType.class);
		criterion.add(Restrictions.eq("code", code));
		List<DictType> l = this.getLocalDao().findAllByCriteria(criterion);
		if (l != null & l.size() > 0) {
			return l.get(0);
		}
		return null;
	}

}