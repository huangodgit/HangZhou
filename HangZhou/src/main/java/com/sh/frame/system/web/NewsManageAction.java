package com.sh.frame.system.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.gson.Gson;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.system.domain.Dict;
import com.sh.frame.system.domain.Newses;
import com.sh.frame.system.service.INewsesService;
import com.sh.frame.utils.JQueryDataTablesUtil;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

public class NewsManageAction extends BaseAction<Newses> {
    private static final long serialVersionUID = 6950808042088342028L;

    @Autowired
    private INewsesService newsesService;

    private Dict dict;

    @Override
    public void prepare() throws Exception {
        if (id != null) {
            entity = newsesService.findById(id);
        } else
            entity = new Newses();
    }

    public String list() {
        return LIST;
    }

    public String eCharts() {
        return "eCharts";
    }

    public String insert() {
        return INSERT;
    }

    public String edit() {
        return EDIT;
    }

    public String view() {
        entity.setPageView(entity.getPageView()+1);
        newsesService.saveOrUpdate(entity);
        newsesService.flush();
        return VIEW;
    }

    public void delete() {
        try {
            newsesService.delete(entity);
            newsesService.flush();
            msgResult.put("status", true);
            msgResult.put("info", "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            msgResult.put("status", false);
            msgResult.put("info", "删除失败");
        }
        Gson gson = builder.create();
        responseHtml(gson.toJson(msgResult));
    }

    public void save(){
        try{
            entity.setPageView(0);//访问量初始化
            newsesService.saveOrUpdate(entity);
            newsesService.flush();
            msgResult.put("status", true);
            msgResult.put("info", "保存成功");
        }catch (Exception e){
            e.printStackTrace();
            msgResult.put("status", false);
            msgResult.put("info", "保存失败");
        }
        Gson gson = builder.create();
        responseHtml(gson.toJson(msgResult));
    }

    public void listAllForJQueryDataTable() {
        CustomExample<Newses> example = new CustomExample<Newses>(this.getModel()) {
            public void appendCondition(Criteria criteria) {
                criteria.addOrder(Order.asc("id"));
            }
        };
        example.enableLike(MatchMode.ANYWHERE);
        this.listResult = newsesService.findPageByExample(example, PaginationSupport.pageToIndex(pageNum, numPerPage),
                numPerPage);
        responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(),
                listResult));
    }

    public void listPageView() throws JsonProcessingException {
        List<String> typeList = newsesService.listType();
        List<Long> PageViewsList = new ArrayList<>();
        for(String newsesType : typeList){
            PageViewsList.add(newsesService.getPageViewByDict(newsesType));
        }
        msgResult.put("totalPageViews",newsesService.getTotalPageView());
        msgResult.put("typeList",typeList);
        msgResult.put("PageViewsList",PageViewsList);
        String json = JQueryDataTablesUtil.getMapperInstance().writeValueAsString(msgResult);
        responseText(json);
    }
    public Dict getDict() {
        return dict;
    }

    public void setDict(Dict dict) {
        this.dict = dict;
    }
}
