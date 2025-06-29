<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Product</title>
  
</head>
<body>
<%
    // Retrieve form parameters
    String productId = request.getParameter("productId");
    String price = request.getParameter("price");
    String quantity = request.getParameter("quantity");

    try {
        // Load the Oracle JDBC driver
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // Connect to your Oracle database
        String url = "jdbc:oracle:thin:@localhost:1521:XE"; // Update with your database URL
        String user = "system"; // Update with your username
        String password = "kavya"; // Update with your password
        Connection connection = DriverManager.getConnection(url, user, password);

        // Update query to update product price and quantity
        String updateQuery = "UPDATE products SET price = ?, quantity = ? WHERE productid = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
        preparedStatement.setString(1, price);
        preparedStatement.setString(2, quantity);
        preparedStatement.setString(3, productId);

        // Execute the update query
        int rowsUpdated = preparedStatement.executeUpdate();

        // Close resources
        preparedStatement.close();
        connection.close();

        // Redirect back to the edit menu page with a success message
        if (rowsUpdated > 0) {
            response.sendRedirect("editmenu.jsp?success=true");
        } else {
            response.sendRedirect("editmenu.jsp?error=true");
        }

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Redirect back to the edit menu page with an error message
        response.sendRedirect("editmenu.jsp?error=true");
    }
%>
</body>
</html>
