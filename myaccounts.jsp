<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Account</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
        }

        p {
            color: #666;
        }
        .order-item {
    background-color: #f9f9f9;
    padding: 10px;
    margin-bottom: 20px;
    border-radius: 5px;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    border: 2px solid #ccc; /* Add thicker border */
}

        .order-item p {
            margin: 5px 0;
        }
        .order-item p {
            margin: 5px 0;
            font-size: 18px;
            color: #333;
        }

        .order-item p.title {
            font-weight: bold;
        }
        .cancel-btn {
            background-color: #ff6666;
            color: #fff;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

    </style>
</head>
<body>
    <div class="container">
<%
    // Retrieve username from session
    String username = (String) session.getAttribute("username");

    // Check if username exists
    if (username != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Initialize the connection
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "kavya");

            // Prepare SQL statement to retrieve user details
            String sql = "SELECT * FROM users WHERE username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);

            // Execute the query
            rs = pstmt.executeQuery();

            // Display user details
            if (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                String mobileno = rs.getString("mobileno");
                // You can retrieve other user details in a similar manner

                // Output user details
                out.println("<h2>User Details:</h2>");
                out.println("<p>Name: " + name + "</p>");
                out.println("<p>Email: " + email + "</p>");
                out.println("<p>Mobile Number: " + mobileno+ "</p>");
                // Output other user details as needed
                 
                String orderSql = "SELECT * FROM orders WHERE username = ?";
                pstmt = conn.prepareStatement(orderSql);
                pstmt.setString(1, username);

                // Execute the order query
                rs = pstmt.executeQuery();

                
                out.println("<h2>Order Details:</h2>");
                while (rs.next()) {
                    String pname = rs.getString("pname");
                    int pq = rs.getInt("pq");
                    double pt = rs.getDouble("pt");
                    

                    out.println("<div class=\"order-item\">");
                    out.println("<p>Product Name: " + pname + "</p>");
                    out.println("<p>Quantity: " + pq + "</p>");
                    out.println("<p>Total Price: " + pt + "</p>");
                    out.println("<form action=\"cancleorder.jsp\" method=\"post\">"); 
                    out.println("<input type=\"hidden\" name=\"productName\" value=\"" + pname + "\">");
                    out.println("<button class=\"cancel-btn\" onclick=\"cancelOrder('" + pname + "')\">Cancel Order</button>");
                    out.println("</div>");
                    
            }
        } else {
            // User not logged in
            out.println("<p>Please login to view your account details</p>");
        }
        } catch (ClassNotFoundException e) {
            // Handle ClassNotFoundException
            e.printStackTrace();
        } catch (SQLException e) {
            // Handle SQLException
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        // User not logged in
        out.println("<p>Please login to view your account details</p>");
    }
%>
</div>
</body>
</html>