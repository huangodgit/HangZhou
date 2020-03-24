package com.qqpp.qzce.news.service;

import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.qqpp.qzce.news.domain.News;

@Component(value = "newsService")
public class NewsService extends BaseServiceImpl<News>implements INewsService {
	private static final long serialVersionUID = 1L;

	public NewsService() {
		super(News.class);

	}

}
