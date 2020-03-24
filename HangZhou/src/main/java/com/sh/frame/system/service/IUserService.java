package com.sh.frame.system.service;

import java.util.List;

import com.sh.frame.system.domain.User;
import com.sh.frame.base.service.IBaseService;

public interface IUserService extends IBaseService<User> {
	public User findById(Long id);

	public User findByIdEx(Long id);
	
	public User findByLoginName(String loginName);
	
	public User findByLoginNameAndPwdEx(String loginName, String pwd);
	
	public List<User> listAllNeedTips();
	
	public void deleteAll(String tableName, String ids) ;
	
	public void deleteByTime(String tableName, String time, String type);
}
