package com.example.todolist.repositories;

import java.util.List;

public interface Repository<T> {
    public T add(T object);
    public T get(String id);
    public List<T> getAll();
    public T update(T object);
    public T delete(String id);
}
