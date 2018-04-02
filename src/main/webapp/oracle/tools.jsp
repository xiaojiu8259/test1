<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../config/config.jsp"%>
<%@page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>Oracle工具</title>
	<script src="../jquery-3.3.1.min.js" type="text/javascript"></script>
</head>
<body>
<script type="text/javascript">
function testConn() {
	$.post("testconn.jsp",
	  {
		dbname:$("#dbname").val(),
		host:$("#host").val(),
	    port:$("#port").val(),
	    username:$("#username").val(),
	    password:$("#pwd").val()
	  },
	  function(data,status){
		  if($.trim(data)=="true") {
			  alert('数据库连接成功！');
			  $("#contable").hide();
			$("#sqltalbe").show();
		   }
		   else {
			  alert('data:'+$.trim(data));
		   }
	  });
}

function querySql() {
	$.post("querysql.jsp",
	  {
		sql:$("#sql").val()
	  },
	  function(data,status){
		 $("#cont").html(data);
	  });
}

function initConn() {
	$.post("init.jsp",
	  {},
	  function(data,status){
		  if($.trim(data)=="true") {
			  alert('数据库初始化成功成功！');
		  }
		  else {
			  alert('data:'+$.trim(data));
		  }
	  });
}

function reback() {
	window.location.href = "../index.jsp";
}
</script>
<center>
    <table id="contable" width="500" border="1" cellpadding="0" cellspacing="0">
	  <tr>
		<td><font color="red">*</font>&nbsp;数据库名称：</td>
		<td><input type="text" name="dbname" id="dbname" value="ORCL"/></td>
	  </tr>
	  <tr>
		<td><font color="red">*</font>&nbsp;主机名或IP地址：</td>
		<td><input type="text" name="host" id="host" value="localhost"/></td>
	  </tr>
	  <tr>
		<td><font color="red">*</font>&nbsp;端口号</td>
		<td><input type="text" name="port" id="port" value="1521"/></td>
	  </tr>
	  <tr>
	  <tr>
		<td><font color="red">*</font>&nbsp;用户名：</td>
		<td><input type="text" name="dbusername" id="username" value="platform"/></td>
	  </tr>
	  <tr>
		<td><font color="red">*</font>&nbsp;密码</td>
		<td><input type="text" name="dbpwd" id="pwd" value="platform"/></td>
	  </tr>
	  <tr>
		<td colspan=2 align="center">
			<input type="button" value="测试连接" onClick="javascript:testConn()"/>
			<input type="button" value="查询" onClick="javascript:querySql()"/>
			<input type="button" value="返回登录页面" onClick="javascript:reback()"/>
		</td>
	  </tr>
	</table>
	<div id="sqltalbe" style="display:none;">
		Oracle
		<table width="500" border="1" cellpadding="0" cellspacing="0">
		  <tr>
			<td><textarea id="sql" rows="5" cols="100">select * from W_QJD</textarea></td>
		  </tr>
		  <tr>
			<td align="center">
				<input type="button" value="查询" onClick="javascript:querySql()"/>
				<input type="button" value="返回登录页面" onClick="javascript:reback()"/>
			</td>
		  </tr>
		</table>
		<div id="cont"></div>
	</div>
</center>
</body>
</html>
