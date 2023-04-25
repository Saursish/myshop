<%-- 
    Document   : verification
    Created on : 22-Apr-2023, 11:26:04 am
    Author     : Saurasish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>new user</title>
        <%@include file="components/comman-css-js.jsp"%>

    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="card">
            <div class="card-body px-5" style="background-color: rgba(238, 134, 235, 0.42);">
                <h3 class="text-center my-3">Sign up here!!!</h3>
                <form action="VerificationServlet" method="post">
                    <div class="form-group">
                        <label for="name" class="form-label">OTP</label>
                        <input name="otp" type="text" class="form-control" id="name" required>
                    </div>
                    <div class="container text-center mt-3">
                        <button class="btn btn-outline-success">Register</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
