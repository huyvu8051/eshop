package com.eshop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.eshop.entity.Customer;
import com.eshop.service.HttpService;

@Component
public class AuthInterceptor implements HandlerInterceptor {
	@Autowired
	HttpService httpService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String url = request.getRequestURI();
		Customer user = httpService.getSession("user");
		if(user == null) {
			httpService.setSession("security-uri", url);
			response.sendRedirect("/account/login?message=Unauthorized!");
			return false;
		}
		return true;
	}
}
