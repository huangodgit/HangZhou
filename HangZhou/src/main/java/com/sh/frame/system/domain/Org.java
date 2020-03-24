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


@Entity
@Table(name = "system_org")
public class Org implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(length = 100)
	private String name;

	@Column(length = 2000)
	private String description;

	@Column(length = 100)
	private String code;

	// 序号
	@Column
	private Integer sortnum;

	@Column
	private String leader;

	@JsonIgnore
	@Enumerated(value = EnumType.STRING)
	private ValidFlag validFlag;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private Org parent;

	@Transient
	private Boolean added = false;

	public Integer getSortnum() {
		return sortnum;
	}

	public void setSortnum(Integer sortnum) {
		this.sortnum = sortnum;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getLeader() {
		return leader;
	}

	public void setLeader(String leader) {
		this.leader = leader;
	}

	public Boolean getAdded() {
		return added;
	}

	public void setAdded(Boolean added) {
		this.added = added;
	}

	public Org getParent() {
		return parent;
	}

	public void setParent(Org parent) {
		this.parent = parent;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public ValidFlag getValidFlag() {
		return validFlag;
	}

	public void setValidFlag(ValidFlag validFlag) {
		this.validFlag = validFlag;
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

	public boolean isChecked() {
		return false;
	}

	public String getLink() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getQueryTable() {
		// TODO Auto-generated method stub
		return null;
	}
}
