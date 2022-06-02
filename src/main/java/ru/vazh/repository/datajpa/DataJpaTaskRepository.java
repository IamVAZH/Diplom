package ru.vazh.repository.datajpa;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import ru.vazh.model.Task;
import ru.vazh.repository.TaskRepository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public class DataJpaTaskRepository implements TaskRepository {

    private final CrudTaskRepository crudTaskRepository;

    private final CrudUserRepository crudUserRepository;

    public DataJpaTaskRepository(CrudTaskRepository crudTaskRepository, CrudUserRepository crudUserRepository) {
        this.crudTaskRepository = crudTaskRepository;
        this.crudUserRepository = crudUserRepository;
    }

    @Override
    public boolean delete(int id, int userId) {
        return crudTaskRepository.delete(id, userId) != 0;
    }

    @Override
    public Task get(int id, int userId) {
        return crudTaskRepository.findById(id)
                .filter(task -> task.getUser().getId() == userId)
                .orElse(null);
    }

    @Override
    public List<Task> getAll(int userId) {
        return crudTaskRepository.getAllByUserId(userId);
    }

    @Override
    public List<Task> getBetweenHalfOpen(LocalDateTime startDateTime, LocalDateTime endDateTime, int userId) {
        return null;
    }

    @Transactional
    public Task save(Task task, int userId) {
        if (!task.isNew() && get(task.getId(), userId) == null) {
            return null;
        }
        task.setUser(crudUserRepository.getOne(userId));
        return crudTaskRepository.save(task);
    }

    @Transactional
    public Task saveAndFlush(Task task, int userId) {
        if (!task.isNew() && get(task.getId(), userId) == null) {
            return null;
        }
        task.setUser(crudUserRepository.getOne(userId));
        return crudTaskRepository.saveAndFlush(task);
    }
}
