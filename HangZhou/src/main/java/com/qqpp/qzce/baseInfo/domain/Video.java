package com.qqpp.qzce.baseInfo.domain;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 
 * 视频
 * 
 * @author ZXP
 * 
 */
@Entity
@Table(name = "t_video")
public class Video implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(length = 100)
	private String code;// 编码

	@Column(length = 100)
	private String name;// 名称

	@Column(length = 100)
	private String url;// 访问地址

	@Column(length = 100)
	private String user;// 用户

	@Column(length = 100)
	private String password;// 密码

	private String intro;// 简介

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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
