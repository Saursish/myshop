<%-- 
    Document   : product
    Created on : 02-Apr-2023, 1:13:20 pm
    Author     : Saurasish
--%>

<%@page import="com.myshop.myshop.entites.Product"%>
<%@page import="com.myshop.myshop.dao.ProductDao"%>
<%@page import="com.myshop.myshop.helper.FactoryProvider"%>
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
        <%            int productId = Integer.parseInt(request.getParameter("id"));
            ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
            Product product = productDao.getProductById(productId);
        %>
        <div class="container">
            <div class="row mt-3">
                <div class="col-6">
                    <img src="img/Products/<%=product.getProductPhoto()%>" class="card-img-top rounded mx-auto d-block mt-2" style="height:300px;width: 300px" alt="nothing">
                </div>
                <div class="col-6">
                    <!--product name, description, price-->
                    <h3><%=product.getProductName()%></h3>
                    <div class="container">
                        <h4>Description</h4>
                        <div class="mt-2">
                            <p><%=product.getProductDescription()%></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <!--big description of the product and add to cart-->
                <div class="col-6 text-center mt-4">
                    <div><span class="calculated-price1">&#8377;<%=product.getPriceIncludingDiscount()%></span>
                        <%
                            if (product.getProductDiscount() != 0) {
                        %>
                        <span class="discount"><%=product.getProductDiscount()%>% off</span>
                        <%}%>
                        </div>
                        <%
                            if (product.getProductDiscount() != 0) {
                        %>

                    <div class="actual-price1">&#8377;<%=product.getProductPrice()%></div>
                    <%}%>
                </div>
                <div class="col-6 mt-4 text-center">
                    <button class="btn btn-success text-white btn-lg" onclick="addToCart(<%=product.getProductId()%>, '<%=product.getProductName()%>',<%=product.getPriceIncludingDiscount()%>,<%=product.getProductQuantity()%>)">Add to cart</button>
                </div>
            </div>
        </div>
                <%@include file="components/modal.jsp"%>
    </body>
</html>
