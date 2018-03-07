<%
boolean UseCas=false; 
%>
<%! public static class LoginCheck
{
	public static boolean login(String username,String pwd)
	{
		if("admin".equals(username)&&"111111".equals(pwd))
		{
			return true;
		}
		return false;
	}
}

%>