<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URLEncoder" %>

<%
    // Get form data
    String pname = request.getParameter("pname");
    int pq = Integer.parseInt(request.getParameter("pq"));
    double pt = Double.parseDouble(request.getParameter("pt"));
    String username = request.getParameter("username");

    Date currentDate = new Date();
    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmtUpdateProduct = null;
    ResultSet rs = null;

    try {
        // Load Oracle JDBC driver
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // Initialize the connection
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "kavya");

        // Prepare SQL statement to check product availability
        String sqlCheckAvailability = "SELECT quantity FROM products WHERE productname = ?";
        pstmt = conn.prepareStatement(sqlCheckAvailability);
        pstmt.setString(1, pname);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            int availableQuantity = rs.getInt("quantity");

            if (availableQuantity >= pq) {
                // Prepare SQL statement to insert data into the orders table
                String sqlInsertOrder = "INSERT INTO orders (pname, pq, pt, orderdate, username) VALUES (?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sqlInsertOrder);
                pstmt.setString(1, pname);
                pstmt.setInt(2, pq);
                pstmt.setDouble(3, pt);
                pstmt.setDate(4, new java.sql.Date(currentDate.getTime()));
                pstmt.setString(5, username);

                // Execute the SQL statement to insert order
                pstmt.executeUpdate();

                // Prepare SQL statement to update product quantity in the products table
                String sqlUpdateProduct = "UPDATE products SET quantity = quantity - ? WHERE productname = ?";
                pstmtUpdateProduct = conn.prepareStatement(sqlUpdateProduct);
                pstmtUpdateProduct.setInt(1, pq);
                pstmtUpdateProduct.setString(2, pname);

                // Execute the SQL statement to update product quantity
                pstmtUpdateProduct.executeUpdate();

                // Set username in session
                HttpSession sessionObj = request.getSession();
                sessionObj.setAttribute("username", username);

                // Redirect to home.html with username as query parameter
                response.sendRedirect("pay.html?username=" + URLEncoder.encode(username, "UTF-8"));
            } else {
                // Product is unavailable
                out.println("<script>alert('Product is unavailable.');</script>");
                out.println("<script>window.location.replace('pay.html');</script>");
            }
        }

    } catch (ClassNotFoundException e) {
        // Handle ClassNotFoundException
        e.printStackTrace();
    } catch (SQLException e) {
        // Handle SQLException
        e.printStackTrace();
    } catch (IOException e) {
        // Handle IOException
        e.printStackTrace();
    } finally {
        // Close the resources in a finally block to ensure they are always closed
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (pstmtUpdateProduct != null) pstmtUpdateProduct.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
