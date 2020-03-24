package com.sh.frame.system.service;

import java.util.List;

import com.sh.frame.system.domain.Role;
import com.sh.frame.base.service.IBaseService;

public interface IRoleService extends IBaseService<Role>{
	public void saveRoleModule(Role entity, List<Long> idList);

	public Role findById(Long id);

	public Role findByIdEx(Long id);

	public void saveRoleModule(Role entity, String moduleStr);

}
