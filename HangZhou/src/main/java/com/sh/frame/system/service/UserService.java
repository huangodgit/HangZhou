package com.sh.frame.system.service;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sh.frame.constant.ValidFlag;
import com.sh.frame.system.domain.User;
import com.sh.frame.base.service.BaseServiceImpl;

@Component(value = "userService")
public class UserService extends BaseServiceImpl<User> implements IUserService {

	private static final long serialVersionUID = 123123123L;

	public UserService() {
		super(User.class);
	}

	public User findById(Long id) {
		User entity = super.findById(id);
		return entity;
	}

	public User findByIdEx(Long id) {
		Session session = sessionFactory.openSession();
		User tempUser = (User) session.get(User.class, id);
		Hibernate.initialize(tempUser.getRoleList());
		Hibernate.initialize(tempUser.getOrg());
//		Hibernate.initialize(tempUser.getGroups());
		session.close();
		return tempUser;
	}
	
	/**
	 * 用户登入
	 */
	public User findByLoginNameAndPwdEx(String loginName, String pwd) {
		DetachedCriteria criterion = DetachedCriteria.forClass(User.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.add(Restrictions.eq("loginName", loginName.trim()));
		List<User> users = this.getLocalDao().findAllByCriteria(criterion);
		if(users.isEmpty()){
			throw new RuntimeException("用户名不存在！");
		}else if(users.size()>1){
			throw new RuntimeException("存在多个相同用户名，请与管理员联系！");
		}else if(!users.get(0).getPassword().equals(pwd.trim())&& users.size() == 1){
			throw new RuntimeException("密码错误！");
		}else if(users.get(0).getPassword().equals(pwd.trim())&& users.size() == 1){
			Session session = sessionFactory.openSession();
			User tempUser = (User) session.get(User.class, users.get(0).getId());
			Hibernate.initialize(tempUser.getRoleList());
			Hibernate.initialize(tempUser.getOrg());
			session.close();
			return tempUser;
		}else{
			throw new RuntimeException("登入失败！");
		}
	}
	
	

	public List<User> listAllNeedTips() {
		DetachedCriteria criterion = DetachedCriteria.forClass(User.class);
		criterion.add(Restrictions.eq("needTips", true));
		return this.getLocalDao().findAllByCriteria(criterion);
	}
	
	public void deleteAll(String tableName, String ids) {
		String sql = "delete from " + tableName + " where id in ("+ids+")" ;
		this.getLocalDao().excuteBySql(sql);
	}
	
	public void deleteByTime(String tableName, String time,String dataType) {
		String sql = "delete from "+tableName+ " where to_char(rksj,'yyyy-mm-dd')='"+time+"'";
		if("success".equalsIgnoreCase(dataType)){
			sql+=" and sjbdjg like '%"+"比对成功"+"%'";
		}else if("failure".equalsIgnoreCase(dataType)){
			sql+=" and sjbdjg like '%"+"比对失败"+"%'";
		}else if("all".equalsIgnoreCase(dataType)){
		}else{
			throw new RuntimeException("无法删除数据！");
		}
		this.getLocalDao().excuteBySql(sql);
	}

	@Override
	public User findByLoginName(String loginName) {
		DetachedCriteria criterion = DetachedCriteria.forClass(User.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.add(Restrictions.eq("loginName", loginName.trim()));
		List<User> users = this.getLocalDao().findAllByCriteria(criterion);
		if(users.isEmpty()){
			throw new RuntimeException("用户名不存在！");
		}else if(users.size()>1){
			throw new RuntimeException("存在多个相同用户名，请与管理员联系！");
		}else{
			Session session = sessionFactory.openSession();
			User tempUser = (User) session.get(User.class, users.get(0).getId());
			Hibernate.initialize(tempUser.getRoleList());
			Hibernate.initialize(tempUser.getOrg());
			session.close();
			return tempUser;
		}
	}
}
