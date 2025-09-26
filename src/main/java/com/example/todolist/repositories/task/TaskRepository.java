package com.example.todolist.repositories.task;

import com.example.todolist.models.Task;

import java.util.*;

public class TaskRepository implements TaskRepositoryInterface {
    private static Map<String, Task> tasks = new LinkedHashMap<>();

    @Override
    public Task add(Task object) {
        tasks.put(object.getId(), object);
        return object;
    }

    @Override
    public Task get(String id) { return tasks.get(id); }

    @Override
    public List<Task> getAll() {
        return new ArrayList<>(tasks.values());
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

        tasks.replace(itemToUpdate.getId(), itemToUpdate);

        return itemToUpdate;
    }

    @Override
    public Task delete(String id) {
        return tasks.remove(id);
    }
}
