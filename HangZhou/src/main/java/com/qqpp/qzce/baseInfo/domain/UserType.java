package com.qqpp.qzce.baseInfo.domain;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 字段类型
 * 
 * @author ZXP
 *
 */

@Entity
@Table(name = "system_usertype")
public class UserType implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(length = 100)
	private String name;

	@Column(length = 100)
	private String code;

	@Column
	private int seqno;// 排序位

	@Column
	private Boolean flag;// 状态

	@Column(length = 200)
	private String remark;// 备注

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

	public int getSeqno() {
		return seqno;
	}

	public void setSeqno(int seqno) {
		this.seqno = seqno;
	}

	public Boolean getFlag() {
		return flag;
	}

	public void setFlag(Boolean flag) {
		this.flag = flag;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
