<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>U-POS | Login Page </title>
        <link rel="stylesheet" href="css/login_styles.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="icon" type="image/x-icon" href="images/ustore_logo2.png">

    <div id="incorrectCreds" class="popup">
        <h1>Incorrect User Credentials</h1>
        <p>You have inputted incorrect user credentials, please try again.</p>
        <button onclick="closePopup()">Close</button>
    </div>

    <div id="deactUser" class="popup">
        <h1>Account Deactivated</h1>
        <p>Your account has been deactivated by the system. Please consult with an admin user.</p>
        <button onclick="closePopup()">Close</button>
    </div>

    <div id="successSignup" class="popup">
        <h1>Sign Up Success</h1>
        <p>You have successfully created an account. Please consult with an admin for account activation.</p>
        <button onclick="closePopup()">Close</button>
    </div>

    <div id="usernameExist" class="popup">
        <h1>Username Exist</h1>
        <p>The inputted username already exist. Please choose another one.</p>
        <button onclick="closePopup()">Close</button>
    </div>


    <div id="usernameNotExist" class="popup">
        <h1>Username Does not Exist</h1>
        <p>The inputted username does not exist. Please check the username.</p>
        <button onclick="closePopup()">Close</button>
    </div>

    <div id="successChangePass" class="popup">
        <h1>Password Change Success</h1>
        <p>You have successfully changed your account password. Please consult with an admin for account reactivation.</p>
        <button onclick="closePopup()">Close</button>
    </div>

    <div id="passwordNotMatching" class="popup">
        <h1>Password Input Not Matching</h1>
        <p>The inputted passwords do not match. Try again.</p>
        <button onclick="closePopup()">Close</button>
    </div>

    <div id="wrongAnsToSecQues" class="popup">
        <h1>Incorrect Answer To Security Question</h1>
        <p>The answer to the security question is incorrect. Try again.</p>
        <button onclick="closePopup()">Close</button>
    </div>

    <div id="overlay" onclick="closePopup()"></div>  

    <script>
        function showIncorrectCredsPopup() {
            var popup = document.getElementById('incorrectCreds');
            var overlay = document.getElementById('overlay');
            popup.style.display = 'block';
            overlay.style.display = 'block';
        }

        function showDeactUserPopup() {
            var popup = document.getElementById('deactUser');
            var overlay = document.getElementById('overlay');
            popup.style.display = 'block';
            overlay.style.display = 'block';
        }

        function closePopup() {
            var popups = document.getElementsByClassName('popup');
            var overlay = document.getElementById('overlay');
            for (var i = 0; i < popups.length; i++) {
                popups[i].style.display = 'none';
            }
            overlay.style.display = 'none';
        }

        function showSuccessPopup() {
            var popup = document.getElementById('successSignup');  // Corrected ID
            var overlay = document.getElementById('overlay');
            popup.style.display = 'block';
            overlay.style.display = 'block';
        }

        function showUsernameExistPopup() {
            var popup = document.getElementById('usernameExist');  // Corrected ID
            var overlay = document.getElementById('overlay');
            popup.style.display = 'block';
            overlay.style.display = 'block';
        }

        function showUsernameNotExistPopup() {
            var popup = document.getElementById('usernameNotExist');
            var overlay = document.getElementById('overlay');
            popup.style.display = 'block';
            overlay.style.display = 'block';
        }

        function showSuccessChangePassPopup() {
            var popup = document.getElementById('successChangePass');
            var overlay = document.getElementById('overlay');
            popup.style.display = 'block';
            overlay.style.display = 'block';
        }

        function showNotMatchingPassword() {
            var popup = document.getElementById('passwordNotMatching');
            var overlay = document.getElementById('overlay');
            popup.style.display = 'block';
            overlay.style.display = 'block';
        }

        function showWrongAnsToSecQues() {
            var popup = document.getElementById('wrongAnsToSecQues');
            var overlay = document.getElementById('overlay');
            popup.style.display = 'block';
            overlay.style.display = 'block';
        }

    </script>

    <%
        // alerts 
        Boolean incorrectCreds = (Boolean) request.getAttribute("incorrectCreds");
        Boolean addAcc = (Boolean) request.getAttribute("addedAccount");
        Boolean deactivatedEmp = (Boolean) request.getAttribute("deactivatedEmployee");
        Boolean duplicate = (Boolean) request.getAttribute("duplicate");
        Boolean userNotExistingForgotPass = (Boolean) request.getAttribute("userNotExistingForgotPass");
        Boolean passwordChanged = (Boolean) request.getAttribute("passwordChanged");

        Boolean wrongAnsToSecQues = (Boolean) request.getAttribute("wrongAnsToSecQues");
        Boolean passwordNotMatching = (Boolean) request.getAttribute("passwordNotMatching");

        if (incorrectCreds != null) {
    %>
    <script>
        showIncorrectCredsPopup();
    </script>
    <%
        }
        if (deactivatedEmp != null) {
    %>
    <script>
        showDeactUserPopup();
    </script>
    <%
        }
        if (addAcc != null) {
    %>
    <script>
        showSuccessPopup();
    </script>
    <%
        }
        if (duplicate != null) {
    %>
    <script>
        showUsernameExistPopup();
    </script>
    <%
        }
        if (userNotExistingForgotPass != null) {
    %>
    <script>
        showUsernameNotExistPopup();
    </script>
    <%
        }
        if (passwordChanged != null) {
    %>
    <script>
        showSuccessChangePassPopup();
    </script>
    <%
        }
        if (wrongAnsToSecQues != null) {
    %>
    <script>
        showWrongAnsToSecQues();
    </script>
    <%
        }
        if (passwordNotMatching != null) {
    %>
    <script>
        showNotMatchingPassword();
    </script>
    <%
        }
    %>
</head>
<body>

    <div class="pageSizeErr">
        <img src="images/ustore_logo.png" alt="U-Store logo">
        <h1>U-POS Page Size Error</h1>
        <h3>The current screen size is too small for U-POS. Kindly revert the screen size to default size to continue using U-POS.</h3>
        <img src="images/algoamigos.png" alt="U-Store logo" class="algoAmigoLogo">
    </div>
    <div class="left">
        <div class="back_button">
            <!-- <a href="login.html" class="back-link"><i class="fas fa-chevron-left"></i>Back</a> 
            -->
        </div>
        <div class="ustore_logo">
            <img src="images/ustore_logo.png" alt="U-Store logo">
        </div>
        <div class="ustore_title">
            <h1>U-POS</h1>
            <h2>U-Store's Point of Sale System</h2>
        </div>

    </div>
    <div class="right">
        <div class="login_form_div">
            <div class="head">
                <h1>Login Account</h1>
            </div>
            <div class="main">
                <form action="Login" method="post" class="login_form">
                    <input type="hidden" name="login" value="true">
                    <div class="login_form_control">
                        <label for="" class="username-input-label">Username</label>
                        <input type="text" name="username" id="username" placeholder="Input username" class="" required>
                    </div>
                    <div class="login_form_control">
                        <label for="">Password</label>
                        <input type="password" name="password" placeholder="Input password">
                        <label for=""><a href="ForgotPassword" class="forgot_pass_label" id="forgotPasswordLink" onclick="submitForm()">Forgot Password?</a></label>
                    </div>
                    <div class="login_form_control">
                        <button type="button" onclick="this.form.submit()">Login</button>
                    </div>
                </form>
                <p>
                    don't have an account? <a href="Signup">sign in here</a>
                </p>
            </div>
        </div>

        <div class="algoAmigoFooter">
            <h3>Developed by:</h3>
            <img src="images/algoamigos.png" alt="U-Store logo">
        </div>

    </div>

    <script>
        function submitForm() {
            var username = document.getElementById("username").value;

            // Redirect to the ForgotPassword servlet with the values
            var forgotPasswordLink = "ForgotPassword?uname=" + encodeURIComponent(username);
            window.location.href = forgotPasswordLink;
        }

        document.getElementById("forgotPasswordLink").addEventListener("click", function (event) {
            event.preventDefault();
            submitForm();
        });
    </script>

</body>

</html>
