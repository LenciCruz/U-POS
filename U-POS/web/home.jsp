<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>U-POS | Home Page</title>
        <link rel="stylesheet" href="css/home_styles.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="icon" type="image/x-icon" href="images/ustore_logo2.png">
    </head>
    <body>

        <%
            // Set cache-control for our headers
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            response.setHeader("Pragma", "no-cache");

            response.setHeader("Expires", "0");

            if (session.getAttribute("EMP_ID") == null) {
                response.sendRedirect("login.jsp");
            }

        %>

        <div class="pageSizeErr">
            <img src="images/ustore_logo.png" alt="U-Store logo">
            <h1>U-POS Page Size Error</h1>
            <h3>The current screen size is too small for U-POS. Kindly revert the screen size to default size to continue using U-POS.</h3>
            <img src="images/algoamigos.png" alt="U-Store logo" class="algoAmigoLogo">
        </div>
        <div class="nav">
            <div class="nav-left">
                <div class="ustore_logo">
                    <img src="images/ustore_logo2.png" alt="U-Store logo">
                </div>
                <h1 class="home-title">Home</h1>
            </div> 
            <div class="nav-right">
                <div class="top">
                    <% 
                        ResultSet rs = (ResultSet) request.getAttribute("username");
                        while (rs.next()) {
                    %>
                    <h1>Welcome back, <%= rs.getString("EMP_USERNAME")%> !</h1>
                    <%
                        }
                    %>

                </div>
                <div class="bottom">
                    <h2>Admin</h2>
                    <button class="nav-button-control" onclick="redirectToPage('ActivityLog')">Logs</button>
                    <button class="nav-button-control" onclick="redirectToPage('Logout')">Logout</button>
                </div>
            </div>
        </div>
        <div class="body">
            <div class="pages-container">
                <button class="page-button-control" onclick="redirectToPage('sales.jsp')">Sales</button>
                <button class="page-button-control" onclick="redirectToPage('reports.jsp')">Reports</button>
                <button class="page-button-control" onclick="redirectToPage('exchange.jsp')">Exchange</button>
                <button class="page-button-control" onclick="redirectToPage('inventory.jsp')">Inventory</button>
                <button class="page-button-control" onclick="redirectToPage('Accounts')">Accounts</button>
                <button class="page-button-control" onclick="redirectToPage('alerts.jsp')">Alerts</button>
            </div>
        </div>

        <script>
            function redirectToPage(pageUrl) {
                window.location.href = pageUrl;
            }
        </script>
    </body>
</html>
