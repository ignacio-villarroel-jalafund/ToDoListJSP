package com.example.todolist.controller;

import com.example.todolist.constants.TaskStatus;
import com.example.todolist.models.Task;
import com.example.todolist.services.task.TaskService;
import com.example.todolist.services.task.TaskServiceInterface;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet(name = "toDoListPut", value = "/TodoList/edit/")
public class TaskPut extends HttpServlet {
    private TaskServiceInterface taskService = TaskService.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        Task task = taskService.get(UUID.fromString(id));
        task.setTitle(req.getParameter("title"));
        task.setDescription(req.getParameter("description"));
        String newStatus = req.getParameter("status");
        String newInitialDate = req.getParameter("startDate");
        String newFinalDate = req.getParameter("targetDate");
        TaskStatus taskStatus;
        LocalDate startDate;
        LocalDate targetDate;
        try {
            taskStatus = TaskStatus.valueOf(newStatus);
            targetDate = LocalDate.parse(newFinalDate);
            startDate = LocalDate.parse(newInitialDate);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        task.setStatus(taskStatus);
        task.setStartDate(startDate);
        task.setTargetDate(targetDate);
        taskService.update(task);
        resp.sendRedirect("/");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        request.setAttribute("action", "edit");
        request.setAttribute("task", taskService.get(UUID.fromString(id)));
        request.getRequestDispatcher("/WEB-INF/pages/form.jsp").forward(request, response);
    }
}
