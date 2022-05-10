DELETE FROM user_roles;
DELETE FROM tasks;
DELETE FROM users;
ALTER SEQUENCE global_seq RESTART WITH 100000;

INSERT INTO users (name, email, password)
VALUES ('User', 'user@yandex.ru', 'password'),
       ('Admin', 'admin@gmail.com', 'admin'),
       ('Guest', 'guest@gmail.com', 'guest');

INSERT INTO user_roles (role, user_id)
VALUES ('USER', 100000),
       ('ADMIN', 100001);

INSERT INTO tasks (date_time, text, short_description, name, user_id,img_path, audio_path, video_path)
VALUES ('2020-01-30 10:00:00', 'География наука всей земли','Что-то о географии', 'География', 100000,'resources/files/images/img1.jpeg', 'resources/files/audio/audio1.mp3', 'resources/files/video/video1.mp4'),
       ('2020-01-30 13:00:00', 'Трансмагестрпаыващ','Что-то о трансе', 'Транс', 100000,'resources/files/images/img2.jpeg', 'resources/files/audio/audio2.mp3', 'resources/files/video/video2.mp4'),
       ('2020-01-30 20:00:00', 'Мир полон загадок','Что-то о мире', 'Мир', 100000,'resources/files/images/img3.jpeg', 'resources/files/audio/audio3.mp3', 'resources/files/video/video3.mp4'),
       ('2020-01-31 0:00:00', 'Еда на граничное значение','Что-то о еде', 'Еда', 100000,'resources/files/images/img4.jpeg', 'resources/files/audio/audio4.mp3', 'resources/files/video/video4.mp4'),
       ('2020-01-31 10:00:00', 'Земля - большой шар','Что-то о земле', 'Земля', 100000,'resources/files/images/img5.jpeg', 'resources/files/audio/audio5.mp3', 'resources/files/video/video5.mp4'),
       ('2020-01-31 13:00:00', 'Китай одна из самых густонаселенных стран','Что-то о географии', 'Китай', 100000,'resources/files/images/img6.webp', 'resources/files/audio/audio6.mp3', 'resources/files/video/video6.mp4'),
       ('2020-01-31 20:00:00', 'Физика была заложена Эйнштейном','Что-то о физике', 'Физика', 100000,'resources/files/images/img7.jpeg', 'resources/files/audio/audio7.mp3', 'resources/files/video/video7.mp4'),
       ('2020-01-31 14:00:00', 'Администратор любит поесть в 10','Что-то об админе', 'Администратор', 100001,'resources/files/images/img8.png', 'resources/files/audio/audio8.mp3', 'resources/files/video/video8.mp4'),
       ('2020-01-31 21:00:00', 'Победа на турнире стоила ему ног','Что-то о победе', 'Победа', 100001,'resources/files/images/default.jpeg', 'resources/files/audio/default.mp3', 'resources/files/video/default.mp4');