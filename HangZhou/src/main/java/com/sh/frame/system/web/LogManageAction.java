/**
 * 
 */
package com.sh.frame.system.web;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.sh.frame.system.domain.Log;
import com.sh.frame.system.domain.Org;
import com.sh.frame.system.service.ILogService;
import com.sh.frame.system.service.IOrgService;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;

/**
 * @packageName com.jc.system.web
 * @className LogManageAction.java
 * @author WangChen 
 * @date Jul 14, 2012
 * @instruction 
 */
public class LogManageAction extends BaseAction<Log> {


	/**
	 * 
	 */
	private static final long serialVersionUID = -8715775012606732944L;
	
	@Autowired(required = true)
	private ILogService logservice;
	
	@Autowired(required = true)
	private IOrgService orgService;
	
	private Map<String, String> parentMap;
	
	private Long parentId;
	
	
	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public Map<String, String> getParentMap() {
		return parentMap;
	}

	public void setParentMap(Map<String, String> parentMap) {
		this.parentMap = parentMap;
	}

	@Override
	public void prepare() throws Exception {
		if (id != null) {
			entity = logservice.findById(id);
		} else
			entity = new Log();
	}
	
	public String list() {
		parentMap = getBmList();
		CustomExample<Log> example = new CustomExample<Log>(this.getModel()) {
			private static final long serialVersionUID = 1L;
			public void appendCondition(Criteria criteria) {
				criteria.addOrder(Order.desc("vistdate"));
				if(getParentId()!=null){
					criteria.createCriteria("user").add(Restrictions.eq("parent.id",getParentId() ));
				}
				appendBetweenDateProperty(criteria);
			}
			
		};
		example.addBetweenDateProperty("vistdate", entity.getBeginDate(), entity.getEndDate());
		example.enableLike(MatchMode.ANYWHERE);
		try{
		this.listResult = logservice.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return LIST;
	}
	
	// 得到部门LIST
	public Map<String, String> getBmList() {
		Map<String, String> parentMap = new LinkedHashMap<String, String>();
		List<Org> parentList = orgService.findAllValid();
		for (Org s : parentList) {
			parentMap.put(s.getId().toString(), s.getName());
		}
		return parentMap;
	}
	
	public String view() {
		return VIEW;
	}
	

}
