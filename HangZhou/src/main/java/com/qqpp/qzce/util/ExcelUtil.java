package com.qqpp.qzce.util;

import java.util.List;

import javax.servlet.ServletOutputStream;

import com.qqpp.qzce.baseInfo.domain.UserType;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;


public class ExcelUtil {

    /**
     * 导出用户的所有列表到excel
     *
     * @param userTypeList 用户列表
     * @param outputStream 输出流
     */
    public static void exportUserExcel(List<UserType> userTypeList, ServletOutputStream outputStream) {
        try {
            //1、创建工作簿
            HSSFWorkbook workbook = new HSSFWorkbook();
            //1.1、创建合并单元格对象
            CellRangeAddress cellRangeAddress = new CellRangeAddress(0, 0, 0, 3);//起始行号，结束行号，起始列号，结束列号

            //1.2、头标题样式
            HSSFCellStyle style1 = createCellStyle(workbook, (short) 16);

            //1.3、列标题样式
            HSSFCellStyle style2 = createCellStyle(workbook, (short) 13);

            //2、创建工作表
            HSSFSheet sheet = workbook.createSheet("用户类型列表");
            //2.1、加载合并单元格对象
            sheet.addMergedRegion(cellRangeAddress);
            //设置默认列宽
            sheet.setDefaultColumnWidth(25);

            //3、创建行
            //3.1、创建头标题行；并且设置头标题
            HSSFRow row1 = sheet.createRow(0);
            HSSFCell cell1 = row1.createCell(0);
            //加载单元格样式
            cell1.setCellStyle(style1);
            cell1.setCellValue("用户类型列表");

            //3.2、创建列标题行；并且设置列标题
            HSSFRow row2 = sheet.createRow(1);
            String[] titles = {"id", "code", "name", "remark"};
            for (int i = 0; i < titles.length; i++) {
                HSSFCell cell2 = row2.createCell(i);
                //加载单元格样式
                cell2.setCellStyle(style2);
                cell2.setCellValue(titles[i]);
            }

            //4、操作单元格；将用户列表写入excel
            if (userTypeList != null) {
                for (int j = 0; j < userTypeList.size(); j++) {
                    HSSFRow row = sheet.createRow(j + 2);//因为前面已经2行了所以要+2
                    HSSFCell cell11 = row.createCell(0);
                    cell11.setCellValue(userTypeList.get(j).getId().toString());
                    HSSFCell cell12 = row.createCell(1);
                    cell12.setCellValue(userTypeList.get(j).getCode());
                    HSSFCell cell13 = row.createCell(2);
                    cell13.setCellValue(userTypeList.get(j).getName());
                    HSSFCell cell14 = row.createCell(3);
                    cell14.setCellValue(userTypeList.get(j).getRemark());
                }
            }
            //5、输出
            workbook.write(outputStream);
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建单元格样式
     *
     * @param workbook 工作簿
     * @param fontSize 字体大小
     * @return 单元格样式
     */
    private static HSSFCellStyle createCellStyle(HSSFWorkbook workbook, short fontSize) {
        HSSFCellStyle style = workbook.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        //加载字体
        return style;
    }

}