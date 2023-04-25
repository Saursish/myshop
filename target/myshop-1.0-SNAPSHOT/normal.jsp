<%@page import="com.myshop.myshop.entites.OrderHistory"%>
<%@page import="java.util.List"%>
<%@page import="com.myshop.myshop.entites.User"%>
<%@page import="com.myshop.myshop.helper.FactoryProvider"%>
<%@page import="com.myshop.myshop.dao.OrderDao"%>
<%
    User user= (User) session.getAttribute("currentUser");
    if(user==null){
        session.setAttribute("message", "Not a authorized user!! Login First");
        response.sendRedirect("login.jsp");
        return;
    }
    else{
        if(user.getUserType().equals("admin")){
            session.setAttribute("message","Not a admin... register as a admin first");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <%@include  file="components/comman-css-js.jsp"%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>myshop</title>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container">
            <div class ="row">
                <div class="col-4">
                    <!--for picture-->
                    <div class="card mt-4">
                        <div class="card-body">
                            <img src="img/User/<%=user.getUserPic()%>" class="card-img-top rounded mx-auto d-block mt-2" style="max-height:210px;max-width: 210px" alt="nothing">
                        </div>
                    </div>
                </div>
                <div class="col-8">
                    <!--for details-->
                    <div class="card mt-4">
                        <div class="card-header">
                            User Details
                        </div>
                        <div class="cadr-body px-5" style="background-color: rgba(238, 134, 235, 0.42);">
                            <form action="UserUpdate" method="post">
                                <div class="form-group">
                                    <label for="name" class="form-label">Name</label>
                                    <input name="user_name" type="text" class="form-control" id="name" placeholder="Your Name" value="<%=user.getUserName()%>" disabled/>
                                </div>

                                <input name="userId" type="hidden" class="form-control" value="<%=user.getUserId()%>"/>
                                <input name="deleteId"  type= "hidden" id="userDelete" value="0"/>
                              
                                <div class="form-group">
                                    <label for="email" class="form-label">Email</label>
                                    <input name="email" type="email" class="form-control" id="email" placeholder="youremail@example.com" value="<%=user.getUserEmail() %>" disabled/>
                                </div>

                                <div class="form-group">
                                    <label for="number" class="form-label">Phone Number</label>
                                    <input name="number" type="number" class="form-control" id="number" placeholder="123456789" value="<%=user.getUserPhone() %>" disabled>
                                </div>
                                <div class="form-group">
                                    <label for="address" class="form-label">Address</label>
                                    <textarea name="address" class="form-control text-area" style="height:200px" ><%=user.getUserAddress()%></textarea>
                                </div>
                                <div class="container text-center mt-3">
                                    <button class="btn btn-outline-success">Update</button>
                                    <button class="btn btn-danger" onclick="changeUserDeletevalue()">Delete Account</button>
                                </div>
                            </form>
                                
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <table class='table'>
            <thead class='thread-light'>
                <tr>
                <th>Order Date </th>
                <th>Product </th>
                <th>Price </th>
                <th>Quantity</th>
                <th>Mode of Transaction</th>
                <th>Total Price</th>              
                </tr>
            </thead>
                    <%
                                       int userId = user.getUserId();
                                       OrderDao orderDao = new OrderDao(FactoryProvider.getFactory());
                                       List<OrderHistory> orderHistoryList = orderDao.getOrderByUserId(userId);
                                       if(orderHistoryList != null){
                                          for(OrderHistory order: orderHistoryList){
                                          String product = order.getProductName().replaceAll(",", "<br>");
                                          String quentity = order.getProductQuantity().replaceAll(",", "<br>");
                                          String price =order.getProductPrice().replaceAll(",", "<br>");
                    %>
                    <tbody>
                        <tr>
                            <td>
                                <%=order.getOrderDate()%>
                            </td>
                            <td><%=product%></td>
                            <td><%=price%></td>
                            <td><%=quentity%></td>
                            <td><%=order.getModeOfTransaction()%></td>
                            <td><%=order.getAmount()%></td>
                        </tr>
                    </tbody>                              
                                          
                    <%
                                        }
                                        }
                    %>
            </div>
        </div>
        <%@include file="components/modal.jsp"%>
    </body>
</html>
