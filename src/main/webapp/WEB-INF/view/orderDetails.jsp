<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>订单详情</title>
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
<jsp:include page="header.jsp"></jsp:include>

<section id="cart_items">
    <div class="container">
        <div class="breadcrumbs">
            <h2>订单详情</h2>
        </div>
        <div class="review-payment">
            <h2>菜品列表</h2>
        </div>
        <div class="table-responsive cart_info">
            <table class="table table-condensed">
                <thead>
                <tr class="cart_menu">
                    <td class="image" width="15%">菜品图片</td>
                    <td class="description" width="20%">名称</td>
                    <td class="price" width="10%">价格</td>
                    <td class="price" width="10%">折扣价</td>
                    <td class="total" width="10%">数量</td>
                    <td class="price" width="10%">金额</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.details}" var="detail" varStatus="status">
                    <tr>
                        <td><img width="100px" height="100px" src="${detail.dish.imgUrl}" alt=""></td>
                        <td>${detail.dish.dishName}</td>
                        <td>¥${detail.dish.price}</td>
                        <td>¥${detail.dish.discount}</td>
                        <td>${detail.count}</td>
                        <td>¥${detail.total}</td>
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