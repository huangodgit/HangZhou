package com.qqpp.qzce.baseInfo.service;

import com.sh.frame.base.service.BaseServiceImpl;
import com.qqpp.qzce.baseInfo.domain.UserType;
import com.qqpp.qzce.util.ExcelUtil;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import javax.servlet.ServletOutputStream;
import java.util.List;

@Component(value = "userTypeService")
public class UserTypeService extends BaseServiceImpl<UserType>implements IUserTypeService {

	private static final long serialVersionUID = 1L;

	public UserTypeService() {
		super(UserType.class);
	}

	public List<UserType> findAllValid() {
		DetachedCriteria dc = DetachedCriteria.forClass(UserType.class);
		return this.getLocalDao().findAllByCriteria(dc);
	}

	public UserType findByCode(String code) {
		DetachedCriteria criterion = DetachedCriteria.forClass(UserType.class);
		criterion.add(Restrictions.eq("code", code));
		List<UserType> l = this.getLocalDao().findAllByCriteria(criterion);
		if (l != null & l.size() > 0) {
			return l.get(0);
		}
		return null;
	}

	public void exportExcel(List<UserType> userTypeList, ServletOutputStream outputStream) {
		ExcelUtil.exportUserExcel(userTypeList, outputStream);
	}


}