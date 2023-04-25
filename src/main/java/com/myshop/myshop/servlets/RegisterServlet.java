package com.myshop.myshop.servlets;

import com.myshop.myshop.dao.OrderDao;
import com.myshop.myshop.dao.UserDao;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.regex.*;
import com.myshop.myshop.entites.User;
import com.myshop.myshop.helper.FactoryProvider;
import com.myshop.myshop.helper.SendMail;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(name = "com.myshop.myshop.servlets.RegisterServlet", urlPatterns = {"/RegisterServlet"})
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Throwable {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession httpSession = request.getSession();
            /* TODO output your page here. You may use following sample code. */
            try {           
                
                    //getting data from the registeation form
                    String userName = request.getParameter("user_name");
                    String userEmail = request.getParameter("email");
                    String userNumber = request.getParameter("number");
                    String userPassword = request.getParameter("password");
                    String userAddress = request.getParameter("address");
                    Part part = request.getPart("userPicture");
           
                    //find path to upload pic
                    String path = request.getRealPath("img") + File.separator+"User"+File.separator+part.getSubmittedFileName();
                    FileOutputStream fileOutputStream = new FileOutputStream(path); 
                    InputStream is = part.getInputStream();
                    //reading data
                    byte [] data = new byte[is.available()];
                    is.read(data);
                    //writing the data
                    fileOutputStream.write(data);
                    fileOutputStream.close();
                    is.close();
                    
                    //validation for the password
                    String regex = "^(?=.*[a-z])(?=."
                            + "*[A-Z])(?=.*\\d)"
                            + "(?=.*[-+_!@#$%^&*., ?]).+$";
                    Pattern p = Pattern.compile(regex);

                    Matcher m = p.matcher(userPassword);

                    if (!m.matches()) {
                        httpSession.setAttribute("message", "Invalid password");
                        response.sendRedirect("register.jsp");
                        return;
                    }
                    //encoding the password 
                    Encoder encode = Base64.getEncoder();
                    String encodedPassword = encode.encodeToString(userPassword.getBytes());
                    
                    
                    //
                    String alphaNumeric ="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456987abcdefghijklmnopqrstuvwxyz";
                    String otp ="";
                    for(int i=0;i<5;i++){
                        int ind =(int)(alphaNumeric.length()*Math.random());
                        otp=otp+alphaNumeric.charAt(ind);
                    }
                    String message = "<h3>you otp for login is</h3> <h2>"+otp+"</h2>";
                    SendMail.sendEmail(message, "OTP verification", userEmail, "saurabasak90@gmail.com");
                    // creating user objects to store data
                    
                    httpSession.setAttribute("otp", otp);
                    User user = new User(userName, userEmail, encodedPassword, userNumber, part.getSubmittedFileName(), userAddress, "normal");
                    httpSession.setAttribute("registeringUser", user);
                    response.sendRedirect("verification.jsp");
                    //crate a user dao object to store data in the database
                    
            } catch (Exception e) { 
                httpSession.setAttribute("message", "try again leter");
                        response.sendRedirect("index.jsp");
                        return;
//                  e.printStackTrace();
                   
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
        try {
            processRequest(request, response);
        } catch (Throwable ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Throwable ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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

    private static class HTTPSession {

        public HTTPSession() {
        }
    }

}
