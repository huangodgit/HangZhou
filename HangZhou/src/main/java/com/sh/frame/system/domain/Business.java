package com.sh.frame.system.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 业务管理
 *
 */
@Entity
@Table(name = "t_business")
public class Business implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String name;//名字

    private String company;//公司

    private Long tel;//电话

    @OneToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    private SpecialCondition specialCondition;

    @OneToMany(cascade = CascadeType.ALL,mappedBy = "business")
    private Set<Image> images = new HashSet<>();


    @Temporal(TemporalType.TIMESTAMP)
    @Transient
    private Date time;//时间

    @Transient
    private Integer state;//状态

    @Transient
    private String description;//情况描述

    @Transient
    private String founder;//创建人


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

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public Long getTel() {
        return tel;
    }

    public void setTel(Long tel) {
        this.tel = tel;
    }

    public SpecialCondition getSpecialCondition() {
        return specialCondition;
    }

    public void setSpecialCondition(SpecialCondition specialCondition) {
        this.specialCondition = specialCondition;
    }

    public Set<Image> getImages() {
        return images;
    }

    public void setImages(Set<Image> images) {
        this.images = images;
    }

//    public Date getTime() {
//        return time;
//    }

    public String getTime(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        if (time != null && !time.equals("")) {
            return df.format(time);
        }
        return "";
    }

    public void setTime(Date time) {
        this.time = time;
    }

//    public void setTime(String time) {
//        this.time = time;
//    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFounder() {
        return founder;
    }

    public void setFounder(String founder) {
        this.founder = founder;
    }

    @Override
    public String toString() {
        return "Business{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", company='" + company + '\'' +
                ", tel=" + tel +
                ", specialCondition=" + specialCondition +
                ", images=" + images +
                ", time=" + time +
                ", state=" + state +
                ", description='" + description + '\'' +
                ", founder='" + founder + '\'' +
                '}';
    }

}