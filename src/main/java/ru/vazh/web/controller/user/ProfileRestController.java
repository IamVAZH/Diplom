package ru.vazh.web.controller.user;

import org.springframework.stereotype.Controller;
import ru.vazh.model.User;

import static ru.vazh.web.SecurityUtil.authUserId;

@Controller
public class ProfileRestController extends AbstractUserController {

    public User get() {
        return super.get(authUserId());
    }

    public void delete() {
        super.delete(authUserId());
    }

    public void update(User user) {
        super.update(user, authUserId());
    }
}