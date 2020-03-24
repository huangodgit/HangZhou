package com.qqpp.qzce.baseInfo.service;

import java.util.List;

import com.sh.frame.base.service.IBaseService;
import com.qqpp.qzce.baseInfo.domain.Project;

public interface IProjectService extends IBaseService<Project> {

	List<Project> findAllByBoundary(String minX, String minY, String maxX, String maxY);
}
