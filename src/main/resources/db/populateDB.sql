DELETE FROM user_roles;
DELETE FROM tasks;
DELETE FROM users;
ALTER SEQUENCE global_seq RESTART WITH 100000;

INSERT INTO users (name, email, password)
VALUES ('User', 'user@yandex.ru', '{noop}password'),
       ('Admin', 'admin@gmail.com', '{noop}admin');

INSERT INTO user_roles (role, user_id)
VALUES ('USER', 100000),
       ('ADMIN', 100001);

INSERT INTO tasks (date_time, text, short_description, name, user_id,img_path, audio_path, video_path)
VALUES ('2020-01-30 10:00:00', 'Приседания задействуют большое количество мышц, а также укрепляют их. При таких упражнениях работают квадрицепсы, передняя задняя и внутренняя поверхности бедра, ягодичная мышца, поясничная мышца, мышцы спины, а также камбаловидные и икроножные мышцы.Приседания помогают развить выносливость и силу. Если приседать 100 раз в день, то можно сжечь более 200 калорий.Приседания хорошо укрепляют сердечно-сосудистую систему, помогают похудеть, улучшить кровообращение и накачать мышцы. А чтобы выполнять их, не нужен специальный инвентарь. Приседать можно самостоятельно дома.Неоспоримым плюсом приседаний с собственным весом является минимальный риск получения травмы, в отличие от приседаний с отягощениями.Частой ошибкой при приседаниях является то, что люди неправильно разводят колени, направляя их внутрь. Это происходит из-за дисбаланса или слабых средних и малых мышц ягодиц.Обращайте внимание и на поясницу. При приседаниях до параллели пола или чуть ниже в определенный момент поясничный отдел начинает выворачиваться в обратную сторону или округляться. А при нарушении естественных изгибов позвоночника возрастает нагрузка на межпозвоночные столбы. В дальнейшем это может привести к образованию грыж или всевозможных травм. Желательно выявить причину такого «поведения» поясницы. Это может быть связано с неподвижностью голеностопного сустава или его слабостью. Также причиной этой ошибки является нерастянутая задняя поверхность бедра. В этом случае перед упражнениями необходимо делать растяжку.Правильно при приседании вниз втягивать нижние поперечные мышцы живота (то, что ниже пупка), потому что когда вы находитесь в нижней точке упражнения, создается внутрибрюшное давление. Многие ошибочно надувают живот в нижней точке, особенно женщины. Это заставляет все органы, включая матку, просаживаться вниз, что категорически неправильно. Если вы будете втягивать нижние поперечные мышцы живота, то у вас будет правильное дыхание, расправятся легкие, а органы поднимутся наверх.Нужно не забывать и про взгляд. Есть смысл смотреть чуть больше вперед и наверх. Если вы будете смотреть себе под ноги, то у вас автоматически округлится спина, что создает дополнительную нагрузку на межпозвоночные диски.При выполнении приседаний желательно следить за собой в зеркало. Это поможет заметить ключевые ошибки. Неправильное выполнение приседаний может привести к развитию геморроя, варикоза и даже к проблемам в половой жизни.Приседания с собственным весом можно выполнять практически всем, важно только знать — сколько, кому и когда. Самое главное — подходить к этому вопросу грамотно. Начинать нужно постепенно, равномерно увеличивая нагрузки. Выполнять движения плавно и медленно.Людям, у которых есть нарушения или проблемы с осанкой, стоит быть осторожными. Они наиболее часто подвержены травмам.Тем, у кого есть варикоз, геморрой, проблемы с тазобедренными суставами, ревматоидный артрит, артроз тазобедренного или коленного сустава, стоит выполнять приседания только после консультации с врачом или тренером.','Приседания задействуют большое количество мышц. Работают квадрицепсы, передняя задняя, поясничная и поверхность бедра. Развивает выносливость и силу. Помогают худеть, заниматься где угодно.', 'Присед', 100000,'img1.jpeg', 'audio1.mp3', 'video1.mp4'),

       ('2020-01-30 13:00:00', 'Трансмагестрпаыващ','Что-то о трансе', 'Транс', 100000,'img2.jpeg', 'audio2.mp3', 'video2.mp4'),
       ('2020-01-30 20:00:00', 'Мир полон загадок','Что-то о мире', 'Мир', 100000,'img3.jpeg', 'audio3.mp3', 'video3.mp4'),
       ('2020-01-31 0:00:00', 'Еда на граничное значение','Что-то о еде', 'Еда', 100000,'img4.jpeg', 'audio4.mp3', 'video4.mp4'),
       ('2020-01-31 10:00:00', 'Земля - большой шар','Что-то о земле', 'Земля', 100000,'img5.jpeg', 'audio5.mp3', 'video5.mp4'),
       ('2020-01-31 13:00:00', 'Китай одна из самых густонаселенных стран','Что-то о географии', 'Китай', 100000,'img6.webp', 'audio6.mp3', 'video6.mp4'),
       ('2020-01-31 20:00:00', 'Физика была заложена Эйнштейном фдылов фыдлво дфлы флыовлд фыовдлфыо вдлфыов длфыво дыфло вфлдыов лдфыовлд ыфовлды овлдфыовлдфы овлдфоы влдоыфвлд офылдв оыфлдв офыдлво флдыов лдфыов лдфыов лдфыов лфыовлд ','Что-то о физике', 'Физика', 100000,'img7.jpeg', 'audio7.mp3', 'video7.mp4'),
       ('2020-01-31 14:00:00', 'Администратор любит поесть в 10','Что-то об админе', 'Админ', 100001,'img8.png', 'audio8.mp3', 'video8.mp4'),
       ('2020-01-31 21:00:00', 'Победа на турнире стоила ему ног','Что-то о победе', 'Победа', 100001,'img9.jpeg', 'audio9.mp3', 'video9.mp4');