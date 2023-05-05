<%@page import="com.myshop.myshop.entites.User"%>
<%
    User user1 = (User) session.getAttribute("currentUser");
%>

<nav class="navbar navbar-expand-lg navbar-dark custom-bg">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">myshop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">

                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#" data-bs-toggle="modal" data-bs-target="#cart"> <i class="bi bi-cart-fill" style="font-size: 20px;"></i><span class="cart-number"></span> </a>
                </li>

                <%
                    if (user1 == null) {
                %>

                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="register.jsp">Register</a>
                </li>
            </ul>
            <%
            } else if (user1.getUserType().equals("normal")) {
            %> 
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="normal.jsp"><%= user1.getUserName()%></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="LogoutServlet">Logout</a>
                </li>       
            </ul>

            <%
            } else {
            %>
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="admin.jsp"><%= user1.getUserName()%></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="LogoutServlet">Logout</a>
                </li>
            </ul>

            <%
                }
            %>
            <form class="d-flex" method="post" action="index.jsp">
                <input class="form-control me-2" type="text" name="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-success" type="submit">Search</button>
            </form>
        </div>
    </div>
</nav>
