/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.myshop.myshop.dao;

import com.myshop.myshop.entites.OrderHistory;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

/**
 *
 * @author Saurasish
 */
public class OrderDao {
    private final SessionFactory factory;
    public OrderDao(SessionFactory factory) {
        this.factory=factory;
    }
    
    public void saveOrder(OrderHistory orderHistoy){
        Session openSession = factory.openSession();
        Transaction beginTransaction = openSession.beginTransaction();
        openSession.save(orderHistoy);
        beginTransaction.commit();
        openSession.close();
    }
    
    public List<OrderHistory> getOrderByUserId(int userId){
        Session s = factory.openSession();
        Query q = s.createQuery("from OrderHistory as o where o.userId =: id");
        q.setParameter("id", userId);
        List<OrderHistory> list;
        list = q.list();
        s.close();
        return list;
    }
    
    public void deleteOrderByUserId(int userId){
        Session session = factory.openSession();
        Transaction t = session.beginTransaction();
        Query q = session.createQuery("delete from OrderHistory where userId =: id");
        q.setParameter("id", userId);
        int status = q.executeUpdate();
        t.commit();
        session.close();
    }
}
