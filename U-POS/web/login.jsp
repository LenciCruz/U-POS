<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form method="post" action="Login">
            <input type="hidden" name="login" value="true">
            <input type="text" placeholder="Enter Username" name="uname" required>
            <input type="password" placeholder="Enter Password" name="pass" required>
            
            <button type="submit">Login</button>
        </form>
    </body>
</html>
