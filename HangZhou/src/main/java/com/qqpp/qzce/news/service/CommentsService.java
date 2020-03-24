package com.qqpp.qzce.news.service;

import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.qqpp.qzce.news.domain.Comments;

@Component(value = "commentsService")
public class CommentsService extends BaseServiceImpl<Comments>implements ICommentsService {
	private static final long serialVersionUID = 1L;

	public CommentsService() {
		super(Comments.class);

	}

}
