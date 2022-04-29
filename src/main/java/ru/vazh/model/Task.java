package ru.vazh.model;

import java.time.LocalDateTime;
import java.time.LocalTime;

public class Task extends AbstractBaseEntity {
    private final LocalDateTime dateTime;
    //Body of task
    private final String text;
    //Title of task
    private final String name;

    public Task(Integer id, LocalDateTime dateTime, String name, String text) {
        super(id);
        this.dateTime = dateTime;
        this.text = text;
        this.name = name;
    }

    public Task(LocalDateTime dateTime, String name, String text) {
        this(null, dateTime, text, name);
    }

    public LocalDateTime getDateTime() {
        return dateTime;
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