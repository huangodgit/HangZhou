package com.qqpp.qzce.baseInfo.web;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import com.google.gson.Gson;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.utils.JQueryDataTablesUtil;
import com.qqpp.qzce.baseInfo.domain.CollectionArea;
import com.qqpp.qzce.baseInfo.domain.Enterprise;
import com.qqpp.qzce.baseInfo.service.ICollectionAreaService;
import com.qqpp.qzce.baseInfo.service.IEnterpriseService;

public class EnterpriseManageAction extends BaseAction<Enterprise> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private IEnterpriseService enterpriseService;

	private Long areaId;
	private Double swlng;
	private Double swlat;
	private Double nelng;
	private Double nelat;

	@Autowired(required = true)
	private ICollectionAreaService collectionAreaService;

	@Override
	public void prepare() throws Exception {
		if (id != null) {
			entity = enterpriseService.findById(id);
		} else {
			entity = new Enterprise();
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

	public String pointView(){
		return "pointView";
	}
	
	public void save() {
		try {
			enterpriseService.saveOrUpdate(entity);
			enterpriseService.flush();
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
			enterpriseService.delete(entity);
			enterpriseService.flush();
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
		CustomExample<Enterprise> example = new CustomExample<Enterprise>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {
				criteria.addOrder(Order.desc("id"));
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = enterpriseService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(), listResult));
	}

	public String listForSelect() {
		CustomExample<Enterprise> example = new CustomExample<Enterprise>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {

			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = enterpriseService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		return "listForSelect";
	}

	public void listAllForCollectionArea(){
		try{
			if(swlng != null){
				String swlngT = swlng.toString();
				String swlatT = swlat.toString();
				String nelngT = nelng.toString();
				String nelatT = nelat.toString();
				List<Enterprise> list = enterpriseService.findAllByBoundary(swlngT, swlatT, nelngT, nelatT);
				List<Object> lo = new ArrayList<>();
				for (Enterprise object : list){
					if(object==null){
						continue;
					}
					Enterprise enterprise = enterpriseService.findById(object.getId());
					if(enterprise.getCollectionArea()!=null){
						object.setAttribute(true);
					}else{
						object.setAttribute(false);
					}
					lo.add(object);
				}

				responseText(JQueryDataTablesUtil.beanToJson(lo));
			}

		}catch(Exception e){
			e.printStackTrace();
		}
	}
	/**
	 * 与聚集区关联（单条数据）
	 */
	public void relation(){
		try{
			CollectionArea area=collectionAreaService.findById(areaId);
			entity.setCollectionArea(area);
			enterpriseService.saveOrUpdate(entity);
			enterpriseService.flush();
			msgResult.put("status", true);
			msgResult.put("info", "关联成功");
		}catch(Exception e){
			e.printStackTrace();
			msgResult.put("status", false);
			msgResult.put("info", "关联失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));

	}

	public void canclerelation(){
		try{
			entity.setCollectionArea(null);
			enterpriseService.saveOrUpdate(entity);
			enterpriseService.flush();
			msgResult.put("status", true);
			msgResult.put("info", "取消关联成功");
		}catch(Exception e){
			e.printStackTrace();
			msgResult.put("status", false);
			msgResult.put("info", "取消关联失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}

	public Double getSwlng() {
		return swlng;
	}

	public void setSwlng(Double swlng) {
		this.swlng = swlng;
	}

	public Double getSwlat() {
		return swlat;
	}

	public void setSwlat(Double swlat) {
		this.swlat = swlat;
	}

	public Double getNelng() {
		return nelng;
	}

	public void setNelng(Double nelng) {
		this.nelng = nelng;
	}

	public Double getNelat() {
		return nelat;
	}

	public void setNelat(Double nelat) {
		this.nelat = nelat;
	}

	public Long getAreaId() {
		return areaId;
	}

	public void setAreaId(Long areaId) {
		this.areaId = areaId;
	}

}
