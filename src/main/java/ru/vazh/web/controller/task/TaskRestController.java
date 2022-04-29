package ru.vazh.web.controller.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import ru.vazh.model.Task;
import ru.vazh.service.TaskService;
import ru.vazh.util.TaskUtil;
import ru.vazh.web.SecurityUtil;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import static ru.vazh.util.ValidationUtil.assureIdConsistent;
import static ru.vazh.util.ValidationUtil.checkNew;

@Controller
public class TaskRestController {
    private static final Logger log = LoggerFactory.getLogger(TaskRestController.class);

    private final TaskService service;

    public TaskRestController(TaskService service) {
        this.service = service;
    }

    public Task get(int id) {
        int userId = SecurityUtil.authUserId();
        log.info("get meal {} for user {}", id, userId);
        return service.get(id, userId);
    }

    public void delete(int id) {
        int userId = SecurityUtil.authUserId();
        log.info("delete meal {} for user {}", id, userId);
        service.delete(id, userId);
    }

    public List<Task> getAll() {
        int userId = SecurityUtil.authUserId();
        log.info("getAll for user {}", userId);
        return service.getAll(userId);
    }

    public Task create(Task meal) {
        int userId = SecurityUtil.authUserId();
        checkNew(meal);
        log.info("create {} for user {}", meal, userId);
        return service.create(meal, userId);
    }

    public void update(Task meal, int id) {
        int userId = SecurityUtil.authUserId();
        assureIdConsistent(meal, id);
        log.info("update {} for user {}", meal, userId);
        service.update(meal, userId);
    }

    /**
     * <ol>Filter separately
     * <li>by date</li>
     * <li>by time for every date</li>
     * </ol>
     */
    public List<Task> getBetween(@Nullable LocalDate startDate, @Nullable LocalTime startTime,
                                 @Nullable LocalDate endDate, @Nullable LocalTime endTime) {
        int userId = SecurityUtil.authUserId();
        log.info("getBetween dates({} - {}) time({} - {}) for user {}", startDate, endDate, startTime, endTime, userId);

        List<Task> mealsDateFiltered = service.getBetweenInclusive(startDate, endDate, userId);
        return TaskUtil.getFilteredTos(mealsDateFiltered, startTime, endTime);
    }
}
