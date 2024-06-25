<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="${path}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${path}/css/font-awesome.min.css" rel="stylesheet">
    <link href="${path}/css/prettyPhoto.css" rel="stylesheet">
    <link href="${path}/css/price-range.css" rel="stylesheet">
    <link href="${path}/css/animate.css" rel="stylesheet">
    <link href="${path}/css/main.css" rel="stylesheet">
    <link href="${path}/css/responsive.css" rel="stylesheet">
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <script language="javascript">
        function checkUser() {
            if (document.updateForm.userName.value == "") {
                alert("用户名不能为空");
                return false;
            }
            if (document.updateForm.email.value == "") {
                alert("邮箱不能为空");
                return false;
            }
            if (document.updateForm.phone.value == "") {
                alert("电话不能为空");
                return false;
            }
            if (document.updateForm.address.value == "") {
                alert("收货地址不能为空");
                return false;
            }
            if (document.updateForm.modifyPass.value == "") {
                alert("密码不能为空");
                return false;
            }
            if (document.updateForm.confirmPass.value == "") {
                alert("请再次确认密码");
                return false;
            }
            if (document.updateForm.confirmPass.value != document.updateForm.modifyPass.value) {
                alert("两次密码不一致");
                return false;
            }
        }

    </script>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<section id="form" style="margin-top: 0px; margin-bottom: 0px ">
    <div class="container" style="position: relative;height: 520px;">
        <div >
            <div >
                <div class="signup-form" align=center>
                    <c:choose>
                        <c:when test="${requestScope.msg eq null}"><h2>修改信息</h2></c:when>
                        <c:otherwise><h2>${requestScope.msg}</h2></c:otherwise>
                    </c:choose>
                    <form action="/online/user/update" method="POST" name="updateForm" onSubmit="return checkUser()">
                        <table>
                            <tr>
                                <input type="hidden" value="${sessionScope.user.userId}" name="userId"/>
                            </tr>
                            <tr>
                                <td>用户名: </td>
                                <td><input type="text" name="userName"/></td>
                            </tr>
                            <tr>
                                <td>邮箱:  </td>
                                <td><input type="email" name="email"/></td>
                            </tr>
                            <tr>
                                <td>电话:  </td>
                                <td><input type="tel" name="phone"/></td>
                            </tr>
                            <tr>
                                <td>收货地址:  </td>
                                <td><input type="text" name="address"/></td>
                            </tr>
                            <tr>
                                <td>密码:  </td>
                                <td><input type="password" name="modifyPass"/></td>
                            </tr>
                            <tr>
                                <td>确认密码:</td>
                                <td><input type="password" name="confirmPass"/></td>
                            </tr>
                        </table>
                        <button type="submit" class="btn btn-default">确认修改</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>