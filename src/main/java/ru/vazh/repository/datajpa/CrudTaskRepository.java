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


    List<Task> getAllByUserId(int userId);

    @Modifying
    @Transactional
    @Query("DELETE FROM Task t WHERE t.id=:id AND t.user.id=:userId")
    int delete(@Param("id") int id, @Param("userId") int userId);

}