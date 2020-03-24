package com.sh.frame.system.service;

import java.util.List;

import com.sh.frame.base.service.IBaseService;
import com.sh.frame.system.domain.Dict;

public interface IDictService extends IBaseService<Dict> {

	List<Dict> getDictList(String dictTypeCode);

	String getDictName(String dictTypeCode, String dictCode);
	
	public Dict findByCode(String code);
}
