package com.sh.frame.system.service;

import java.util.List;

import com.sh.frame.system.domain.UserGroup;
import com.sh.frame.base.service.IBaseService;

public interface IUserGroupService extends IBaseService<UserGroup> {

	public void invalid(UserGroup entity);

	public UserGroup findById(Long id);

	public UserGroup findByIdEx(Long id);

	public List<UserGroup> getAllNodes();
}
