package com.sh.frame.system.web;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.sh.frame.system.domain.DictType;
import com.sh.frame.system.service.IDictTypeService;
import com.sh.frame.utils.JQueryDataTablesUtil;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;

public class DictTypeManageAction extends BaseAction<DictType> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private IDictTypeService dicttypeService;

	private String validateCode;
	private Long validateId;

	public void prepare() throws Exception {
		if (id != null) {
			entity = dicttypeService.findById(id);
		} else
			entity = new DictType();
	}

	public String insert() {
		return INSERT;
	}

	public String edit() {
		return EDIT;
	}

	public String view() {
		return VIEW;
	}

	public void save() {
		try {
			entity.setFlag(true);
			dicttypeService.saveOrUpdate(entity);
			dicttypeService.flush();
			msgResult.put("status", true);
			msgResult.put("info", "保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			msgResult.put("status", false);
			msgResult.put("info", "保存失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}

	public String list() {
		return LIST;
	}

	public void delete() {
		try {
			dicttypeService.delete(entity);
			dicttypeService.flush();
			msgResult.put("status", true);
			msgResult.put("info", "删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			msgResult.put("status", false);
			msgResult.put("info", "删除失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}

	public void listAllForJQueryDataTable() {
		CustomExample<DictType> example = new CustomExample<DictType>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {

				criteria.addOrder(Order.desc("id")).addOrder(Order.asc("seqno"));
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = dicttypeService.findPageByExample(example, PaginationSupport.pageToIndex(pageNum, numPerPage),
				numPerPage);
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(),
				listResult));
	}

	public String listForSelect() {
		CustomExample<DictType> example = new CustomExample<DictType>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {

			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = dicttypeService.findPageByExample(example, PaginationSupport.pageToIndex(pageNum, numPerPage),
				numPerPage);

		return "listForSelect";
	}

	public void validateCode(){
		DetachedCriteria criterion = DetachedCriteria.forClass(DictType.class);
		criterion.add(Restrictions.eq("code", validateCode));
		List<DictType> l = dicttypeService.findAllByCriteria(criterion);
		if(validateId != null){
			DictType d = dicttypeService.findById(validateId);
			l.remove(d);
		}
		responseHtml(JQueryDataTablesUtil.beanToJson(l));
	}

	public String getValidateCode() {
		return validateCode;
	}

	public void setValidateCode(String validateCode) {
		this.validateCode = validateCode;
	}

	public Long getValidateId() {
		return validateId;
	}

	public void setValidateId(Long validateId) {
		this.validateId = validateId;
	}
}
