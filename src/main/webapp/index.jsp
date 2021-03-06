<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../config/config.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>登录</title>
	<script src="jquery-3.3.1.min.js" type="text/javascript"></script>
</head>
<body>
<%
String username="";
boolean loginFlag=false;
if(UseCas)
{
	username=request.getRemoteUser();
	if(username!=null&&!"".equals(username))
	{
		loginFlag=true;
	}
}
else
{
	username=request.getParameter("username")==null?"":(String)request.getParameter("username");
	String pwd=request.getParameter("pwd")==null?"":(String)request.getParameter("pwd");
	if(username!=null&&!"".equals(username)&&pwd!=null&&!"".equals(pwd))
	{
		loginFlag=LoginCheck.login(username,pwd);
	}
}
if(loginFlag)
{
	// 添加用户session
	session.setAttribute("username",username);
	if(UseCas) 
	{
		session.setAttribute("type","cas");
	}
	else
	{
		session.setAttribute("type","login");
	}
	response.sendRedirect("welcome.jsp");
}
%>
<center>
<form action="index.jsp" method="post">
    <table width="500" border="0" cellpadding="1" cellspacing="1">
	  <tr>
		<td>用户名：</td>
		<td><input type="text" name="username" id="username"/></td>
	  </tr>
	  <tr>
		<td>密码</td>
		<td><input type="password" name="pwd" id="pwd"/></td>
	  </tr>
	  <tr>
		<td cospan="2" align="center">
			<input type="button" value="登录" onClick="this.form.submit();"/>
			<input type="button" value="Mysql工具" onClick="tomysql()"/>
			<input type="button" value="Oracle" onClick="tooracle()"/>
			<input type="button" value="环境变量" onClick="getenv()"/>
		</td>
	  </tr>
	</table>
	<p id="env"></p>
</form>
</center>
<script language="javascript">
function tomysql() {
	window.location.href = "mysql/tools.jsp";
}
function tooracle() {
	window.location.href = "oracle/tools.jsp";
}

function getenv() {
	$.post("getenv.jsp",
	  {},
	  function(data,status){
		  $("#env").html(data);
	  });
}
</script>
</body>
</html>
