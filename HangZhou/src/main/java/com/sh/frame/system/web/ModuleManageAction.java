package com.sh.frame.system.web;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.sh.frame.constant.ValidFlag;
import com.sh.frame.system.domain.Module;
import com.sh.frame.system.service.IModuleService;
import com.sh.frame.utils.JQueryDataTablesUtil;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.PaginationSupport;

public class ModuleManageAction extends BaseAction<Module> {

	private static final long serialVersionUID = 1L;

	@Autowired(required = true)
	private IModuleService moduleService;

	private Long parentid;

	private String funcName;

	private Long changeNum;

	private String actionOperation;

	private String searchModule;

	private String permissionName;
	private Long mode;
	private String affectNum;
	private String expandStr;
	private String expandList;

	public void delete() {
		//SaveOrUpdateDone sou = new SaveOrUpdateDone();
		int getFunctionNum = getFunctionList().size();
		if(getFunctionNum > 0){
			msgResult.put("info", "存在子级功能,请先删除子级功能");
			msgResult.put("ok", false);
		}else{
			try {
				entity.setParent(null);
				moduleService.invalid(entity);
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
	private List<Module> getFunctionList(){
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Module.class);
		detachedCriteria.createAlias("parent", "p");
		detachedCriteria.add(Restrictions.eq("p.id", entity.getId()));
		detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		List<Module> list = moduleService.findAllByCriteria(detachedCriteria);
		return list;

	}

	public void save() {
		//SaveOrUpdateDone sou = new SaveOrUpdateDone();
		if(entity.getName() == null || entity.getCode() == null){
			msgResult.put("info", "信息不完整");
			msgResult.put("ok", false);
		}else{
			try {
				/*if (entity.getParent() != null
						&& entity.getParent().getId() == null) {
					entity.setParent(null);
					entity.setLevel(1);
				} else if (entity.getParent() != null) {
					Module tmpP = moduleService
							.findById(entity.getParent().getId());
					entity.setParent(tmpP);
					entity.setLevel(tmpP.getLevel() + 1);
				} else{
					entity.setLevel(1);
				}*/
				
				if(parentid!=null)
				{
					Module tmpP = moduleService.findById(parentid);
					entity.setParent(tmpP);
					entity.setLevel(tmpP.getLevel() + 1);
				}else{
					entity.setParent(null);
					entity.setLevel(1);
				}
				if(actionOperation != null && actionOperation.equals("insert")){
					Long parentID = null;
					if(entity != null && entity.getParent() != null && entity.getParent().getId() != null){
						parentID = entity.getParent().getId();
					}
					entity.setSortnum(getSortNumMax(entity.getLevel(),parentID,-1));
				}
				if(entity.getType() == null || !(entity.getType().equals("menu") && entity.getType().equals("operation"))){
					entity.setType("menu");
				}
				entity.setAvailable(Boolean.TRUE);
				entity.setValidFlag(ValidFlag.VALID);
				moduleService.saveOrUpdate(entity);
				msgResult.put("info", "保存成功,将在您重新登录后生效");
				msgResult.put("ok", true);
			} catch (Exception e) {
				msgResult.put("info", "保存失败,异常错误");
				msgResult.put("ok", false);
			}
		}

		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}
	private Integer getSortNumMax(Integer level,Long parentID,int addNum){
		Integer sortnum = 0;
		int addSortNum = 0;
		switch(level){
			case 1:addSortNum = 10000;break;
			case 2:addSortNum = 100;break;
			case 3:addSortNum = 1;break;
		}
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Module.class);
		detachedCriteria.createAlias("parent", "parent",DetachedCriteria.LEFT_JOIN);
		if(parentID == null){
			detachedCriteria.add(Restrictions.or(Restrictions.eq("id", parentID), Restrictions.isNull("parent")));
		}else{
			detachedCriteria.add(Restrictions.or(Restrictions.eq("id", parentID), Restrictions.eq("parent.id", parentID)));
		}
		detachedCriteria.add(Restrictions.ne("sortnum", 400000)); // 排序序号400000被系统管理占用,也就是系统管理永远在最后一个
		detachedCriteria.addOrder(Order.desc("sortnum"));
		List<Module> returnList = moduleService.findAllByCriteria(detachedCriteria);
		sortnum = returnList.get(0).getSortnum();
		int lastNum = sortnum % 10;
		if(addNum > 0){
			int parentnum = sortnum - lastNum; // 这样为父级排序序号
			sortnum  = parentnum + addNum;
		}else if(addNum == 0){ // 默认从6开始排序 前5个被list,*,insert,edit,view占用
			addNum = 6;
			addNum = addNum - lastNum;
			if(addNum < 0){
				addNum = 0;
			}
			sortnum = sortnum + addSortNum+addNum;
		}else{
			sortnum = sortnum + addSortNum;
		}
		
		
		
		return sortnum;
	}
	public String listTree(){
		return "listTree";
	}
	public String view(){
		funcName = "";
		List<Module> moduleList = getFunctionList();
		for(Module m : moduleList){
			funcName += m.getName()+",";
		}
		if(funcName.indexOf(",") >= 0){
			funcName = funcName.substring(0,funcName.length() - 1);
		}else{
			funcName = "";
		}
		return VIEW;
	}

	public String listTreeForSelect(){
		//	html = moduleService.getModuleTree(true);
		return "listTreeForSelect";
	}

	private Long selectParentId;

	public Long getSelectParentId() {
		return selectParentId;
	}

	public void setSelectParentId(Long selectParentId) {
		this.selectParentId = selectParentId;
	}
	public void listTreeData(){
		responseHtml(builder.create().toJson(moduleService.findAllValid()));
	}

	public void listAllForJQueryDataTable() {
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Module.class);
		if (funcName != null && !"".equals(funcName))
			detachedCriteria.add(Restrictions.like("name",
					"%" + funcName + "%"));
		detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		detachedCriteria.addOrder(Order.asc("id"));
		this.listResult = moduleService.findPageByCriteria(detachedCriteria,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		System.out.println(listResult.getItems().size());
		responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(), listResult));
	}

	public String codelink;



	public String getCodelink() {
		return codelink;
	}

	public void setCodelink(String codelink) {
		this.codelink = codelink;
	}

	public String edit() {
		codelink = entity.getLink();
		return EDIT;
	}
	public void changeModuleAvaliable(){
		if(mode != null && mode == 0){
			try{
				boolean b = entity.getAvailable();
				if(b){
					entity.setAvailable(Boolean.FALSE);
				}else{
					entity.setAvailable(Boolean.TRUE);
				}
				moduleService.saveOrUpdate(entity);
				msgResult.put("ok", true);
			}catch(Exception e){
				e.printStackTrace();
				msgResult.put("ok", false);
			}
		}else if(mode != null && mode == 1){
			try{
				JsonParser parser = new JsonParser();
				JsonObject obj = parser.parse(affectNum).getAsJsonObject();
				JsonArray arr = obj.getAsJsonArray("num");
				long offOrOn = arr.get(0).getAsLong();
				Boolean b;
				if(offOrOn == 0){
					b = Boolean.FALSE;
				}else{
					b = Boolean.TRUE;
				}
				for(int i = 1 ; i < arr.size() ; i++){
					entity = moduleService.findById(arr.get(i).getAsLong());
					entity.setAvailable(b);
					moduleService.saveOrUpdate(entity);
				}
				msgResult.put("ok", true);
			}catch(Exception e){
				e.printStackTrace();
				msgResult.put("ok", false);
			}
		}else{
			msgResult.put("ok", false);
		}

		responseHtml(builder.create().toJson(msgResult));
	}
	public String addSon() {
		if (selectParentId != null) {
			entity.setParent(moduleService.findById(selectParentId));
		}
		return "addSon";
	}
	public String insert(){
		return INSERT;
	}
	public String list() {
		return LIST;
	}

	private String html;

	public String getHtml() {
		return html;
	}

	public void treeHTML(){
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Module.class);
		detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		detachedCriteria.addOrder(Order.asc("sortnum"));
		if(actionOperation != null){
			if(actionOperation.equals("noOp")){
				detachedCriteria.add(Restrictions.ne("type", "operation"));
			}else if(actionOperation.equals("noOPAVALIABLE")){
				detachedCriteria.add(Restrictions.ne("type", "operation"));
				detachedCriteria.add(Restrictions.eq("available", Boolean.TRUE));
			}
		}
		tmpModule = moduleService.findAllByCriteria(detachedCriteria);
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
		tmpModule = null;
		responseHtml(htmlBuf.toString());
		htmlBuf = null;
		expLong = null;
		expList = null;
	}

	// fubo 增加 递归实现生成树
	private List<Module> tmpModule;
	private int level = 0;
	private StringBuffer htmlBuf;
	private int px = 40;
	private List<Long> expLong;
	private List<Long> expList;
	private void roleTreeBuilder(){
		for(Module parentModule : tmpModule){
			Long getModuleID = parentModule.getId();
			if(parentModule.getParent() == null){ // is parent
				String checkLabel = "1";
				if(!parentModule.getAvailable()){
					checkLabel = "0";
				}
				String type = "0";
				if(parentModule.getType().equals("operation")){
					type = "1";
				}
				String resName = "";
				if(parentModule.getResourceUri() != null && parentModule.getResourceUri().indexOf("/") >= 0){
					String[] s = parentModule.getResourceUri().split("/");
					resName = s[s.length-2];
				}
				String expand = "expand=\"0\"";
				if(expList != null){
					for(int i = 0 ; i < expList.size() ; i++){
						if(getModuleID.equals(expList.get(i))){
							expand = "expand=\"1\"";
							expList.remove(i);
							break;
						}
					}
				}
				level = 0; // 当前层位最高层
				htmlBuf.append("<tr "+expand+" data-id=" + getModuleID + " data-pid=0 data-level=" + level + " data-enable=\""+checkLabel+"\" data-permission=\""+parentModule.getPermission()+"\" data-permissionName=\""+resName+"\" data-type=\""+type+"\">"
						//+ "<td>" + getRoleID + "</td>"
						+ "<td onclick=\"toggleChildNode(this)\" style=\"padding-left:" + level*px + "px\">" + parentModule.getName() + "</td>"
						+ "<td style=\"text-align:center;\">" + parentModule.getCode() + "</td>"
						+ "<td></td>"
						+ "<td></td>"
						+ "<td id=\"hrefoperation\"></td>"
						+ "<td style=\"text-align:center;\" id=\"isEnable\"></td>"
						//+ "<td>" + (parentModule.getDescription() != null?(parentModule.getDescription().length() > 35?parentModule.getDescription().substring(0, 35)+"....":parentModule.getDescription()):"") + "</td>"
						+ "</tr>");
				moduleTreeLoop(parentModule);
			}
		}
	}
	private String moduleTreeLoop(Module moudleSingle){
		List<Module> childModules = treeGetChild(moudleSingle);
		if(!childModules.isEmpty()){
			level ++;
			for(Module childModule : childModules){
				String checkLabel = "1";
				if(!childModule.getAvailable()){
					checkLabel = "0";
				}
				String typeStr = "0";
				
				String permission = childModule.getPermission();
				if(childModule.getType().equals("operation") && childModule.getPermission() != null && !childModule.getPermission().endsWith(":list")){
					typeStr = "操作";
				}else{
					permission = childModule.getResourceUri();
					typeStr = "菜单";
				}
				if(level < 2){
					typeStr = "";
				}
				String resName = "";
				if(childModule.getResourceUri() != null && childModule.getResourceUri().indexOf("/") >= 0){
					String[] s = childModule.getResourceUri().split("/");
					resName = s[s.length-2];
				}
				Long getChildModuleID = childModule.getId();
				String display = "style=\"display:none;\"";
				if(expLong != null){
					for(int i = 0 ; i < expLong.size() ; i++){
						if(getChildModuleID.equals(expLong.get(i))){
							display = "";
							expLong.remove(i);
							break;
						}
					}
				}
				String expand = "expand=\"0\"";
				if(expList != null){
					for(int i = 0 ; i < expList.size() ; i++){
						if(getChildModuleID.equals(expList.get(i))){
							expand = "expand=1";
							expList.remove(i);
							break;
						}
					}
				}
				htmlBuf.append("<tr "+display+" "+expand+" data-id=" + getChildModuleID + " data-pid=" + childModule.getParent().getId() + " data-level=" + level + " data-enable=\""+checkLabel+"\" data-permission=\""+childModule.getPermission()+"\" data-permissionName=\""+resName+"\">"
						//+ "<td>" + getChildRoleID + "</td>"
						+ "<td onclick=\"toggleChildNode(this)\" style=\"padding-left:" + level*px + "px\">" + childModule.getName()+"</td>"
						+ "<td style=\"text-align:center;\">" + childModule.getCode() + "</td>"
						+ "<td>"+permission+"</td>"
						+ "<td>"+typeStr+"</td>"
						+ "<td id=\"hrefoperation\"></td>"
						+ "<td style=\"text-align:center;\" id=\"isEnable\"></td>"
						//+ "<td>" + (childModule.getDescription() != null?(childModule.getDescription().length() > 35?childModule.getDescription().substring(0, 35)+"....":childModule.getDescription()):"") + "</td>"
						+ "</tr>");
				moduleTreeLoop(childModule);
			}
			level --;

		}
		return "";
	}
	public String addModule(){
		if(actionOperation != null){
			if(actionOperation.equals("web")){
				return "addModule";
			}else if(actionOperation.equals("save")){
				try{
					String[] getRes = entity.getResourceUri().split("/");
					entity.setPermission("#");
					entity.setResourceUri(getRes[0]+"/"+getRes[1]+"/list");
					entity.setLink(getRes[0]+"/"+getRes[1]+"/list");
					entity.setLevel(2);
					entity.setParent(moduleService.findById(parentid));
					entity.setSortnum(getSortNumMax(2, parentid,-1));
					entity.setAvailable(Boolean.TRUE);
					entity.setValidFlag(ValidFlag.VALID);
					entity.setType("menu");
					moduleService.saveOrUpdate(entity);
					Module tmpModule = new Module();
					tmpModule.setId(null);
					tmpModule.setParent(entity);
					tmpModule.setName("列表");
					tmpModule.setCode("LIST");
					tmpModule.setLevel(3);
					tmpModule.setSortnum(getSortNumMax(3, entity.getId(),1));
					tmpModule.setAvailable(Boolean.TRUE);
					tmpModule.setValidFlag(ValidFlag.VALID);
					tmpModule.setResourceUri(getRes[0]+"/"+getRes[1]+"/list");
					tmpModule.setLink(getRes[0]+"/"+getRes[1]+"/list");
					tmpModule.setPermission(getRes[1]+":list");
					tmpModule.setType("operation");
					moduleService.saveOrUpdate(tmpModule);
					Module tmpModule2 = new Module();
					tmpModule2.setId(null);
					tmpModule2.setParent(entity);
					tmpModule2.setName("全部权限");
					tmpModule2.setCode("*");
					tmpModule2.setLevel(3);
					tmpModule2.setSortnum(getSortNumMax(3, entity.getId(),2));
					tmpModule2.setAvailable(Boolean.TRUE);
					tmpModule2.setValidFlag(ValidFlag.VALID);
					tmpModule2.setResourceUri(getRes[0]+"/"+getRes[1]+"/*");
					tmpModule2.setLink(getRes[0]+"/"+getRes[1]+"/*");
					tmpModule2.setPermission(getRes[1]+":*");
					tmpModule2.setType("operation");
					moduleService.saveOrUpdate(tmpModule2);
					msgResult.put("ok", true);
					msgResult.put("info", "创建成功");
				}catch(Exception e){
					e.printStackTrace();
					msgResult.put("ok", false);
					msgResult.put("info", "创建失败");
				}
				responseHtml(builder.create().toJson(msgResult));
			}
		}
		return NONE;
	}
	public String addPermission(){
		if(actionOperation != null){
			if(actionOperation.equals("web")){
				return "addPermission";
			}else 
//				if(actionOperation.equals("list")){
//				DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Module.class);
//				detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
//				detachedCriteria.add(Restrictions.eq("type", "operation"));
//				detachedCriteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
//				List<Module> list = moduleService.findAllByCriteria(detachedCriteria);
//				Set<String> nvps = new HashSet<String>();
//				for(Module m : list){
//					String tmpp = m.getPermission();
//					if(tmpp == null || tmpp.indexOf(":") == -1){
//						continue;
//					}
//					tmpp = tmpp.split(":")[1];
//					nvps.add(tmpp);
//				}
//				responseHtml(builder.create().toJson(nvps));
//			}else 
				if(actionOperation.equals("save")){
				String setURI = permissionName.split(":")[1];
				String parentURI = entity.getResourceUri();
				String URI = parentURI.substring(0, parentURI.lastIndexOf("/"))+"/"+setURI;
				int returnDuplicate = isHaved(permissionName,URI);
				if(returnDuplicate == 1){
					msgResult.put("ok", false);
					msgResult.put("info", "资源已存在");
				}else if(returnDuplicate == 2){
					msgResult.put("ok", false);
					msgResult.put("info", "权限已存在");
				}else{
					try{
						Long pid = entity.getId();
						entity.setId(null);
						entity.setName(funcName);
						entity.setPermission(permissionName);
						
						entity.setType("operation");
						if(setURI.equals("list")){
							entity.setSortnum(getSortNumMax(3, pid,1));
						}else if(setURI.equals("*")){
							entity.setSortnum(getSortNumMax(3, pid,2));
						}else if(setURI.equals("insert")){
							entity.setSortnum(getSortNumMax(3, pid,3));
						}else if(setURI.equals("edit")){
							entity.setSortnum(getSortNumMax(3, pid,4));
						}else if(setURI.equals("view")){
							entity.setSortnum(getSortNumMax(3, pid,5));
						}else{
							entity.setSortnum(getSortNumMax(3, pid,0));
						}
						
						entity.setResourceUri(URI);
						entity.setLink(URI);
						entity.setCode(setURI.toUpperCase());
						if(entity.getPermission() == null){
							entity.setPermission("");
						}
						entity.setAvailable(Boolean.TRUE);
						entity.setParent(moduleService.findById(id));
						moduleService.saveOrUpdate(entity);
						msgResult.put("ok", true);
						msgResult.put("info", "保存成功");
						//					// 内容输出
						//					msgResult.put("id", entity.getId());
						//					msgResult.put("pid", entity.getParent().getId());
						//					msgResult.put("level", entity.getLevel());
						//					msgResult.put("name", entity.getName());
						//					msgResult.put("permission", permissionName.split(":")[0]);
						//					msgResult.put("code", permissionName.split(":")[1].toUpperCase());
						//					msgResult.put("enabled", entity.getAvailable()?"1":"0");
						//					msgResult.put("type", entity.getType());
						// end
					}catch(Exception e){
						e.printStackTrace();
						msgResult.put("ok", false);
						msgResult.put("info", "保存失败");
					}
				}
				responseHtml(builder.create().toJson(msgResult));

			}
		}
		return NONE;
	}
	private int isHaved(String name,String resources) {
		int val = 0;
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Module.class);
		detachedCriteria.add(Restrictions.eq("validFlag", ValidFlag.VALID));
		detachedCriteria.add(Restrictions.eq("type", "operation"));
		detachedCriteria.add(Restrictions.or(Restrictions.eq("permission", name), Restrictions.eq("resourceUri", resources)));
		List<Module> listm = moduleService.findAllByCriteria(detachedCriteria);
		for(Module m : listm){
			String res = m.getResourceUri();
			String perm = m.getPermission();
			if(res.equals(resources)){
				val = 1;
			}else if(perm.equals(name)){
				val = 2;
			}
		}
		return val;
	}

	private List<Module> treeGetChild(Module moduleSingle){
		List<Module> tmpList = new ArrayList<Module>();
		Long parnetID = moduleSingle.getId();
		for(Module tmpr : tmpModule){
			try{
				Module tmprParent = tmpr!=null?tmpr.getParent():null;

				if(tmprParent != null && tmprParent.getId() == parnetID){
					tmpList.add(tmpr);
				}
			}catch(Exception e){
				e.printStackTrace();
				continue;
			}
		}
		return tmpList;
	}
	//	// fubo追加 权限更改支持
	//	public void changeModuleAuth(){
	//		try{
	//			String auth = entity.getPermission();
	//			String[] authStr = new String[4];
	//			if(auth == null || auth.split(",").length != 4){
	//				authStr[0] = "0";
	//				authStr[1] = "0";
	//				authStr[2] = "0";
	//				authStr[3] = "0";
	//			}else{
	//				authStr = auth.split(",");
	//			}
	//			if(changeNum != null){
	//				switch(changeNum.intValue()){
	//				case 0:
	//					if(authStr[0].equals("0")){
	//						authStr[0] = "1";
	//					}else{
	//						authStr[0] = "0";
	//					}
	//					break;
	//				case 1:
	//					if(authStr[1].equals("0")){
	//						authStr[1] = "1";
	//					}else{
	//						authStr[1] = "0";
	//					}
	//					break;
	//				case 2:
	//					if(authStr[2].equals("0")){
	//						authStr[2] = "1";
	//					}else{
	//						authStr[2] = "0";
	//					}
	//					break;
	//				case 3:
	//					if(authStr[3].equals("0")){
	//						authStr[3] = "1";
	//					}else{
	//						authStr[3] = "0";
	//					}
	//					break;
	//				}
	//				String newAuthStr = authStr[0]+","+authStr[1]+","+authStr[2]+","+authStr[3];
	//				entity.setPermission(newAuthStr);
	//				moduleService.saveOrUpdate(entity);
	//				msgResult.put("ok", true);
	//				msgResult.put("info", "修改成功");
	//				msgResult.put("status", newAuthStr);
	//			}else{
	//				msgResult.put("ok", false);
	//				msgResult.put("info", "修改失败");
	//			}
	//		}catch(Exception e){
	//			msgResult.put("ok", false);
	//			msgResult.put("info", "修改失败");
	//		}
	//		responseHtml(builder.create().toJson(msgResult));
	//	}

	public void setHtml(String html) {
		this.html = html;
	}

	public void prepare() throws Exception {
		if (id != null)
			entity = moduleService.findByIdEx(id);
		else
			entity = new Module();
	}

	public String getFuncName() {
		return funcName;
	}

	public void setFuncName(String funcName) {
		this.funcName = funcName;
	}

	public Long getChangeNum() {
		return changeNum;
	}

	public void setChangeNum(Long changeNum) {
		this.changeNum = changeNum;
	}

	public String getActionOperation() {
		return actionOperation;
	}

	public void setActionOperation(String actionOperation) {
		this.actionOperation = actionOperation;
	}

	public String getSearchModule() {
		return searchModule;
	}

	public void setSearchModule(String searchModule) {
		this.searchModule = searchModule;
	}

	public String getPermissionName() {
		return permissionName;
	}

	public void setPermissionName(String permissionName) {
		this.permissionName = permissionName;
	}

	public Long getMode() {
		return mode;
	}

	public void setMode(Long mode) {
		this.mode = mode;
	}

	public String getAffectNum() {
		return affectNum;
	}

	public void setAffectNum(String affectNum) {
		this.affectNum = affectNum;
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
	public Long getParentid() {
		return parentid;
	}
	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}



}
