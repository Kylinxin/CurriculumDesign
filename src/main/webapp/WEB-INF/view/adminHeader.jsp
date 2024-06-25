<%@ page import="com.hui.entity.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<header id="header">
    <div class="header-middle">
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="logo pull-left">
                        <a href="index.jsp"><img src="${path}/images/home/logo.png" width="280px" height="60px" alt=""/></a>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="shop-menu pull-right">
                        <ul class="nav navbar-nav">
                            <%
                                User user = (User) session.getAttribute("user");
                                if ("admin".equals(user.getUserId())) {
                                    out.println("<li><a></i>欢迎管理员：" + user.getUserName() + "</a></li>");
                                } else {
                                    response.sendRedirect("/toLogin");
                                }
                            %>
                            <li><a href="/logOut">注销</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="header-bottom">
        <div class="container">
            <div class="row">
                <div class="col-sm-9">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse"
                                data-target=".navbar-collapse">
                            <span class="sr-only">header</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <div class="mainmenu pull-left">
                        <ul class="nav navbar-nav collapse navbar-collapse">
                            <li><a href="/index">首页</a></li>
                            <li class="dropdown"><a href="/manager/dishes">菜品管理</a></li>
                            <li><a href="/users">用户管理</a></li>
                            <li><a href="/message">留言板</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
