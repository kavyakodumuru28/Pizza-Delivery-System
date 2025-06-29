<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>View Orders - Admin Dashboard</title>
  <style>
  
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
    }
    .container {
      max-width: 1200px;
      margin: 20px auto;
      padding: 20px;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }
    th, td {
      padding: 10px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }
    th {
      background-color: #f2f2f2;
    }
    th, td {
      padding: 12px 15px;
    }
    th {
      background-color: #007bff;
      color: #fff;
      font-weight: bold;
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
  <div class="container">
    <h1>All Orders</h1>
    <table>
      <thead>
        <tr>
          <th>card_number</th>
          <th>expiration-date</th>
          <th>cvv</th>
          <th>Username</th>
        </tr>
      </thead>
      <tbody>
        <% 
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
          // Establish connection to the database
          Class.forName("oracle.jdbc.driver.OracleDriver");
          conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "kavya");
          
          // Execute SQL query to retrieve orders
          String query = "SELECT * FROM payment";
          stmt = conn.createStatement();
          rs = stmt.executeQuery(query);
          
          // Iterate through the result set and display orders
          while(rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getString("card_number") + "</td>");
            out.println("<td>" + rs.getInt("expiration_date") + "</td>");
            out.println("<td>" + rs.getDouble("cvv") + "</td>");
            out.println("<td>" + rs.getString("username") + "</td>");
            out.println("</tr>");
          }
        } catch(Exception e) {
          e.printStackTrace();
        } finally {
          // Close resources
          try {
            if(rs != null) rs.close();
            if(stmt != null) stmt.close();
            if(conn != null) conn.close();
          } catch(SQLException e) {
            e.printStackTrace();
          }
        }
        %>
      </tbody>
    </table>
  </div>
</body>
</html>
