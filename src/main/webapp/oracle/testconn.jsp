<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../config/config.jsp"%>
<%@page import="com.eccl.OracleTools" %>
<%
	String dbname = request.getParameter("dbname")==null?"":request.getParameter("dbname");	
	String host = request.getParameter("host")==null?"":request.getParameter("host");
	String port = request.getParameter("port")==null?"":request.getParameter("port");
	String username = request.getParameter("username")==null?"":request.getParameter("username");
	String pwd = request.getParameter("password")==null?"":request.getParameter("password");
	System.out.println("host=="+host);
	System.out.println("port=="+port);
	System.out.println("username=="+username);
	System.out.println("pwd=="+pwd);
	
	OracleTools tool = new OracleTools();
	boolean f = tool.testConnection(host,port,username,pwd,dbname);
	if(f) {
		out.print("true");
	}
	else {
		out.print("false");
	}
%>