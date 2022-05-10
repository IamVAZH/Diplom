package ru.vazh.service;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.web.multipart.MultipartFile;
import ru.vazh.model.Task;
import ru.vazh.model.User;
import ru.vazh.repository.TaskRepository;
import ru.vazh.repository.UserRepository;
import ru.vazh.web.SecurityUtil;

import javax.servlet.http.HttpServlet;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import static ru.vazh.util.ValidationUtil.checkNotFoundWithId;

@Service
public class TaskService extends HttpServlet {

    private final TaskRepository taskRepository;

    private final UserRepository userRepository;

    public TaskService(TaskRepository repository, UserRepository userRepository) {
        this.taskRepository = repository;
        this.userRepository = userRepository;
    }

    public Task get(int id, int userId) {
        return checkNotFoundWithId(taskRepository.get(id, userId), id);
    }

    public void delete(int id, int userId) {
        checkNotFoundWithId(taskRepository.delete(id, userId), id);
    }

    public List<Task> getAll(int userId) {
        return taskRepository.getAll(userId);
    }

    public void updateForm(LocalDateTime date, String name, String text, int id, String shortDescription) {
        int userId = SecurityUtil.authUserId();
        Task repTask = taskRepository.get(id, userId);
        repTask.setDateTime(date);
        repTask.setName(name);
        repTask.setText(text);
        repTask.setShortDescription(shortDescription);
        taskRepository.save(repTask, userId);
    }

    public void saveVideo(MultipartFile file, Integer id) {
        if (file != null) {
            File uploadDir = new File("/Users/valerijzarkov/Downloads/Diplom/src/main/webapp/resources/files/video");
            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();
            String longPath = "/Users/valerijzarkov/Downloads/Diplom/src/main/webapp/";
            Task task = get(id, SecurityUtil.authUserId());
            try {
                file.transferTo(new File(uploadDir + "/" + resultFileName));
                if (Files.exists(Paths.get(longPath + task.getVideo_path()))) {
                    Files.delete(Paths.get(longPath + task.getVideo_path()));
                }
                task.setVideo_path("resources/files/video/" + resultFileName);
                taskRepository.save(task, SecurityUtil.authUserId());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void saveVideo2(MultipartFile file, Integer id) {
        if (file != null) {
            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();
            String longPath = "/Users/valerijzarkov/Downloads/Diplom/src/main/webapp/";
            Task task = get(id, SecurityUtil.authUserId());
            try {
                file.transferTo(new File("/Users/valerijzarkov/Downloads/Diplom/src/main/webapp/resources/files/video" + "/" + resultFileName));
                if (Files.exists(Paths.get(longPath + task.getVideo_path()))) {
                    Files.delete(Paths.get(longPath + task.getVideo_path()));
                }
                task.setVideo_path("resources/files/video/" + resultFileName);
                taskRepository.save(task, SecurityUtil.authUserId());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void saveAudio(MultipartFile file, Integer id) {
        if (file != null) {
            File uploadDir = new File("/Users/valerijzarkov/Downloads/Diplom/src/main/webapp/resources/files/audio");
            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();
            String longPath = "/Users/valerijzarkov/Downloads/Diplom/src/main/webapp/";
            Task task = get(id, SecurityUtil.authUserId());
            try {
                file.transferTo(new File(uploadDir + "/" + resultFileName));
                if (Files.exists(Paths.get(longPath + task.getAudio_path()))) {
                    Files.delete(Paths.get(longPath + task.getAudio_path()));
                }
                task.setAudio_path("resources/files/audio/" + resultFileName);
                taskRepository.save(task, SecurityUtil.authUserId());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public String getVideoPath(int id, int userId) {
        Task task = checkNotFoundWithId(taskRepository.get(id, userId), id);
        return task.getVideo_path();
    }

    public String getAudioPath(int id, int userId) {
        Task task = checkNotFoundWithId(taskRepository.get(id, userId), id);
        return task.getAudio_path();
    }

    public String getImgPath(int id, int userId) {
        Task task = checkNotFoundWithId(taskRepository.get(id, userId), id);
        return task.getImg_path();
    }

    public void saveImg(MultipartFile file, Integer id) {
        if (file != null) {
            Task task = get(id, SecurityUtil.authUserId());
            File uploadDir = new File("/Users/valerijzarkov/Downloads/Diplom/src/main/webapp/resources/files/images");
            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();
            String longPath = "/Users/valerijzarkov/Downloads/Diplom/src/main/webapp/";
            try {
                file.transferTo(new File(uploadDir + "/" + resultFileName));
                if (Files.exists(Paths.get(longPath + task.getImg_path()))) {
                    Files.delete(Paths.get(longPath + task.getImg_path()));
                }
                task.setImg_path("resources/files/images/" + resultFileName);
                taskRepository.save(task, SecurityUtil.authUserId());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public Task create(Task task, int userId) {
        Assert.notNull(task, "task must not be null");
        return taskRepository.save(task, userId);
    }

    public void setShortDescription(Integer id, String shortDescription, int userId) {
        Task task = taskRepository.get(id,userId);
        task.setShortDescription(shortDescription);
        taskRepository.save(task,userId);
    }
}
