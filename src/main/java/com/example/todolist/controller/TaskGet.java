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
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Set;

@WebServlet(name = "todoList", value = "/TodoList")
public class TaskGet extends HttpServlet {
    private TaskServiceInterface taskService = TaskService.getInstance();
    private Validator validator;

    @Override
    public void init() throws ServletException {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

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

        title = title.trim();
        description = description.trim();

        String cleanedTitle = Jsoup.clean(title, Safelist.none());
        String cleanedDescription = Jsoup.clean(description, Safelist.none());

        Task task = Task.builder().title(cleanedTitle).description(cleanedDescription).status(taskStatus)
                .startDate(startDate).targetDate(targetDate).build();
        Set<ConstraintViolation<Task>> violations = validator.validate(task);
        if (!violations.isEmpty()) {
            req.setAttribute("errors", violations);
            req.getRequestDispatcher("/WEB-INF/pages/form.jsp").forward(req, resp);
            return;
        }

        taskService.create(task);
        req.getSession().setAttribute("popUpMessage", "Task created successfully");
        req.getSession().setAttribute("popUpType", "success");
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
