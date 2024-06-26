<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>添加菜品</title>
    <link href="${path}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${path}/css/font-awesome.min.css" rel="stylesheet">
    <link href="${path}/css/prettyPhoto.css" rel="stylesheet">
    <link href="${path}/css/price-range.css" rel="stylesheet">
    <link href="${path}/css/animate.css" rel="stylesheet">
    <link href="${path}/css/main.css" rel="stylesheet">
    <link href="${path}/css/responsive.css" rel="stylesheet">
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <script>function checkDishInfo() {
        if (document.addDishForm.dishName.value == "") {
            alert("菜品名称不能为空");
            return false;
        }
        if (document.addDishForm.dishName.price == "") {
            alert("价格不能为空");
            return false;
        }
        if (document.addDishForm.dishName.discount == "") {
            alert("折扣不能为空");
            return false;
        }
        if (document.addDishForm.dishName.imgUrl == "") {
            alert("图片url不能为空");
            return false;
        }
        if (document.addDishForm.dishName.description == "") {
            alert("描述不能为空");
            return false;
        }
    }

    function giveURL() {
        var element = document.getElementById("dishImg");
        var inbox = document.getElementById("imgUrl");
        var url = inbox.value.substr(0, 450);
        url += "335x335";
        element.src = url;
    }
    </script>
</head>
<body>
<jsp:include page="adminHeader.jsp"></jsp:include>

<section id="cart_items">
    <div class="container">
        <div class="breadcrumbs">
            <div class="breadcrumbs">
                <h2>菜品管理</h2>
            </div>
        </div>
        <div class="step-one">
            <h2 class="heading">新增菜品信息</h2>
        </div>
        <div class="table-responsive cart_info">
            <div class="shopper-informations">
                <div class="row">
                    <div class="col-sm-1"></div>
                    <div class="col-sm-5">
                        <div class="shopper-info">
                            <br>
                            <p>菜品信息</p>
                            <form action="/manager/addDish" method="post" name="addDishForm"
                                  onSubmit="return checkDishInfo()">
                                <table>
                                    <tr>
                                        <td>菜品名称:</td>
                                        <td><input type="text" placeholder="菜品名称" name="dishName"/></td>
                                    </tr>
                                    <tr>
                                        <td>价格:</td>
                                        <td><input type="number" placeholder="价格" name="price"/></td>
                                    </tr>
                                    <tr>
                                        <td>折扣:</td>
                                        <td><input type="number" placeholder="折扣" name="discount"/></td>
                                    </tr>
                                    <tr>
                                        <td>图片:</td>
                                        <td><input type="text" placeholder="图片url" name="imgUrl" id="imgUrl"/></td>
                                    </tr>
                                    <tr>
                                        <td>描述:</td>
                                        <td><textarea type="text" placeholder="描述" name="description"></textarea></td>
                                    </tr>
                                </table>
                                <button type="submit" class="btn btn-primary" width="80" padding="20">增加菜品</button>
                                <button type="button" class="btn btn-primary" width="80" padding="20" onclick="giveURL()">图片预览 </button>
                            </form>
                            </br>
                        </div>
                    </div>
                    <div class="col-sm-1"></div>
                    <div class="col-sm-4">
                        <div class="order-message">
                            <p>图片预览</p>
                            <img id="dishImg" src="#" height="335" width="335">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>