/**
 * 
 */
package com.sh.frame.system.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

import com.sh.frame.system.domain.OperatingStatistics;
import com.sh.frame.system.domain.User;
import com.sh.frame.base.service.BaseServiceImpl;

@Component(value = "operatingStatisticsService")
public class OperatingStatisticsService extends BaseServiceImpl<OperatingStatistics> implements IOperatingStatisticsService {

	private static final long serialVersionUID = 3500587563897105576L;

	public OperatingStatisticsService() {
		super(OperatingStatistics.class);
	}

	public void recordOperate(String ope, User user) {
		OperatingStatistics os = null;
		DetachedCriteria criterion = DetachedCriteria.forClass(OperatingStatistics.class);
		criterion.add(Restrictions.eq("user", user));
		List<OperatingStatistics> list =  this.getLocalDao().findAllByCriteria(criterion);
		if (list.size()>0) {
			os = list.get(0);
			if (ope.indexOf("list")>-1) {
				os.setListnum(os.getListnum()+1);
			} else if (ope.indexOf("edit")>-1) {
				os.setEditnum(os.getEditnum()+1);
			} else if (ope.indexOf("insert")>-1) {
				os.setInsertnum(os.getInsertnum()+1);
			} else if (ope.indexOf("add")>-1) {
				os.setInsertnum(os.getInsertnum()+1);
			} else if (ope.indexOf("delete")>-1) {
				os.setDeletenum(os.getDeletenum()+1);
			} else if (ope.indexOf("login")>-1) {
				os.setLoginnum(os.getLoginnum()+1);
			} else if (ope.indexOf("export")>-1) {
				os.setExportnum(os.getExportnum()+1);
			} else if (ope.indexOf("download")>-1) {
				os.setExportnum(os.getExportnum()+1);
			} else if (ope.indexOf("import")>-1) {
				os.setImportnum(os.getImportnum()+1);
			}else{
				os.setOthernum(os.getOthernum()+1);
			}
		}else{
			os = new OperatingStatistics(user,0,0,0,0,0,0,0,0);
			if (ope.indexOf("list")>-1) {
				os.setListnum(1);
			} else if (ope.indexOf("edit")>-1) {
				os.setEditnum(1);
			} else if (ope.indexOf("insert")>-1) {
				os.setInsertnum(1);
			} else if (ope.indexOf("add")>-1) {
				os.setInsertnum(1);
			} else if (ope.indexOf("delete")>-1) {
				os.setDeletenum(1);
			} else if (ope.indexOf("login")>-1) {
				os.setLoginnum(1);
			} else if (ope.indexOf("export")>-1) {
				os.setExportnum(1);
			} else if (ope.indexOf("download")>-1) {
				os.setExportnum(1);
			} else if (ope.indexOf("import")>-1) {
				os.setImportnum(1);
			}else{
				os.setOthernum(1);
			}
		}
		this.getLocalDao().saveOrUpdate(os);
	}

}
