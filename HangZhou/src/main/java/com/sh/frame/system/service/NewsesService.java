package com.sh.frame.system.service;

import com.sh.frame.base.service.BaseServiceImpl;
import com.sh.frame.system.domain.Newses;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsesService extends BaseServiceImpl<Newses> implements INewsesService {

    private static final long serialVersionUID = 1L;

    public NewsesService() {
        super(Newses.class);
    }

    @Override
    public List<String> listType() {
        String hql = "SELECT DISTINCT n.type FROM Newses n";
        return getsession().createQuery(hql).list();
    }

    @Override
    public Long getPageViewByDict(String type) {
        String hql = "SELECT SUM(n.pageView) FROM Newses n WHERE n.type = :type";
        return Long.parseLong(getsession().createQuery(hql).setParameter("type",type).uniqueResult().toString());
    }

    @Override
    public Long getTotalPageView() {
        String hql =  "SELECT SUM(n.pageView) FROM Newses n";
        return Long.parseLong(getsession().createQuery(hql).uniqueResult().toString());
    }
}
