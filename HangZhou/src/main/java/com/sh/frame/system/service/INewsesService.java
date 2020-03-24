package com.sh.frame.system.service;

import com.sh.frame.base.service.IBaseService;
import com.sh.frame.system.domain.Newses;

import java.util.List;

public interface INewsesService extends IBaseService<Newses> {

    List<String> listType();

    Long getPageViewByDict(String newses);

    Long getTotalPageView();

}
