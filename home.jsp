<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pizza Delight</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
    body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    background-color:#fff; 
    background-image: url('https://www.bhg.com/thmb/DI7ZFLKalff_Cwm-9BLdx7uhgf4=/5472x0/filters:no_upscale():strip_icc()/bhg-spicy-tjs-pizza-7969147-d10d8cc375cc49a19e7c387e9ec25a75.jpg');
    background-size:cover ;
   }

header {
    font-family: 'Montserrat', sans-serif;
    color: #fff;
    padding: 15px;
    text-align: center;
}

nav {
      background-color: #0e0d0d;
      text-align: center;
      overflow: hidden;
    }

    nav a {
      display: inline-block;
      color: #ffffff;
      text-align: center;
      padding: 10px 20px;
      text-decoration: none;
      transition: background-color 0.3s;
    }

    nav a:hover {
      background-color: #555555;
    }


section {
    padding: 20px;
    h1{
        font-family:'Abril Fatface', serif;
        font-size:80px ;
        font-style:italic;
        color:lightcyan;
        position:absolute;
        top:200px;
        left:100px;
    }
    h3{
        font-family:'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
        font-size:30px ;
        font-style:normal;
        color:darkgrey;
        position:absolute;
        top:400px;
        left:100px;
    }
}
h2{
   color:#fff;}
p{
   color:#fff;}
article {
    background-color: #fff;
    padding: 20px;
}footer {
    background-color: #0e0d0d;
    color: #fff;
    text-align: center;
    padding: 10px;
    position: fixed;
    bottom: 0;
    width: 100%;
}
.btn {
background-color: #6daf4c;
color: white;
padding: 15px 32px;
text-align: center;
font-size: 16px;
margin: 4px 2px;
cursor: pointer;
border-radius: 8px;
position:absolute;
top:500px;
left:100px;
}
p{
position:absolute;
top:600px;
left:100px;
}



    </style>
</head>
<body>
    <header>
    <nav>
        <a href="home.html">Home</a>
        <a href="login.html">Login</a>
        <a href="reg.html">Registration</a>
        <a href="menu.html">Menu</a>
        <a href="about.html">About Us</a>
        <a href="service.html">Our Services</a>
        <a href="contact.html">Contact</a>
        <a href="logout.html">Log out</a>
        <a href="admlog.html">Admin Login</a>

        <%
          String name=(String)session.getAttribute("individual");
          out.print(name);
        %>
          
    </nav>
    </header>
    
    <section id = "home">
        <h1>Pizza Delight..</h1> 
        <h3>Pizza is My Therapyyy..!!</h3>
        <button class="btn" onclick="window.location.href='shop.html';">Order Now..!</button>

    <p class="signup-message">Don't have an account? <a href="reg.html">Sign up here</a></p>
    
</body> 
    <footer>
        <p>&copy; 2023 Pizza Delight. All rights reserved.</p>
    </footer>
    <script>

    </script>

</body>
</html>
