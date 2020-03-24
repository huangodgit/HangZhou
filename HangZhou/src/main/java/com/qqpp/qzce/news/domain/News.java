package com.qqpp.qzce.news.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

/**
 * 新闻
 * 
 * @author ZXP
 */

@Entity
@Table(name = "t_news")
public class News implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	private String newsType;// 信息类型

	private String title;// 标题

	private String content;// 信息内容

	private String operator; // 发布人

	private Date operateTime; // 发布时间

	private String newsSource; // 新闻来源

	private String status; // 记录是否转为待决策的状态

	private String handleResult; // 处理结果

	private Date handleTime; // 处理时间

	private String handleOperator; // 处理人

	private String topNumber; // 置顶序号
	
	private int hits;// 点击量
	
	private String sendType;// 发布类型（微信、触摸屏）
	
	private String programa;// 栏目

	@OneToMany(mappedBy = "news", cascade = { CascadeType.ALL })
	@OrderBy(value = "operateTime DESC")
	private List<Comments> comments;

	@OneToMany(mappedBy = "news", cascade = { CascadeType.ALL })
	@Where(clause = "type='support'")
	private List<NewsSupport> newsSupports;// 赞

	@OneToMany(mappedBy = "news", cascade = { CascadeType.ALL })
	@Where(clause = "type='oppose'")
	private List<NewsSupport> newsOpposes;// 踩

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getCommentsNum() {
		return comments != null ? comments.size() : 0;
	}

	public String getNewsType() {
		return newsType;
	}

	public void setNewsType(String newsType) {
		this.newsType = newsType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getOperateTime() {
		if (operateTime != null) {
			java.text.DateFormat f = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return f.format(operateTime);
		} else
			return null;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	public String getNewsSource() {
		return newsSource;
	}

	public void setNewsSource(String newsSource) {
		this.newsSource = newsSource;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getSupport() {
		return newsSupports.size();
	}
	
	public void setSupport(int support) {
	}

	public int getOppose() {
		return newsOpposes.size();
	}

	public void setOppose(int oppose) {
	}

	public int getHits() {
		return hits;
	}

	public void setHits(int hits) {
		this.hits = hits;
	}

	public List<Comments> getComments() {
		return comments;
	}

	public void setComments(List<Comments> comments) {
		this.comments = comments;
	}

	public String getSendType() {
		return sendType;
	}

	public void setSendType(String sendType) {
		this.sendType = sendType;
	}

	public String getHandleResult() {
		return handleResult;
	}

	public void setHandleResult(String handleResult) {
		this.handleResult = handleResult;
	}

	public String getHandleTime() {
		if (handleTime != null) {
			java.text.DateFormat f = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return f.format(handleTime);
		} else
			return null;
	}

	public void setHandleTime(Date handleTime) {
		this.handleTime = handleTime;
	}

	public String getHandleOperator() {
		return handleOperator;
	}

	public void setHandleOperator(String handleOperator) {
		this.handleOperator = handleOperator;
	}

	public String getPrograma() {
		return programa;
	}

	public void setPrograma(String programa) {
		this.programa = programa;
	}

	public List<NewsSupport> getNewsSupports() {
		return newsSupports;
	}

	public void setNewsSupports(List<NewsSupport> newsSupports) {
		this.newsSupports = newsSupports;
	}

	public List<NewsSupport> getNewsOpposes() {
		return newsOpposes;
	}

	public void setNewsOpposes(List<NewsSupport> newsOpposes) {
		this.newsOpposes = newsOpposes;
	}

	public String getTopNumber() {
		return topNumber;
	}

	public void setTopNumber(String topNumber) {
		this.topNumber = topNumber;
	}

}
