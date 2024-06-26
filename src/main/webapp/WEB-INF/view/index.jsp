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
    <title>网上订餐</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144"
          href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114"
          href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72"
          href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed"
          href="images/ico/apple-touch-icon-57-precomposed.png">
</head>

<body>
<c:choose>
    <c:when test="${sessionScope.user.userId eq 'admin'}">
        <jsp:include page="adminHeader.jsp"></jsp:include>
    </c:when>
    <c:otherwise>
        <jsp:include page="header.jsp"></jsp:include>
    </c:otherwise>
</c:choose>

<section>
    <div class="container">
        <div class="row">
            <div class="col-sm-12 padding-right">
                <div class="category-tab">
                    <div class="tab-content">
                        <div class="tab-pane fade active in">
                            <c:if test="${requestScope.pageResult.result.size() eq 0}">
                                <div class="tab-pane fade active in" align=center>
                                    <div style = "height:450px; padding-top:50px;">
                                        <span style="font-size:22px;">未找到符合您口味的食物...去尝试搜索其他美味吧！</span><br />
                                        <a href="index">
                                            <img src="images/404/404.jpg" width="400px" height="250px" style = "margin-top:50px;">
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                            <c:forEach items="${requestScope.pageResult.result}" var="dish"
                                       varStatus="status">
                                <div class="col-sm-3">
                                    <div class="product-image-wrapper">
                                        <div class="single-products">
                                            <div class="productinfo text-center">
                                                <a href="dishDetails?id=${dish.getId()}"><img src="${dish.picSize("256")}" alt="">
                                                    <h2>¥${dish.getDiscount()}</h2>
                                                </a>
                                                <a href="dishDetails?id=${dish.getId()}">
                                                    <p>${dish.getDishName()}</p>
                                                </a>
                                                <a href="dishDetails?id=${dish.getId()}"class="btn btn-default add-to-cart">
                                                    <i class="fa fa-eye"></i>详情
                                                </a>
                                                <c:if test="${sessionScope.user.userId != 'admin'}">
                                                    <a href="/online/addCart?count=1&dishId=${dish.getId()}"class="btn btn-default add-to-cart">
                                                        <i class="fa fa-shopping-cart"></i>添加购物车
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <c:if test="${requestScope.pageResult.result.size() != 0}">
                    <div class="col-sm-12">
                        <table>
                            <tr>
                                <ul class="pager" >
                                    <li><a name="btnTopPage" id="btnTopPage" href="index<c:if test="${dishName != null}">?dishName=${dishName}</c:if>">首页</a></li>
                                    <c:choose>
                                        <c:when test="${requestScope.pageResult.pageNo eq 1}"><li class="disabled"></c:when>
                                        <c:otherwise><li></c:otherwise>
                                    </c:choose>
                                    <a name="btnPreviousPage" id="btnPreviousPage"
                                       href="index?pageNo=${requestScope.pageResult.pageNo-1}<c:if test="${dishName != null}">&dishName=${dishName}</c:if>">上一页</a>
                                </li>
                                    <li class="disabled"><a href="#">${requestScope.pageResult.pageNo}
                                        / ${requestScope.pageResult.totalPage}</a></li>
                                    <c:choose>
                                        <c:when test="${requestScope.pageResult.pageNo eq requestScope.pageResult.totalPage}"><li class="disabled"></c:when>
                                        <c:otherwise><li></c:otherwise>
                                    </c:choose>
                                    <a name="btnNextPage" id="btnNextPage"
                                       href="index?pageNo=${requestScope.pageResult.pageNo+1}<c:if test="${dishName != null}">&dishName=${dishName}</c:if>">下一页</a></li>
                                    <li><a name="btnBottomPage" id="btnBottomPage"
                                           href="index?pageNo=${requestScope.pageResult.totalPage}<c:if test="${dishName != null}">&dishName=${dishName}</c:if>">尾页</a></li>
                                </ul>
                            </tr>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>