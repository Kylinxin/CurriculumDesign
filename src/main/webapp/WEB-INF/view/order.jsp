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
    <title>订单信息</title>
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


<section id="cart_items" style="margin-bottom: 20px">
    <div class="container">
        <div class="breadcrumbs">
            <h2>订单信息</h2>
        </div>
        <div class="review-payment">
            <h2>商品列表</h2>
        </div>
        <div class="table-responsive cart_info">
            <table class="table table-condensed">
                <c:choose>
                    <c:when test="${requestScope.orders == null}">
                        <tr>还没有下过单？<a href="/index">去订餐</a></tr>
                    </c:when>
                    <c:otherwise>
                        <thead align="center">
                        <tr class="cart_menu">
                            <td>订单号</td>
                            <td>金额</td>
                            <td>电话</td>
                            <td>收货地址</td>
                            <td>状态</td>
                            <td>操作</td>
                        </tr>
                        </thead>
                        <tbody align="center">
						<c:forEach items="${requestScope.orders}" var="order" varStatus="status">
							<tr>
								<td><a href="/online/orderDetails?id=${order.id}">${order.id}</a></td>
								<td>¥${order.total}</td>
								<td>${order.phone}</td>
								<td>${order.address}</td>
								<c:if test="${order.status eq 0}"><td>关闭</td></c:if>
								<c:if test="${order.status eq 1}"><td>配送中</td></c:if>
								<c:if test="${order.status eq 2}"><td>完成</td></c:if>
								<td>
									<c:if test="${order.status eq 1}">
										<a href="/online/confirmOrder?id=${order.id}">确认收货</a>
									</c:if>
                                    <a style="margin-left:20px;color:red" href="/online/deleteOrder?id=${order.id}">删除</a>
								</td>
							</tr>
						</c:forEach>
                        </tbody>
                    </c:otherwise>
                </c:choose>
            </table>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>