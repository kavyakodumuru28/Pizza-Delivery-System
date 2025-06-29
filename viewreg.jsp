<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registrations</title>
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
  </style>
</head>
<body>
  <h1>Registrations</h1>
  <table border="1">
    <tr>
      <th>Name</th>
      <th>Email</th>
      <th>UserName</th>
      <th>Phone</th>
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

        // Query to select data from registration table
        String query = "SELECT name, email,username, mobileno FROM users"; // Corrected query
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // Loop through the result set and display data
        while (resultSet.next()) {
          out.println("<tr>");
          out.println("<td>" + resultSet.getString("name") + "</td>");
          out.println("<td>" + resultSet.getString("email") + "</td>");
          out.println("<td>" + resultSet.getString("username") + "</td>");
          out.println("<td>" + resultSet.getString("mobileno") + "</td>"); 
          // Corrected column name
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
