package com.sh.frame.system.domain;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.sh.frame.constant.ValidFlag;


@SuppressWarnings("rawtypes")
@Entity
@Table(name = "system_module")
public class Module implements Serializable ,Comparable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(length = 200)
	private String name;

	@Column(length = 50)
	private String target;

	@Column(length = 20)
	private String code;

	@Column
	private Boolean exter = false;

	@Column(length = 512)
	private String link;

	@Column(length = 200)
	private String picUrl;

	@Column(length = 500)
	private String description;

	@Column(name = "menulevel")
	private Integer level;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private Module parent;

	@Column
	private Integer sortnum;

	private String pos_no;

	@Enumerated(value = EnumType.STRING)
	private ValidFlag validFlag;

	@Transient
	private Boolean added = false;
	
	@Transient
	private Boolean checked;

	// 操作权限
	private String permission;
	// 资源类型
	@Column(length = 32)
	private String type = ResourceType.menu.getName();

	// 资源路径--不同于link
	private String resourceUri;
	// 是否可用
	private Boolean available = Boolean.FALSE;

	public static enum ResourceType {
		menu("菜单"), operation("操作"), data("数据");

		private final String name;

		private ResourceType(String name) {
			this.name = name;
		}

		public String getName() {
			return name;
		}
	}

	public Boolean getExter() {
		if (exter == null) {
			return false;
		} else {
			return exter;
		}
	}

	public void setExter(Boolean exter) {
		this.exter = exter;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setAdded(Boolean b) {
		added = b;
	}

	public Boolean getAdded() {
		return added;
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

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getPicUrl() {
		return picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Module getParent() {
		return parent;
	}

	public void setParent(Module parent) {
		this.parent = parent;
	}

	public Integer getSortnum() {
		return sortnum;
	}

	public void setSortnum(Integer sortnum) {
		this.sortnum = sortnum;
	};

	public int compareTo(Object obj) {
		Module cmp = (Module) obj;
		if (this.sortnum == null && cmp.sortnum == null) {
			return 1;
		} else if (this.sortnum != null && cmp.sortnum != null) {
			return this.sortnum.compareTo(cmp.sortnum);
		} else if (this.sortnum == null) {
			return 1;
		} else {
			return -1;
		}
	}

	public boolean equals(Object obj) {
		Module cmp = (Module) obj;
		return this.id.equals(cmp.id);
	}

	public String getPos_no() {
		return pos_no;
	}

	public void setPos_no(String pos_no) {
		this.pos_no = pos_no;
	}

	public boolean isParent() {
		return this.getParent() == null ? true : false;
	}

	public Long getParentId() {
		if (this.isParent())
			return 0L;
		else
			return this.getParent().getId();
	}

	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Boolean getAvailable() {
		return available;
	}

	public void setAvailable(Boolean available) {
		this.available = available;
	}

	public String getResourceUri() {
		return resourceUri;
	}

	public void setResourceUri(String resourceUri) {
		this.resourceUri = resourceUri;
	}

//	@JsonIgnore
//	public String getLink() {
//		if (link.indexOf("${preYear}") > -1 && link.indexOf("${currentYear}") > -1) {
//			Date d = new Date();
//			String endTime = "'end";// DateFormate.dateToStr("yyyy-MM", d);
//			Calendar rightNow = Calendar.getInstance();
//			rightNow.setTime(d);
//			rightNow.add(Calendar.YEAR, -1);// 日期减1年
//			// Date dt = rightNow.getTime();
//			String beginTime = "aaa";// DateFormate.dateToStr("yyyy-MM", dt);
//			link = link.replace("${preYear}", beginTime);
//			link = link.replace("${currentYear}", endTime);
//		}
//		return link;
//	}

	public boolean isValiadResource() {
		if (available) {
			if (link != null && link.length() > 3 && "menu".equalsIgnoreCase(type)) {
				return true;
			}
			if (resourceUri != null && type.equalsIgnoreCase("operation")) {
				return true;
			}
		}
		return false;
	}

	public boolean isChecked() {
		return false;
	}

	public String getQueryTable() {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean getChecked() {
		return checked;
	}

	public void setChecked(Boolean checked) {
		this.checked = checked;
	}

}
