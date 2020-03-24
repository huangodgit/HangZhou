package com.sh.frame.system.web;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.sh.frame.base.action.BaseAction;
import com.sh.frame.system.domain.Log;
import com.sh.frame.system.domain.Module;
import com.sh.frame.system.domain.Role;
import com.sh.frame.system.domain.User;
import com.sh.frame.system.service.BootStrapHtmlUtil;
import com.sh.frame.system.service.ILogService;
import com.sh.frame.system.service.IOperatingStatisticsService;
import com.sh.frame.system.service.IRoleService;
import com.sh.frame.system.service.IUserService;
import com.sh.frame.utils.MD5Util;

public class MainAction extends BaseAction<User> {

	private static final long serialVersionUID = 8287769782l;

	@Autowired(required = true)
	private IUserService userService;

	@Autowired(required = true)
	private IRoleService roleService;

	@Autowired(required = true)
	private ILogService logService;

	@Autowired(required = true)
	private IOperatingStatisticsService operatingStatisticsService;

	public String topMenuHtmlStr = "";

	public String getTopMenuHtmlStr() {
		return topMenuHtmlStr;
	}

	public void setTopMenuHtmlStr(String topMenuHtmlStr) {
		this.topMenuHtmlStr = topMenuHtmlStr;
	}

	public String index() {
		try {
			entity = userService.findById(loginUser.getId());
			topMenuHtmlStr = loginUser.getTopMenuHtml();
			sidebarHtml = loginUser.getFirstSideBarHtml();
			return INDEX;
		} catch (Exception e) {
			e.printStackTrace();
			return LOGIN;
		}
	}

	public String logout() {
		this.getSession().remove("LOGINUSER");
		return LOGIN;
	}

	public String jcaptcha;

	public String getJcaptcha() {
		return jcaptcha;
	}

	public void setJcaptcha(String jcaptcha) {
		this.jcaptcha = jcaptcha;
	}

	/**
	 * TODO 用户登入 void
	 */
	public String login() {
		try {
			//general login
			loginUser = (User) this.getSession().get("LOGINUSER");
			if (loginUser == null) {
				loginUser = userService.findByLoginNameAndPwdEx(entity.getLoginName(), MD5Util.md5(entity.getPassword()));
			}
			
			//CAS login
//			HttpServletRequest request = ServletActionContext.getRequest();
//			AttributePrincipal principal = (AttributePrincipal) request.getUserPrincipal();
//			String username = principal.getName();
//			if (username != null) {
//				entity.setLoginName(username);
//			} else {
//				return LOGIN;
//			}
//			loginUser = userService.findByLoginName(entity.getLoginName());
			
			
			if (loginUser == null) {
				return LOGIN;
			}
			
			Set<Role> roles = loginUser.getRoleList();
			if (roles == null || roles.size() == 0) {
				msgResult.put("ok", false);
				msgResult.put("info", "用户权限不足");
				logService.saveOrUpdate(new Log().setVName("未登录用户").setVAction("MainAction").setVMethod("login")
						.setVVistdate(new Date()).setVErrormsg("用户无权限,登录失败"));
			} else {
				Set<Module> allModules = new HashSet<Module>();
				TreeSet<Module> menuModules = new TreeSet<Module>();
				for (Role role : roles) {
					Role trueRole = roleService.findByIdEx(role.getId());
					allModules.addAll(trueRole.getMenuList());
				}
				// 增加menu resource
				for (Module resource : allModules) {
					// 添加可获取的
					if ("menu".equalsIgnoreCase(resource.getType()) && resource.getAvailable()) {
						menuModules.add(resource);
					}
				}
				User u = userService.findById(loginUser.getId());
				u.setLogincount(u.getLogincount() + 1);
				u.setLastlogintime(new Date());
				userService.saveOrUpdate(u);

				// 记录操作次数
				operatingStatisticsService.recordOperate("login", u);

				loginUser.setTopMenuHtml(BootStrapHtmlUtil.makeMenuHtml(menuModules));
				loginUser.setLogincount(loginUser.getLogincount() + 1);
				loginUser.setAllAvailableModules(allModules);
				this.getSession().put("LOGINUSER", loginUser);

				logService.saveOrUpdate(
						new Log().setVName(loginUser.getName()).setVAction("MainAction").setVMethod("login")
								.setVUser(loginUser).setVIp(ServletActionContext.getRequest().getRemoteAddr())
								.setVVistdate(new Date()).setVErrormsg("登录成功"));

				topMenuHtmlStr = loginUser.getTopMenuHtml();
				sidebarHtml = loginUser.getFirstSideBarHtml();

				return INDEX;
			}
		} catch (Exception e) {
			msgResult.put("ok", false);
			msgResult.put("info", "用户名错误或密码验证失败");
			e.printStackTrace();
		}
		return LOGIN;
	}

	public void switchTopMenu() {
		if (selectedTopMenuCode != null && selectedTopMenuCode.trim().length() > 0) {
			sidebarHtml = loginUser.getMenuHtmlMap().get(selectedTopMenuCode);
			this.responseHtml(sidebarHtml);
		}
		return;
	}

	private String selectedTopMenuCode = "";

	private String sidebarHtml = "";

	public String getSelectedTopMenuCode() {
		return selectedTopMenuCode;
	}

	public void setSelectedTopMenuCode(String selectedTopMenuCode) {
		this.selectedTopMenuCode = selectedTopMenuCode;
	}

	public String getSidebarHtml() {
		return sidebarHtml;
	}

	public void setSidebarHtml(String sidebarHtml) {
		this.sidebarHtml = sidebarHtml;
	}

	public void prepare() {
		if (id != null) {
			entity = userService.findById(id);
		} else
			entity = new User();
	}

}
