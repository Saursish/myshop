package com.myshop.myshop.servlets;

import com.myshop.myshop.dao.CategoryDao;
import com.myshop.myshop.dao.ProductDao;
import com.myshop.myshop.entites.Category;
import com.myshop.myshop.entites.Product;
import com.myshop.myshop.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(name = "ProductOperationServlet", urlPatterns = {"/ProductOperationServlet"})
@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try{
            PrintWriter out = response.getWriter();
            HttpSession httpSession = request.getSession();
            String parameter = request.getParameter("operation");
            if(parameter == null){
                String productQuentityString = request.getParameter("addQuentity");
                int productQuentity =0;
                if(productQuentityString.charAt(0)=='-'){
                    productQuentity=Integer.parseInt(productQuentityString.substring(1));
                    productQuentity=-1*productQuentity;
                }
                else{
                    productQuentity = Integer.parseInt(productQuentityString);
                }
                int productDiscount = Integer.parseInt(request.getParameter("updateDiscount"));
                int productId = Integer.parseInt(request.getParameter("Id"));
                ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
                productDao.updateProduct(productId, productQuentity, productDiscount);
                //update product here
                httpSession.setAttribute("message", "Product is updated");
                response.sendRedirect("admin.jsp");
                
            }
            else{
                if(parameter.trim().equals("addCategory")){
                        // fetching caategoy data
                    String title =request.getParameter("catTitle");
                    String description = request.getParameter("catDescription");

                    //creating category object
                    Category category = new Category();
                    category.setCategoryTitle(title);
                    category.setCategoryDescription(description);
                    out.println("category saved");
                    //save to category dataabase
                    CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                    int catId = categoryDao.saveCategory(category);


                    httpSession.setAttribute("message", "Category is added ");
                    response.sendRedirect("admin.jsp");
                    return;
                }
                else if(parameter.trim().equals("addProduct")){
                    String pTitle = request.getParameter("productTitle");
                    String pDescription = request.getParameter("productDescription");
                    int pPrice = Integer.parseInt(request.getParameter("productPrice"));
                    int pDiscount = Integer.parseInt(request.getParameter("productDiscount"));
                    int pQuantity = Integer.parseInt(request.getParameter("productQuantity"));
                    Part part = request.getPart("productPicture");
                    int cId = Integer.parseInt(request.getParameter("catId"));
                    pDescription = pDescription.replaceAll("\n", "</br>");

                    //getting the perticular category by id
                    CategoryDao cDao=new CategoryDao(FactoryProvider.getFactory());
                    Category category = cDao.getCategroyById(cId);

                    //creating the product object
                    Product product = new Product(pTitle, pDescription, new Date(),null, part.getSubmittedFileName(), pPrice, pDiscount, pQuantity, category);

                    //save product to database
                    ProductDao productDao =new ProductDao(FactoryProvider.getFactory());
                    productDao.saveProduct(product);

                    //pic save


                    //find path to upload pic
                    String path = request.getRealPath("img") + File.separator+"Products"+File.separator+part.getSubmittedFileName();
                    FileOutputStream fileOutputStream = new FileOutputStream(path); 
                    InputStream is = part.getInputStream();
                    //reading data
                    byte [] data = new byte[is.available()];
                    is.read(data);
                    //writing the data
                    fileOutputStream.write(data);
                    fileOutputStream.close();
                    is.close();

                    httpSession.setAttribute("message", "Product is added");
                    response.sendRedirect("admin.jsp");
                    return;
                }   
            }
        }catch(Exception e){
            e.printStackTrace();
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
