package com.example.todolist.repositories;

import java.util.List;
import java.util.UUID;

public interface Repository<T> {
    public T add(T object);
    public T get(UUID id);
    public List<T> getAll();
    public T update(T object);
    public T delete(UUID id);
}
