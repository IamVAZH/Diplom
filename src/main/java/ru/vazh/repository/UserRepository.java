package ru.vazh.repository;

import ru.vazh.model.User;

import java.util.List;

public interface UserRepository {
    // null if not found, when updated
    User save(User user);

    // false if not found
    boolean delete(int id);

    // null if not found
    User get(int id);

//    // null if not found
    User getByEmail(String email);

    List<User> getAll();

    User getWithTasks(int id);
}
