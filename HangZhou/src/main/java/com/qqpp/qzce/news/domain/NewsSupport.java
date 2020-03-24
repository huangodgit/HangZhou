package com.qqpp.qzce.news.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * @author zxp 村民自治-触摸屏-文章赞、踩情况
 */

@Entity
@Table(name = "t_newssupport")
public class NewsSupport implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@JsonIgnore
	@ManyToOne
	private News news;

	private String type;// 赞--support 踩--oppose

	private String operater;// 评论人

	private String identify;// 身份证号

	private Date operateTime;// 评论时间

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public News getNews() {
		return news;
	}

	public void setNews(News news) {
		this.news = news;
	}

	public String getOperater() {
		return operater;
	}

	public void setOperater(String operater) {
		this.operater = operater;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getIdentify() {
		return identify;
	}

	public void setIdentify(String identify) {
		this.identify = identify;
	}

}
