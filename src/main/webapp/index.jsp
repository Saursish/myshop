<%-- 
    Document   : index
    Created on : 15-Jan-2023, 5:18:46 pm
    Author     : Saurasish
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.myshop.myshop.helper.Helper"%>
<%@page import="org.hibernate.cfg.annotations.HCANNHelper"%>
<%@page import="com.myshop.myshop.entites.Category"%>
<%@page import="com.myshop.myshop.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.myshop.myshop.entites.Product"%>
<%@page import="com.myshop.myshop.entites.User"%>
<%@page import="com.myshop.myshop.dao.ProductDao"%>
<%@page import="com.myshop.myshop.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>myshop</title>
        <%@include file="components/comman-css-js.jsp"%>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="row mx-2 mt-2">
            <%                String cat = request.getParameter("category");
                List<Product> list = new ArrayList<>();
                ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
                if (cat == null || cat.trim().equals("all")) {
                    list = productDao.getAllProducts();
                } else {
                    int cid = Integer.parseInt(cat.trim());
                    list = productDao.getAllProductByCategory(cid);
                }
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                List<Category> catList = categoryDao.getCategoryList();
            %>
            <!--show category--> 
            <div class="col-md-2">
                <div class="list-group">
                    <a href="index.jsp?category=all" class="list-group-item list-group-item-action active" aria-current="true">
                        Categories
                    </a>
                    <%
                        for (Category category : catList) {%>

                    <a href="index.jsp?category=<%=category.getCategoryId()%>" class="list-group-item list-group-item-action"><%=category.getCategoryTitle()%></a>
                    <%
                        }
                    %>
                </div>
            </div> 
            <div class="col-md-10">
                <div class="row row-cols-1 row-cols-md-3 g-4">
                    <%
                        for (Product product : list) {
                            if (product.getProductQuantity() > 0) {
                    %>
                    <div class="col mt-4">
                        <div class="card product-card">
                            <div onclick="location.href = 'product.jsp?id=<%=product.getProductId()%>'">
                                <img src="img/Products/<%=product.getProductPhoto()%>" class="card-img-top rounded mx-auto d-block mt-2" style="max-height:210px;max-width: 210px" alt="nothing">
                                <div class="card-body">
                                    <h5 class="card-title">  <%=product.getProductName()%></h5>
                                    <p class="card-text"> <%=Helper.get10Words(product.getProductDescription())%> </p>
                                </div>
                            </div>
                            <div>
                                <div><span class="calculated-price">&#8377;<%=product.getPriceIncludingDiscount()%></span>
                                    <%
                                        if (product.getProductDiscount() != 0) {
                                    %>
                                    <span class="discount"><%=product.getProductDiscount()%>% off</span>
                                    <%}%>
                                </div>
                                <%
                                    if (product.getProductDiscount() != 0) {
                                %>

                                <div class="actual-price">&#8377;<%=product.getProductPrice()%></div>
                                <%}%>
                                <button class="btn btn-success text-white" onclick="addToCart(<%=product.getProductId()%>, '<%=product.getProductName()%>',<%=product.getPriceIncludingDiscount()%>,<%=product.getProductQuantity()%>)">Add to cart</button>
                            </div>
                        </div>
                    </div>
                    <%}
                        }%>
                </div>
            </div>
        </div>
        <%@include file="components/modal.jsp"%>
    </body>
</html>
