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

@WebServlet(name = "toDoDelete", value = "/TodoList/delete/")
public class TaskDelete extends HttpServlet {
    private static TaskServiceInterface taskService = TaskService.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Task task = taskService.get(req.getParameter("id"));
        if (task != null) {
            taskService.delete(task.getId());
        }
        resp.sendRedirect("/");
    }
}
