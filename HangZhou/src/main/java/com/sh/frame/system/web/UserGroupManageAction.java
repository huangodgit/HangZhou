package com.sh.frame.system.web;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.constant.ValidFlag;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.system.domain.User;
import com.sh.frame.system.domain.UserGroup;
import com.sh.frame.system.service.IUserGroupService;
import com.sh.frame.system.service.IUserService;
import com.sh.frame.utils.JQueryDataTablesUtil;


public class UserGroupManageAction extends BaseAction<UserGroup> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private IUserGroupService userGroupService;

	@Autowired(required = true)
	private IUserService userService;

	private Long parentid;
	private Long userid;
	private String username;
	private List<User> userList;
	private String selectedUser;

	private Long[] selected;
	
	private String expandStr;
	private String expandList;

	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public Long getParentid() {
		return parentid;
	}

	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}

	public String getCheckBoxAllUserGroupList() throws Exception {
		CustomExample<UserGroup> example = new CustomExample<UserGroup>(this.getModel()) {
			private static final long serialVersionUID = 1L;
			public void appendCondition(Criteria criteria) {
				criteria.add(Restrictions.eq("validFlag",ValidFlag.VALID));
				criteria.addOrder(Order.asc("sortnum"));
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = userGroupService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		return "getCheckBoxAllUserGroupList";
	}

	public String insert(){
		return INSERT;
	}
	
	public void delete() {
//		SaveOrUpdateDone sou = new SaveOrUpdateDone();
//		try {
//			userGroupService.invalid(entity);
//			sou.setStatusCode(StatusCode.ok.toString());
//			sou.setMessage("删除当前记录成功");
//			sou.setId(entity.getId());
//			//sou.setCallbackTypeValue("closeCurrent")
//			sou.setNavTabIdValue(navTabId);
//		} catch (Exception e) {
//			e.printStackTrace();
//			sou.setStatusCode(StatusCode.error.toString());
//			sou.setMessage("删除失败，出现意外错误：" + e.getMessage());
//		}
//		Gson gson = builder.create();
//		responseHtml(gson.toJson(sou));
		try{
			if(entity.getUsers().size() != 0){
				msgResult.put("info", "用户组中存在用户,请先删除用户,再删除用户组");
				msgResult.put("ok", false);
			}else{
				userGroupService.invalid(entity);
				msgResult.put("info", "删除成功");
				msgResult.put("ok", true);
			}
		}catch(Exception e){
			e.printStackTrace();
			msgResult.put("info", "删除失败");
			msgResult.put("ok", false);
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}

	public void save() {
		try{
			if(entity.getName() == null){
				msgResult.put("info", "未填写用户组名");
				msgResult.put("ok", false);
			}else if(entity.getId() == null && getUserGroupNameSome()){
				msgResult.put("info", "用户组名已存在");
				msgResult.put("ok", false);
			}else{
				entity.setValidFlag(ValidFlag.VALID);
				entity.setSortnum(10);
				if(parentid != null){
					entity.setParent(userGroupService.findById(parentid));
				}
				userGroupService.saveOrUpdate(entity);
				msgResult.put("info", "创建成功");
				msgResult.put("ok", true);
			}
		}catch(Exception e){
			e.printStackTrace();
			msgResult.put("info", "创建成功");
			msgResult.put("ok", false);
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}
	private boolean getUserGroupNameSome(){
		boolean b = false;
		List<UserGroup> li = userGroupService.findAllValid();
		for(UserGroup u : li){
			if(u.getName().equals(entity.getName())){
				b = true;
				break;
			}
		}
		return b;
	}

	//	public void addUser(){
	//		SaveOrUpdateDone sou = new SaveOrUpdateDone();
	//		try{
	//			User user  = userService.findById(userid);
	//			entity.getUsers().add(user);
	//			userGroupService.saveOrUpdate(entity);
	//			sou.setStatusCode(StatusCode.ok.toString());
	//			sou.setMessage("成员添加成功");
	//			sou.setCallbackTypeValue("closeCurrent")
	//			.setNavTabIdValue(navTabId);
	//		} catch (Exception e) {
	//			sou.setStatusCode(StatusCode.error.toString());
	//			sou.setMessage("小组成员添加失败：" + e.getMessage());
	//		}
	//		Gson gson = builder.create();
	//		responseHtml(gson.toJson(sou));
	//	}
	public void editUser(){
		try{
			Set<User> newUser = new HashSet<User>();
			if(selected != null){
				User u = null;
				
				for(int i = 0 ; i< selected.length ; i++){
					u = userService.findById(selected[i]);
					newUser.add(u);
				}
				entity.setUsers(newUser);
				userGroupService.saveOrUpdate(entity);
				msgResult.put("ok", true);
				msgResult.put("info", "更新成功");
			}else{
				entity.setUsers(newUser);
				userGroupService.saveOrUpdate(entity);
				msgResult.put("ok", true);
				msgResult.put("info", "清空成功");
			}
		}catch(Exception e){
			e.printStackTrace();
			msgResult.put("ok", false);
			msgResult.put("info", "更新失败");
		}
		responseHtml(builder.create().toJson(msgResult));
	}
	public String view(){
		return VIEW;
	}
	public String userList(){
		userList = userService.findAllValid();
		selectedUser = returnSelectedUserID();
		return "userList";
	}
	
	
	
	private String returnSelectedUserID(){
		String id = "";
		Set<User> us = entity.getUsers();
		for(User u : us){
			id += u.getId() + ",";
		}
		if(id.indexOf(",") >= 0){
			return id.substring(0,id.length()-1);
		}else{
			return "";
		}
	}

	public void listAllForJQueryDataTable() {
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(UserGroup.class);
		if (entity.getName() != null && !"".equals(entity.getName()))
			detachedCriteria.add(Restrictions.like("name","%" + entity.getName() + "%"));
		detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		detachedCriteria.addOrder(Order.asc("id"));
		this.listResult = userGroupService.findPageByCriteria(detachedCriteria,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(), listResult));
	}

	public void deleteUser(){
		try{
			User user  = userService.findById(userid);
			entity.getUsers().remove(user);
			userGroupService.saveOrUpdate(entity);
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

	private Long selectParentId;

	public Long getSelectParentId() {
		return selectParentId;
	}

	public void setSelectParentId(Long selectParentId) {
		this.selectParentId = selectParentId;
	}

	public String edit() {
		return EDIT;
	}

	public String addSon() {
		if (selectParentId != null) {
			entity.setParent(userGroupService.findById(selectParentId));
		}
		return "addSon";
	}

	public String list() {
//		try{
//			html = userGroupService.getUserGroupTree("onselectUserGroup");
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
		return LIST;
	}
	

	public void treeHTML(){
		tmpUserGroup = userGroupService.findAllValid();
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
		userGroupTreeBuilder();
		tmpUserGroup = null;
		responseHtml(htmlBuf.toString());
		htmlBuf = null;
		expLong = null;
		expList = null;
	}
	
	// fubo 增加 递归实现生成树
		private List<UserGroup> tmpUserGroup;
		private int level = 0;
		private StringBuffer htmlBuf;
		private List<Long> expLong;
		private List<Long> expList;
		private int px = 40;
		private void userGroupTreeBuilder(){
			for(UserGroup parentUserGroup : tmpUserGroup){
				Long getUserGroupID = parentUserGroup.getId();
				if(parentUserGroup.getParent() == null){ // is parent
					String expand = "expand=\"0\"";
					if(expList != null){
						for(int i = 0 ; i < expList.size() ; i++){
							if(getUserGroupID.equals(expList.get(i))){
								expand = "expand=\"1\"";
								expList.remove(i);
								break;
							}
						}
					}
					level = 0; // 当前层位最高层
					htmlBuf.append("<tr "+expand+" data-id=" + getUserGroupID + " data-pid=0 data-level=" + level + ">"
							//+ "<td>" + getUserGroupID + "</td>"
							+ "<td onclick=\"toggleChildNode(this)\" style=\"padding-left:" + level*px + "px\">" + parentUserGroup.getName() + "</td>"
							+ "<td></td>"
//							+ "<td>" + parentUserGroup.getDescription() + "</td>"
							+ "<td id=\"hrefoperation\"></td>"
							+ "</tr>");
					orgTreeLoop(parentUserGroup);
				}
			}
		}
		private String orgTreeLoop(UserGroup userGroupSingle){
			List<UserGroup> childUserGroups = treeGetChild(userGroupSingle);
			if(!childUserGroups.isEmpty()){
				level ++;
				for(UserGroup childUserGroup : childUserGroups){
					Long getChildUserGroupID = childUserGroup.getId();
					String display = "style=\"display:none;\"";
					if(expLong != null){
						for(int i = 0 ; i < expLong.size() ; i++){
							if(getChildUserGroupID.equals(expLong.get(i))){
								display = "";
								expLong.remove(i);
								break;
							}
						}
					}
					String expand = "expand=\"0\"";
					if(expList != null){
						for(int i = 0 ; i < expList.size() ; i++){
							if(getChildUserGroupID.equals(expList.get(i))){
								expand = "expand=\"1\"";
								expList.remove(i);
								break;
							}
						}
					}
					htmlBuf.append("<tr "+display+" "+expand+" data-id=" + getChildUserGroupID + " data-pid=" + childUserGroup.getParent().getId() + " data-level=" + level + ">"
							//+ "<td>" + getChildUserGroupID + "</td>"
							+ "<td onclick=\"toggleChildNode(this)\" style=\"padding-left:" + level*px + "px\">" + childUserGroup.getName() + "</td>"
							+ "<td>" + childUserGroup.getParent().getName() + "</td>"
//							+ "<td>" + childUserGroup.getDescription() + "</td>"
							+ "<td id=\"hrefoperation\"></td>"
							+ "</tr>");
					orgTreeLoop(childUserGroup);
				}
				level --;

			}
			return "";
		}
		private List<UserGroup> treeGetChild(UserGroup userGroupSingle){
			List<UserGroup> tmpList = new ArrayList<UserGroup>();
			Long parnetID = userGroupSingle.getId();
			for(UserGroup tmpr : tmpUserGroup){
				UserGroup tmprParent = tmpr.getParent();
				if(tmprParent != null && tmprParent.getId() == parnetID){
					tmpList.add(tmpr);
				}
			}
			return tmpList;
		}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
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


	public void prepare() {
		if (id != null) {
			entity = userGroupService.findByIdEx(id);
		} else
			entity = new UserGroup();
	}

	public Long[] getSelected() {
		return selected;
	}

	public void setSelected(Long[] selected) {
		this.selected = selected;
	}

	public List<User> getUserList() {
		return userList;
	}

	public void setUserList(List<User> userList) {
		this.userList = userList;
	}

	public String getSelectedUser() {
		return selectedUser;
	}

	public void setSelectedUser(String selectedUser) {
		this.selectedUser = selectedUser;
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
