package com.qqpp.qzce.baseInfo.domain;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.qqpp.qzce.news.domain.DocumentFile;

/**
 * 项目进度
 */

@Entity
@Table(name = "t_projectProgress")
public class ProjectProgress implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@JsonIgnore
	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private Project project;

	// 当前状态
	private String progressStatus;

	// 发生时间
	@Temporal(TemporalType.TIMESTAMP)
	private Date progressDate;

	// 状态情况说明
	private String progressInfo;
	// // 附件
	// private String docFiles;
	// 操作人
	private String operator;

	// 上报时间
	@Temporal(TemporalType.TIMESTAMP)
	private Date operateTime;

	@Transient
	private List<DocumentFile> documentFiles;

	public List<DocumentFile> getDocumentFiles() {
		return documentFiles;
	}

	public void setDocumentFiles(List<DocumentFile> documentFiles) {
		this.documentFiles = documentFiles;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public String getProgressStatus() {
		return progressStatus;
	}

	public void setProgressStatus(String progressStatus) {
		this.progressStatus = progressStatus;
	}

	public String getProgressDate() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		if (progressDate != null && !progressDate.equals("")) {
			return df.format(progressDate);
		}
		return "";
	}

	public void setProgressDate(Date progressDate) {
		this.progressDate = progressDate;
	}

	public String getProgressInfo() {
		return progressInfo;
	}

	public void setProgressInfo(String progressInfo) {
		this.progressInfo = progressInfo;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getOperateTime() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		if (operateTime != null && !operateTime.equals("")) {
			return df.format(operateTime);
		}
		return "";
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

}
