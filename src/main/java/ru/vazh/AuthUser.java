package ru.vazh;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import ru.vazh.model.AbstractBaseEntity;
import ru.vazh.model.Role;
import ru.vazh.model.User;

import java.io.Serial;
import java.util.Collections;
import java.util.Set;

public class AuthUser extends org.springframework.security.core.userdetails.User {
    @Serial
    private static final long serialVersionUID = 1L;

    private User user;

    public AuthUser(User user) {
        super(user.getEmail(), user.getPassword(), user.isEnabled(), true, true, true, user.getRoles());
        this.user = new User(user.getId(), user.getName(), user.getEmail(), user.getPassword());
    }

    public int getId() {
        return user.id();
    }

    public void update(User newU) {
        user = newU;
    }

    public User getUser() {
        return user;
    }

    @Override
    public String toString() {
        return user.toString();
    }
}
