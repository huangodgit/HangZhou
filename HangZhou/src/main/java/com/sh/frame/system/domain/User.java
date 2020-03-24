package com.sh.frame.system.domain;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.sh.frame.constant.ValidFlag;

@Entity
@Table(name = "system_user")
public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(length = 50)
	private String name;

	@Column(length = 20)
	private String loginName;

	@JsonIgnore
	@Column(length = 100)
	private String password;

	@JsonIgnore
	@Column(length = 100)
	private String tel;

	@Column(length = 500)
	private String remark;

	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "users")
	private Set<UserGroup> userGroups = new HashSet<UserGroup>();

	// 所属部门
	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER, cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private Org org;

	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY, cascade = { CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH })
	@JoinTable(name = "system_user_role", joinColumns = @JoinColumn(name = "user_id") , inverseJoinColumns = @JoinColumn(name = "role_id") )
	private Set<Role> roleList = new HashSet<Role>();

	// 当前用户的登陆次数
	@JsonIgnore
	@Column(length = 19)
	private int logincount;

	// 当前用户最后一次登录系统的时间
	@JsonIgnore
	@Column(name = "LASTLOGINTIME")
	private Date lastlogintime;

	@Transient
	private String rolename = "";

	@JsonIgnore
	@Enumerated(value = EnumType.STRING)
	private ValidFlag validFlag = ValidFlag.VALID;


	@Transient
	private String topMenuHtml;

	@Transient
	private HashMap<String, String> menuHtmlMap;

	@Transient
	private String firstSideBarHtml;

	@Transient
	private Set<Module> allAvailableModules;


	public String getFirstSideBarHtml() {
		return firstSideBarHtml;
	}

	public void setFirstSideBarHtml(String firstSideBarHtml) {
		this.firstSideBarHtml = firstSideBarHtml;
	}

	public String getTopMenuHtml() {
		return topMenuHtml;
	}

	public void setTopMenuHtml(String topMenuHtml) {
		this.topMenuHtml = topMenuHtml;
	}

	public HashMap<String, String> getMenuHtmlMap() {
		return menuHtmlMap;
	}

	public void setMenuHtmlMap(HashMap<String, String> menuHtmlMap) {
		this.menuHtmlMap = menuHtmlMap;
	}

	public Set<Role> getRoleList() {
		return roleList;
	}

	public void setRoleList(Set<Role> roleList) {
		this.roleList = roleList;
	}

	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	public ValidFlag getValidFlag() {
		return validFlag;
	}

	public void setValidFlag(ValidFlag validFlag) {
		this.validFlag = validFlag;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getRoleNames() {
		if (roleList != null && roleList.size() > 0) {
			for (Role r : roleList) {
				rolename = rolename + r.getName() + " ";
			}
		}
		return rolename;
	}

	public String getRolename() {
		return getRoleNames();
	}

	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

	public String getRoleIds() {
		String roleid = "";
		if (roleList != null && roleList.size() > 0) {
			for (Role r : roleList) {
				roleid = roleid + r.getId() + " ";
			}
		}
		return roleid.trim();
	}

	public Set<UserGroup> getUserGroups() {
		return userGroups;
	}

	public void setUserGroups(Set<UserGroup> userGroups) {
		this.userGroups = userGroups;
	}

	public int getLogincount() {
		return logincount;
	}

	public void setLogincount(int logincount) {
		this.logincount = logincount;
	}

	public String getLastlogintime() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (lastlogintime != null) {
			try {
				return df.format(lastlogintime);
			} catch (Exception e) {
				return "";
			}
		} else {
			return "";
		}
	}

	public void setLastlogintime(Date lastlogintime) {
		this.lastlogintime = lastlogintime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Set<Module> getAllAvailableModules() {
		return allAvailableModules;
	}

	public void setAllAvailableModules(Set<Module> allAvailableModules) {
		this.allAvailableModules = allAvailableModules;
	}

}
