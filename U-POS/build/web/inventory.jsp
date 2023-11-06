<%-- 
    Document   : inventory
    Created on : Oct 31, 2023, 10:50:03 PM
    Author     : Lenci
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Inventory Page</title>
    </head>
    <body>
        <h1>Hello World! This is the inventory Page</h1>
        <% ResultSet rs = (ResultSet) request.getAttribute("username");
            while (rs.next()) {%>
        <h2>Welcome back, <%= rs.getString("ACC_NAME")%> !</h2>
        <% }%>
        
        <form action="Inventory" method="POST" id="form"> 
            <input type="hidden" name="filter" value="true">
            <select name="category" id="category" onchange="this.form.submit()">
                <option selected disabled>Select</option>
                <option value="all">All</option>
                <%
                    ResultSet categories = (ResultSet) request.getAttribute("categories");
                    while (categories.next()) {
                        String category = categories.getString("PROD_CATEGORY");
                %>
                <option value="<%= category%>"><%= category%></option>
                <%
                    }
                %>
            </select>
            <input type="text" name="searchBar" placeholder="Search"/>
            <input type="submit" value="Go"/>
        </form>
        <table>
            <tr>
                <th>PRODUCT CODE</th>
                <th>NAME</th>
                <th>PRICE</th>
                <th>QUANTITY</th>
                <th>CATEGORY</th>
            </tr>

            <% ResultSet results = (ResultSet) request.getAttribute("inventoryTable");
                while (results.next()) {%>
            <tr>
                <td><%=results.getString("PROD_CODE")%></td>
                <td><%=results.getString("PROD_NAME")%></td>
                <td>₱<%=results.getString("PROD_PRICE")%></td>
                <td><%=results.getString("PROD_QUANTITY")%></td>
                <td><%=results.getString("PROD_CATEGORY")%></td
            </tr>

            <% }%>
        </table>

        <form action="AddProduct" method="POST">
            <input type="submit" value="Add New Product" />
        </form>
    </body>
</html>
