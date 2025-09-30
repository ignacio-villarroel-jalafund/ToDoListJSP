package com.example.todolist.services;

import java.util.List;
import java.util.UUID;

public interface Service<T> {
    public T create(T object);
    public T get(UUID id);
    public List<T> getAll();
    public T update(T object);
    public T delete(UUID id);
}
