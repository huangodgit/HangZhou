package com.qqpp.qzce.baseInfo.service;

import com.qqpp.qzce.baseInfo.domain.Video;
import com.sh.frame.base.service.BaseServiceImpl;
import org.springframework.stereotype.Component;

@Component(value = "videoService")
public class VideoService extends BaseServiceImpl<Video> implements IVideoService {

	private static final long serialVersionUID = 1L;

	public VideoService() {
		super(Video.class);
	}

}
