package com.example.todolist.services;

import java.util.List;

public interface Service<T> {
    public T create(T object);
    public T get(String id);
    public List<T> getAll();
    public T update(T object);
    public T delete(String id);
}
