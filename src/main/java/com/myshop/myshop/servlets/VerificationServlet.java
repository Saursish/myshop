/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.myshop.myshop.servlets;

import com.myshop.myshop.dao.UserDao;
import com.myshop.myshop.entites.User;
import com.myshop.myshop.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "VerificationServlet", urlPatterns = {"/VerificationServlet"})
public class VerificationServlet extends HttpServlet {

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
        HttpSession httpSession = request.getSession();
        try {
            PrintWriter out = response.getWriter();
            /* TODO output your page here. You may use following sample code. */

            User user = (User) httpSession.getAttribute("registeringUser");
            String setOtp = (String) httpSession.getAttribute("otp");
            String getOtp = request.getParameter("otp");
            if (getOtp.equals(setOtp)) {
                UserDao userDao = new UserDao(FactoryProvider.getFactory());
                userDao.saveUser(user);
                httpSession.setAttribute("message", "Registation Successful");
                response.sendRedirect("login.jsp");
                httpSession.removeAttribute("registeringUser");
                return;
            } else {
                httpSession.setAttribute("message", "Registration faild for wrong otp");
                response.sendRedirect("register.jsp");
                httpSession.removeAttribute("registeringUser");
                return;
            }

        } catch (Exception e) {
            httpSession.setAttribute("message", "Already log in with this email id");

            response.sendRedirect("login.jsp");
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
