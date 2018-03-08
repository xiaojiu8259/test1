<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="../config/config.jsp"%>
<%@page import="com.eccl.Tools" %>
<%
	Tools tool = new Tools();
	String f= tool.getEnv();
	out.print(f);
%>