package com.qqpp.qzce.baseInfo.service;

import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.qqpp.qzce.baseInfo.domain.EnterpriseInnerCycle;

@Component(value = "enterpriseInnerCycleService")
public class EnterpriseInnerCycleService extends BaseServiceImpl<EnterpriseInnerCycle>
		implements IEnterpriseInnerCycleService {

	private static final long serialVersionUID = 1L;

	public EnterpriseInnerCycleService() {
		super(EnterpriseInnerCycle.class);
	}

}
