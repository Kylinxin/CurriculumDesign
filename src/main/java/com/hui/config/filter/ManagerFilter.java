package com.hui.config.filter;

import com.hui.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "managerFilter", urlPatterns = {"/manager/*"})
public class ManagerFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        User user = (User) request.getSession().getAttribute("user");
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        if (user == null) {
            request.setAttribute("msg", "请先登录！");
            response.sendRedirect("/toLogin");
            return;
        }
        if(!"admin".equals(user.getUserId())){
            request.setAttribute("msg", "您没有权限！");
            response.sendRedirect("/toLogin");
            return;
        }
        chain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
}