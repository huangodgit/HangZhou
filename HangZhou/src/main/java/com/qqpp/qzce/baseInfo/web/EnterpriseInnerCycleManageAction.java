package com.qqpp.qzce.baseInfo.web;

import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.utils.JQueryDataTablesUtil;
import com.qqpp.qzce.baseInfo.domain.Enterprise;
import com.qqpp.qzce.baseInfo.domain.EnterpriseInnerCycle;
import com.qqpp.qzce.baseInfo.service.IEnterpriseInnerCycleService;
import com.qqpp.qzce.baseInfo.service.IEnterpriseService;

public class EnterpriseInnerCycleManageAction extends BaseAction<EnterpriseInnerCycle> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private IEnterpriseInnerCycleService enterpriseInnerCycleService;

	@Autowired(required = true)
	private IEnterpriseService enterpriseService;
	
	private Enterprise enterprise;
	
	private Long enterpriseId;
	
	@Override
	public void prepare() throws Exception {
		if (id != null) {
			entity = enterpriseInnerCycleService.findById(id);
		} else {
			entity = new EnterpriseInnerCycle();
		}
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
			if(enterpriseId!=null){
				enterprise=enterpriseService.findById(enterpriseId);
				entity.setEnterprise(enterprise);
			}
			enterpriseInnerCycleService.saveOrUpdate(entity);
			enterpriseInnerCycleService.flush();
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
			enterpriseInnerCycleService.delete(entity);
			enterpriseInnerCycleService.flush();
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
		CustomExample<EnterpriseInnerCycle> example = new CustomExample<EnterpriseInnerCycle>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {
				criteria.addOrder(Order.desc("id"));
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = enterpriseInnerCycleService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(), listResult));
	}

	public String listForSelect() {
		CustomExample<EnterpriseInnerCycle> example = new CustomExample<EnterpriseInnerCycle>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {

			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = enterpriseInnerCycleService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		return "listForSelect";
	}

	public Long getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	
	
}
