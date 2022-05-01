package ru.vazh.repository.datajpa;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import ru.vazh.model.Task;
import ru.vazh.repository.TaskRepository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public class DataJpaTaskRepository implements TaskRepository {

    private final CrudTaskRepository crudTaskRepository;

    public DataJpaTaskRepository(CrudTaskRepository crudTaskRepository) {
        this.crudTaskRepository = crudTaskRepository;
    }


    @Override
    public Task save(Task task, int userId) {
        return crudTaskRepository.save(task);
    }

    @Override
    public boolean delete(int id, int userId) {
        return false;
    }

    @Override
    public Task get(int id, int userId) {
        return null;
    }

    @Override
    public List<Task> getAll(int userId) {
        return null;
    }

    @Override
    public List<Task> getBetweenHalfOpen(LocalDateTime startDateTime, LocalDateTime endDateTime, int userId) {
        return null;
    }
}
