<%-- 
    Document   : search
    Created on : 02-May-2023, 10:15:08 pm
    Author     : Saurasish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String reg = request.getParameter("search");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>myshop</title>
        <%@include file="components/comman-css-js.jsp"%>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <h1>Hello World!</h1>
        <h1><%=reg %></h1>
    </body>
</html>
