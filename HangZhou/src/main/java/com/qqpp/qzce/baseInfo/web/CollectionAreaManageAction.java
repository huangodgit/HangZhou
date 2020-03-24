package com.qqpp.qzce.baseInfo.web;

import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.utils.JQueryDataTablesUtil;
import com.qqpp.qzce.baseInfo.domain.CollectionArea;
import com.qqpp.qzce.baseInfo.domain.Enterprise;
import com.qqpp.qzce.baseInfo.domain.Project;
import com.qqpp.qzce.baseInfo.service.ICollectionAreaService;
import com.qqpp.qzce.baseInfo.service.IEnterpriseService;
import com.qqpp.qzce.baseInfo.service.IProjectService;


public class CollectionAreaManageAction extends BaseAction<CollectionArea> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private ICollectionAreaService collectionAreaService;

	@Autowired(required = true)
	private IProjectService projectService;
	@Autowired(required = true)
	private IEnterpriseService enterpriseService;
	
	private String projectIds;
	private String enterpriseIds;

	@Override
	public void prepare() throws Exception {
		if (id != null) {
			entity = collectionAreaService.findById(id);
		} else {
			entity = new CollectionArea();
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
			collectionAreaService.saveOrUpdate(entity);
			collectionAreaService.flush();
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

	public String searchByGrid(){
		return "searchByGrid";
	}
	
	public void delete() {
		try {
			collectionAreaService.delete(entity);
			collectionAreaService.flush();
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
		CustomExample<CollectionArea> example = new CustomExample<CollectionArea>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {
				criteria.addOrder(Order.desc("id"));
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = collectionAreaService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(), listResult));
	}

	public String listForSelect() {
		CustomExample<CollectionArea> example = new CustomExample<CollectionArea>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {

			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = collectionAreaService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		return "listForSelect";
	}

	
	public void areaForRelevance(){ 	
		Gson gson = new Gson();
		
		try {
			String[] pids=projectIds.split(",");
			String[] eids=enterpriseIds.split(",");
			if(pids.length != 0){
				for(String s: pids){
					Project project=projectService.findById(Long.parseLong(s));
					project.setCollectionArea(entity);
					projectService.saveOrUpdate(project);
					projectService.flush();
					msgResult.put("status", true);
					msgResult.put("info", "关联成功");
				}
			}
			if(eids.length != 0){
				for(String s: eids){
					Enterprise enterprise =enterpriseService.findById(Long.parseLong(s));
					enterprise.setCollectionArea(entity);
					enterpriseService.saveOrUpdate(enterprise);
					enterpriseService.flush();
					msgResult.put("status", true);
					msgResult.put("info", "关联成功");
				}
			}
			if(pids.length == 0 && eids.length == 0 ){
				msgResult.put("status", false);
				msgResult.put("info", "关联失败");
			}
		} catch (JsonSyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}

	
	public String getProjectIds() {
		return projectIds;
	}

	public void setProjectIds(String projectIds) {
		this.projectIds = projectIds;
	}

	public String getEnterpriseIds() {
		return enterpriseIds;
	}

	public void setEnterpriseIds(String enterpriseIds) {
		this.enterpriseIds = enterpriseIds;
	}
	
	
	
}
