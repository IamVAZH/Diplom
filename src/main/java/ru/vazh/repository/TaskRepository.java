package ru.vazh.repository;

import ru.vazh.model.Task;

import java.time.LocalDateTime;
import java.util.List;

public interface TaskRepository {
    // null if not found, when updated
    Task save(Task task, int userId);

    Task saveAndFlush(Task task, int userId);

    // false if not found
    boolean delete(int id, int userId);

    // null if not found
    Task get(int id, int userId);

    List<Task> getAll(int userId);

    // ORDERED dateTime desc
    List<Task> getBetweenHalfOpen(LocalDateTime startDateTime, LocalDateTime endDateTime, int userId);

}