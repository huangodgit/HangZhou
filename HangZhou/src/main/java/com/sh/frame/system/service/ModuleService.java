package com.sh.frame.system.service;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sh.frame.constant.ValidFlag;
import com.sh.frame.system.domain.Module;
import com.sh.frame.base.service.BaseServiceImpl;

@Component(value = "moduleService")
public class ModuleService extends BaseServiceImpl<Module>implements IModuleService {

	private static final long serialVersionUID = 1L;

	public ModuleService() {
		super(Module.class);
	}

	public void invalid(Module entity) {
		entity = this.getLocalDao().findById(entity.getId());
		entity.setValidFlag(ValidFlag.INVALID);
		this.getLocalDao().saveOrUpdate(entity);
		List<Module> children = getChildrenById(entity.getId());
		for (Module child : children) {
			invalid(child);
		}
	}

	public Module findById(Long id) {
		Module entity = super.findById(id);
		return entity;
	}

	public Module findByIdEx(Long id) {
		Session session = sessionFactory.openSession();
		Module tempModule = (Module) session.get(Module.class, id);
		Hibernate.initialize(tempModule.getParent());
		session.close();
		return tempModule;
	}

	public List<Module> getChildrenById(Long id) {
		DetachedCriteria criterion = DetachedCriteria.forClass(Module.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.createCriteria("parent").add(Restrictions.eq("id", id));
		criterion.addOrder(Order.asc("sortnum"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}

	// 顶级部门 parent is null
	public List<Module> getTopLevel() {
		DetachedCriteria criterion = DetachedCriteria.forClass(Module.class);
		criterion.add(Restrictions.isNull("parent"));
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.addOrder(Order.asc("sortnum"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}

	public List<Module> getAllNodes() {
		DetachedCriteria criterion = DetachedCriteria.forClass(Module.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.addOrder(Order.asc("sortnum"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}


}
