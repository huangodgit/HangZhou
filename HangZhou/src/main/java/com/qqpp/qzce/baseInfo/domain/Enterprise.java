package com.qqpp.qzce.baseInfo.domain;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 
 * 企业表
 * 
 * @author ZXP
 * 
 */
@Entity
@Table(name = "t_enterprise")
public class Enterprise implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(length = 100)
	private String code;// 编号

	@Column(length = 100)
	private String name;// 企业名称

	private String intro;// 企业文化（简介）
	@Column
	private String longitude;// 经度

	@Column
	private String latitude;// 纬度

	@Column(length = 100)
	private String legalMember;// 法定代表人

	@Column
	private Double fund;// 注册资金
	@Column
	private String businessLicenseNum;// 营业执照号

	@Column
	private String taxpayerNumber;// 纳税人识别号

	@Column(length = 200)
	private String address;// 注册地址

	private Date foundTime;// 成立时间

	@JsonIgnore
	@OneToMany(mappedBy = "enterprise")
	private List<EnterpriseInnerCycle> enterpriseInnerCycles;// 企业内循环

	@JsonIgnore
	@OneToMany(mappedBy = "enterprise")
	private List<EnterpriseOuterCycle> enterpriseOuterCycles;// 企业外循环

	@JsonIgnore
	@OneToMany(mappedBy = "enterprise")
	private List<Project> projects;// 项目
	
	@JsonIgnore
	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private CollectionArea collectionArea;// 聚集区


	@Transient
	private Boolean attribute; 

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

	public String getLegalMember() {
		return legalMember;
	}

	public void setLegalMember(String legalMember) {
		this.legalMember = legalMember;
	}

	public Double getFund() {
		return fund;
	}

	public void setFund(Double fund) {
		this.fund = fund;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
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

	public String getBusinessLicenseNum() {
		return businessLicenseNum;
	}

	public void setBusinessLicenseNum(String businessLicenseNum) {
		this.businessLicenseNum = businessLicenseNum;
	}

	public String getTaxpayerNumber() {
		return taxpayerNumber;
	}

	public void setTaxpayerNumber(String taxpayerNumber) {
		this.taxpayerNumber = taxpayerNumber;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getFoundTime() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		if (foundTime != null && !foundTime.equals("")) {
			return df.format(foundTime);
		}
		return "";
	}

	public void setFoundTime(Date foundTime) {
		this.foundTime = foundTime;
	}

	public List<EnterpriseInnerCycle> getEnterpriseInnerCycles() {
		return enterpriseInnerCycles;
	}

	public void setEnterpriseInnerCycles(List<EnterpriseInnerCycle> enterpriseInnerCycles) {
		this.enterpriseInnerCycles = enterpriseInnerCycles;
	}

	public List<EnterpriseOuterCycle> getEnterpriseOuterCycles() {
		return enterpriseOuterCycles;
	}

	public void setEnterpriseOuterCycles(List<EnterpriseOuterCycle> enterpriseOuterCycles) {
		this.enterpriseOuterCycles = enterpriseOuterCycles;
	}

	public List<Project> getProjects() {
		return projects;
	}

	public void setProjects(List<Project> projects) {
		this.projects = projects;
	}

	public CollectionArea getCollectionArea() {
		return collectionArea;
	}

	public void setCollectionArea(CollectionArea collectionArea) {
		this.collectionArea = collectionArea;
	}

	public Boolean getAttribute() {
		return attribute;
	}

	public void setAttribute(Boolean attribute) {
		this.attribute = attribute;
	}

}
