package ru.vazh.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ru.vazh.model.Task;
import ru.vazh.repository.InMemoryTaskRepository;
import ru.vazh.repository.TaskRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Objects;

public class TaskServlet extends HttpServlet {
    private static final Logger log = LoggerFactory.getLogger(TaskServlet.class);

    private TaskRepository repository;

    @Override
    public void init() {
        repository = new InMemoryTaskRepository();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");

        Task task = new Task(id.isEmpty() ? null : Integer.valueOf(id),
                LocalDateTime.parse(request.getParameter("dateTime")),
                request.getParameter("name"),
                request.getParameter("text"));

        log.info(task.isNew() ? "Create {}" : "Update {}", task);
        repository.save(task, SecurityUtil.authUserId());
        response.sendRedirect("tasks");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action == null ? "all" : action) {
            case "delete":
                int id = getId(request);
                log.info("Delete {}", id);
                repository.delete(id, SecurityUtil.authUserId());
                response.sendRedirect("tasks");
                break;
            case "create":
            case "update":
                final Task task = "create".equals(action) ?
                        new Task(LocalDateTime.now().truncatedTo(ChronoUnit.MINUTES), "", "New_Task") :
                        repository.get(getId(request), SecurityUtil.authUserId());
                request.setAttribute("task", task);
                request.getRequestDispatcher("/taskForm.jsp").forward(request, response);
                break;
            case "all":
            default:
                log.info("getAll");
                request.setAttribute("tasks", repository.getAll(SecurityUtil.authUserId()));
                request.getRequestDispatcher("/tasks.jsp").forward(request, response);
                break;
        }
    }

    private int getId(HttpServletRequest request) {
        String paramId = Objects.requireNonNull(request.getParameter("id"));
        return Integer.parseInt(paramId);
    }
}
