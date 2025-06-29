<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Menu</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
    }

    h1 {
      text-align: center;
      margin-top: 20px;
      color: #333;
    }

    table {
      width: 80%;
      margin: 20px auto;
      border-collapse: collapse;
      border: 2px solid #333;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: left;
    }

    th {
      background-color: #333;
      color: white;
    }

    tbody tr:nth-child(even) {
      background-color: #f2f2f2;
    }

    tbody tr:hover {
      background-color: #ddd;
    }

    .edit-btn {
      background-color: #4CAF50;
      border: none;
      color: white;
      padding: 8px 16px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 14px;
      margin: 4px 2px;
      cursor: pointer;
      border-radius: 4px;
    }

    .edit-btn:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
  <h1>Edit Menu</h1>
  <table border="1">
    <tr>
      <th>ProductID</th>
      <th>ProductName</th>
      <th>Price</th>
      <th>Quantity</th>
      <th>Action</th>
    </tr>
    <% 
      try {
        // Load the Oracle JDBC driver
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // Connect to your Oracle database
        String url = "jdbc:oracle:thin:@localhost:1521:XE"; // Update with your database URL
        String user = "system"; // Update with your username
        String password = "kavya"; // Update with your password
        Connection connection = DriverManager.getConnection(url, user, password);

        // Query to select data from products table
        String query = "SELECT * FROM products"; 
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and display data
        while (resultSet.next()){
          out.println("<tr>");
          out.println("<td>" + resultSet.getString("productid") + "</td>");
          out.println("<td>" + resultSet.getString("productname") + "</td>");
          out.println("<td>" + resultSet.getString("price") + "</td>");
          out.println("<td>" + resultSet.getString("quantity") + "</td>");
          out.println("<td>");
          out.println("<form method='post' action='edit.jsp'>");
          out.println("<input type='hidden' name='productId' value='" + resultSet.getString("productid") + "'>");
          out.println("<input type='number' name='price' value='" + resultSet.getString("price") + "' required>");
          out.println("<input type='number' name='quantity' value='" + resultSet.getString("quantity") + "' required>");
          out.println("<button type='submit' class='edit-btn'>Save</button>");
          out.println("</form>");
          out.println("</td>");
          out.println("</tr>");
        }
        // Close resources
        resultSet.close();
        statement.close();
        connection.close();
      } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
      }
    %>
  </table>
</body>
</html>
