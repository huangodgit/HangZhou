package com.qqpp.qzce.baseInfo.web;

import com.google.gson.Gson;
import com.qqpp.qzce.baseInfo.domain.Video;
import com.qqpp.qzce.baseInfo.service.IVideoService;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.utils.JQueryDataTablesUtil;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;

public class VideoManageAction extends BaseAction<Video> {
	private static final long serialVersionUID = 6950808042088342028L;

	@Autowired(required = true)
	private IVideoService videoService;

	@Override
	public void prepare() throws Exception {
		if (id != null) {
			entity = videoService.findById(id);
		} else {
			entity = new Video();
		}
	}

	public String insert() {
		return INSERT;
	}

	public String edit() {
		return EDIT;
	}

	public String view() {
		return VIEW;
	}

	public void save() {
		try {
			videoService.saveOrUpdate(entity);
			videoService.flush();
			msgResult.put("status", true);
			msgResult.put("info", "保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			msgResult.put("status", false);
			msgResult.put("info", "保存失败");
		}
		Gson gson = builder.create();
		responseHtml(gson.toJson(msgResult));
	}

	public String list() {
		return LIST;
	}

	public void delete() {
		try {
			videoService.delete(entity);
			videoService.flush();
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

	public void listAllForJQueryDataTable() {
		CustomExample<Video> example = new CustomExample<Video>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {
				criteria.addOrder(Order.desc("id"));
			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = videoService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		responseText(JQueryDataTablesUtil.prepareResponseJson(this.getAoData_echo(), this.getAoData_props(), listResult));
	}

	public String listForSelect() {
		CustomExample<Video> example = new CustomExample<Video>(this.getModel()) {
			private static final long serialVersionUID = 1L;

			public void appendCondition(Criteria criteria) {

			}
		};
		example.enableLike(MatchMode.ANYWHERE);
		this.listResult = videoService.findPageByExample(example,
				PaginationSupport.pageToIndex(pageNum, numPerPage), numPerPage);
		return "listForSelect";
	}

}
