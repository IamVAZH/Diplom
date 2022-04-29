package ru.vazh.repository;

import org.springframework.stereotype.Repository;
import ru.vazh.model.Task;
import ru.vazh.util.TaskUtil;

import java.util.Collection;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

@Repository
public class InMemoryTaskRepository implements TaskRepository {
    private final Map<Integer, Task> repository = new ConcurrentHashMap<>();
    private final AtomicInteger counter = new AtomicInteger(0);

    {
        TaskUtil.tasks.forEach(this::save);
    }

    @Override
    public Task save(Task task) {
        if (task.isNew()) {
            task.setId(counter.incrementAndGet());
            repository.put(task.getId(), task);
            return task;
        }
        // handle case: update, but not present in storage
        return repository.computeIfPresent(task.getId(), (id, oldTask) -> task);
    }

    @Override
    public boolean delete(int id) {
        return repository.remove(id) != null;
    }

    @Override
    public Task get(int id) {
        return repository.get(id);
    }

    @Override
    public Collection<Task> getAll() {
        return repository.values();
    }
}
