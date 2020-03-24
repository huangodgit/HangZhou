package com.qqpp.qzce.baseInfo.web;

import com.google.gson.Gson;
import com.sh.frame.base.action.BaseAction;
import com.sh.frame.support.CustomExample;
import com.sh.frame.support.PaginationSupport;
import com.qqpp.qzce.baseInfo.domain.UserType;
import com.qqpp.qzce.baseInfo.service.IUserTypeService;
import com.sh.frame.utils.JQueryDataTablesUtil;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;


public class UserTypeManageAction extends BaseAction<UserType> {
    private static final long serialVersionUID = 6950808042088342028L;

    @Autowired(required = true)
    private IUserTypeService userTypeService;

    private String validateCode;
    private Long validateId;

    private DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSSS");

    public DateFormat getDateFormat() {
        return dateFormat;
    }

    public void setDateFormat(DateFormat dateFormat) {
        this.dateFormat = dateFormat;
    }

    //excel
    private File excel;
    private String userExcelContentType;
    private String userExcelFileName;
    private List<UserType> userTypeList;

    public String excel() {
        return "excel";
    }


    public List<UserType> getUserTypeList() {
        return userTypeList;
    }

    public void setUserTypeList(List<UserType> userTypeList) {
        this.userTypeList = userTypeList;
    }

    public File getExcel() {
        return excel;
    }

    public void setExcel(File excel) {
        this.excel = excel;
    }

    public String getUserExcelContentType() {
        return userExcelContentType;
    }

    public void setUserExcelContentType(String userExcelContentType) {
        this.userExcelContentType = userExcelContentType;
    }

    public String getUserExcelFileName() {
        return userExcelFileName;
    }

    public void setUserExcelFileName(String userExcelFileName) {
        this.userExcelFileName = userExcelFileName;
    }


    public void prepare() throws Exception {
        if (id != null) {
            entity = userTypeService.findById(id);
        } else
            entity = new UserType();
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
            entity.setFlag(true);
            entity.setSeqno(0);
            userTypeService.saveOrUpdate(entity);
            userTypeService.flush();
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
            userTypeService.delete(entity);
            userTypeService.flush();
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
        CustomExample<UserType> example = new CustomExample<UserType>(this.getModel()) {
            private static final long serialVersionUID = 1L;

            public void appendCondition(Criteria criteria) {

                criteria.addOrder(Order.desc("id")).addOrder(Order.asc("seqno"));
            }
        };
        example.enableLike(MatchMode.ANYWHERE);
        this.listResult = userTypeService.findPageByExample(example, PaginationSupport.pageToIndex(pageNum, numPerPage),
                numPerPage);
        responseText(JQueryDataTablesUtil.prepareResponseJsonData(this.getAoData_echo(), this.getAoData_props(),
                listResult));
    }

    public String listForSelect() {
        CustomExample<UserType> example = new CustomExample<UserType>(this.getModel()) {
            private static final long serialVersionUID = 1L;

            public void appendCondition(Criteria criteria) {

            }
        };
        example.enableLike(MatchMode.ANYWHERE);
        this.listResult = userTypeService.findPageByExample(example, PaginationSupport.pageToIndex(pageNum, numPerPage),
                numPerPage);

        return "listForSelect";
    }

    public void validateCode() {
        DetachedCriteria criterion = DetachedCriteria.forClass(UserType.class);
        criterion.add(Restrictions.eq("code", validateCode));
        List<UserType> l = userTypeService.findAllByCriteria(criterion);
        if (validateId != null) {
            UserType d = userTypeService.findById(validateId);
            l.remove(d);
        }
        responseHtml(JQueryDataTablesUtil.beanToJson(l));
    }

    public String getValidateCode() {
        return validateCode;
    }

    public void setValidateCode(String validateCode) {
        this.validateCode = validateCode;
    }

    public Long getValidateId() {
        return validateId;
    }

    public void setValidateId(Long validateId) {
        this.validateId = validateId;
    }

    //导出用户列表
    public void exportExcel() {
        String sid = ServletActionContext.getRequest().getSession().getId();
        try {
            //1、查找用户列表
            userTypeList = userTypeService.findAll();
            //2、导出
            HttpServletResponse response = ServletActionContext.getResponse();
            //告诉浏览器导出为excel文件类型
            response.setContentType("application/x-excel");
            //设置以浏览器打开方式并且设置文件名以及编码
            String fileName = "exit_excel" + dateFormat.format(new Date()) + (new Random().nextInt(10000)) + ".xls";
            response.setHeader("Content-Disposition", "attachment;filename=" + new String(fileName.getBytes(), "ISO-8859-1"));
            //获取输出流
            ServletOutputStream outputStream = response.getOutputStream();
            //调用导出方法
            userTypeService.exportExcel(userTypeList, outputStream);
            if (outputStream != null) {
                outputStream.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void importExcel() throws IOException, InvalidFormatException {
        XSSFWorkbook workBook = new XSSFWorkbook(excel);
        XSSFSheet sheet = workBook.getSheetAt(0);
        HashMap<String, Integer> nameMap = new HashMap<>();
        if (sheet.getPhysicalNumberOfRows() > 2) {
            UserType userType = null;
            for (int k = 2; k < sheet.getPhysicalNumberOfRows(); k++) {
                //4、读取单元格
                Row row = sheet.getRow(k);
                userType = new UserType();
//                userType.setId(Long.parseLong(row.getCell(0).toString()));
//                System.out.println("0");
                userType.setCode(row.getCell(1).toString());
                userType.setName(row.getCell(2).toString());
                userType.setRemark(row.getCell(3).toString());
                //5、保存
                userTypeService.saveOrUpdate(userType);
            }
            msgResult.put("status", true);
            msgResult.put("info", "导入成功");
        } else {
            msgResult.put("status", false);
            msgResult.put("info", "详情格式不匹配");
        }
        Gson gson = builder.create();
        responseText(gson.toJson(msgResult));
    }

}
