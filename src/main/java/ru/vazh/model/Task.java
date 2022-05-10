package ru.vazh.model;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
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
    //image for task
    @Column(name = "img_path")
    private String img_path;
    //Body of task
    @Column(name = "text", nullable = false)
    private String text;
    //Short description
    @Column(name = "short_description", nullable = false)
    private String shortDescription;
    //Title of task
    @Column(name = "name", nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private User user;

    @Column(name = "audio_path")
    private String audio_path;

    @Column(name = "video_path")
    private String video_path;

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

    public Task(LocalDateTime dateTime, String img_path, String text, String shortDescription, String name, User user, String audio_path, String video_path) {
        this(null,dateTime,text,name);
        this.img_path = img_path;
        this.shortDescription = shortDescription;
        this.user = user;
        this.audio_path = audio_path;
        this.video_path = video_path;
    }

    public Task(Integer id, LocalDateTime dateTime, String img_path, String text, String shortDescription, String name, User user, String audio_path, String video_path) {
        super(id);
        this.dateTime = dateTime;
        this.img_path = img_path;
        this.text = text;
        this.shortDescription = shortDescription;
        this.name = name;
        this.user = user;
        this.audio_path = audio_path;
        this.video_path = video_path;
    }

    public String getImg_path() {
        return img_path;
    }

    public void setImg_path(String img_path) {
        this.img_path = img_path;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public String getAudio_path() {
        return audio_path;
    }

    public void setAudio_path(String audio_path) {
        this.audio_path = audio_path;
    }

    public String getVideo_path() {
        return video_path;
    }

    public void setVideo_path(String video_path) {
        this.video_path = video_path;
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