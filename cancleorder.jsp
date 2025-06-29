<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URLEncoder" %>
<%
    // Retrieve the product name to cancel from the request parameter
    String productName = request.getParameter("productName");

    if (productName != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Initialize the connection
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "kavya");

            // Prepare SQL statement to delete the order
            String sql = "DELETE FROM orders WHERE pname = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productName);

            // Execute the deletion query
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Order canceled successfully
                out.println("Order for " + productName + " canceled successfully.");
            } else {
                // Order not found
                out.println("Order for " + productName + " not found.");
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
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        // No product name provided in the request parameter
        out.println("Product name not provided.");
    }
    
%>
