/**
 * 
 */
package com.sh.frame.system.service;

import java.util.Date;

import com.sh.frame.system.domain.Log;
import com.sh.frame.system.domain.User;
import com.sh.frame.base.service.IBaseService;

/**
 * @packageName com.jc.system.service
 * @className ILogService.java
 * @author WangChen 
 * @date Jul 14, 2012
 * @instruction 
 */
public interface ILogService extends IBaseService<Log> {

	public Date getMaxDateByUser(User u);
}
