package ru.vazh.repository.datajpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import ru.vazh.model.Task;

import java.time.LocalDateTime;
import java.util.List;
@Transactional(readOnly = true)
public interface CrudTaskRepository extends JpaRepository<Task, Integer> {

}