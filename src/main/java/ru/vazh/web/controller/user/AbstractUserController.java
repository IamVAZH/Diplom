package ru.vazh.web.controller.user;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import ru.vazh.model.User;
import ru.vazh.service.UserService;

import java.util.List;

import static ru.vazh.util.ValidationUtil.assureIdConsistent;
import static ru.vazh.util.ValidationUtil.checkNew;


public abstract class AbstractUserController {
    protected final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    private UserService service;

    public List<User> getAll() {
        log.info("getAll");
        return service.getAll();
    }

    public User get(int id) {
        log.info("get {}", id);
        return service.get(id);
    }

    public User create(User user) {
        log.info("create {}", user);
        checkNew(user);
        return service.create(user);
    }

    public String delete(int id) {
        log.info("delete {}", id);
        service.delete(id);
        return null;
    }

    public String update(User user, int id) {
        service.update(user);
        return null;
    }

    public User getByMail(String email) {
        log.info("getByEmail {}", email);
        return service.getByEmail(email);
    }
}