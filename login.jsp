<%@ page import="java.util.*,java.sql.*"%>
<%
    String username=request.getParameter("username");
    String pwd=request.getParameter("password");
    try 
    {
        Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","kavya");
        String query="select * from users where username=? and passwor=?";
        PreparedStatement pst=con.prepareStatement(query);
        pst.setString(1,username);
        pst.setString(2,pwd);
        ResultSet rs=pst.executeQuery();
        if(rs.next())
        {
            // Set username in session
            session.setAttribute("individual", username);
            // Redirect to shop.html with username as query parameter
            response.sendRedirect("shop.html?username=" + username);
        }
        else
        {
    %>
    <script>
        alert("Invalid username or Password");
        window.location.replace("login.html");
    </script>
    <%
        } 
    }
    catch(Exception e)
    {
        out.println("<h1>"+e+"</h1>");
    }
%>