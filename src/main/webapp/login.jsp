
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>myshop</title>
        <%@include file="components/comman-css-js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                     <%@include file="components/message.jsp" %>
                    <div class="card mt-3">
                        <div class="card-header" style="background-color: rgba(245, 39, 244, 0.84)">
                            <h3>Login</h3>
                        </div>
                        <div class="card-body" style="background-color: rgba(238, 134, 235, 0.42);">
                            <form action="LoginServlet" method="post">
                                <div class="mb-3">
                                  <label for="exampleInputEmail1" class="form-label">Email address</label>
                                  <input name = "email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" required>
                                </div>
                                <div class="mb-3">
                                  <label for="exampleInputPassword1" class="form-label">Password</label>
                                  <input name="password" type="password" class="form-control" id="exampleInputPassword1" required>
                                </div>
                                <a href="register.jsp">Sign in</a>
                                <div class="container text-center mt-3">
                                <button type="submit" class="btn btn-primary">Submit</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
