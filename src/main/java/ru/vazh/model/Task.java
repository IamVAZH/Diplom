package ru.vazh.model;

import java.time.LocalDateTime;

public class Task {
    private Integer id;

    private final LocalDateTime dateTime;
    //Body of task
    private final String text;
    //Title of task
    private final String name;

    public Task(Integer id, LocalDateTime dateTime, String name, String text) {
        this.id = id;
        this.dateTime = dateTime;
        this.text = text;
        this.name = name;
    }

    public Task(LocalDateTime dateTime, String name, String text) {
        this(null,dateTime,text,name);
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public String getText() {
        return text;
    }

    public String getName() {
        return name;
    }

    public boolean isNew() {
        return id == null;
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