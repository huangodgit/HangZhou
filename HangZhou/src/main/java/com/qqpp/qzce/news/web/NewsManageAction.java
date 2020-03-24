package com.qqpp.qzce.news.web;

import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.utils.JQueryDataTablesUtil;
import com.qqpp.qzce.news.domain.News;
import com.qqpp.qzce.news.service.INewsService;

public class NewsManageAction extends BaseAction<News> {

	private static final long serialVersionUID = 1L;
	@Autowired(required = true)
	private INewsService villageLivelihoodNewsService;
	
	private String menuTitle;
	
	private String dictCodeType;
	
	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		if (id != null) {
			entity = villageLivelihoodNewsService.findById(id);
		} else
			entity = new News();
	}
	public String list() {
		return LIST;
	}
	public String insert() {
		return INSERT;
	}
	public String view() {
		return VIEW;
	}
	public String edit() {
		return EDIT;
	}
	public String handle() {
		return "handle";
	}
	public void delete() {
		try {
			villageLivelihoodNewsService.delete(entity);
			villageLivelihoodNewsService.flush();
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
	public void save() {
		try {
			Date dt = new Date();
			entity.setOperateTime(dt);
            if(entity.getStatus()==null){
            	entity.setStatus("待处理");
            }
            if(entity.getStatus().equals("待处理")&&(entity.getHandleOperator()!=null||entity.getHandleResult()!=null||
            		entity.getHandleTime()!=null)){
            	entity.setStatus("已处理");
            	entity.setHandleOperator(loginUser.getName());
            	entity.setHandleTime(dt);
            }
            if(entity.getStatus().equals("已处理")&&entity.getHandleTime()==null){
            	entity.setHandleTime(dt);
            }
			villageLivelihoodNewsService.saveOrUpdate(entity);
			villageLivelihoodNewsService.flush();
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
	public void listAllForJQueryDataTable() {
	    try{
		List<String> list = getAoData_props();
		final String getOrder = getAoDatasSortDir();
		final String getOrderColName = list.get(getAoDataiSortCol());
		CustomExample<News> example = new CustomExample<News>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {
				criteria.add(Restrictions.eq("newsType", entity.getNewsType()));
				criteria.addOrder(Order.desc("topNumber"));
				if(getOrder.equalsIgnoreCase("asc")){
					criteria.addOrder(Order.asc(getOrderColName));
				}else{
					criteria.addOrder(Order.desc(getOrderColName));
				}
				criteria.addOrder(Order.desc("operateTime"));
				
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = villageLivelihoodNewsService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(
				this.getAoData_echo(), this.getAoData_props(), listResult));
	    }catch(Exception e){
	        e.printStackTrace();
	    }
	}
	public void listAll() {
		
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(News.class);
		detachedCriteria.add(Restrictions.eq("newsType", entity.getNewsType()));
		detachedCriteria.addOrder(Order.desc("operateTime"));
		List<News> list=villageLivelihoodNewsService.findAllByCriteria(detachedCriteria);
		responseText(JQueryDataTablesUtil.beanToJson(list));
	}
    //置顶
	public void stick(){
		try{
		    entity.setTopNumber("1");
		    villageLivelihoodNewsService.saveOrUpdate(entity);
			villageLivelihoodNewsService.flush();
		    msgResult.put("status", true);
		    msgResult.put("info", "置顶成功");
		}catch (Exception e){
			msgResult.put("status", false);
			msgResult.put("info", "置顶失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}
	//取消置顶
	public void canelStick(){
		try{
		    entity.setTopNumber(null);
		    villageLivelihoodNewsService.saveOrUpdate(entity);
			villageLivelihoodNewsService.flush();
		    msgResult.put("status", true);
		    msgResult.put("info", "取消置顶成功");
		}catch (Exception e){
			msgResult.put("status", false);
			msgResult.put("info", "取消置顶失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}
	
	public String getMenuTitle() {
		return menuTitle;
	}
	public void setMenuTitle(String menuTitle) {
		this.menuTitle = menuTitle;
	}
	public String getDictCodeType() {
		return dictCodeType;
	}
	public void setDictCodeType(String dictCodeType) {
		this.dictCodeType = dictCodeType;
	}

	
}
