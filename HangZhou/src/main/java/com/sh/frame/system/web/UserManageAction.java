package com.sh.frame.system.web;

import java.io.File;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.constant.ValidFlag;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.system.domain.Role;
import com.sh.frame.system.domain.User;
import com.sh.frame.system.service.IOrgService;
import com.sh.frame.system.service.IRoleService;
import com.sh.frame.system.service.IUserService;
import com.sh.frame.utils.JQueryDataTablesUtil;
import com.sh.frame.utils.MD5Util;

public class UserManageAction extends BaseAction<User> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private IRoleService roleService;

	@Autowired(required = true)
	private IOrgService orgService;

	@Autowired(required = true)
	private IUserService userService;


	@Autowired(required = true)
	protected SessionFactory sessionFactory;

	// prepare 使用session中的entity
	private String self;
	private String html;
	private String userDictTypes;

	private Long deskTempletId;
	private Long followTaskId;
	private Map<String, String> parentMap;
	private String selectAll;
	private String inputName;
	private String users;
	private String userids;
	private String userGroupId;
	private String selectedDictTypeId;
	private String selectedDictTypeIdImp;
	private Long[] selected;
	private List<Role> roleListArr;
	private File photoHead;
	private String photoHeadFileName;
	private String showName;
	private String remarkText;
	
	public String getSelectedDictTypeIdImp() {
		return selectedDictTypeIdImp;
	}

	public void setSelectedDictTypeIdImp(String selectedDictTypeIdImp) {
		this.selectedDictTypeIdImp = selectedDictTypeIdImp;
	}

	public String getSelectedDictTypeId() {
		return selectedDictTypeId;
	}

	public void setSelectedDictTypeId(String selectedDictTypeId) {
		this.selectedDictTypeId = selectedDictTypeId;
	}

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String getUserDictTypes() {
		return userDictTypes;
	}

	public void setUserDictTypes(String userDictTypes) {
		this.userDictTypes = userDictTypes;
	}

	public String getUserGroupId() {
		return userGroupId;
	}

	public void setUserGroupId(String userGroupId) {
		this.userGroupId = userGroupId;
	}

	private Map<String, String> userGroups;
	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUserids() {
		return userids;
	}

	public Map<String, String> getUserGroups() {
		return userGroups;
	}

	public void setUserGroups(Map<String, String> userGroups) {
		this.userGroups = userGroups;
	}

	public void setUserids(String userids) {
		this.userids = userids;
	}

	public String getUsers() {
		return users;
	}

	public void setUsers(String users) {
		this.users = users;
	}

	public String getInputName() {
		return inputName;
	}

	public void setInputName(String inputName) {
		this.inputName = inputName;
	}

	public String getSelectAll() {
		return selectAll;
	}

	public void setSelectAll(String selectAll) {
		this.selectAll = selectAll;
	}

	public Map<String, String> getParentMap() {
		return parentMap;
	}

	public void setParentMap(Map<String, String> parentMap) {
		this.parentMap = parentMap;
	}

	public Long getDeskTempletId() {
		return deskTempletId;
	}

	public void setDeskTempletId(Long deskTempletId) {
		this.deskTempletId = deskTempletId;
	}

	public void delete() {
		try {
			entity.setOrg(null);
			entity.setRoleList(null);
			userService.invalid(entity);
			msgResult.put("ok", true);
			msgResult.put("info", "删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			msgResult.put("ok", false);
			msgResult.put("info", "删除失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}
	
	public void saveUserRoles(){
		try{
			if(selected != null && selected.length != 0){
				Set<Role> role = new HashSet<Role>();
				for(int i = 0 ; i < selected.length ; i++){
					Role m = roleService.findById(selected[i]);
					if(m != null){
						role.add(m);
					}
				}
				entity.setRoleList(role);
				userService.saveOrUpdate(entity);
				msgResult.put("info", "保存成功");
				msgResult.put("ok", true);
			}else{
				msgResult.put("info", "未选择任何项,无需保存");
				msgResult.put("ok", true);
			}
		}catch(Exception e){
			msgResult.put("info", "保存出现异常");
			msgResult.put("ok", false);
			e.printStackTrace();
		}
		responseHtml(builder.create().toJson(msgResult));
	}

	public void resetPswd(){
		try{
			entity.setPassword(MD5Util.md5("123456"));
			userService.saveOrUpdate(entity);
			msgResult.put("info", "用户:"+entity.getLoginName()+"的密码已被重置为123456,重新登录生效");
			msgResult.put("ok", true);
		}catch(Exception e){
			e.printStackTrace();
			msgResult.put("info", "出现异常错误");
			msgResult.put("ok", false);
		}
		responseHtml(builder.create().toJson(msgResult));
	}

	private String password0;
	
	public String getPassword0() {
		return password0;
	}

	public void setPassword0(String password0) {
		this.password0 = password0;
	}

	private String password1;

	public String getPassword1() {
		return password1;
	}

	public void setPassword1(String password1) {
		this.password1 = password1;
	}

	private String password2;

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	public void savePassword() {
		
		try {
			User user = userService.findById(loginUser.getId());
			if (password1 == null || password1.trim().equals("")) {
				msgResult.put("ok", false);
				msgResult.put("info","必须输入新密码");
			} else if (!password1.equals(password2)) {
				msgResult.put("ok", false);
				msgResult.put("info","两次密码输入不一致");
			} else if (!user.getPassword().equals(password0)) {
				msgResult.put("ok", false);
				msgResult.put("info","旧密码输入错误");
			} else {
				user.setPassword(password1);
				userService.saveOrUpdate(user);
				msgResult.put("ok", true);
				msgResult.put("info","已经成功为你修改密码");
			}
		} catch (Exception e) {
			e.printStackTrace();
			msgResult.put("ok", false);
			msgResult.put("info","异常错误");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}
	
	
	
	public String list() {
		return LIST;
	}

	public void listAllForJQueryDataTable() {
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(User.class);
		if (entity.getName() != null && !"".equals(entity.getName()))
			detachedCriteria.add(Restrictions.like("name","%" + entity.getName() + "%"));
		detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		detachedCriteria.addOrder(Order.asc("id"));
		this.listResult = userService.findPageByCriteria(detachedCriteria,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(), listResult));
	}
	
	public String listForSelect() {
		CustomExample<User> example = new CustomExample<User>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {
				entity.setValidFlag(ValidFlag.VALID);
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = userService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);

		return "listForSelect";
	}

	private Long selectedOrgId;

	public Long getSelectedOrgId() {
		return selectedOrgId;
	}
	public String view(){
		return VIEW;
	}

	public void setSelectedOrgId(Long selectedOrgId) {
		this.selectedOrgId = selectedOrgId;
	}

	public String listForOrg() {
		CustomExample<User> example = new CustomExample<User>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {
				if (selectedOrgId != null) {
					criteria.createCriteria("parent").add(
							Restrictions.eq("id", selectedOrgId));
				}
				if ((name != null) && (!"".equals(name))) {
					criteria.add(Restrictions.like("name", name,
							MatchMode.ANYWHERE));
				}
				entity.setValidFlag(ValidFlag.VALID);
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = userService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		return "listForOrg";
	}

	public String listForRole() {
		CustomExample<User> example = new CustomExample<User>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {
				if (selectedRoleId != null) {
					// TODO
				}
				entity.setValidFlag(ValidFlag.VALID);
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = userService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		return "listForOrg";
	}

	// TODO 验证用户名是否重复
	public void save() {
		//SaveOrUpdateDone sou = new SaveOrUpdateDone();
		List<User> u = null;
		if(id == null){
			u = userService.findAll();
		}
		if(entity.getId() == null && NameIsDuplicate(entity.getName(),u)){
			msgResult.put("info", "用户名重复");
			msgResult.put("ok", false);
		}else if(entity.getId() == null && !password1.equals(password2)){
			msgResult.put("info", "密码与确认密码不一致");
			msgResult.put("ok", false);
		}else{
			try {
				entity.setPassword(password1);
				if (entity.getOrg() != null
						&& entity.getOrg().getId() == null) {
					entity.setOrg(null);
				} else if (entity.getOrg() != null) {
					entity.setOrg(orgService
							.findById(entity.getOrg().getId()));
				}
				entity.setValidFlag(ValidFlag.VALID);
				// 只在新增的时候才清空roleList,否则更改时候role会清空
				if(id == null){
					entity.getRoleList().removeAll(entity.getRoleList());
				}
				if (selectedRoleId != null) {
					Role role = roleService.findByIdEx(selectedRoleId);
					entity.getRoleList().add(role);
				}


				userService.saveOrUpdate(entity);
				msgResult.put("info", "操作成功");
				msgResult.put("ok", true);
			} catch (Exception e) {
				e.printStackTrace();
				msgResult.put("info", "操作失败");
				msgResult.put("ok", false);
			}
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}
	
	private boolean NameIsDuplicate(String name,List<User> uArr){
		boolean b = false;
		for(User u : uArr){
			if(u.getName().equals(name)){
				b = true;
				break;
			}
		}
		return b;
	}

	public void addInOrg() {
		try {
			if (selectedOrgId != null) {
				entity.setOrg(orgService.findById(selectedOrgId));
			}
			userService.saveOrUpdate(entity);
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

	public void deleteFromOrg() {
		try {
			entity.setOrg(null);
			userService.saveOrUpdate(entity);
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

	public void addInRole() {
		try {
			if (selectedRoleId != null) {
				entity.getRoleList()
						.add(roleService.findByIdEx(selectedRoleId));
			}
			userService.saveOrUpdate(entity);
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

	public void deleteFromRole() {
		try {
			if (selectedRoleId != null) {
				entity.getRoleList().remove(
						roleService.findByIdEx(selectedRoleId));
			}
			userService.saveOrUpdate(entity);
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

	public String edit() {
		return EDIT;
	}

	public String insert() {
		return INSERT;
	}

	public String editDeskTop() {
		entity = userService.findById(this.loginUser.getId());
		return "editDeskTop";
	}

	private Long selectedRoleId;

	public Long getSelectedRoleId() {
		return selectedRoleId;
	}

	public void setSelectedRoleId(Long selectedRoleId) {
		this.selectedRoleId = selectedRoleId;
	}

	private Long[] selectedRoleList;

	public Long[] getSelectedRoleList() {
		return selectedRoleList;
	}

	public void setSelectedRoleList(Long[] selectedRoleList) {
		this.selectedRoleList = selectedRoleList;
	}

	private Long currentGroupId;

	public Long getCurrentGroupId() {
		return currentGroupId;
	}

	public void setCurrentGroupId(Long currentGroupId) {
		this.currentGroupId = currentGroupId;
	}


	public void prepare() throws Exception {

		if (self != null) {
			entity = (User) this.getSession().get("LOGINUSER");
			entity = userService.findByIdEx(entity.getId());;
			return;
		}
		if (id != null) {
			entity = userService.findByIdEx(id);
			Session session = sessionFactory.openSession();
			User tempUser = (User) session.get(User.class, entity.getId());
			Hibernate.initialize(tempUser.getRoleList());
			session.close();
			entity = tempUser;
		} else
			entity = new User();
	}

	public String editPersonalInfo() {
		entity = userService.findByIdEx(loginUser.getId());
		
		return "editPersonalInfo";
	}

	public void saveInfo() {
		try {
			userService.saveOrUpdate(entity);
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

	public String getSelf() {
		return self;
	}

	public void setSelf(String self) {
		this.self = self;
	}


 
	public Long getFollowTaskId() {
		return followTaskId;
	}

	public void setFollowTaskId(Long followTaskId) {
		this.followTaskId = followTaskId;
	}

	


	public String roleList(){
		inputName = returnRoleID();
		roleListArr = roleService.findAllValid();
		return "roleList";
	}
	
	private String returnRoleID(){
		String modID = "";
		Set<Role> modules = entity.getRoleList();
		for(Role m : modules){
			modID += m.getId()+",";
		}
		if(modID.indexOf(",") >= 0){
			return modID.substring(0,modID.length() - 1);
		}else{
			return "";
		}
	}
	
	public void saveProfile(){
		try{
			entity.setRemark(remarkText);
			entity.setName(showName);
			userService.saveOrUpdate(entity);
			msgResult.put("status", true);
		}catch(Exception e){
			msgResult.put("status", false);
		}
		responseHtml(builder.create().toJson(msgResult));
	}

	public String editPassword(){
		return "editPassword";
	}

	public Long[] getSelected() {
		return selected;
	}

	public void setSelected(Long[] selected) {
		this.selected = selected;
	}

	public List<Role> getRoleListArr() {
		return roleListArr;
	}

	public void setRoleListArr(List<Role> roleListArr) {
		this.roleListArr = roleListArr;
	}

	public File getPhotoHead() {
		return photoHead;
	}

	public void setPhotoHead(File photoHead) {
		this.photoHead = photoHead;
	}

	public String getPhotoHeadFileName() {
		return photoHeadFileName;
	}

	public void setPhotoHeadFileName(String photoHeadFileName) {
		this.photoHeadFileName = photoHeadFileName;
	}

	public String getShowName() {
		return showName;
	}

	public void setShowName(String showName) {
		this.showName = showName;
	}

	public String getRemarkText() {
		return remarkText;
	}

	public void setRemarkText(String remarkText) {
		this.remarkText = remarkText;
	}
	

}
