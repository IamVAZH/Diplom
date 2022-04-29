package ru.vazh.service;

import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;
import ru.vazh.model.Task;
import ru.vazh.repository.TaskRepository;

import java.time.LocalDate;
import java.util.List;

import static ru.vazh.util.DateTimeUtil.atStartOfDayOrMin;
import static ru.vazh.util.DateTimeUtil.atStartOfNextDayOrMax;
import static ru.vazh.util.ValidationUtil.checkNotFoundWithId;

@Service
public class TaskService {

    private final TaskRepository repository;

    public TaskService(TaskRepository repository) {
        this.repository = repository;
    }

    public Task get(int id, int userId) {
        return checkNotFoundWithId(repository.get(id, userId), id);
    }

    public void delete(int id, int userId) {
        checkNotFoundWithId(repository.delete(id, userId), id);
    }

    public List<Task> getBetweenInclusive(@Nullable LocalDate startDate, @Nullable LocalDate endDate, int userId) {
        return repository.getBetweenHalfOpen(atStartOfDayOrMin(startDate), atStartOfNextDayOrMax(endDate), userId);
    }

    public List<Task> getAll(int userId) {
        return repository.getAll(userId);
    }

    public void update(Task meal, int userId) {
        checkNotFoundWithId(repository.save(meal, userId), meal.getId());
    }

    public Task create(Task meal, int userId) {
        return repository.save(meal, userId);
    }
}
