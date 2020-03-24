package com.sh.frame.base.action;

import java.io.PrintWriter;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.lang.reflect.TypeVariable;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.util.ServletContextAware;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sh.frame.support.PaginationSupport;
import com.sh.frame.system.domain.Dict;
import com.sh.frame.system.domain.User;
import com.sh.frame.system.service.IDictService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import com.opensymphony.xwork2.conversion.annotations.Conversion;
import com.qqpp.qzce.news.domain.DocumentFile;
import com.qqpp.qzce.news.service.IDocumentFileService;

@SuppressWarnings("serial")
@Conversion()
public abstract class BaseAction<T> extends ActionSupport implements
ModelDriven<T>, Preparable, ServletContextAware {

	@Autowired(required = true)
	public IDocumentFileService documentFileService;
	@Autowired(required = true)
	private IDictService dictService;
	
	protected final Log log = LogFactory.getLog(BaseAction.class);

	protected Map<String, Object> msgResult = new LinkedHashMap<String, Object>();

	// Model的ID
	protected Long id;
	// Model的Class
	protected Class<T> entityClass;
	// Model的实体
	protected T entity;
	// 分页的
	protected short[] pageSizeList = { 15, 30, 50, 100 };

	protected final int DEFAULT_PAGESIZE = 15;

	protected int pageNum = 1;

	protected int numPerPage = DEFAULT_PAGESIZE;

	protected PaginationSupport<T> listResult;
	
	public static WebApplicationContext applicationContext;

	protected ServletContext servletContext;
	
	protected Date startModify;

	protected Date endModify;

	// 回调函数
	private String callbackFunc;
	//
	protected String navTabId;

	protected String forwardUrl;

	protected String dialogId;

	protected final String LIST = "list";

	protected final String EDIT = "edit";

	protected final String INSERT = "insert";

	protected final String EDITLOCAL = "editLocal";

	protected final String VIEW = "view";

	protected final String INDEX = "index";

	protected final String CONFIRM = "confirm";

	protected final String DELETE = "delete";

	protected static GsonBuilder builder = new GsonBuilder();
	// 当前的登录用户
	public User loginUser;

	public List<DocumentFile> getDocumentFiles(String entityName,Long id) {
		return documentFileService.getDocumentFiles(entityName, id);
	}
	
	@SuppressWarnings("unchecked")
	public BaseAction() {
		@SuppressWarnings("rawtypes")
		TypeVariable[] typeVariables = getClass().getSuperclass().getTypeParameters();
		if (typeVariables != null && typeVariables.length > 0) {
			try {
				Type[] types = ((ParameterizedType) getClass()
						.getGenericSuperclass()).getActualTypeArguments();
				entityClass = (Class<T>) types[0];
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public T getModel() {
		loginUser = (User) this.getSession().get("LOGINUSER");
		return entity;
	}

	public abstract void prepare() throws Exception;

	public PaginationSupport<T> getListResult() {
		return listResult;
	}

	public void setListResult(PaginationSupport<T> listResult) {
		this.listResult = listResult;
	}

	protected Map<String, Object> getSession() {
		return ActionContext.getContext().getSession();
	}

	public T getEntity() {
		return entity;
	}

	public void setEntity(T entity) {
		this.entity = entity;
	}

	public void responseHtml(String html) {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("Cache-Control", "no-cache");
		response.setContentType("text/html;charset=utf-8 ");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.print(html);
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	public void responseText(String html) {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("Cache-Control", "no-cache");
		response.setContentType("text/plain;charset=utf-8 ");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.print(html);
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	public void responseXml(String xml) {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader("Cache-Control", "no-cache");
		response.setContentType("text/xml;charset=utf-8 ");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.print(xml);
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public short[] getPageSizeList() {
		return pageSizeList;
	}

	public void setPageSizeList(short[] pageSizeList) {
		this.pageSizeList = pageSizeList;
	}

	public void setServletContext(ServletContext sc) {
		this.servletContext = sc;
		if (applicationContext == null)
			applicationContext = WebApplicationContextUtils
			.getWebApplicationContext(servletContext);
	}

	public String getNavTabId() {
		return navTabId;
	}

	public void setNavTabId(String navTabId) {
		this.navTabId = navTabId;
	}

	public String getForwardUrl() {
		return forwardUrl;
	}

	public void setForwardUrl(String forwardUrl) {
		this.forwardUrl = forwardUrl;
	}

	public String getDialogId() {
		return dialogId;
	}

	public void setDialogId(String dialogId) {
		this.dialogId = dialogId;
	}

	public void setCallbackFunc(String callBackFunc) {
		this.callbackFunc = callBackFunc;
	}

	public String getCallbackFunc() {
		return callbackFunc;
	}

	public Integer getNumPerPage() {
		return numPerPage;
	}

	public void setNumPerPage(Integer numPerPage) {
		this.numPerPage = numPerPage;
	}

	public Date getStartModify() {
		return startModify;
	}

	public void setStartModify(Date startModify) {
		this.startModify = startModify;
	}

	public Date getEndModify() {
		return endModify;
	}

	public void setEndModify(Date endModify) {
		this.endModify = endModify;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	// 使用 jquery datatables
	private String aoData;

	private String aoData_echo;

	//fubo 添加,增加排序列,升降序获取
	private Integer aoDataiSortCol;

	private String aoDatasSortDir;
	// end
	/**
	 * @return the aoData_props
	 */
	public ArrayList<String> getAoData_props() {
		return aoData_props;
	}

	/**
	 * @param aoData_props the aoData_props to set
	 */
	public void setAoData_props(ArrayList<String> aoData_props) {
		this.aoData_props = aoData_props;
	}

	/**
	 * @return the aoData_echo
	 */
	public String getAoData_echo() {
		return aoData_echo;
	}

	/**
	 * @param aoData_echo the aoData_echo to set
	 */
	public void setAoData_echo(String aoData_echo) {
		this.aoData_echo = aoData_echo;
	}

	private ArrayList<String> aoData_props=new ArrayList<String>();


	/**
	 * @return the aoData
	 */
	public String getAoData() {
		return aoData;
	}



	public Integer getAoDataiSortCol() {
		return aoDataiSortCol;
	}

	public void setAoDataiSortCol(Integer aoDataiSortCol) {
		this.aoDataiSortCol = aoDataiSortCol;
	}

	public String getAoDatasSortDir() {
		return aoDatasSortDir;
	}

	public void setAoDatasSortDir(String aoDatasSortDir) {
		this.aoDatasSortDir = aoDatasSortDir;
	}
	
	/**
	 * 乡镇村权限控制过滤
	 * @param criteria
	 * @param loginUser
	 * @return
	 */
	public Criteria RightLimit(Criteria criteria,User loginUser,String townFieldName, String villageFieldName) {
		if ("村用户".equals(loginUser.getRolename())) {
			criteria.add(Restrictions.eq(villageFieldName, loginUser.getName()));
		}
		if ("乡镇用户".equals(loginUser.getRolename())) {
			criteria.add(Restrictions.eq(townFieldName, loginUser.getName()));
		}
		return criteria;
	}
	
	/**
	 * 根据'字典代码'获取'代码名称'
	 * @param dictCodeType 字典代码类型
	 * @param dictCode  字典代码
	 * @return 代码名称
	 */
	public String getDictName(String dictCodeType, String dictCode){
		return dictService.getDictName(dictCodeType,dictCode);
	}

	/**
	 * 根据'字典类型代码'获取'代码列表'
	 * @param dictCodeType 代码类型
	 * @param dictCode  代码
	 * @return 代码LIST
	 */
	public List<Dict> getDictList(String dictCodeType){
		return dictService.getDictList(dictCodeType);
	}
	/**
	 * @param aoData
	 *            the aoData to set
	 */
	public void setAoData(String aoData) {
		if (aoData != null) {
			Gson gson = new Gson();
			aoData_props.clear();
			try {
				Integer start = 0;
				Integer pl = 0;
				NameValue[] nvs = gson.fromJson(aoData, NameValue[].class);
				for (NameValue nv : nvs) {
					if (nv.name.equalsIgnoreCase("iDisplayStart")) {
						if (nv.value != null && nv.value.trim().length() > 0) {
							start = Integer.parseInt(nv.value);
						} else {
							start = -1;
						}
					} else if (nv.name.equalsIgnoreCase("iDisplayLength")) {
						if (nv.value != null && nv.value.trim().length() > 0) {
							pl = Integer.parseInt(nv.value);
						} else {
							pl = -1;
						}
					} else if (nv.name.equalsIgnoreCase("sEcho")) {
						if (nv.value != null && nv.value.trim().length() > 0) {
							aoData_echo = nv.value;
						}else{
							aoData_echo="1";
						}
					} else if (nv.name.startsWith("mDataProp_")) {
						if (nv.value != null && nv.value.trim().length() > 0) {
							aoData_props.add(nv.value);
						}
					}
					// fubo 新增:增加排序字段获取和升降序获取
					else if(nv.name.startsWith("iSortCol_")){
						if (nv.value != null && nv.value.trim().length() > 0) {
							try{
								aoDataiSortCol = Integer.parseInt(nv.value);
							}catch(Exception e){
								aoDataiSortCol = null;
							}
						}
					}else if(nv.name.startsWith("sSortDir_")){
						if (nv.value != null && nv.value.trim().length() > 0) {
							aoDatasSortDir = nv.value;
						}
					}
					// end
					else {
						continue;
					}
				}
				if (start != -1) {
					pageNum = start / pl+1;
					numPerPage = pl;
				} else {
					pageNum=1;
					start = 1;
					numPerPage = DEFAULT_PAGESIZE;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return;
			}
		}
		this.aoData = aoData;
	}
}

class NameValue {
	public String name = "";
	public String value = "";
}