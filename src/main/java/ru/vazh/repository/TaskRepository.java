package ru.vazh.repository;

import ru.vazh.model.Task;

import java.util.Collection;

public interface TaskRepository {
    // null if not found, when updated
    Task save(Task meal);

    // false if not found
    boolean delete(int id);

    // null if not found
    Task get(int id);

    Collection<Task> getAll();
}
