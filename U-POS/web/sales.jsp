<%-- 
    Document   : sales
    Created on : Oct 27, 2023, 5:12:44 PM
    Author     : Lenci
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sales Page</title>
    </head>
    <body>

        <h1>LOGIN SUCCESSFUL! this is the cashier role page</h1>
        <% ResultSet rs = (ResultSet) request.getAttribute("username");
            while (rs.next()) {%>
        <h2>Welcome back, <%= rs.getString("ACC_NAME")%> !</h2>
        <% }%>
        <a href="Logout"><input type=button value="Logout"></a>

    </body>
</html>