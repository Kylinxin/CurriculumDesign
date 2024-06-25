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
    <title>注册</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <script language="javascript">
        function checkUserInfo() {
            if (document.registerForm.userId.value == "") {
                alert("登录名不能为空");
                return false;
            }
            if (document.registerForm.userName.value == "") {
                alert("用户名不能为空");
                return false;
            }
            if (document.registerForm.email.value == "") {
                alert("邮箱不能为空");
                return false;
            }
            if (document.registerForm.phone.value == "") {
                alert("电话不能为空");
                return false;
            }
            if (document.registerForm.address.value == "") {
                alert("收货地址不能为空");
                return false;
            }
            if (document.registerForm.password.value == "") {
                alert("密码不能为空");
                return false;
            }
        }
    </script>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<section id="form" style="margin-top: 0px; margin-bottom: 0px ">
    <div class="container" style="position: relative;height: 520px;">
            <div>
                <div class="signup-form" align=center>
                    <c:choose>
                        <c:when test="${requestScope.msg eq null}"><h2>注册新用户</h2></c:when>
                        <c:otherwise><h2>${requestScope.msg}</h2></c:otherwise>
                    </c:choose>
                    <form action="register" method="POST" name="registerForm" onSubmit="return checkUserInfo()">
                        <table>
                            <tr>
                                <td>登录名:</td>
                                <td><input type="text" placeholder="登录名" name="userId"/></td>
                            </tr>
                            <tr>
                                <td>用户名:</td>
                                <td><input type="text" placeholder="用户名" name="userName"/></td>
                            </tr>
                            <tr>
                                <td>邮箱:</td>
                                <td><input type="email" placeholder="邮箱" name="email"/></td>
                            </tr>
                            <tr>
                                <td>电话:  </td>
                                <td><input type="tel" placeholder="电话" name="phone"/></td>
                            </tr>
                            <tr>
                                <td>收货地址:  </td>
                                <td><input type="text" placeholder="收货地址" name="address"/></td>
                            </tr>
                            <tr>
                                <td>密码:</td>
                                <td><input type="password" placeholder="密码" name="password"/></td>
                            </tr>
                        </table>
                        <button type="submit" style="margin-top:20px" class="btn btn-default">注册</button>
                    </form>
                </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>