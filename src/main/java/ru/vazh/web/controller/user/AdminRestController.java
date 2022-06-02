package ru.vazh.web.controller.user;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.vazh.model.Role;
import ru.vazh.model.User;

import java.util.Collections;
import java.util.List;

@RequestMapping("/admin")
@Controller
public class AdminRestController extends AbstractUserController {

    @Override
    public List<User> getAll() {
        return super.getAll();
    }

    @Override
    public User get(int id) {
        return super.get(id);
    }

    @Override
    public User create(User user) {
        return super.create(user);
    }

    @Override
    @GetMapping("/delete")
    public String delete(@RequestParam("id") int id) {
        super.delete(id);
        return "redirect:/admin/users";
    }

    @GetMapping("/update")
    public String updateU(@RequestParam("id") Integer id, Model model) {
        User user = get(id);
        model.addAttribute("user", user);
        return "updateUser";
    }

    @PostMapping("/update")
    public String updateUser(@RequestParam("id") Integer id,
                             @RequestParam("name") String name,
                             @RequestParam("email") String email,
                             @RequestParam("role") String role,
                             @RequestParam("psw") String psw) {
        User user = get(id);
        user.setName(name);
        user.setEmail(email);
        if (role.equals("ADMIN")) {
            user.setRoles(Collections.singleton(Role.ADMIN));
        } else {
            user.setRoles(Collections.singleton(Role.USER));
        }
        super.update(user, user.getId());
        return "redirect:/admin/users";
    }

    @Override
    public User getByMail(String email) {
        return super.getByMail(email);
    }
}