
package com.myshop.myshop.dao;

import com.myshop.myshop.entites.Category;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;


public class CategoryDao {

    private final SessionFactory factory;
    public CategoryDao(SessionFactory factory) {
        this.factory=factory;
    }
    
    //save datas to data base
    public int saveCategory(Category category){
        Session openSession = factory.openSession();
        Transaction beginTransaction = openSession.beginTransaction();
        int id = (int) openSession.save(category);
        beginTransaction.commit();
        openSession.close();
        return id;
    }
    //list of all categories
    public List<Category> getCategoryList(){
        Session session = factory.openSession();
        Query q= session.createQuery("from Category");
        List<Category> list =q.list();
        session.close();
        return list;
    }
    
    //get category by id
    public Category getCategroyById(int id){
        Session session = factory.openSession();
        Category category=session.get(Category.class, id);
        session.close();
        return category;
    }

}
