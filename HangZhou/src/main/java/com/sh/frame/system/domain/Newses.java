package com.sh.frame.system.domain;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "t_newses")
public class Newses implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column
    private String type;//种类

    @Column
    private String content;//内容

    @Column
    private Integer pageView;//访问量

    @ManyToOne(fetch = FetchType.EAGER)
    private Dict dict;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getPageView() {
        return pageView;
    }

    public void setPageView(Integer pageView) {
        this.pageView = pageView;
    }

    public Dict getDict() {
        return dict;
    }

    public void setDict(Dict dict) {
        this.dict = dict;
    }

    @Override
    public String toString() {
        return "Newses{" +
                "id=" + id +
                ", type='" + type + '\'' +
                ", content='" + content + '\'' +
                ", pageView=" + pageView +
                ", dict=" + dict +
                '}';
    }
}