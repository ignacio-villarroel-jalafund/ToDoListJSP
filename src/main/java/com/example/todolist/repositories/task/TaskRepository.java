package com.example.todolist.repositories.task;

import com.example.todolist.database.connection.DatabaseConnection;
import com.example.todolist.models.Task;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.hibernate.Session;

import java.util.*;

public class TaskRepository implements TaskRepositoryInterface {
    private static TaskRepository taskRepository;
    private Session session;

    private TaskRepository() {
        session = DatabaseConnection.getSessionFactory().openSession();
    }

    public static TaskRepository getInstance() {
        if (taskRepository == null) {
            taskRepository = new TaskRepository();
        }
        return taskRepository;
    }

    @Override
    public Task add(Task object) {
        EntityManager em = session.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        transaction.begin();
        em.persist(object);
        transaction.commit();
        em.close();
        return object;
    }

    @Override
    public Task get(UUID id) { return session.find(Task.class, id); }

    @Override
    public List<Task> getAll() {
        return (List<Task>) session.createQuery("from Task").list();
    }

    @Override
    public Task update(Task object) {
        Task itemToUpdate = get(object.getId());
        if (itemToUpdate == null){
           return null;
        }

        itemToUpdate.setDescription(object.getDescription());
        itemToUpdate.setTitle(object.getTitle());
        itemToUpdate.setStatus(object.getStatus());
        itemToUpdate.setTargetDate(object.getTargetDate());

        session.beginTransaction();
        session.merge(itemToUpdate);
        session.getTransaction().commit();

        return itemToUpdate;
    }

    @Override
    public Task delete(UUID id) {
        Task taskToDelete = get(id);
        if (taskToDelete != null){
            EntityManager em = session.getEntityManagerFactory().createEntityManager();
            EntityTransaction transaction = em.getTransaction();
            transaction.begin();
            em.remove(taskToDelete);
            transaction.commit();
            em.close();
        }
        return null;
    }
}
