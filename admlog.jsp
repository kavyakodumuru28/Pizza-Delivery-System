<%@ page import="java.util.*"%>
<html>
<heda>
<title>Response object example program</title>
</head>
<body>
<%
String em=request.getParameter("uname");
String pw=request.getParameter("pwd");
if(em.equals("admin")&&pw.equals("admin"))
{
 response.sendRedirect("adm.html");
}
else
{
 
%>
<h1>invalidusername or password</h1>
<%
response.sendRedirect("login.html");
}
%>
</body>
</html>
