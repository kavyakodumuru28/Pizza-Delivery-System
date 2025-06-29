<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Order Details</title>
    <!-- Styles can be included here if needed -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>

<%
    // Database connection parameters for Oracle
    String url = "jdbc:oracle:thin:@localhost:1521:XE";
    String username = "system";
    String password = "kavya";

    // Retrieving username from the request parameter
    String targetUsername = request.getParameter("username");

    // SQL query to retrieve order details based on username
    String sql = "SELECT * FROM orders WHERE username = ?";

    // Establishing database connection
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection(url, username, password);
        
        // Prepared statement to execute the SQL query
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, targetUsername);
        
        // Executing the query and retrieving the results
        ResultSet resultSet = statement.executeQuery();

        // Displaying the order details
        out.println("<h1>Order Details for User: " + targetUsername + "</h1>");
        out.println("<table border='1'>");
        out.println("<tr><th>Item</th><th>Quantity</th><th>Total Price</th></tr>");
        while (resultSet.next()) {
            String productName = resultSet.getString("pname");
            int quantity = resultSet.getInt("pq");
            double totalPrice = resultSet.getDouble("pt");
            out.println("<tr><td>" + productName + "</td><td>" + quantity + "</td><td>" + totalPrice + "</td></tr>");
        }
        out.println("</table>");

        // Closing resources
        resultSet.close();
        statement.close();
        conn.close();
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    }
%>

</body>
</html>
