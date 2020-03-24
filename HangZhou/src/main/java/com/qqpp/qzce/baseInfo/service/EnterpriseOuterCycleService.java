package com.qqpp.qzce.baseInfo.service;

import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.qqpp.qzce.baseInfo.domain.EnterpriseOuterCycle;

@Component(value = "enterpriseOuterCycleService")
public class EnterpriseOuterCycleService extends BaseServiceImpl<EnterpriseOuterCycle>implements IEnterpriseOuterCycleService {

	private static final long serialVersionUID = 1L;

	public EnterpriseOuterCycleService() {
		super(EnterpriseOuterCycle.class);
	}

}
