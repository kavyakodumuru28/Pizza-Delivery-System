<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>User Orders Details</title>
</head>
<body>
    <%
        String username = request.getParameter("username");
        if (username != null && !username.isEmpty()) {
            try {
                // Establish database connection
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "username", "password");
                
                // Prepare SQL statement
                PreparedStatement pstmt = con.prepareStatement("SELECT * FROM orders WHERE username = ?");
                pstmt.setString(1, username);
                
                // Execute query
                ResultSet rs = pstmt.executeQuery();
                
                // Display results
                out.println("<h3>Orders for User: " + username + "</h3>");
                out.println("<table border='1'>");
                out.println("<tr><th>Order ID</th><th>Product</th><th>Quantity</th></tr>");
                while (rs.next()) {
                    out.println("<tr>");
                        out.println("<td>" + rs.getString("pname") + "</td>");
                        out.println("<td>" + rs.getInt("pq") + "</td>");
                        out.println("<td>" + rs.getInt("pt") + "</td>");
                        out.println("<td>" + rs.getString("username") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                
                // Close connections
                rs.close();
                pstmt.close();
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        } else {
            // If username is not provided, show a message
            out.println("<h3>Please enter a username to get orders.</h3>");
        }
    %>
    <br>
    <a href="index.jsp">Go back to Home</a>
</body>
</html>
