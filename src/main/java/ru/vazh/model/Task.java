package ru.vazh.model;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Entity
@Table(name = "tasks", uniqueConstraints = {@UniqueConstraint(columnNames = {"user_id", "date_time"}, name = "tasks_unique_user_datetime_idx")})
public class Task extends AbstractBaseEntity {


    @Column(name = "date_time", nullable = false)
    @NotNull
    private LocalDateTime dateTime;
    //Body of task
    @Column(name = "text", nullable = false)
    private String text;
    //Title of task
    @Column(name = "name", nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private User user;

    public Task(Integer id, LocalDateTime dateTime, String name, String text) {
        super(id);
        this.dateTime = dateTime;
        this.text = text;
        this.name = name;
    }

    public Task(LocalDateTime dateTime, String name, String text) {
        this(null, dateTime, text, name);
    }

    public Task() {
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public void setDateTime(LocalDateTime dateTime) {
        this.dateTime = dateTime;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getText() {
        return text;
    }

    public String getName() {
        return name;
    }

    public LocalTime getTime() {
        return dateTime.toLocalTime();
    }

    @Override
    public String toString() {
        return "Meal{" +
                "id=" + id +
                ", dateTime=" + dateTime +
                ", description='" + getName() + '\'' +
                ", calories=" + getText() +
                '}';
    }
}