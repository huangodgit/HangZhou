package com.qqpp.qzce.baseInfo.service;

import com.sh.frame.base.service.IBaseService;
import com.qqpp.qzce.baseInfo.domain.UserType;

import javax.servlet.ServletOutputStream;
import java.util.List;

public interface IUserTypeService extends IBaseService<UserType> {

	public List<UserType> findAllValid();

	public UserType findByCode(String code);

	public void exportExcel(List<UserType> userTypeList, ServletOutputStream outputStream);

//	public void importExcel(File userExcel, String userExcelFileName);

}
