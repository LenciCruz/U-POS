<%-- 
    Document   : add-account
    Created on : Nov 6, 2023, 9:53:13 PM
    Author     : Lenci
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World! This is the inventory Page</h1>
        <% ResultSet rs = (ResultSet) request.getAttribute("username");
            while (rs.next()) {%>
        <h2>Welcome back, <%= rs.getString("ACC_NAME")%> !</h2>
        <% }%>  
        
         <form action="AddAccount" method="POST">
            <input type="hidden" name="add" value="true"/>
            <input type="text" name="name" placeholder="name"/>
            <input type="text" name="password" placeholder="password"/>
            <input type="radio" name="role" value="Admin"/>
            <input type="radio" name="role" value="Cashier"/>
            <button type="submit">Submit</button>
        </form>

    </body>
</html>
