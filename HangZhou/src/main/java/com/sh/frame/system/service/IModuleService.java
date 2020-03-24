package com.sh.frame.system.service;

import com.sh.frame.system.domain.Module;
import com.sh.frame.base.service.IBaseService;

public interface IModuleService extends IBaseService<Module> {

	public void invalid(Module entity);

	public Module findById(Long id);

	public Module findByIdEx(Long id);

}
