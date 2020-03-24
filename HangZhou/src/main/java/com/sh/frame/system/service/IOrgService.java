package com.sh.frame.system.service;

import com.sh.frame.system.domain.Org;
import com.sh.frame.base.service.IBaseService;

public interface IOrgService extends IBaseService<Org> {

	public void invalid(Org entity);

	public Org findById(Long id);

	public Org findByIdEx(Long id);

	public Org findByDepartCode(String departCode);

	public int findMaxSortNum();

	public void deleteOrgByName(String name);
}
