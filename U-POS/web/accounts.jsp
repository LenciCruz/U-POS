<%-- 
    Document   : accounts
    Created on : Nov 6, 2023, 4:54:10 PM
    Author     : Lenci
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Accounts</title>
    </head>
    <body>
         <h1>Hello World! This is the admin dashboard</h1>
        <% ResultSet rs = (ResultSet) request.getAttribute("username");
            while (rs.next()) {%>
        <h2>Welcome back, <%= rs.getString("ACC_NAME")%> !</h2>
        <% }%>
        
         <table>
            <tr>
                <th>USERNAME</th>
                <th>PASSWORD</th>
                <th>USER ROLE</th>
            </tr>

            <% ResultSet results = (ResultSet) request.getAttribute("accountsTable");
                while (results.next()) {%>
            <tr>
                <td><%=results.getString("ACC_NAME")%></td>
                <td>₱<%=results.getString("ACC_PASS")%></td>
                <td><%=results.getString("ACC_ROLE")%></td>
            </tr>
            
            <form action="DeleteAccount" method="POST">
                <input type="hidden" name="acc_id" value="<%=results.getString("ACC_ID")%>"/>
                <button type="submit" value="Delete"/>
            </form>
            <% }%>
        </table>
        
        <form action="AddAccount" method="POST">
            <input type="submit" value="Add Account"/>
        </form>
        
    </body>
</html>
