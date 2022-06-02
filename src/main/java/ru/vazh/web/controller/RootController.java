package ru.vazh.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import ru.vazh.AuthUser;
import ru.vazh.model.Task;
import ru.vazh.model.User;
import ru.vazh.service.TaskService;
import ru.vazh.service.UserService;
import ru.vazh.web.SecurityUtil;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.List;

@Controller
public class RootController {
    @Autowired
    private TaskService taskService;
    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/")
    public String root() {
        return "index";
    }

    @GetMapping("/conseption")
    public String conseption() {
        return "conseption2";
    }

    @GetMapping("/audio")
    public String audio(HttpServletRequest request, Model model) {
        model.addAttribute("id", Integer.parseInt(request.getParameter("id")));
        model.addAttribute("savedAudio", taskService.getAudioPath(Integer.parseInt(request.getParameter("id")), SecurityUtil.authUserId()));
        return "audio2";
    }

    @PostMapping("/createAudio")
    public String createAudio(HttpServletRequest request, Model model) {
        Task task = taskService.create(new Task(LocalDateTime.now(),
                        "default.jpeg",
                        request.getParameter("name"),
                        "",
                        request.getParameter("text"),
                        null,
                        "default.mp3",
                        "default.mp4"),
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
        return "tasks";
    }


    @PostMapping("/audio")
    public void saveAudio(@RequestParam MultipartFile audio, @RequestParam Integer id) {
        taskService.saveAudio(audio, id);
    }

    @GetMapping("/video")
    public String video(HttpServletRequest request, Model model) {
        model.addAttribute("id", Integer.parseInt(request.getParameter("id")));
        model.addAttribute("savedVideo", taskService.getVideoPath(Integer.parseInt(request.getParameter("id")), SecurityUtil.authUserId()));
        return "video2";
    }

    @PostMapping("/video")
    public void saveVideo(@RequestParam MultipartFile video, @RequestParam Integer id) {
        taskService.saveVideo(video, id);
    }

    @GetMapping("/tasks")
    public String tasks(Model model) {
//        AuthUser.safeGet();
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
        return "redirect:/tasks";
    }

    @GetMapping("/img")
    public String img(HttpServletRequest request, Model model) {
        model.addAttribute("id", Integer.parseInt(request.getParameter("id")));
        model.addAttribute("savedImg", taskService.getImgPath(Integer.parseInt(request.getParameter("id")), SecurityUtil.authUserId()));
        return "img2";
    }

    @PostMapping("/img")
    public String img(@RequestParam MultipartFile image, @RequestParam Integer id) {
        taskService.saveImg(image, id);
        return "redirect:/tasks";
    }

    @GetMapping("/t")
    public String t() {
        return "t";
    }

    @GetMapping("/registration")
    public String registration(ModelMap model) {
        model.addAttribute("user", new User());
        model.addAttribute("register", true);
        return "profile";
    }

    @PostMapping("/registration")
    public String saveRegister(@Validated User user, BindingResult result, SessionStatus status, ModelMap model) {
        if (result.hasErrors()) {
            model.addAttribute("register", true);
            return "profile";
        }
        status.setComplete();
        userService.create(user);
        status.setComplete();
        return "redirect:/login?message=Registered&username=" + user.getEmail();
    }

    @GetMapping("/profile")
    public String profile(ModelMap model) {
        model.put("user", SecurityUtil.safeGet().getUser());
        return "profile";
    }

    @PostMapping("/profile")
    public String updateProfile(@Valid User user, BindingResult result, SessionStatus status) {
        if (result.hasErrors()) {
            return "profile";
        } else {
            userService.update(user);
            SecurityUtil.get().update(user);
            status.setComplete();
            return "redirect:/tasks";
        }
    }

    @GetMapping("/admin/users")
    public String getAllUsers(Model model) {
        model.addAttribute("users", userService.getAll());
        return "users";
    }


}
