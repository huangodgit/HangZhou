package com.sh.frame.system.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;


@Entity
@Table(name = "system_dict")
public class Dict implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@ManyToOne(fetch = FetchType.EAGER, cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	private DictType dictType;

	@Column(length = 100)
	private String code;// 属性代码

	@Column(length = 100)
	private String name;// 属性名称

	@Column
	private int seqno;// 排序位

	@Column
	private Boolean flag;// 状态

	@Column(length = 200)
	private String remark;// 备注

	@OneToMany(cascade = CascadeType.ALL,mappedBy = "dict")
	@JsonIgnore
	private Set<Newses> news = new HashSet<>();

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	public DictType getDictType() {
		return dictType;
	}

	public void setDictType(DictType dictType) {
		this.dictType = dictType;
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

	public Set<Newses> getNews() {
		return news;
	}

	public void setNews(Set<Newses> news) {
		this.news = news;
	}
}
