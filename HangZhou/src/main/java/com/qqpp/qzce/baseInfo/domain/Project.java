package com.qqpp.qzce.baseInfo.domain;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.qqpp.qzce.news.domain.DocumentFile;


@Entity
@Table(name = "t_project")
public class Project implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	private String projectName;// 项目名称

	private String projectType;// 项目类型
	
	private String intro;// 项目介绍

	@Temporal(TemporalType.TIMESTAMP)
	private Date startDate;// 开工时间
	
	private String longitude;// 经度

	private String latitude;// 纬度
	
	private String explanation;// 说明

	private double investmentCapital;// 投资金额

	private String investmentType;// 投资类型

	private String constructionUnit;// 建设单位
	
	private String projectNewestProgress;//当前项目最新阶段
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date planFinishedDate;// 计划完成时间
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date FinishedDate;// 完工时间
	
	@Transient
	private List<DocumentFile> documentFiles;
	
	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private Enterprise enterprise;// 企业
	
	@JsonIgnore
	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private CollectionArea collectionArea;// 聚集区


	//	项目进度情况
	@OneToMany(cascade = CascadeType.ALL,fetch=FetchType.LAZY,mappedBy="project")
	@OrderBy(value = "progressDate DESC")
	private List<ProjectProgress> ProjectProgress;
	
	@Transient
	private Boolean attribute; 

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectType() {
		return projectType;
	}

	public void setProjectType(String projectType) {
		this.projectType = projectType;
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

	public double getInvestmentCapital() {
		return investmentCapital;
	}

	public void setInvestmentCapital(double investmentCapital) {
		this.investmentCapital = investmentCapital;
	}

	public String getInvestmentType() {
		return investmentType;
	}

	public void setInvestmentType(String investmentType) {
		this.investmentType = investmentType;
	}

	public String getConstructionUnit() {
		return constructionUnit;
	}

	public void setConstructionUnit(String constructionUnit) {
		this.constructionUnit = constructionUnit;
	}

	

	public List<DocumentFile> getDocumentFiles() {
		return documentFiles;
	}

	public void setDocumentFiles(List<DocumentFile> documentFiles) {
		this.documentFiles = documentFiles;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}


	public String getExplanation() {
		return explanation;
	}

	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}

	public String getPlanFinishedDate() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		if (planFinishedDate != null && !planFinishedDate.equals("")) {
			return df.format(planFinishedDate);
		}
		return "";
	}

	public void setPlanFinishedDate(Date planFinishedDate) {
		this.planFinishedDate = planFinishedDate;
	}

	public Enterprise getEnterprise() {
		return enterprise;
	}

	public void setEnterprise(Enterprise enterprise) {
		this.enterprise = enterprise;
	}

	public CollectionArea getCollectionArea() {
		return collectionArea;
	}

	public void setCollectionArea(CollectionArea collectionArea) {
		this.collectionArea = collectionArea;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public Boolean getAttribute() {
		return attribute;
	}

	public void setAttribute(Boolean attribute) {
		this.attribute = attribute;
	}

	public List<ProjectProgress> getProjectProgress() {
		return ProjectProgress;
	}

	public void setProjectProgress(List<ProjectProgress> projectProgress) {
		ProjectProgress = projectProgress;
	}

	public String getProjectNewestProgress() {
		return projectNewestProgress;
	}

	public void setProjectNewestProgress(String projectNewestProgress) {
		this.projectNewestProgress = projectNewestProgress;
	}

	public String getFinishedDate() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		if (FinishedDate != null && !FinishedDate.equals("")) {
			return df.format(FinishedDate);
		}
		return "";
	}

	public void setFinishedDate(Date finishedDate) {
		FinishedDate = finishedDate;
	}

	
	
}
