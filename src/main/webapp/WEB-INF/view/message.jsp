<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%
    String username = request.getParameter("username");
    String content = request.getParameter("content");

    String guestBookKey = "GUEST_BOOK";
    List<Map<String, String>> comments = new ArrayList<Map<String, String>>();

    if (content != null) {
        Object obj = application.getAttribute(guestBookKey);

        if (obj != null) {
            comments = (List<Map<String, String>>) obj;
        }

        Map<String, String> comment = new HashMap<String, String>();
        String              ip      = request.getHeader("x-real-ip");

        if (ip == null) {
            ip = request.getRemoteAddr();
        }

        comment.put("username", username);
        comment.put("content", content);
        comment.put("ip", ip);
        comment.put("date", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

        comments.add(comment);

        application.setAttribute(guestBookKey, comments);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>留言板</title>
    <link href="${path}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${path}/css/font-awesome.min.css" rel="stylesheet">
    <link href="${path}/css/prettyPhoto.css" rel="stylesheet">
    <link href="${path}/css/price-range.css" rel="stylesheet">
    <link href="${path}/css/animate.css" rel="stylesheet">
    <link href="${path}/css/main.css" rel="stylesheet">
    <link href="${path}/css/responsive.css" rel="stylesheet">
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <script language="javascript">
        function checkMessage() {
            if (document.messageForm.message.value == "") {
                alert("留言不能为空");
                return false;
            }
        }
    </script>
	<style>
		.table tbody tr td{
		border:0px!important;
		}
	</style>
</head>
<head>
    <title>留言板</title>
</head>
<style>
    * {
        margin: 0;
        padding: 0;
    }
</style>
<body>
<c:choose>
    <c:when test="${sessionScope.user.userId eq 'admin'}">
        <jsp:include page="adminHeader.jsp"></jsp:include>
    </c:when>
    <c:otherwise>
        <jsp:include page="header.jsp"></jsp:include>
    </c:otherwise>
</c:choose>


<section id="cart_items" style="margin-bottom: 20px">
    <div class="container">
        <div class="breadcrumbs">
            <h2>留言板</h2>
        </div>
        <div class="table-responsive cart_info">
            <table class="table table-condensed">
                <tbody >
                <c:forEach items="${requestScope.messages}" var="message" varStatus="status">
                    <tr style="border-bottom:1px solid #eee">
                        <td style="padding-top:16px;">${message.userName}:</td>
                    </tr>
                    <tr>
                        <td>
                            <textarea>${message.message}</textarea>
                        </td>
                        <td style="text-align:right;">
                            <c:if test="${sessionScope.user.userId eq 'admin'}">
                                <a href="/manager/deleteMessage?id=${message.id}">删除</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:if test="${sessionScope.user.userId != 'admin'}">
                <form action="/online/createMessage" method="POST" name="messageForm" onSubmit="return checkMessage()" enctype="multipart/form-data">

                    <table style="width:100%;min-height:100px;margin-bottom:16px;">

                        <tr>
                            <td><textarea style="min-height:100px" type="text" placeholder="留言" name="message"></textarea></td>
                        </tr>
                        <tr>
                            <td><input type="file" name="MessageFile"></td> <!-- 上传文件 -->
                        </tr>
                        <button onclick="window.location.href='/online/createMessage'">留言</button>
                        <tr>
                            <td><input type="submit" value="上传文件"></td> <!-- 提交按钮 -->
                        </tr>
                    </table>
                </form>
            </c:if>
        </div>
    </div>
    <div style="border: 1px solid #C6C6C6;">
        <div style="text-align: center;">
            <h2>在线留言板</h2>
        </div>
        <div>
            <dl>
                <%
                    Object obj = application.getAttribute(guestBookKey);

                    if (obj instanceof List) {
                        comments = (List<Map<String, String>>) obj;

                        for (Map<String, String> comment : comments) {
                %>
                <dd>
                    <div style="min-height: 50px; margin: 20px; border-bottom: 1px solid #9F9F9F;">
                        <p><B><%=comment.get("username")%>
                        </B>[<%=comment.get("ip")%>] 于 <%=comment.get("date")%> 发表回复：</p>
                        <p style="margin: 15px 0 5px 0; font-size: 12px;">
                        <pre><%=comment.get("content")%></pre>
                        </p>
                    </div>
                </dd>
                <%
                        }
                    }
                %>
            </dl>
        </div>
        <div style="background-color: #fff; border: 1px solid #C6C6C6;">
            <form action="#" method="POST" style="margin: 20px;">
                昵称: <input type="text" name="username" style="width:250px; height: 28px;"/><br/><br/>
                <textarea name="content" style="overflow: auto;width: 100%; height: 250px;"></textarea>
                <input type="submit" value="提交留言" style="margin-top: 20px; width: 80px; height: 30px;"/>
            </form>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

