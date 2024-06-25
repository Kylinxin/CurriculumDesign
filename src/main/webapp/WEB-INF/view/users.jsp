<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>用户管理</title>
    <link href="${path}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${path}/css/font-awesome.min.css" rel="stylesheet">
    <link href="${path}/css/prettyPhoto.css" rel="stylesheet">
    <link href="${path}/css/price-range.css" rel="stylesheet">
    <link href="${path}/css/animate.css" rel="stylesheet">
    <link href="${path}/css/main.css" rel="stylesheet">
    <link href="${path}/css/responsive.css" rel="stylesheet">
    <link rel="shortcut icon" href="images/ico/favicon.ico">
</head>
<body>

<jsp:include page="adminHeader.jsp"></jsp:include>
<section id="cart_items">
    <div class="container">
        <div class="breadcrumbs">
            <h2>用户管理</h2>
        </div>
        <div class="review-payment">
            <h2>用户列表</h2>
        </div>
        <div class="table-responsive cart_info">
            <table class="table table-striped">
                <thead>
                <tr class="cart_menu">
                    <th>登录名</th>
                    <th>用户名</th>
                    <th>电话</th>
                    <th>收货地址</th>
                    <th>邮箱</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.users}" var="user" varStatus="status">
                    <tr>
                        <td>${user.userId}</td>
                        <td>${user.password}</td>
                        <td>${user.phone}</td>
                        <td>${user.address}</td>
                        <td>${user.email}</td>
                        <td><a href="/manager/deleteUser?id=${user.id}">删除</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</section>

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>