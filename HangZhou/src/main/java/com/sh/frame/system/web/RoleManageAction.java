package com.sh.frame.system.web;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
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
import com.sh.frame.system.domain.Module;
import com.sh.frame.system.domain.Role;
import com.sh.frame.system.service.IModuleService;
import com.sh.frame.system.service.IRoleService;
import com.sh.frame.utils.JQueryDataTablesUtil;

public class RoleManageAction extends BaseAction<Role> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private IModuleService moduleService;

	@Autowired(required = true)
	private IRoleService roleService;

	@Autowired(required = true)
	protected SessionFactory sessionFactory;

	private Long parentid;

	private String roleQueryName;

	private String callbackFunc;

	private Long[] selected;

	private List<Module> moduleList;

	public String getCallbackFunc() {
		return callbackFunc;
	}

	public void setCallbackFunc(String callbackFunc) {
		this.callbackFunc = callbackFunc;
	}

	public Long getParentid() {
		return parentid;
	}

	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}

	public void delete() {
		//SaveOrUpdateDone sou = new SaveOrUpdateDone();
		int getFunctionNum = getFunctionList().size();
		if(getFunctionNum > 0){
			msgResult.put("info", "存在子级功能,请先删除子级角色");
			msgResult.put("ok", false);
		}else{
			try {
				entity.setValidFlag(ValidFlag.INVALID);
				entity.setParent(null);
				roleService.saveOrUpdate(entity);
				msgResult.put("info", "删除成功");
				msgResult.put("ok", true);
			} catch (Exception e) {
				e.printStackTrace();
				msgResult.put("info", "删除失败,异常错误");
				msgResult.put("ok", false);
			}
		}

		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}
	private List<Role> getFunctionList(){
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Role.class);
		detachedCriteria.createAlias("parent", "p");
		detachedCriteria.add(Restrictions.eq("p.id", entity.getId()));
		detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		List<Role> list = roleService.findAllByCriteria(detachedCriteria);
		return list;

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
			entity.setParent(roleService.findById(selectParentId));
		}
		return "addSon";
	}

	public void save() {
		//SaveOrUpdateDone sou = new SaveOrUpdateDone();
		if(entity.getName() == null){
			msgResult.put("info", "信息不完整");
			msgResult.put("ok", false);
		}else{
			try {
				if(parentid != null)
					entity.setParent(roleService
							.findById(parentid));
				entity.setValidFlag(ValidFlag.VALID);
				roleService.saveOrUpdate(entity);
				msgResult.put("info", "保存成功");
				msgResult.put("ok", true);
			} catch (Exception e) {
				msgResult.put("info", "保存失败,异常错误");
				msgResult.put("ok", false);
			}
		}

		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}
	public void listAllForJQueryDataTable() {
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Role.class);
		if (roleQueryName != null && !"".equals(roleQueryName))
			detachedCriteria.add(Restrictions.like("name",
					"%" + roleQueryName + "%"));
		detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		detachedCriteria.addOrder(Order.asc("id"));
		this.listResult = roleService.findPageByCriteria(detachedCriteria,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		System.out.println(listResult.getItems().size());
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(), listResult));
	}

	

	public String listTreeForSelect() {
		return "listTreeForSelect";
	}

	public String list() {
		return LIST;
	}

	public String moduleList(){
		//moduleList = moduleService.findAllValid();
		roleQueryName = returnMenuID();
		return "moduleList";
	}

	String html;
	public void saveRoleModule(){
		try{
			Set<Module> module = new HashSet<Module>();
			if(selected != null && selected.length != 0){
				for(int i = 0 ; i < selected.length ; i++){
					Module m = moduleService.findById(selected[i]);
					if(m != null){
						module.add(m);
					}
				}
				entity.setMenuList(module);
				roleService.saveOrUpdate(entity);
				msgResult.put("info", "保存成功");
				msgResult.put("ok", true);
			}else{
				entity.setMenuList(module);
				roleService.saveOrUpdate(entity);
				msgResult.put("info", "清空成功");
				msgResult.put("ok", true);
			}
		}catch(Exception e){
			msgResult.put("info", "保存出现异常");
			msgResult.put("ok", false);
			e.printStackTrace();
		}
		responseHtml(builder.create().toJson(msgResult));
	}

	private String returnMenuID(){
		String modID = "";
		Set<Module> modules = entity.getMenuList();
		for(Module m : modules){
			modID += m.getId()+",";
		}
		if(modID.indexOf(",") >= 0){
			return modID.substring(0,modID.length() - 1);
		}else{
			return "";
		}
	}

	public String view(){
		roleQueryName = "";
		Set<Module> li = entity.getMenuList();
		for(Module m : li){
			roleQueryName +=m.getName()+",";
		}
		if(roleQueryName.indexOf(",") >= 0){
			roleQueryName = roleQueryName.substring(0,roleQueryName.length() - 1);
		}else{
			roleQueryName = "";
		}
		return VIEW;
	}
	public String insert(){
		return INSERT;
	}


	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String listForSelect() {
		CustomExample<Role> example = new CustomExample<Role>(this.getModel()) {
			private static final long serialVersionUID = 1L;
			public void appendCondition(Criteria criteria) {
				entity.setValidFlag(ValidFlag.VALID);
				Criterion c = Restrictions.sqlRestriction("isChildID_ROLE({alias}.id,"+loginUser.getRoleIds()+")=0");
				criteria.add(c);
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = roleService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);

		return "listForSelect";
	}

	public void saveRoleModules() {
		try {
			roleService.saveRoleModule(entity, selectedModules);
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

	private String selectedModules;

	private String menuHtml;

	public String getMenuHtml() {
		return menuHtml;
	}

	public void setMenuHtml(String menuHtml) {
		this.menuHtml = menuHtml;
	}

	public String getSelectedModules() {
		return selectedModules;
	}

	public void setSelectedModules(String selectedModules) {
		this.selectedModules = selectedModules;
	}
	public void prepare() throws Exception {
		if (id != null) {
			entity = roleService.findByIdEx(id);
		} else {
			entity = new Role();
		}
	}

	public String getRoleQueryName() {
		return roleQueryName;
	}

	public void treeHTML(){
		tmpRole = roleService.findAllValid();
		htmlBuf = new StringBuffer();
		roleTreeBuilder();
		tmpRole = null;
		responseHtml(htmlBuf.toString());
		htmlBuf = null;
	}
	
	// fubo 增加 递归实现生成树
	private List<Role> tmpRole;
	private int level = 0;
	private StringBuffer htmlBuf;
	private int px = 40;
	private void roleTreeBuilder(){
		for(Role parentRole : tmpRole){
			Long getRoleID = parentRole.getId();
			if(parentRole.getParent() == null){ // is parent
				level = 0; // 当前层位最高层
				htmlBuf.append("<tr data-id=" + getRoleID + " data-pid=0 data-level=" + level + ">"
						//+ "<td>" + getRoleID + "</td>"
						+ "<td onclick=\"toggleChildNode(this)\" style=\"padding-left:" + level*px + "px\">" + parentRole.getName() + "</td>"
						+ "<td>" + parentRole.getDescription() + "</td>"
						+ "<td id=\"hrefoperation\"></td>"
						+ "</tr>");
				roleTreeLoop(parentRole);
			}
		}
	}
	private String roleTreeLoop(Role roleSingle){
		List<Role> childRoles = treeGetChild(roleSingle);
		if(!childRoles.isEmpty()){
			level ++;
			for(Role childRole : childRoles){
				Long getChildRoleID = childRole.getId();
				htmlBuf.append("<tr style=\"display:none;\" data-id=" + getChildRoleID + " data-pid=" + childRole.getParent().getId() + " data-level=" + level + ">"
						//+ "<td>" + getChildRoleID + "</td>"
						+ "<td onclick=\"toggleChildNode(this)\" style=\"padding-left:" + level*px + "px\">" + childRole.getName() + "</td>"
						+ "<td>" + childRole.getDescription() + "</td>"
						+ "<td id=\"hrefoperation\"></td>"
						+ "</tr>");
				roleTreeLoop(childRole);
			}
			level --;

		}
		return "";
	}
	private List<Role> treeGetChild(Role roleSingle){
		List<Role> tmpList = new ArrayList<Role>();
		Long parnetID = roleSingle.getId();
		for(Role tmpr : tmpRole){
			Role tmprParent = tmpr.getParent();
			if(tmprParent != null && tmprParent.getId() == parnetID){
				tmpList.add(tmpr);
			}
		}
		return tmpList;
	}

	public void setRoleQueryName(String roleQueryName) {
		this.roleQueryName = roleQueryName;
	}

	public Long[] getSelected() {
		return selected;
	}

	public void setSelected(Long[] selected) {
		this.selected = selected;
	}

	public List<Module> getModuleList() {
		return moduleList;
	}

	public void setModuleList(List<Module> moduleList) {
		this.moduleList = moduleList;
	}

}
