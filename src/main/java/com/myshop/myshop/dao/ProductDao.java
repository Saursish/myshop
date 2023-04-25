/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.myshop.myshop.dao;

import com.myshop.myshop.entites.Product;
import java.util.Date;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ProductDao {
    private final SessionFactory factory;
    
    public ProductDao(SessionFactory factory){
        this.factory=factory;
    }
    
    //save product in data base;
    public int saveProduct(Product product){
        Session session = factory.openSession();
        Transaction t = session.beginTransaction();
       int productId = (int) session.save(product);
       t.commit();
       session.close();
       return productId;
    }
    //get all products 
    public List<Product> getAllProducts(){
        Session s = factory.openSession();
        Query q = s.createQuery("from Product");
        List<Product> list;
        list = q.list();
        return list;
    }
    //get all products by id
    public List<Product> getAllProductByCategory(int cId){
        Session s = factory.openSession();
        Query q = s.createQuery("from Product as p where p.category.categoryId =: id");
        q.setParameter("id", cId);
        List<Product> list;
        list = q.list();
        return list;
    }
    
    public Product getProductById(int productId){
        Session s = factory.openSession();
        Query q = s.createQuery("from Product as p where p.productId =: id");
        q.setParameter("id", productId);
        List<Product> list;
        list = q.list();
        return list.get(0);
    }
    
    //Update product Quantity
    public void updateProduct(int [] productIds, int [] productQuentities){
        Date date = new Date(); 
        Session session = factory.openSession();
        for(int i=0;i<productIds.length;i++){
            Product p = getProductById(productIds[i]);
            int newQuentity = p.getProductQuantity()-productQuentities[i];
            
            
            Transaction t = session.beginTransaction();
            Query q= session.createQuery("update Product set productQuantity=:q, modificationDate=:d where productId =: id");
            q.setParameter("q", newQuentity);
            q.setParameter("d", date);
            q.setParameter("id", productIds[i]);
            int statud = q.executeUpdate();
            t.commit();
            
        }
        session.close();
    }
    
    public void updateProduct(int productId, int productQuentity, int productDiscount){
        Product p = getProductById(productId);
        int newQuentity = p.getProductQuantity()+productQuentity;
        Date date= new Date();
        Session session = factory.openSession();
        Transaction t = session.beginTransaction();
        Query q= session.createQuery("update Product set productQuantity=:q, modificationDate=:d, productDiscount=:dis where productId =: id");
        q.setParameter("q", newQuentity);
        q.setParameter("d", date);
        q.setParameter("id", productId);
        q.setParameter("dis", productDiscount);
        int statud = q.executeUpdate();

        t.commit();
        session.close();
    }
}
