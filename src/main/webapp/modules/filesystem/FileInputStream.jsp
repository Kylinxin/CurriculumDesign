<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.FileNotFoundException" %>

<pre>
<%
    try {
        File file = new File(request.getRealPath("/") + request.getParameter("name"));
        FileInputStream in = new FileInputStream(file);
        int tempbyte;
        while ((tempbyte = in.read()) != -1) {
            out.print((char) tempbyte); // 输出到网页上
        }
    } catch (FileNotFoundException e) {
        out.println("File not found: " + e.getMessage());
    }
%>
</pre>