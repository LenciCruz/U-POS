<%-- 
    Document   : add-product
    Created on : Nov 6, 2023, 11:44:42 AM
    Author     : Lenci
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Product</title>
    </head>
    <body>
        <h1>Hello World! This is the inventory Page</h1>
        <% ResultSet rs = (ResultSet) request.getAttribute("username");
            while (rs.next()) {%>
        <h2>Welcome back, <%= rs.getString("ACC_NAME")%> !</h2>
        <% }%>    

        <form action="AddProduct" method="POST">
            <input type="hidden" name="add" value="true"/>
            <input type="text" name="name" placeholder="name"/>
            <input type="text" name="price" placeholder="price"/>
            <input type="number" name="quantity" placeholder="quantity"/>
            <input type="text" name="category" placeholder="category"/>
            <input type="submit" value="submit"/>
        </form>

    </body>
</html>
