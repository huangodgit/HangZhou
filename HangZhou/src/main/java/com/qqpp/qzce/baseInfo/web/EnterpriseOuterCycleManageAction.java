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
import com.qqpp.qzce.baseInfo.domain.EnterpriseOuterCycle;
import com.qqpp.qzce.baseInfo.service.IEnterpriseOuterCycleService;
import com.qqpp.qzce.baseInfo.service.IEnterpriseService;

public class EnterpriseOuterCycleManageAction extends BaseAction<EnterpriseOuterCycle> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private IEnterpriseOuterCycleService enterpriseOuterCycleService;
	
	@Autowired(required = true)
	private IEnterpriseService enterpriseService;

	private Long enterpriseId;
	
	private Enterprise enterprise;
	
	@Override
	public void prepare() throws Exception {
		if (id != null) {
			entity = enterpriseOuterCycleService.findById(id);
		} else {
			entity = new EnterpriseOuterCycle();
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
			enterpriseOuterCycleService.saveOrUpdate(entity);
			enterpriseOuterCycleService.flush();
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
			enterpriseOuterCycleService.delete(entity);
			enterpriseOuterCycleService.flush();
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
		CustomExample<EnterpriseOuterCycle> example = new CustomExample<EnterpriseOuterCycle>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {
				criteria.addOrder(Order.desc("id"));
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = enterpriseOuterCycleService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(), listResult));
	}

	public String listForSelect() {
		CustomExample<EnterpriseOuterCycle> example = new CustomExample<EnterpriseOuterCycle>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {

			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = enterpriseOuterCycleService.findPageByExample(example,
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
