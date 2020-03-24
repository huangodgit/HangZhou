package com.sh.frame.system.domain;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
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

/**
 * 用户组
 * 
 * @author ZXP
 *
 */
@Entity
@Table(name = "system_group")
public class UserGroup implements Serializable {
	private static final long serialVersionUID = 3138868249737148522L;
	private Long id;
	private String name;
	private Integer sortnum;

	@JsonIgnore
	private UserGroup parent;

	@JsonIgnore
	private ValidFlag validFlag;

	private Set<User> users = new HashSet<User>();

	@Enumerated(value = EnumType.STRING)
	public ValidFlag getValidFlag() {
		return validFlag;
	}

	public void setValidFlag(ValidFlag validFlag) {
		this.validFlag = validFlag;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
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

	public Integer getSortnum() {
		return sortnum;
	}

	public void setSortnum(Integer sortnum) {
		this.sortnum = sortnum;
	}

	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinColumn(name = "PARENTID")
	public UserGroup getParent() {
		return parent;
	}

	public void setParent(UserGroup parent) {
		this.parent = parent;
	}

	@Transient
	public boolean isParent() {
		return this.getParent() == null ? true : false;
	}

	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY, cascade = { CascadeType.REFRESH })
	@JoinTable(name = "SYSTEM_GROUP_USER", joinColumns = @JoinColumn(name = "group_id") , inverseJoinColumns = @JoinColumn(name = "user_id") )
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof UserGroup) {
			UserGroup t = (UserGroup) obj;
			if (t.id == null || this.id == null) {
				return false;
			}
			if (t.getId().equals(this.id)) {
				return true;
			}
			return super.equals(obj);
		}
		return false;
	}

	@Override
	public int hashCode() {
		if (id != null) {
			return id.hashCode();
		}
		;
		return super.hashCode();
	}

	@JsonIgnore
	@Transient
	public Long getParentId() {
		return parent.getId();
	}

	@Transient
	public boolean isChecked() {
		return false;
	}

}
