<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator,javax.servlet.http.Cookie" %>
<%@ page import="org.jasig.cas.client.authentication.AttributePrincipal" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%
    session.invalidate();
	/*
	Cookie[] cookies = request.getCookies();  
       
     if(cookies == null) {  
        out.print("no cookies");  
     } 
	 else 
	 {  
         for(int i=0; i<cookies.length; i++) 
		 {  
            Cookie cookie = cookies[i];  
            String name = cookie.getName();  
            String value = cookie.getValue();  
            out.print("CookieName:"+name+"   CookieValue:"+value+"<br>");  
         }
		 
		Cookie deleteNewCookie=new Cookie("JSESSIONID",null);
		deleteNewCookie.setMaxAge(0);
		deleteNewCookie.setPath("/"); 
		response.addCookie(deleteNewCookie);
     }*/
	 response.sendRedirect(application.getInitParameter("casServerLogoutUrl")+"?service=http://10.150.60.82:8080/cn1");  
	 //response.sendRedirect("https://niujunlong.eccl.user:8443/cas/logout");
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CAS Example Java Web App</title>
</head>
<body>
<h1>CAS Example Java Web App</h1>
<p>Application session is now invalidated. You may also issue a request to "/cas/logout" to destroy the CAS SSO Session as well.</p>
<hr>

<a href="">Back to Home</a>
</body>
</html>
