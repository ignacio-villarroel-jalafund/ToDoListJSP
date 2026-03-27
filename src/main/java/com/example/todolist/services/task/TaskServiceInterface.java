package com.example.todolist.services.task;

import com.example.todolist.models.Task;
import com.example.todolist.services.Service;

import java.util.List;

public interface TaskServiceInterface extends Service<Task> {
    public int getTotalPagination();
    public List<Task> getPaginatedTasks(int pageNumber);
}
