package com.sh.frame.system.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sh.frame.base.service.BaseServiceImpl;
import com.sh.frame.system.domain.Dict;
import com.sh.frame.system.domain.DictType;

@Component(value = "dictService")
public class DictService extends BaseServiceImpl<Dict>implements IDictService {

	private static final long serialVersionUID = 1L;

	@Autowired(required = true)
	private IDictTypeService dictTypeService;

	public DictService() {
		super(Dict.class);
	}

	public List<Dict> getListByTypeCode(final String code) {
		DetachedCriteria criterion = DetachedCriteria.forClass(Dict.class);
		criterion.createCriteria("type").add(Restrictions.eq("code", code));
		return this.getLocalDao().findAllByCriteria(criterion);
	}

	@Override
	public List<Dict> getDictList(String dictCodeType) {
		List<Dict> dList = null;
		try {
			DictType dt = null;
			DetachedCriteria dtcriterion = DetachedCriteria.forClass(DictType.class);
			dtcriterion.add(Restrictions.eq("code", dictCodeType)).add(Restrictions.eq("flag", Boolean.TRUE));
			List<DictType> dtList = dictTypeService.findAllByCriteria(dtcriterion);

			if (dtList != null && dtList.size() > 0) {
				dt = dtList.get(0);
			}

			if (dt != null) {
				DetachedCriteria dcriterion = DetachedCriteria.forClass(Dict.class);
				dcriterion.add(Restrictions.eq("dictType.id", dt.getId())).add(Restrictions.eq("flag", Boolean.TRUE))
						.addOrder(Order.asc("seqno"));
				dList = this.getLocalDao().findAllByCriteria(dcriterion);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dList;
	}

	@Override
	public String getDictName(String dictTypeCode, String dictCode) {
		String codeName = " ";
		try {
			List<Dict> dList = null;
			DictType dt = null;
			DetachedCriteria dtcriterion = DetachedCriteria.forClass(DictType.class);
			dtcriterion.add(Restrictions.eq("code", dictTypeCode)).add(Restrictions.eq("flag", Boolean.TRUE));
			List<DictType> dtList = dictTypeService.findAllByCriteria(dtcriterion);

			if (dtList != null && dtList.size() > 0) {
				dt = dtList.get(0);
			}

			if (dt != null) {
				DetachedCriteria dcriterion = DetachedCriteria.forClass(Dict.class);
				dcriterion.add(Restrictions.eq("dictType.id", dt.getId())).add(Restrictions.eq("code", dictCode))
						.add(Restrictions.eq("flag", Boolean.TRUE)).addOrder(Order.asc("seqno"));
				dList = this.getLocalDao().findAllByCriteria(dcriterion);
			}

			if (dList != null && dList.size() > 0) {
				codeName = dList.get(0).getName();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return codeName;
	}

	public Dict findByCode(String code) {
        DetachedCriteria criterion = DetachedCriteria.forClass(Dict.class);
        criterion.add(Restrictions.eq("code", code));
        List<Dict> l = this.getLocalDao().findAllByCriteria(criterion);
        if (l != null & l.size() > 0) {
            return l.get(0);
        }
        return null;
    }
	
}