package com.example.todolist.services.task;


import com.example.todolist.models.Task;
import com.example.todolist.repositories.task.TaskRepository;
import com.example.todolist.repositories.task.TaskRepositoryInterface;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class TaskService implements TaskServiceInterface {
    private static TaskService taskService;
    private TaskRepositoryInterface repository = TaskRepository.getInstance();
    private final int MAX_RESULTS = 6;

    private TaskService() {}

    public static TaskService getInstance() {
        if (taskService == null) {
            taskService = new TaskService();
        }
        return taskService;
    }

    @Override
    public Task create(Task object) {
        return repository.add(object);
    }

    @Override
    public Task get(UUID id) {
        return repository.get(id);
    }

    @Override
    public List<Task> getAll() {
        return repository.getAll();
    }

    @Override
    public Task update(Task object) {
        return repository.update(object);
    }

    @Override
    public Task delete(UUID id) {
        return repository.delete(id);
    }

    @Override
    public int getTotalPagination() {
        int totalTasks = repository.getAll().size();
        return (int) Math.ceil((double) totalTasks / MAX_RESULTS);
    }

    @Override
    public List<Task> getPaginatedTasks(int pageNumber) {
        List<Task> tasks = repository.getAll();

        int initialIndex = (pageNumber - 1) * MAX_RESULTS;
        int finalIndex = Math.min(initialIndex + MAX_RESULTS, tasks.size());

        if (initialIndex >= tasks.size()) {
            return new ArrayList<>();
        }

        return tasks.subList(initialIndex, finalIndex);
    }
}
