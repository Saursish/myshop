<%-- 
    Document   : register
    Created on : 29-Jan-2023, 10:12:21 pm
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
        <div class="container-fluid">

            <div class="row mt-5">
                <div class="col-md-4 offset-md-4">

                    <%@include file="components/message.jsp" %>
                    <div class="card">

                        <div class="card-body px-5" style="background-color: rgba(238, 134, 235, 0.42);">
                            <h3 class="text-center my-3">Sign up here!!!</h3>
                            <form action="RegisterServlet" method="post" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="name" class="form-label">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="name" placeholder="Your Name" required>
                                </div>

                                <div class="form-group">
                                    <label for="email" class="form-label">User Email</label>
                                    <input name="email" type="email" class="form-control" id="email" placeholder="youremail@example.com" required>
                                </div>

                                <div class="form-group">
                                    <label for="number" class="form-label">Phone Number</label>
                                    <input name="number" type="number" class="form-control" id="number" placeholder="123456789" required>
                                </div>
                                    
                                <div class="form-group">
                                    <label for="userPicture" class="form-label">Picture</label>
                                    <input name="userPicture" type="file" class="form-control" id="userPicture" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="password" class="form-label">Password</label>
                                    <input name="password" type="password" class="form-control" id="password" required>
                                    <div>
                                        <ul><li>use atleast 1 small case letter</li>
                                            <li>use atleast 1 capital letter</li>
                                            <li>do not use spaces</li>
                                            <li>use atleast 1 number</li>
                                            <li> use atleat 1 special character</li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="address" class="form-label">User Address</label>
                                    <textarea name="address" class="form-control text-area" style="height:200px" required></textarea>
                                </div>

                                <div class="container text-center mt-3">
                                    <button class="btn btn-outline-success">Register</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
