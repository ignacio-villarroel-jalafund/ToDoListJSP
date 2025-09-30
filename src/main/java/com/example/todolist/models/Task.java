package com.example.todolist.models;

import com.example.todolist.constants.TaskStatus;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "tasks")
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Task {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(columnDefinition = "UUID", updatable = false, nullable = false)
    private UUID id;

    @NotBlank(message = "Tittle is required")
    @Size(max = 100, message = "Title can't surpass 100 characters.")
    private String title;

    @Size(max = 1000, message = "Description can't surpass 1000 characters.")
    private String description;

    @Enumerated(EnumType.STRING)
    private TaskStatus status;

    @Column(name = "start_date")
    private LocalDate startDate;
    @Column(name = "target_date")
    private LocalDate targetDate;
}
