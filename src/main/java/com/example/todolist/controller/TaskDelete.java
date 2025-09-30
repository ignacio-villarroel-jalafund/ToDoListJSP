package com.example.todolist.controller;

import com.example.todolist.models.Task;
import com.example.todolist.services.task.TaskService;
import com.example.todolist.services.task.TaskServiceInterface;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "toDoDelete", value = "/TodoList/delete/")
public class TaskDelete extends HttpServlet {
    private static TaskServiceInterface taskService = TaskService.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        System.out.println("id: " + id);
        Task task = taskService.get(UUID.fromString(id));
        if (task != null) {
            System.out.println(task.getTitle());
            taskService.delete(task.getId());
        }
        resp.sendRedirect("/");
    }
}
