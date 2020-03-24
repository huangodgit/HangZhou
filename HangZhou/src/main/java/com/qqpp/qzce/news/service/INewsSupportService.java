package com.qqpp.qzce.news.service;

import com.sh.frame.base.service.IBaseService;
import com.qqpp.qzce.news.domain.NewsSupport;

public interface INewsSupportService extends IBaseService<NewsSupport> {

	boolean checkExist(String identify, Long id);
	
}
