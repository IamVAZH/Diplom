package ru.vazh.repository.datajpa;

import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import ru.vazh.model.User;

import javax.persistence.Entity;
import javax.persistence.QueryHint;

@Transactional(readOnly = true)
public interface CrudUserRepository extends JpaRepository<User, Integer> {
    @Transactional
    @Modifying
    @Query("DELETE FROM User u WHERE u.id=:id")
    int delete(@Param("id") int id);

    //  https://docs.jboss.org/hibernate/orm/5.2/userguide/html_single/Hibernate_User_Guide.html#hql-distinct
    @QueryHints({
            @QueryHint(name = org.hibernate.jpa.QueryHints.HINT_PASS_DISTINCT_THROUGH, value = "false")
    })
    User getByEmail(String email);

    @EntityGraph(attributePaths = {"tasks"}, type = EntityGraph.EntityGraphType.LOAD)
    @Query("select u FROM User u WHERE u.id=?1")
    User getWithTasks(int id);
}
