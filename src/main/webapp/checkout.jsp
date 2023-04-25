<%-- 
    Document   : checkout
    Created on : 01-Apr-2023, 12:34:46 pm
    Author     : Saurasish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.myshop.myshop.entites.User" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        session.setAttribute("message", "Login to order the products");
        response.sendRedirect("login.jsp");
        return;}
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="components/comman-css-js.jsp"%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Out</title>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container">
            <div class ="row mt-5">
                <div class="col-6">
                    <div class="card-body">
                        <h3>Cart Items</h3>
                        <div class="cart-body">
                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <!--form details-->
                    <div class="card">
                        <div class="card-header" style="background-color: rgba(238, 134, 235, 0.42);">Delivery Details</div>
                        <div class="card-body" style="background-color: rgba(238, 134, 235, 0.42);">
                            <form action="OrderServlet" method="post">
                                <div class="form-group">
                                    <label for="name" class="form-label">Name</label>
                                    <input name="user_name" type="text" class="form-control" id="name" value="<%=user.getUserName()%>" aria-describedby="emailHelp" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="number" class="form-label">Phone Number</label>
                                    <input name="number" type="number" class="form-control" id="number" value="<%=user.getUserPhone()%>" aria-describedby="emailHelp" required>
                                </div>

                                <div class="form-group">
                                    <label for="address" class="form-label">Address</label>
                                    <textarea name="address" class="form-control text-area" style="height:200px" required><%=user.getUserAddress()%></textarea>
                                </div>

                                <div class="form-group">
                                    <label for="address" class="form-label">Payment Option</label>
                                    <select name="catId" class="form-control">
                                        <option value="Cash on Delivery">Cash on Delivery</option>
                                        <option value="online Pay">Online pay</option>
                                    </select>  
                                </div>
                                
                                <input class="pId" name="pId" type="hidden"/>
                                <input class="pName" name="pName" type="hidden"/>
                                <input class="pQuentity" name="pQuentity" type="hidden"/>
                                <input class="pPrice" name="pPrice" type="hidden"/>
                                
                                <div class="container text-center mt-3">
                                    <button class="btn btn-outline-success order-btn" onclick="deleteStorage()">Order</button>
                                </div>
                            </form>
                                
                                <button class="btn btn-outline-primary order-btn" onclick="continueShopping()">Continue Shopping</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
