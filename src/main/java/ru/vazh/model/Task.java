package ru.vazh.model;

import java.time.LocalDateTime;

public class Task {
    private final LocalDateTime dateTime;
    //Body of task
    private final String text;
    //Title of task
    private final String name;

    public Task(LocalDateTime dateTime, String text, String name) {
        this.dateTime = dateTime;
        this.text = text;
        this.name = name;
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
}