/**
 * 
 */
package com.sh.frame.system.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;


@Entity
@Table(name = "system_log")
public class Log implements Serializable {

	private static final long serialVersionUID = 2031273398540897686L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	// 用户名
	@Column(name = "NAME", length = 50)
	private String name;

	// action名称
	@Column(name = "ACTION", length = 50)
	private String action;

	// 方法名称
	@Column(name = "METHOD", length = 50)
	private String method;

	// 用户
	@OneToOne()
	@JoinColumn(name = "USERID")
	private User user;

	// ip地址
	@Column(name = "IP", length = 32)
	private String ip;

	// 时间
	@Column(name = "VISTDATE")
	private Date vistdate;

	// 错误信息
	@Column(name = "ERRORMSG", length = 256)
	private String errormsg;

	@Transient
	private Date beginDate;
	@Transient
	private Date endDate;

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Log setVName(String name) {
		this.name = name;
		return this;
	}

	public Log setVAction(String action) {
		this.action = action;
		return this;
	}

	public Log setVMethod(String method) {
		this.method = method;
		return this;
	}

	public Log setVUser(User user) {
		this.user = user;
		return this;
	}

	public Log setVVistdate(Date vistdate) {
		this.vistdate = vistdate;
		return this;
	}

	public Log setVErrormsg(String errormsg) {
		this.errormsg = errormsg;
		return this;
	}

	public Log setVIp(String ip) {
		this.ip = ip;
		return this;
	}

	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the action
	 */
	public String getAction() {
		return action;
	}

	/**
	 * @param action
	 *            the action to set
	 */
	public void setAction(String action) {
		this.action = action;
	}

	/**
	 * @return the method
	 */
	public String getMethod() {
		return method;
	}

	/**
	 * @param method
	 *            the method to set
	 */
	public void setMethod(String method) {
		this.method = method;
	}

	/**
	 * @return the user
	 */
	public User getUser() {
		return user;
	}

	/**
	 * @param user
	 *            the user to set
	 */
	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * @return the ip
	 */
	public String getIp() {
		return ip;
	}

	/**
	 * @param ip
	 *            the ip to set
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}

	/**
	 * @return the vistdate
	 */
	public Date getVistdate() {
		return vistdate;
	}

	/**
	 * @param vistdate
	 *            the vistdate to set
	 */
	public void setVistdate(Date vistdate) {
		this.vistdate = vistdate;
	}

	/**
	 * @return the errormsg
	 */
	public String getErrormsg() {
		return errormsg;
	}

	/**
	 * @param errormsg
	 *            the errormsg to set
	 */
	public void setErrormsg(String errormsg) {
		this.errormsg = errormsg;
	}

}
