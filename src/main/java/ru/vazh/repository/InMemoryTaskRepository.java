package ru.vazh.repository;

import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;
import ru.vazh.model.Task;
import ru.vazh.util.TaskUtil;
import ru.vazh.util.Util;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import static ru.vazh.repository.InMemoryUserRepository.ADMIN_ID;
import static ru.vazh.repository.InMemoryUserRepository.USER_ID;

@Repository
public class InMemoryTaskRepository implements TaskRepository {
    private final Map<Integer, Map<Integer, Task>> usersTaskMap = new ConcurrentHashMap<>();
    private final AtomicInteger counter = new AtomicInteger(0);

    {
        TaskUtil.tasks.forEach(task -> save(task, USER_ID));
        save(new Task(LocalDateTime.of(2015, Month.JUNE, 1, 14, 0), "Админ ланч", "Admin_Task"), ADMIN_ID);
        save(new Task(LocalDateTime.of(2015, Month.JUNE, 1, 21, 0), "Админ ужин", "Admin_Task"), ADMIN_ID);
    }

    @Override
    public Task save(Task task, int userId) {
        // We cannot use method reference "ConcurrentHashMap::new" here. It will be equivalent wrong "new ConcurrentHashMap<>(userId)"
        Map<Integer, Task> tasks = usersTaskMap.computeIfAbsent(userId, uId -> new ConcurrentHashMap<>());
        if (task.isNew()) {
            task.setId(counter.incrementAndGet());
            tasks.put(task.getId(), task);
            return task;
        }
        return tasks.computeIfPresent(task.getId(), (id, oldTask) -> task);
    }

    @Override
    public boolean delete(int id, int userId) {
        Map<Integer, Task> meals = usersTaskMap.get(userId);
        return meals != null && meals.remove(id) != null;
    }

    @Override
    public Task get(int id, int userId) {
        Map<Integer, Task> meals = usersTaskMap.get(userId);
        return meals == null ? null : meals.get(id);
    }

    @Override
    public List<Task> getBetweenHalfOpen(LocalDateTime startDateTime, LocalDateTime endDateTime, int userId) {
        return filterByPredicate(userId, task -> Util.isBetweenHalfOpen(task.getDateTime(), startDateTime, endDateTime));
    }

    @Override
    public List<Task> getAll(int userId) {
        return filterByPredicate(userId, meal -> true);
    }

    private List<Task> filterByPredicate(int userId, Predicate<Task> filter) {
        Map<Integer, Task> meals = usersTaskMap.get(userId);
        return CollectionUtils.isEmpty(meals) ? Collections.emptyList() :
                meals.values().stream()
                        .filter(filter)
                        .sorted(Comparator.comparing(Task::getDateTime).reversed())
                        .collect(Collectors.toList());
    }
}