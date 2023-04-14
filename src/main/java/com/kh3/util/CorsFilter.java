package com.kh3.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class CorsFilter implements Filter{

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletResponse response2 = (HttpServletResponse) response;
		response2.setHeader("Access-Control-Allow-Origin", "*");
		response2.setHeader("Access-Control-Allow-Methods", "POST, GET, DELETE, PUT");
		response2.setHeader("Access-Control-Max-Age", "86400");
		response2.setHeader("Access-Control-Allow-Headers", "x-requested-with,origin,content-type,accept");
		
		chain.doFilter(request, response2);
	}

	@Override
	public void destroy() {}
}
