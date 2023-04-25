package com.myshop.myshop.servlets;

import com.myshop.myshop.dao.UserDao;
import com.myshop.myshop.entites.User;
import java.util.Base64.Encoder;
import com.myshop.myshop.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           HttpSession httpSession = request.getSession();
            
            
            String email=request.getParameter("email");
            String password = request.getParameter("password");
            
            //validation
            String regex = "^(?=.*[a-z])(?=."
                       + "*[A-Z])(?=.*\\d)"
                       + "(?=.*[-+_!@#$%^&*., ?]).+$";
                Pattern p = Pattern.compile(regex);

                Matcher m = p.matcher(password);

                if (!m.matches()){
                    httpSession.setAttribute("message", "Invalid password");
                    response.sendRedirect("login.jsp");
                    return;
                }
                
            //authenticate user
            Encoder encode = Base64.getEncoder();
            String newPassword = encode.encodeToString(password.getBytes());
            UserDao  userDao = new UserDao(FactoryProvider.getFactory());
            User user = userDao.getUserByEmailAndPassword(email, newPassword);
            
            
            if(user == null){
                httpSession.setAttribute("message", "Invalid details");
                response.sendRedirect("login.jsp");
                return;
            }
            else{
                httpSession.setAttribute("currentUser", user);
                if(user.getUserType().equals("admin"))
                    response.sendRedirect("admin.jsp");
                else
                    response.sendRedirect("normal.jsp");
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
