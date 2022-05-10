package ru.vazh.web.controller.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.vazh.model.Task;
import ru.vazh.service.TaskService;
import ru.vazh.util.TaskUtil;
import ru.vazh.web.SecurityUtil;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Objects;

import static ru.vazh.util.ValidationUtil.assureIdConsistent;
import static ru.vazh.util.ValidationUtil.checkNew;
import static ru.vazh.web.controller.task.TaskRestController.REST_URL;

@Controller
@RequestMapping(REST_URL)
public class TaskRestController{
    private static final Logger log = LoggerFactory.getLogger(TaskRestController.class);

    static final String REST_URL = "/tasks";
    private final TaskService service;

    public TaskRestController(TaskService service) {
        this.service = service;
    }

    @GetMapping("/open")
    public String open(HttpServletRequest request, Model model) {
        model.addAttribute("task", get(getId(request)));
        return "taskForm";
    }

    public Task get(int id) {
        int userId = SecurityUtil.authUserId();
        log.info("get meal {} for user {}", id, userId);
        return service.get(id, userId);
    }

    private int getId(HttpServletRequest request) {
        String paramId = Objects.requireNonNull(request.getParameter("id"));
        return Integer.parseInt(paramId);
    }
}
