package com.sh.frame.system.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.sh.frame.constant.ValidFlag;
import com.sh.frame.system.domain.Org;
import com.sh.frame.system.service.IOrgService;
import com.sh.frame.utils.JQueryDataTablesUtil;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;

 
public class OrgManageAction extends BaseAction<Org> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private IOrgService orgService;
	
	private Long parentid;
	private String startTime;
	private String endTime;
	private String bmName;
	private  List<Org> orgs;
	
	private String orgQueryName;
	
	private String expandStr;
	private String expandList;
	
	public List<Org> getOrgs() {
		return orgs;
	}

	public void setOrgs(List<Org> orgs) {
		this.orgs = orgs;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getBmName() {
		return bmName;
	}

	public void setBmName(String bmName) {
		this.bmName = bmName;
	}

	public Long getParentid() {
		return parentid;
	}

	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}

	public String getCheckBoxAllOrgList() throws Exception {
		CustomExample<Org> example = new CustomExample<Org>(this.getModel()) {
			private static final long serialVersionUID = 1L;
			public void appendCondition(Criteria criteria) {
				criteria.add(Restrictions.eq("validFlag",ValidFlag.VALID));
				criteria.addOrder(Order.asc("sortnum"));
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = orgService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
			return "getCheckBoxAllOrgList";
	}
	
	public void delete() {
		//SaveOrUpdateDone sou = new SaveOrUpdateDone();
		// 先检查是否存在下级
		int ChildrenListNum = getChildrenListNum().size();
		if(ChildrenListNum > 0){
			msgResult.put("info", "存在子级,请先删除子级组织,再进行删除");
			msgResult.put("ok", false);
		}else{
			try{
				entity.setParent(null);
				orgService.invalid(entity);
				msgResult.put("info", "删除成功");
				msgResult.put("ok", true);
			}catch(Exception e){
				e.printStackTrace();
				msgResult.put("info", "异常错误,删除失败");
				msgResult.put("ok", false);
			}
		}

		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}
	private List<Org> getChildrenListNum(){
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Org.class);
		detachedCriteria.createAlias("parent", "p");
		detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		detachedCriteria.add(Restrictions.eq("p.id", entity.getId()));
		detachedCriteria.addOrder(Order.asc("id"));

		List<Org> list = orgService.findAllByCriteria(detachedCriteria);
		return list;
	}

	public void save() {
		//SaveOrUpdateDone sou = new SaveOrUpdateDone();
		if(entity.getName() == null || entity.getCode() == null){
			msgResult.put("info", "信息未填写完整,保存失败");
			msgResult.put("ok", false);
		}else{
			try {
				if(parentid != null)
					entity.setParent(orgService.findById(parentid));
				entity.setValidFlag(ValidFlag.VALID);
				orgService.saveOrUpdate(entity);
				msgResult.put("info", "保存成功");
				msgResult.put("ok", true);
			} catch (Exception e) {
				msgResult.put("info", "保存失败,出现意外错误");
				msgResult.put("ok", false);
			}
		}

		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}
	public String view(){
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Org.class);
		detachedCriteria.createAlias("parent", "p");
		detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		detachedCriteria.add(Restrictions.eq("p.id", entity.getId()));
		detachedCriteria.addOrder(Order.asc("id"));
		orgs = orgService.findAllByCriteria(detachedCriteria);
		orgQueryName = "";
		for(Org o : orgs){
			orgQueryName +=o.getName()+",";
		}
		if(orgQueryName.indexOf(",") >= 0){
			orgQueryName = orgQueryName.substring(0,orgQueryName.length() - 1);
		}
		return VIEW;
	}

	private Long selectParentId;

	public Long getSelectParentId() {
		return selectParentId;
	}

	public void setSelectParentId(Long selectParentId) {
		this.selectParentId = selectParentId;
	}
	
	public String insert(){
		return INSERT;
	}
	public String edit() {
		return EDIT;
	}

	public String addSon() {
		if (selectParentId != null) {
			entity.setParent(orgService.findById(selectParentId));
		}
		return "addSon";
	}
 
	public String list() {
		return LIST;
	}
	
	public String orgListTree(){
		return "orgListTree";
	}

	public String listTreeForSelect() {
		return "listTreeForSelect";
	}

	String html;

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String listLogInfo() {
		try{
			DetachedCriteria detachedCriteria =DetachedCriteria.forClass(Org.class);
			detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
			detachedCriteria.addOrder(Order.asc("sortnum"));
			orgs = orgService.findAllByCriteria(detachedCriteria);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "listLogInfo";
	}
	
	public String listDeptDetail() {
		try {
			URLDecoder.decode(bmName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "listDeptDetail";
	}
	
	public String listDeptOperationDetail() {
		try {
			URLDecoder.decode(bmName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "listDeptOperationDetail";
	}
	
	public void listAllForJQueryDataTable() {
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Org.class);
		if (orgQueryName != null && !"".equals(orgQueryName)){
			detachedCriteria.createAlias("parent", "p",DetachedCriteria.LEFT_JOIN);
			detachedCriteria.add(Restrictions.or(Restrictions.like("name","%" + orgQueryName + "%"), Restrictions.like("p.name","%" + orgQueryName + "%")));
		}
		detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		detachedCriteria.addOrder(Order.asc("id"));
		this.listResult = orgService.findPageByCriteria(detachedCriteria,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		System.out.println(listResult.getItems().size());
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(), listResult));
	}
	
	public void treeHTML(){
		tmpOrg = orgService.findAllValid();
		htmlBuf = new StringBuffer();
		if(expandStr != null && expandStr.indexOf("{") == 0){
			JsonParser parse = new JsonParser();
			JsonObject obj = parse.parse(expandStr).getAsJsonObject();
			JsonArray arr = obj.get("expand").getAsJsonArray();
			expLong = new ArrayList<Long>();
			for(int i = 0 ; i < arr.size() ; i++){
				expLong.add(arr.get(i).getAsLong());
			}
			arr = null;
			obj = null;
		}
		if(expandList != null && expandList.indexOf("{") == 0){
			JsonParser parse = new JsonParser();
			JsonObject obj = parse.parse(expandList).getAsJsonObject();
			JsonArray arr = obj.get("expandList").getAsJsonArray();
			expList = new ArrayList<Long>();
			for(int i = 0 ; i < arr.size() ; i++){
				expList.add(arr.get(i).getAsLong());
			}
			arr = null;
			obj = null;
		}
		roleTreeBuilder();
		tmpOrg = null;
		responseHtml(htmlBuf.toString());
		htmlBuf = null;
		expLong = null;
		expList = null;
	}
	
	// fubo 增加 递归实现生成树
		private List<Org> tmpOrg;
		private int level = 0;
		private StringBuffer htmlBuf;
		private int px = 40;
		private List<Long> expLong;
		private List<Long> expList;
		private void roleTreeBuilder(){
			for(Org parentOrg : tmpOrg){
				Long getRoleID = parentOrg.getId();
				if(parentOrg.getParent() == null){ // is parent
					String expand = "expand=\"0\"";
					if(expList != null){
						for(int i = 0 ; i < expList.size() ; i++){
							if(getRoleID.equals(expList.get(i))){
								expand = "expand=\"1\"";
								expList.remove(i);
								break;
							}
						}
					}
					level = 0; // 当前层位最高层
					htmlBuf.append("<tr "+expand+" data-id=" + getRoleID + " data-pid=0 data-level=" + level + ">"
							//+ "<td>" + getRoleID + "</td>"
							+ "<td onclick=\"toggleChildNode(this)\" style=\"padding-left:" + level*px + "px\">" + parentOrg.getName() + "</td>"
							+ "<td>" + parentOrg.getCode() + "</td>"
							+ "<td>" + parentOrg.getDescription() + "</td>"
							+ "<td id=\"hrefoperation\"></td>"
							+ "</tr>");
					orgTreeLoop(parentOrg);
				}
			}
		}
		private String orgTreeLoop(Org roleSingle){
			List<Org> childOrgs = treeGetChild(roleSingle);
			if(!childOrgs.isEmpty()){
				level ++;
				for(Org childOrg : childOrgs){
					Long getChildRoleID = childOrg.getId();
					String display = "style=\"display:none;\"";
					if(expLong != null){
						for(int i = 0 ; i < expLong.size() ; i++){
							if(getChildRoleID.equals(expLong.get(i))){
								display = "";
								expLong.remove(i);
								break;
							}
						}
					}
					String expand = "expand=\"0\"";
					if(expList != null){
						for(int i = 0 ; i < expList.size() ; i++){
							if(getChildRoleID.equals(expList.get(i))){
								expand = "expand=\"1\"";
								expList.remove(i);
								break;
							}
						}
					}
					htmlBuf.append("<tr "+display+" "+expand+" data-id=" + getChildRoleID + " data-pid=" + childOrg.getParent().getId() + " data-level=" + level + ">"
							//+ "<td>" + getChildRoleID + "</td>"
							+ "<td onclick=\"toggleChildNode(this)\" style=\"padding-left:" + level*px + "px\">" + childOrg.getName() + "</td>"
							+ "<td>" + childOrg.getCode() + "</td>"
							+ "<td>" + childOrg.getDescription() + "</td>"
							+ "<td id=\"hrefoperation\"></td>"
							+ "</tr>");
					orgTreeLoop(childOrg);
				}
				level --;

			}
			return "";
		}
		private List<Org> treeGetChild(Org roleSingle){
			List<Org> tmpList = new ArrayList<Org>();
			Long parnetID = roleSingle.getId();
			for(Org tmpr : tmpOrg){
				Org tmprParent = tmpr.getParent();
				if(tmprParent != null && tmprParent.getId() == parnetID){
					tmpList.add(tmpr);
				}
			}
			return tmpList;
		}
	
	public void prepare() {
		if (id != null) {
			entity = orgService.findByIdEx(id);
		} else
			entity = new Org();
	}

	public String getOrgQueryName() {
		return orgQueryName;
	}

	public void setOrgQueryName(String orgQueryName) {
		this.orgQueryName = orgQueryName;
	}

	public String getExpandStr() {
		return expandStr;
	}

	public void setExpandStr(String expandStr) {
		this.expandStr = expandStr;
	}

	public String getExpandList() {
		return expandList;
	}

	public void setExpandList(String expandList) {
		this.expandList = expandList;
	}

}
