package com.sh.frame.system.web;

import com.google.gson.Gson;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.system.domain.Dict;
import com.sh.frame.system.service.IDictService;
import com.sh.frame.system.service.IDictTypeService;
import com.sh.frame.utils.JQueryDataTablesUtil;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class DictManageAction extends BaseAction<Dict> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private IDictService dictService;
	@Autowired(required = true)
	private IDictTypeService dicttypeService;
	
	private Long dictId;
	private String validateCode;
	private Long validateId;

	public void prepare() throws Exception {
		if (id != null) {
			entity = dictService.findById(id);
		} else
			entity = new Dict();
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
			entity.setDictType(dicttypeService.findById(dictId));
			entity.setSeqno(0);
			if(entity.getFlag() == null){
			    entity.setFlag(true);
			}
			dictService.saveOrUpdate(entity);
			dictService.flush();
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
			dictService.delete(entity);
			dictService.flush();
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
		CustomExample<Dict> example = new CustomExample<Dict>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {

				criteria.addOrder(Order.desc("id")).addOrder(Order.asc("seqno"));
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = dictService.findPageByExample(example, PaginationSupport.pageToIndex(pageNum, numPerPage),
				numPerPage);
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(),
				listResult));
	}

	public String listForSelect() {
		CustomExample<Dict> dictCustomExample = new CustomExample<Dict>(this.getModel()) {};
		dictCustomExample.enableLike(MatchMode.ANYWHERE);
		this.listResult = dictService.findPageByExample(dictCustomExample,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		return "listForSelect";
	}

	public void validateCode(){
		DetachedCriteria criterion = DetachedCriteria.forClass(Dict.class);
		criterion.add(Restrictions.eq("dictType", dicttypeService.findById(dictId)));
		criterion.add(Restrictions.eq("code", validateCode));
		List<Dict> l = dictService.findAllByCriteria(criterion);
		if(validateId != null){
			Dict d = dictService.findById(validateId);
			l.remove(d);
		}
		responseHtml(JQueryDataTablesUtil.beanToJson(l));
	}
	
	public Long getDictId() {
		return dictId;
	}

	public void setDictId(Long dictId) {
		this.dictId = dictId;
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
