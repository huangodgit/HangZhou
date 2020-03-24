package com.sh.frame.system.service;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sh.frame.constant.ValidFlag;
import com.sh.frame.system.domain.UserGroup;
import com.sh.frame.base.service.BaseServiceImpl;

@Component(value = "userGroupService")
public class UserGroupService extends BaseServiceImpl<UserGroup> implements IUserGroupService{
	private static final long serialVersionUID = 1L;
	public UserGroupService() {
		super(UserGroup.class);
	}
	
	public void invalid(UserGroup entity) {
		entity = this.getLocalDao().findById(entity.getId());
		entity.setValidFlag(ValidFlag.INVALID);
		this.getLocalDao().saveOrUpdate(entity);
		List<UserGroup> children = getChildrenById(entity.getId());
		for (UserGroup child : children) {
			invalid(child);
		}
	}

	public UserGroup findById(Long id) {
		UserGroup entity = super.findById(id);
		return entity;
	}

	public UserGroup findByIdEx(Long id) {
		UserGroup tempUserGroup = this.getLocalDao().findById(id);
		Hibernate.initialize(tempUserGroup.getParent());
		return tempUserGroup;
	}

	public List<UserGroup> getChildrenById(Long id) {
		DetachedCriteria criterion = DetachedCriteria.forClass(UserGroup.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.createCriteria("parent").add(Restrictions.eq("id", id));
		criterion.addOrder(Order.asc("sortnum"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}

	// 顶级部门 parent is null
	public List<UserGroup> getTopLevel() {
		DetachedCriteria criterion = DetachedCriteria.forClass(UserGroup.class);
		criterion.add(Restrictions.isNull("parent"));
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.addOrder(Order.asc("sortnum"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}
	/* (non-Javadoc)
	 * @see com.jc.support.util.ITreeUtil#getAllNodes()
	 */
	public List<UserGroup> getAllNodes() {
		DetachedCriteria criterion = DetachedCriteria.forClass(UserGroup.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.addOrder(Order.asc("sortnum"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}
	

}
