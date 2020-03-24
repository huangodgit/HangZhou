/**
 * 
 */
package com.sh.frame.system.domain;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "SYSTEM_OPERATINGSTATISTICS")
public class OperatingStatistics implements Serializable {

	private static final long serialVersionUID = 2031273398540897686L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@OneToOne()
	@JoinColumn(name = "USERID")
	private User user;

	private Integer listnum;
	private Integer editnum;
	private Integer insertnum;
	private Integer deletenum;
	private Integer loginnum;
	private Integer importnum;
	private Integer exportnum;
	private Integer othernum;

	public OperatingStatistics() {
		super();
	}

	public OperatingStatistics(User user, Integer listnum, Integer editnum, Integer insertnum, Integer deletenum,
			Integer loginnum, Integer importnum, Integer exportnum, Integer othernum) {
		super();
		this.user = user;
		this.listnum = listnum;
		this.editnum = editnum;
		this.insertnum = insertnum;
		this.deletenum = deletenum;
		this.loginnum = loginnum;
		this.importnum = importnum;
		this.exportnum = exportnum;
		this.othernum = othernum;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Integer getListnum() {
		return listnum;
	}

	public void setListnum(Integer listnum) {
		this.listnum = listnum;
	}

	public Integer getEditnum() {
		return editnum;
	}

	public void setEditnum(Integer editnum) {
		this.editnum = editnum;
	}

	public Integer getInsertnum() {
		return insertnum;
	}

	public void setInsertnum(Integer insertnum) {
		this.insertnum = insertnum;
	}

	public Integer getDeletenum() {
		return deletenum;
	}

	public void setDeletenum(Integer deletenum) {
		this.deletenum = deletenum;
	}

	public Integer getLoginnum() {
		return loginnum;
	}

	public void setLoginnum(Integer loginnum) {
		this.loginnum = loginnum;
	}

	public Integer getImportnum() {
		return importnum;
	}

	public void setImportnum(Integer importnum) {
		this.importnum = importnum;
	}

	public Integer getExportnum() {
		return exportnum;
	}

	public void setExportnum(Integer exportnum) {
		this.exportnum = exportnum;
	}

	public Integer getOthernum() {
		return othernum;
	}

	public void setOthernum(Integer othernum) {
		this.othernum = othernum;
	}

}
