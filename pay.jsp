<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %> <!-- Import URLEncoder -->
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Meta tags -->
    <title>Payment</title>
</head>
<body>
<%
    // Retrieve form parameters
    String cardNumber = request.getParameter("card-number");
    String expirationDate = request.getParameter("expiration-date");
    String cvv = request.getParameter("cvv");
    String username = request.getParameter("username"); // Retrieve username from form

    try {
        // Load the Oracle JDBC driver
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // Connect to your Oracle database
        String url = "jdbc:oracle:thin:@localhost:1521:XE"; // Update with your database URL
        String user = "system"; // Update with your username
        String password = "kavya"; // Update with your password
        Connection connection = DriverManager.getConnection(url, user, password);

        // Create a PreparedStatement to insert data into the database
        String insertQuery = "INSERT INTO payment (card_number, expiration_date, cvv, username) VALUES (?, ?, ?, ?)";
        PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
        preparedStatement.setString(1, cardNumber);
        preparedStatement.setString(2, expirationDate);
        preparedStatement.setString(3, cvv);
        preparedStatement.setString(4, username); // Insert username into database

        // Execute the insert query
        int rowsInserted = preparedStatement.executeUpdate();

        // Close resources
        preparedStatement.close();
        connection.close();

        // Redirect to the home page along with the username as a query parameter
        response.sendRedirect("home.html?username=" + URLEncoder.encode(username, "UTF-8"));

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>
</body>
</html>
