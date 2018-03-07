<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../config/config.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>欢迎登录</title>
</head>
<body>
<%
String usernameCas=request.getRemoteUser();
String username=session.getAttribute("username")==null?"":(String)session.getAttribute("username");
String type=session.getAttribute("type")==null?"":(String)session.getAttribute("type");
if(username==null||"".equals(username))
{
	response.sendRedirect("login.jsp");
}
%>
<center>
<br>
<a href="http://localhost:8080/cn1">应用1</a>&nbsp;&nbsp;&nbsp;
<a href="http://localhost:8080/cn2">应用2</a>&nbsp;&nbsp;&nbsp;
<a href="http://localhost:8080/cn3">应用3</a>


<br/>
应用1  欢迎登录：CAS用户<%=usernameCas%>,Session用户<%=username%>,登录方式：<%=type%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp">注销</a>
<br/>

<%
   out.println("<pre>The user principal is empty from the request object. Review the wrapper filter configuration.</pre>");
%>


</center>
</body>
</html>
