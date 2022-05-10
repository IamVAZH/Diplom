package ru.vazh.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.vazh.model.Task;
import ru.vazh.model.User;
import ru.vazh.service.TaskService;
import ru.vazh.web.SecurityUtil;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;

@Controller
public class RootController {
    @Autowired
    private TaskService taskService;

    @GetMapping("/")
    public String root() {
        return "index";
    }

    @GetMapping("/conseption")
    public String conseption() {
        return "conseption";
    }

    @GetMapping("/audio")
    public String audio(HttpServletRequest request, Model model) {
        model.addAttribute("id", Integer.parseInt(request.getParameter("id")));
        model.addAttribute("savedAudio", taskService.getAudioPath(Integer.parseInt(request.getParameter("id")), SecurityUtil.authUserId()));
        return "audio";
    }

    @PostMapping("/createAudio")
    public String createAudio(HttpServletRequest request, Model model) {
        Task task = taskService.create(new Task(LocalDateTime.now(),
                        "resources/files/default/default.jpeg",
                        request.getParameter("text"),
                        "",
                        request.getParameter("name"),
                        null,
                        "resources/files/default/default.mp3",
                        "resources/files/default/default.mp4"),
                SecurityUtil.authUserId());
        model.addAttribute("id", task.getId());
        return "createAudio";
    }

    @PostMapping("/createVideo")
    public String createVideo(@RequestParam MultipartFile audio, @RequestParam String shortDescription, @RequestParam Integer id) {
        saveAudio(audio, id);
        taskService.setShortDescription(id, shortDescription, SecurityUtil.authUserId());
        return "createVideo";
    }

    @GetMapping("/createVideo")
    public String createVid(@RequestParam Integer id, Model model) {
        model.addAttribute("id", id);
        return "createVideo";
    }

    @PostMapping("/createDone")
    public String createDone(@RequestParam MultipartFile video, @RequestParam Integer id) {
        saveVideo(video, id);
        return "redirect:tasks";
    }

    @PostMapping("/audio")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void saveAudio(@RequestParam MultipartFile audio, @RequestParam Integer id) {
        taskService.saveAudio(audio, id);
    }

    @GetMapping("/video")
    public String video(HttpServletRequest request, Model model) {
        model.addAttribute("id", Integer.parseInt(request.getParameter("id")));
        model.addAttribute("savedVideo", taskService.getVideoPath(Integer.parseInt(request.getParameter("id")), SecurityUtil.authUserId()));
        return "video";
    }

    @PostMapping("/video")
    public void saveVideo(@RequestParam MultipartFile video, @RequestParam Integer id) {
        taskService.saveVideo(video, id);
    }

    @GetMapping("/tasks")
    public String tasks(Model model) {
        model.addAttribute("tasks", taskService.getAll(SecurityUtil.authUserId()));
        return "tasks";
    }

    @PostMapping("/tasks")
    public String saveTask(HttpServletRequest request) {
        LocalDateTime date = LocalDateTime.parse(request.getParameter("dateTime"));
        String name = request.getParameter("name");
        String taskText = request.getParameter("taskText");
        String shortDescription = request.getParameter("shortDescription");
        int id = Integer.parseInt(request.getParameter("id"));
        taskService.updateForm(date, name, taskText, id, shortDescription);
        return "redirect:tasks";
    }

    @GetMapping("/tutorial")
    public String tutorial() {
        return "tutorial";
    }

    @GetMapping("/img")
    public String img(HttpServletRequest request, Model model) {
        model.addAttribute("id", Integer.parseInt(request.getParameter("id")));
        model.addAttribute("savedImg", taskService.getImgPath(Integer.parseInt(request.getParameter("id")), SecurityUtil.authUserId()));
        return "img";
    }

    @PostMapping("/img")
    public String img(@RequestParam MultipartFile image, @RequestParam Integer id) {
        taskService.saveImg(image, id);
        return "redirect:tasks";
    }

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

}
