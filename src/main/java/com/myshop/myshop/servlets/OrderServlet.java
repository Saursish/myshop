/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.myshop.myshop.servlets;

import com.myshop.myshop.dao.OrderDao;
import com.myshop.myshop.dao.ProductDao;
import com.myshop.myshop.entites.OrderHistory;
import com.myshop.myshop.entites.User;
import com.myshop.myshop.helper.FactoryProvider;
import com.myshop.myshop.helper.SendMail;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Saurasish
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/OrderServlet"})
public class OrderServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            try{
                HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            
            
            
            String pId = request.getParameter("pId");
            String pName = request.getParameter("pName");
            String pQuentity = request.getParameter("pQuentity");
            String pPrice = request.getParameter("pPrice");
            String name = request.getParameter("user_name");
            String modeOfTransaction  = request.getParameter("catId");
            
            String [] pIdArr = pId.split(",");
            String [] pQuentityArr = pQuentity.split(",");
            String [] pPriceArr = pPrice.split(",");
            String [] pNameArr = pName.split(",");
            int [] productIdIntArr = new int [pIdArr.length];
            int [] productQuentityIntArr = new int [pIdArr.length];
            int amount =0;
            String message = "<h2>your order has been recived</h2><table style='border: 1px solid #ddd;padding: 8px;'><tr><th>Product Name</th><th>Product quentity</th><th>product price</th>";
           for( int i=0;i<pPriceArr.length;i++){
               int Q = Integer.parseInt(pQuentityArr[i]);
               productQuentityIntArr[i] = Q;
               productIdIntArr[i]= Integer.parseInt(pIdArr[i]);
               int p = Integer.parseInt(pPriceArr[i]);
               amount +=(p*Q);
               message=message+"<tr><td>"+pNameArr[i]+"</td><td>"+pQuentityArr[i]+"<\td><td>"+pPriceArr[i]+"</td></tr>";
           }
           message = message+"</table>";
           ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
           
            
            OrderHistory orderHistory = new OrderHistory();
            orderHistory.setModeOfTransaction(modeOfTransaction);
            orderHistory.setOrderDate(new Date());
            orderHistory.setProductId(pId);
            orderHistory.setProductName(pName);
            orderHistory.setProductPrice(pPrice);
            orderHistory.setProductQuantity(pQuentity);
            orderHistory.setAmount(amount);
            orderHistory.setUserId(user.getUserId());
           
            message = message+ "total amount is <h3>"+amount+"</h3>";
            message= message + "mode of transaction is <h3>"+modeOfTransaction+"</h3>";
            
            if(user.getUserType().equals("normal")){
                SendMail.sendEmail(message, "Order placed on myshop", user.getUserEmail(), "saurabasak90@gmail.com");

                OrderDao orderDao = new OrderDao(FactoryProvider.getFactory());
                orderDao.saveOrder(orderHistory);
                productDao.updateProduct(productIdIntArr,productQuentityIntArr );
            }
            session.setAttribute("message", "order Successful");

            response.sendRedirect("index.jsp");
            return;
            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
