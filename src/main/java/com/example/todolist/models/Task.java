package com.example.todolist.models;

import com.example.todolist.constants.TaskStatus;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.UUID;

public class Task {
    @Getter
    private final String id;

    @Getter @Setter
    private String title;

    @Getter @Setter
    private String description;

    @Getter @Setter
    private TaskStatus status;

    @Getter @Setter
    private LocalDate startDate;

    @Getter @Setter
    private LocalDate targetDate;

    public Task(String title, String description, TaskStatus status, LocalDate startDate, LocalDate targetDate) {
        this.id = UUID.randomUUID().toString();
        this.title = title;
        this.description = description;
        this.status = status;
        this.startDate = startDate;
        this.targetDate = targetDate;
    }
}
