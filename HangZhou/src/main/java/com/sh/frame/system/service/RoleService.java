package com.sh.frame.system.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sh.frame.base.dao.IBaseDao;
import com.sh.frame.base.service.BaseServiceImpl;
import com.sh.frame.constant.ValidFlag;
import com.sh.frame.system.domain.Module;
import com.sh.frame.system.domain.Role;

import freemarker.template.utility.StringUtil;

@Component(value = "roleService")
public class RoleService extends BaseServiceImpl<Role> implements IRoleService {

	private static final long serialVersionUID = 1L;

	public RoleService() {
		super(Role.class);
	}
	

	public void saveRoleModule(Role entity, List<Long> idList) {
		IBaseDao<Module> moduleDao = this.getDao(Module.class);
		List<Module> moduleList = new ArrayList<Module>();
		for (Long id : idList) {
			Module module = moduleDao.findById(id);
			moduleList.add(module);
		}

		entity = getLocalDao().findById(entity.getId());
		entity.getMenuList().removeAll(entity.getMenuList());
		entity.getMenuList().addAll(moduleList);

		this.getLocalDao().saveOrUpdate(entity);
	}

	public void saveRoleModule(Role entity, String moduleStr){
		String[] modules=null;
		//entity.getMenuList().clear();
		/*if (moduleStr!=null&&moduleStr.trim().length()>0){
			modules=StringUtil.split(moduleStr,',');
			List<Module> moduleList = new ArrayList<Module>();
			IBaseDao<Module> moduleDao = this.getDao(Module.class);
			for (String module:modules){
				moduleList.add(moduleDao.findById(Long.valueOf(module)));
			}
			entity.getMenuList().addAll(moduleList);
		};*/
		
		//选择的菜单不为空，则进入保存方法
		if (moduleStr!=null&&moduleStr.trim().length()>0)
		{
			
			IBaseDao<Module> moduleDao = this.getDao(Module.class);
			/*
			 * 1.得到的所有菜单
			 * 2.找出应该从原来中去除的，删除
			 * 3.找出应该从原来中增加的，添加
			 */
			// 1modules 是从页面端过来的所有选择的菜单项，ids
			modules=StringUtil.split(moduleStr,',');

			//2
			Iterator<Module> it =  entity.getMenuList().iterator();
			while(it.hasNext())
			{
				Module m = (Module) it.next();
				System.out.print(m.getId() + ",");
				if(!inStrs(m.getId().toString(), modules))
				{
					it.remove();
				}
			}
			
			//3
			for (String module:modules){
				if(!inStrs(module, entity.getMenuList()))
				{
					entity.getMenuList().add(moduleDao.findById(Long.valueOf(module)));
				}
				
			}
			
		}
		else
		{
			entity.getMenuList().clear();
		}
		
		this.getLocalDao().saveOrUpdate(entity);
		
	}
	
	private boolean inStrs(String src, String[] targets)
	{
		boolean flag = false;
		for (String target:targets){
			if(src.equals(target))
			{
				flag = true;
				break;
			}
		}
		return flag;
	}
	
	private boolean inStrs(String src, Set<Module> targets)
	{
		boolean flag = false;
		Iterator<Module> it =  targets.iterator();
		while(it.hasNext())
		{
			Module m = (Module) it.next();
			if(src.equals(m.getId().toString()))
			{
				flag = true;
				break;
			}
		}
		return flag;
	}
 
	public Role findById(Long id) {
		Role entity = super.findById(id);
		entity.getMenuList().size();
		return entity;
	}
	
	public Role findByIdEx(Long id){
		Session session = sessionFactory.openSession();
		Role tempRole = (Role) session.get(Role.class, id);
		Hibernate.initialize(tempRole.getMenuList());
		session.close();
		return tempRole;
	}

	public void invalid(Role entity) {
		entity = this.getLocalDao().findById(entity.getId());
		entity.setValidFlag(ValidFlag.INVALID);
		this.getLocalDao().saveOrUpdate(entity);
	}

	public List<Role> getAllNodes() {
		DetachedCriteria criterion = DetachedCriteria.forClass(Role.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.addOrder(Order.asc("id"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}

	public List<Role> getChildrenById(Long Id) {
		DetachedCriteria criterion = DetachedCriteria.forClass(Role.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.addOrder(Order.asc("id"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}

	public List<Role> getTopLevel() {
		DetachedCriteria criterion = DetachedCriteria.forClass(Role.class);
		criterion.add(Restrictions.isNull("parent"));
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.addOrder(Order.asc("id"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}

	public List<Role> getAllNodesById(Long Id) {
		DetachedCriteria criterion = DetachedCriteria.forClass(Role.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.addOrder(Order.asc("id"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}

}