package com.sh.frame.support;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter;

import com.sh.frame.constant.SystemContant;
import com.sh.frame.system.domain.User;

public class SecurityFilter extends StrutsPrepareAndExecuteFilter {
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException,
			ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(SystemContant.CURRENT_USER);

		String path = request.getServletPath();
		if (path.matches(SystemContant.NOT_RESOURCE_PATH)) {
				chain.doFilter(req, res);
			return;
		} else {
			if (user != null) {
				path = path.length()>1?path.substring(1, path.length()):path;
				boolean b = PermissionVerification.hasPermissiontoResource(user, path);
				if (b) {
					//拥有菜单权限，则放行
					chain.doFilter(req, res);
					return;
				}
				else{
					//登录用户 没有权限-提示
					//TODO 根据不同的请求，返回不同的内容
					String s = request.getHeader("X-Requested-With");
					if(s == null){
						if(path.indexOf("seed") == -1){
							response.sendRedirect("/seed/403.jsp");
						}else{
							response.sendRedirect("/403.jsp");
						}
					}else{
						response.getWriter().print("{\"access\":false}");
					}
					
					
					//返回放入action中实现
					return;
				}
			}
			// 登陆过滤
			response.sendRedirect(request.getContextPath() + SystemContant.GOTOLOGIN);
		}
	}
}
