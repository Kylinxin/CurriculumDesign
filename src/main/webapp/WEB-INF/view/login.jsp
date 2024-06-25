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
		if(document.loginForm.loginName.value==""){
			alert("用户名不能为空");
			return false;
		}
		if(document.loginForm.loginPass.value==""){
			alert("密码不能为空");
			return false;
		}
	}
	</script>
</head>

<body>

	<jsp:include page="header.jsp"></jsp:include>

	<section id="form" style="margin-top:0px; margin-bottom:0px;">
		<div class="container" style="position: relative;height: 300px;" >
				<div class="login-form" >
					<c:choose>
						<c:when test="${requestScope.msg eq null}"><h2>登录到您的账户</h2></c:when>
						<c:otherwise><h2>${requestScope.msg}</h2></c:otherwise>
					</c:choose>
						<form action="login" method="POST" name="loginForm" onSubmit="return checkUserInfo()">
							<table>
								<tr>
									<td>
										登录名:
									</td>
									<td>
										<input type="text" placeholder="用户名" name="userId"/>
									</td>
								</tr>
								<tr>
									<td>
										密码：
									</td>
									<td>
										<input type="password" placeholder="密码" name="password"/>
									</td>
								</tr>
							</table>
							<table>
								<tr class="login-form-btn">
									<td ><button style="margin-left:87px" type="submit" class="btn btn-default">登录</button></td>
									<td ><a style="margin-right:87px;display:block;margin-top:24px;" href="/toRegister">注册</a></td>
								</tr>
							</table>
						</form>
					</div>
		</div>
	</section>

    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

