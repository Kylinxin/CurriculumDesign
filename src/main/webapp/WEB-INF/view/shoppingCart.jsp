<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>购物车</title>
    <link href="${path}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${path}/css/font-awesome.min.css" rel="stylesheet">
    <link href="${path}/css/prettyPhoto.css" rel="stylesheet">
    <link href="${path}/css/price-range.css" rel="stylesheet">
    <link href="${path}/css/animate.css" rel="stylesheet">
    <link href="${path}/css/main.css" rel="stylesheet">
    <link href="${path}/css/responsive.css" rel="stylesheet">
</head>

<body>
<jsp:include page="header.jsp"></jsp:include>


<section id="cart_items" style="margin-bottom: 20px">
    <div class="container">
        <div class="breadcrumbs">
            <h2>购物车</h2>
        </div>
        <div class="review-payment">
            <h2>商品列表</h2>
        </div>
        <div class="table-responsive cart_info">
            <table class="table table-condensed">
                <c:choose>
                    <c:when test="${requestScope.cart == null}">
                        <tr>还没有下过单？<a href="/index">去订餐</a></tr>
                    </c:when>
                    <c:otherwise>
                        <thead>
                        <tr class="cart_menu">
                            <td class="description">菜品信息</td>
                            <td class="price">单价</td>
                            <td class="quantity">数量</td>
                            <td class="total">金额</td>
                            <td>操作</td>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.cart.details}" var="cartDetails" varStatus="status">
                            <tr>
                                <td class="description"><img width="100px" height="100px" src="${cartDetails.dish.imgUrl}" alt=""> ${cartDetails.dish.dishName}</td>
                                <td class="price">¥${cartDetails.dish.discount}</td>
                                <td class="quantity">${cartDetails.count}</td>
                                <td class="total">¥${cartDetails.count * cartDetails.dish.discount}</td>
                                <td><a href="/online/deleteCartDetails?id=${cartDetails.id}">删除</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <div>
                            <tr class="cart_menu">
                                <td class="total">总价:&nbsp; &nbsp;&nbsp;&nbsp;¥${requestScope.cart.total}</td>
                                <td></td>
                                <td><a href="/online/removeCart?id=${requestScope.cart.id}">清空</a></td>
                                <td><a href="/online/createOrder">结算</a></td>
								<td></td>
                            </tr>
                        </div>
                    </c:otherwise>
                </c:choose>
            </table>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>