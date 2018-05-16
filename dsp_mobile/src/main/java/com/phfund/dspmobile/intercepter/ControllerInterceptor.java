package com.phfund.dspmobile.intercepter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.phfund.dspmobile.util.GeneralUtils;

/**
 * 添加controller层拦截器
 * 
 * 
 * 
 */
public class ControllerInterceptor implements HandlerInterceptor {

	private String logId;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		String uri = request.getRequestURI();
		boolean isPermitted = false;
		String reg = ".*/mobile/.*.do";
		if(uri.matches(reg)){
		if (GeneralUtils.isIpPass(GeneralUtils.getIpAddress(request))) {
			System.out.println("请求信息："+request.getRequestURI());
			System.out.println("请求IP："+GeneralUtils.getIpAddress(request));
			return true;
		}else
		   {		return false;
		
		}
	}
		isPermitted = true;
		return isPermitted;
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
