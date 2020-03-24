package com.qqpp.qzce.baseInfo.service;

import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.qqpp.qzce.baseInfo.domain.ProjectProgress;


@Component(value = "projectProgressService")
public class ProjectProgressService extends BaseServiceImpl<ProjectProgress> implements IProjectProgressService {

	private static final long serialVersionUID = 1L;

	public ProjectProgressService() {
		super(ProjectProgress.class);
	}

}
