package com.qqpp.qzce.baseInfo.domain;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;


@Entity
@Table(name = "t_collectionarea")
public class CollectionArea implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(length = 100)
	private String name;// 名称

	private String pointSet;// 点集合

	@Temporal(TemporalType.TIMESTAMP)
	private Date startDate;// 设立时间

	private String intro;// 简介

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "collectionArea")
	private List<Enterprise> enterprises;// 企业

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "collectionArea")
	private List<Project> projects;// 项目

	public String getPointSet() {
		return pointSet;
	}

	public void setPointSet(String pointSet) {
		this.pointSet = pointSet;
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

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public List<Enterprise> getEnterprises() {
		return enterprises;
	}

	public void setEnterprises(List<Enterprise> enterprises) {
		this.enterprises = enterprises;
	}

	public String getStartDate() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		if (startDate != null && !startDate.equals("")) {
			return df.format(startDate);
		}
		return "";
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public List<Project> getProjects() {
		return projects;
	}

	public void setProjects(List<Project> projects) {
		this.projects = projects;
	}

}
