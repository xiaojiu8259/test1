<%@ page session="true" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="org.jasig.cas.client.authentication.AttributePrincipal,java.util.*" %>
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
    if (request.getUserPrincipal() != null) {
        AttributePrincipal principal = (AttributePrincipal) request.getUserPrincipal();

        final Map attributes = principal.getAttributes();

        if (attributes != null) {
            Iterator attributeNames = attributes.keySet().iterator();

            if (attributeNames.hasNext()) {
                out.println("<hr><table border='3pt' width='100%'>");
                out.println("<th colspan='2'>Attributes</th>");
                out.println("<tr><td><b>Key</b></td><td><b>Value</b></td></tr>");

                for (; attributeNames.hasNext(); ) {
                    out.println("<tr><td>");
                    String attributeName = (String) attributeNames.next();
                    out.println(attributeName);
                    out.println("</td><td>");
                    final Object attributeValue = attributes.get(attributeName);

                    if (attributeValue instanceof List) {
                        final List values = (List) attributeValue;
                        out.println("<strong>Multi-valued attribute: " + values.size() + "</strong>");
                        out.println("<ul>");
                        for (Object value : values) {
                            out.println("<li>" + value + "</li>");
                        }
                        out.println("</ul>");
                    } else {
                        out.println(attributeValue);
                    }
                    out.println("</td></tr>");
                }
                out.println("</table>");
            } else {
                out.print("No attributes are supplied by the CAS server.</p>");
            }
        } else {
            out.println("<pre>The attribute map is empty. Review your CAS filter configurations.</pre>");
        }
    } else {
        out.println("<pre>The user principal is empty from the request object. Review the wrapper filter configuration.</pre>");
    }
%>


</center>
</body>
</html>
