package com.qqpp.qzce.news.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.qqpp.qzce.news.domain.NewsSupport;

@Component(value = "newsSupportService")
public class NewsSupportService extends BaseServiceImpl<NewsSupport>implements INewsSupportService {
	private static final long serialVersionUID = 1L;

	public NewsSupportService() {
		super(NewsSupport.class);

	}

	@Override
	public boolean checkExist(String identify, Long id) {
		DetachedCriteria criterion = DetachedCriteria.forClass(NewsSupport.class);
		criterion.add(Restrictions.eq("identify", identify)).add(Restrictions.eq("news.id", id));
		List<NewsSupport> list = this.getLocalDao().findAllByCriteria(criterion);
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

}
