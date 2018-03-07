<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../config/config.jsp"%>
<%@page import="com.eccl.Tools" %>
<%
	String sql = request.getParameter("sql")==null?"":request.getParameter("sql");
	System.out.println("sql=="+sql);
	
	Tools tool = new Tools();
	String f = tool.querySql(sql);
	out.print(f);
%>