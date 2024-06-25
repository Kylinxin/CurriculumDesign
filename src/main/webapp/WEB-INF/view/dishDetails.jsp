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
    <title>菜品详情</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
    <link rel="shortcut icon" href="images/ico/favicon.ico">
</head>
<script type="text/javascript">
</script>
<body>
<c:choose>
    <c:when test="${sessionScope.user.userId eq 'admin'}">
        <jsp:include page="adminHeader.jsp"></jsp:include>
    </c:when>
    <c:otherwise>
        <jsp:include page="header.jsp"></jsp:include>
    </c:otherwise>
</c:choose>

<section style="margin-top: 0px; margin-bottom: 50px">
    <div class="product-details"
         style="margin-left: 100px; margin-right: 100px;">
        <div class="col-sm-5">
            <div class="view-product">
                <img src=${requestScope.dish.picSize("400")} alt=""/>
            </div>
            <div id="similar-product" class="carousel slide"
                 data-ride="carousel">
                <a class="left item-control" href="#similar-product"
                   data-slide="prev"> <i class="fa fa-angle-left"></i>
                </a> <a class="right item-control" href="#similar-product"
                        data-slide="next"> <i class="fa fa-angle-right"></i>
            </a>
            </div>
        </div>
        <div class="col-sm-7">
            <div class="product-information">
                <img src="images/product-details/new.jpg" class="newarrival" alt="">
                <h2>${requestScope.dish.dishName}</h2>
                <p>
                    <span style="font-size: 20px"><del>￥${requestScope.dish.getPrice()}</del></span>
                    &nbsp;&nbsp;<span style="color: #FE980F; font-size: 22px">￥${requestScope.dish.getDiscount()}</span>
                </p>
                <form action="/online/addCart" method="POST" name="addCartForm"/>
                <c:if test="${sessionScope.user.userId != 'admin'}">
                    <div class="col-sm-2">
                        <p style="padding-top: 5px; font-size: 16px">数量
                        </p>
                    </div>
                    <p class="col-sm-2" style="margin-left: -40px">
                        <select class="form-control" name="count">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                        </select>
                    </p>
                    <input type="hidden" name="dishId" value=${requestScope.dish.id}>
                    <button type="submit" class="btn btn-default cart">
                        <i class="fa fa-shopping-cart fa-lg">加入购物车</i>&nbsp;&nbsp;&nbsp;
                    </button>
                </c:if>
                </form>
                <p></p>
                <p>
                    <b>描述:</b> ${requestScope.dish.description}
                </p>
            </div>
        </div>
    </div>

</section>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>