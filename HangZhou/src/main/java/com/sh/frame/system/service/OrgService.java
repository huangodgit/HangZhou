package com.sh.frame.system.service;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sh.frame.constant.ValidFlag;
import com.sh.frame.system.domain.Org;
import com.sh.frame.base.service.BaseServiceImpl;

@Component(value = "orgService")
public class OrgService extends BaseServiceImpl<Org> implements IOrgService{
	private static final long serialVersionUID = 1L;
	public OrgService() {
		super(Org.class);
	}
	public void invalid(Org entity) {
		entity = this.getLocalDao().findById(entity.getId());
		entity.setValidFlag(ValidFlag.INVALID);
		this.getLocalDao().saveOrUpdate(entity);
		List<Org> children = getChildrenById(entity.getId());
		for (Org child : children) {
			invalid(child);
		}
	}

	public Org findById(Long id) {
		Org entity = super.findById(id);
		return entity;
	}

	public Org findByIdEx(Long id) {
		Session session = sessionFactory.openSession();
		Org tempOrg = (Org) session.get(Org.class, id);
		Hibernate.initialize(tempOrg.getParent());
		session.close();
		return tempOrg;
	}

	public List<Org> getChildrenById(Long id) {
		DetachedCriteria criterion = DetachedCriteria.forClass(Org.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.createCriteria("parent").add(Restrictions.eq("id", id));
		criterion.addOrder(Order.asc("sortnum"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}

	// 顶级部门 parent is null
	public List<Org> getTopLevel() {
		DetachedCriteria criterion = DetachedCriteria.forClass(Org.class);
		criterion.add(Restrictions.isNull("parent"));
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.addOrder(Order.asc("sortnum"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}
	/* (non-Javadoc)
	 * @see com.jc.support.util.ITreeUtil#getAllNodes()
	 */
	public List<Org> getAllNodes() {
		DetachedCriteria criterion = DetachedCriteria.forClass(Org.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.addOrder(Order.asc("sortnum"));
		return this.getLocalDao().findAllByCriteria(criterion);
	}
	public List<Org> getAllNodesById(Long Id) {
		return this.getAllNodes();
	}
	
	public Org findByDepartCode(String departCode) {

		DetachedCriteria criterion = DetachedCriteria.forClass(Org.class);
		criterion.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		criterion.add(Restrictions.eq("code", departCode));
		List<Org> l = this.getLocalDao().findAllByCriteria(criterion);
		if(l.size()>0)
			return l.get(0);
		else
			return null;
	}
	public int findMaxSortNum() {
		return this.getLocalDao().getValueX("select max(sortnum) x from system_org");
	}
	
	
	
	public void deleteOrgByName(String name){
		try{
			String sql = "delete System_org t where t.name='"+name.trim()+"'";
			this.getLocalDao().excuteBySql(sql);
		}catch(Exception e) {
			throw new RuntimeException("删除部门:"+name+"失败！");
		}
	}
}
