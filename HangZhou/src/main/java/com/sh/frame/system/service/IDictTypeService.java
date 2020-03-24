package com.sh.frame.system.service;

import java.util.List;

import com.sh.frame.base.service.IBaseService;
import com.sh.frame.system.domain.DictType;

public interface IDictTypeService extends IBaseService<DictType> {

	public List<DictType> findAllValid();

	public DictType findByCode(String code);

}
