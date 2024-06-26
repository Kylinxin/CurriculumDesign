<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="com.hui.entity.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<header id="header">
    <div class="header-middle">
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="logo pull-left">
                        <a href="/index"><img src="${path}/images/home/logo.png" width="280px" height="60px" alt=""/></a>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="shop-menu pull-right">
                        <ul class="nav navbar-nav">
                            <li><a href="/online/cart">我的购物车
                                <c:if test="${requestScope.total != null}">
                                    <span style="font-weight:bolder; font-size:18px; color:red ">¥ ${requestScope.total}</span>
                                </c:if></a></li>
                            <%
                                User user = (User) session.getAttribute("user");
                                if (user == null) {
                                    out.println("<li><a href=\"/toLogin\">登录或注册</a></li>");
                                } else {
                                    out.println("<li><a></i>欢迎：" + user.getUserName() + "</a></li>");
                                    out.println("<li><a href=\"/logOut\"></i>注销</a></li>");
                                }
                            %>
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
                            <span class="icon-bar"></span> <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <div class="mainmenu pull-left">
                        <ul class="nav navbar-nav collapse navbar-collapse">
                            <li><a href="/index">首页</a></li>
                            <li><a href="/online/order">我的订单</a></li>
                            <li><a href="/online/user">修改信息</a></li>
                            <li><a href="/message">留言板</a></li>
                            <li class="dropdown"><a href="/about">关于我们</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="search_box pull-right">
                        <form action="/index" method="post">
							<c:if test="${dishName != null}">
								<input type="text" name="dishName" value="${dishName}">&nbsp;
							</c:if>
							<c:if test="${dishName == null}">
								<input type="text" placeholder="吃点啥？" name="dishName">&nbsp;
							</c:if>
                            <button class="btn btn-default get" style="margin-top: 0px" id="search">
                                <i class="fa fa-search">搜索</i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
</body>
</html>