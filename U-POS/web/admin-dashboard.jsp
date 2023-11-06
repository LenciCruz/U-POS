<%-- 
    Document   : admin-dashboard
    Created on : Oct 27, 2023, 8:03:56 PM
    Author     : Lenci
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard: Admin</title>
    </head>
    <body>
        <h1>Hello World! This is the admin dashboard</h1>
        <% ResultSet rs = (ResultSet) request.getAttribute("username");
            while (rs.next()) {%>
        <h2>Welcome back, <%= rs.getString("ACC_NAME")%> !</h2>
        <% }%>
        
        <%
            // alerts for adding, updating, and deleting records
            Boolean addProd = (Boolean) request.getAttribute("addedProduct");
            Boolean addAcc = (Boolean) request.getAttribute("addedAccount");

            if (addProd != null) {
        %>
        <script>
            alert("Alert: New product added succesfully");
        </script>
        <%
            }
            if (addAcc != null) {
        %>
         <script>
            alert("Alert: New account added succesfully");
        </script>
        <% } %>
        
        <a href="Logout"><input type=button value="Logout"></a>
        <h3>Sales Button</h3>
        <a href="Inventory"><input type=button value="Inventory Page"></a>
        <h3>Reports Button</h3>
        <a href="Accounts"><input type=button value="Accounts Page"></a>
    </body>
</html>
