package com.myshop.myshop.dao;

import com.myshop.myshop.entites.User;
import java.util.List;


import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UserDao {
    
    private final SessionFactory factory;
    public UserDao(SessionFactory factory) {
        this.factory=factory;
    }
    
    //save the user
    public int saveUser(User user){
        Session openSession = factory.openSession();
        Transaction beginTransaction = openSession.beginTransaction();
        int userId = (int) openSession.save(user);
        beginTransaction.commit();
        openSession.close();
        return userId;
    }
    
    //get all user
     public List<User> getAllUser(){
        Session s = factory.openSession();
        Query q = s.createQuery("from User");
        List<User> list;
        list = q.list();
        return list;
    }
    
    //get the user
    public User getUserByEmailAndPassword(String email, String password){
        User user = null;
        
        try{
            String query="from User where userEmail =: e and userPassword =: p";
            Session session = factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            q.setParameter("p", password);
            
            user = (User) q.uniqueResult();
            
            
            session.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
        
        
        return user;
  
    }
    
    //update user detail
    public void updateUser(int userId, String address){
        Session session = factory.openSession();
        Transaction t = session.beginTransaction();
        Query q = session.createQuery("update User set userAddress=: a where userId =: id");
        q.setParameter("a", address);
        q.setParameter("id", userId);
        int status = q.executeUpdate();
        t.commit();
        session.close();
    }
    //delete user
    public void deleteUser(int userId){
        Session session = factory.openSession();
        Transaction t = session.beginTransaction();
        Query q = session.createQuery("delete from User where userId =: id");
        q.setParameter("id", userId);
        int status = q.executeUpdate();
        t.commit();
        session.close();
    }
    
}
