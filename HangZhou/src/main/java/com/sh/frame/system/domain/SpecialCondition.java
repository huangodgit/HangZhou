package com.sh.frame.system.domain;

import com.fasterxml.jackson.annotation.JsonBackReference;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 特殊情况
 */
@Entity
@Table(name = "t_sc")
public class SpecialCondition {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Temporal(TemporalType.TIMESTAMP)
    private Date time;//时间

    @Column
    private Integer state;//状态

    @Column
    private String description;//情况描述

    @Column
    private String founder;//创建人

    @OneToOne(mappedBy = "specialCondition", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Business business;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

//    public Date getTime() {
//        return time;
//    }
    public String getTime() {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        if (time != null && !time.equals("")) {
            return df.format(time);
        }
        return "";
    }

    public void setTime(Date time) {
        this.time = time;
    }

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

    public Business getBusiness() {
        return business;
    }

    @JsonBackReference
    public void setBusiness(Business business) {
        this.business = business;
    }
}