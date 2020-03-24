package com.sh.frame.support;

import java.util.Set;

import com.sh.frame.system.domain.Module;
import com.sh.frame.system.domain.User;

/**
 * @author yaogjim
 *
 */
public class PermissionVerification {

	/**
	 * 判断用户user是否有访问path的权限
	 * @param user
	 * @param path
	 * @return
	 */
	public static boolean hasPermissiontoResource(User user,String path){
		if(user!=null){
			Set<Module> allResources=user.getAllAvailableModules();
			for(Module resource:allResources){
				//当前菜单是否可用
				
				if(resource.isValiadResource()){
					// 菜单判断
					if("menu".equalsIgnoreCase(resource.getType())){			
						//TODO check menu authorization
						if(path.equals(resource.getResourceUri())){
							return true;
						}
					}
					else{
						//TODO check action authorization
						// 操作判断
						String resourceUri=resource.getResourceUri();
						// 操作不为list操作
						if(resource.getResourceUri()!=null){
							String regResUri=resourceUri.replace("/", "//");
							regResUri=resourceUri.replace("/*", "/.*");
							// 操作如果是查看list操作
							if(path.endsWith("list")){
								// 不适用/*判断,单独使用path全文匹配判断
								if(path.equals(resourceUri) && resource.getAvailable()){
									return true;
								}
							}else{
								if(path.matches(regResUri)){
									return true;
								}	
							}
							
						}
					}
				}
			}
		}
		return false;
	}
	
}
