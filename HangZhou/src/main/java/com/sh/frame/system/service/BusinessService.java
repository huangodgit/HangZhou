package com.sh.frame.system.service;

import com.sh.frame.base.service.BaseServiceImpl;
import com.sh.frame.system.domain.Business;
import org.springframework.stereotype.Component;

@Component(value = "businessService")
public class BusinessService extends BaseServiceImpl<Business> implements IBusinessService {

    private static final long serialVersionUID = 1L;

    public BusinessService() {
        super(Business.class);
}

}
