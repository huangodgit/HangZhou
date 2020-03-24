package com.qqpp.qzce.baseInfo.service;

import java.util.List;

import com.sh.frame.base.service.IBaseService;
import com.qqpp.qzce.baseInfo.domain.Enterprise;

public interface IEnterpriseService extends IBaseService<Enterprise> {

	List<Enterprise> findAllByBoundary(String minX, String minY, String maxX, String maxY);
}
