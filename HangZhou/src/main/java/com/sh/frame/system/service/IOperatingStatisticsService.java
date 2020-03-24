/**
 * 
 */
package com.sh.frame.system.service;

import com.sh.frame.system.domain.OperatingStatistics;
import com.sh.frame.system.domain.User;
import com.sh.frame.base.service.IBaseService;

/**
 */
public interface IOperatingStatisticsService extends IBaseService<OperatingStatistics> {

	void recordOperate(String string, User loginUser);

}
