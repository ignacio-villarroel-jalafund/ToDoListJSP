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
import java.util.List;

@WebServlet(name = "todoList", value = "/TodoList")
public class TaskGet extends HttpServlet {
    private TaskServiceInterface taskService = TaskService.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String status = req.getParameter("status");
        String initialDate = req.getParameter("startDate");
        String finalDate = req.getParameter("targetDate");
        TaskStatus taskStatus;
        LocalDate startDate;
        LocalDate targetDate;
        try {
            taskStatus = TaskStatus.valueOf(status);
            targetDate = LocalDate.parse(finalDate);
            startDate = LocalDate.parse(initialDate);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        taskService.create(new Task(title, description, taskStatus, startDate, targetDate));
        resp.sendRedirect("/");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int currentPage = 1;
        String page = request.getParameter("page");
        if (page != null) {
            currentPage = Integer.parseInt(page);
        }

        List<Task> tasks = taskService.getPaginatedTasks(currentPage);
        int totalPageNumber = taskService.getTotalPagination();

        request.setAttribute("tasks", tasks);
        request.setAttribute("page", currentPage);
        request.setAttribute("totalPageNumber", totalPageNumber);
        request.getRequestDispatcher("/WEB-INF/pages/index.jsp").forward(request, response);
    }
}
