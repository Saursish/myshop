<%@page import="com.myshop.myshop.dao.UserDao"%>
<%@page import="com.myshop.myshop.entites.Product"%>
<%@page import="com.myshop.myshop.dao.ProductDao"%>
<%@page import="com.myshop.myshop.helper.Helper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.myshop.myshop.entites.Category"%>
<%@page import="com.myshop.myshop.helper.FactoryProvider"%>
<%@page import="com.myshop.myshop.dao.CategoryDao"%>
<%@page import="com.myshop.myshop.entites.User" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        session.setAttribute("message", "Not a authorized user!! Login First");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "Not a admin... register as a admin first");
            response.sendRedirect("login.jsp");
            return;
        }
    }

    CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cDao.getCategoryList();

    Map<String, Long> map = Helper.getCount(FactoryProvider.getFactory());
    ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
    List<Product> productList = productDao.getAllProducts(null);
    
    UserDao userDao = new UserDao(FactoryProvider.getFactory());
    List<User> userList = userDao.getAllUser();

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include  file="components/comman-css-js.jsp"%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>

        <div class="container admin">
            <div class="container-fliud">
                <%@include file="components/message.jsp" %>
            </div>
        </div>

        <div class="row mt-3">

            <div class="col-md-4 text-center">
                <div class="card" data-bs-toggle="modal" data-bs-target="#showUserDetail">
                    <div class="card-body">
                        <div class="container">
                            <img style='max-width: 120px' class="img-fluid" src="img/profile.png" alt="user icon"/>
                        </div>

                        <h3><%=map.get("userCount") - 1%></h3>
                        <h2>User</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="card">
                    <div class="card-body">
                        <div class="container">
                            <img style='max-width: 120px' class="img-fluid" src="img/list.png" alt="user icon"/>
                        </div>
                        <h3><%=list.size()%></h3>
                        <h2>Category</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="card" data-bs-toggle="modal" data-bs-target="#updateProductModal">
                    <div class="card-body">
                        <div class="container">
                            <img style='max-width: 120px' class="img-fluid" src="img/package.png" alt="user icon"/>
                        </div>
                        <h3><%=map.get("productCount")%></h3>
                        <h2>Products</h2>
                    </div>
                </div>
            </div>
        </div>


        <div class="row mt-3">

            <div class="col-md-6 text-center">
                <div class="card" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                    <div class="card-body">
                        <div class="container">
                            <img style='max-width: 120px' class="img-fluid" src="img/interace.png" alt="user icon"/>
                        </div>
                        <p>click here to add new category</p> 
                        <h2 class="text-muted">Add Category</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-6 text-center">
                <div class="card" data-bs-toggle="modal" data-bs-target="#addProductModal">
                    <div class="card-body">
                        <div class="container">
                            <img style='max-width: 120px' class="img-fluid" src="img/plus.png" alt="user icon"/>
                        </div>

                        <p>click here to add new products</p>
                        <h2 class="text-muted">Add Products</h2>
                    </div>
                </div> 
            </div>
        </div>
    </div>
    <!-- Modal for category-->
    <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header custom-bg text-white">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Add Category</h>
                </div>
                <div class="modal-body">
                    <form action="ProductOperationServlet" method="post" >
                        <input type="hidden" name="operation" value="addCategory">
                        <div class="form-group">
                            <input type="text" class="form-control"  name="catTitle" placeholder="Enter Category title" required/>
                        </div>
                        <div class="form-group">
                            <textarea class="form-control mt-2" placeholder="Enter cataeogory description" name="catDescription" required></textarea>
                        </div>
                        <div class="container text-center mt-2">
                            <button class="btn btn-outline btn-success">Add Category</button>
                            <button type="reset" value="Reset" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--modal for product-->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header custom-bg text-white">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Add Product</h>
                </div>
                <div class="modal-body">
                    <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="operation" value="addProduct">
                        <div class="form-group">
                            <input type="text" class="form-control"  name="productTitle" placeholder="Enter Product title" required/>
                        </div>
                        <div class="form-group">
                            <textarea class="form-control mt-2 text-area" placeholder="Enter Product description" name="productDescription" required></textarea>
                        </div>
                        <div class="form-group mt-2">
                            <input type="number" class="form-control"  name="productPrice" placeholder="Enter Product price" required/>
                        </div>
                        <div class="form-group mt-2">
                            <input type="number" class="form-control"  name="productDiscount" placeholder="Enter Product discount" required/>
                        </div>
                        <div class="form-group mt-2">
                            <input type="number" class="form-control"  name="productQuantity" placeholder="Enter Product quantity" required/>
                        </div>

                        <div class="form-group mt-2">
                            <select name="catId" class="form-control">
                                <%                                        for (Category c : list) {
                                %>
                                <option value="<%=c.getCategoryId()%>"><%=c.getCategoryTitle()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>

                        <div class="form-group mt-2">
                            <label for="productPicture">Select picture for product</label>
                            <input type="file" class="form-control"  name="productPicture" required/>
                        </div>

                        <div class="container text-center mt-2">
                            <button class="btn btn-outline btn-success">Add Product</button>
                            <button type="reset" value="Reset" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--modal for product update-->
    <div class="modal fade" id="updateProductModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header custom-bg text-white">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Update Quantity</h>
                </div>
                <div class="modal-body">
                    <%            for (Product product : productList) {
                    %>
                    <form action="ProductOperationServlet" method="post">
                        <div class="row">

                            <div class="form-groupt mt-2 col-2">
                                <input name="Id" type="number" class="form-control" value="<%=product.getProductId()%>" readonly="readonly"/>
                            </div>


                            <div class="form-group mt-2 col-4">
                                <input name="productName" type="text" class="form-control" value="<%=product.getProductName()%>" readonly="readonly"/>
                            </div>

                            <div class="form-group mt-2 col-2">
                                <input name="addQuentity" type="number" class="form-control" placeholder="<%=product.getProductQuantity()%>" requied/>
                            </div>
                            
                            <div class="form-group mt-2 col-2">
                                <input name="updateDiscount" type="number" class="form-control" placeholder="<%=product.getProductDiscount()%>%" required/>
                            </div>
                       
                            <div class="container text-center mt-2 col-1">
                                <button class="btn btn-outline btn-success">Add</button>
                            </div>
                         </div>
                    </form>
                    <%}%>
                    <div class="container text-center mt-2 col-1">
                    <button type="reset" value="Reset" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
   <!--modal to show all users information-->
   <div class="modal fade" id="showUserDetail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header custom-bg text-white">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Update Quantity</h>
                </div>
                <div class="modal-body">
                    <%            for (User user2 : userList) {
                                        if(!user2.getUserType().equals("admin")){
                    %>
                    <form action="ProductOperationServlet" method="post">
                        <div class="row">

                            <div class="form-groupt mt-2 col-4">
                                <div class="card-body">
                            <img src="img/User/<%=user.getUserPic()%>" class="card-img-top rounded mx-auto d-block mt-2" style="max-height:50px;max-width: 50px" alt="nothing">
                        </div>
                            </div>


                            <div class="form-group mt-2 col-4">
                                <input name="userName" type="text" class="form-control" value="<%=user2.getUserName()%>" readonly="readonly"/>
                            </div>

                            <div class="form-group mt-2 col-4">
                                <input name="userEmail" type="text" class="form-control" value="<%=user2.getUserEmail()%>" readonly="readonly"/>
                            </div>
                         </div>
                    </form>
                    <%}}%>
                    <div class="container text-center mt-2 col-1">
                    <button type="reset" value="Reset" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="components/modal.jsp"%>
</body>
</html>
