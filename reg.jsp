<%@ page  language="java" import="java.util.*,java.sql.*"%>
<%
        String n=request.getParameter("name");
        String mb=request.getParameter("mnumber");
        String un=request.getParameter("username");
        String email=request.getParameter("email");
        String pwd=request.getParameter("password");
        String ad=request.getParameter("Address"); 
        
        java.sql.Date currentdate = new java.sql.Date(new java.util.Date().getTime());
try
           {
             Class.forName("oracle.jdbc.driver.OracleDriver");
             Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","kavya");
             String query="insert into users values(?,?,?,?,?,?,?)";
             PreparedStatement pst=con.prepareStatement(query);
             pst.setString(1,n);
             pst.setString(2,mb);
             pst.setString(3,un);
             pst.setString(4,email);
             pst.setString(5,pwd);
             pst.setString(6,ad);
             pst.setDate(7,currentdate);
            
             pst.executeUpdate();
             con.close();
             
  boolean regcomplete=true;
  if(regcomplete){
response.sendRedirect("login.html");
  }
  else{
      response.sendRedirect("reg.html");
  }
           }
           
       catch(Exception e)
        {
          out.println("<h1>" +e+"</h1>");
     }

     
%>
