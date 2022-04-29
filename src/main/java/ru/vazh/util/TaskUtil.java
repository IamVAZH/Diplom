package ru.vazh.util;

import ru.vazh.model.Task;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class TaskUtil {

    public static final List<Task> tasks = Arrays.asList(
            new Task(LocalDateTime.of(2020, Month.JANUARY, 30, 10, 0), "Завтрак", "Task1"),
            new Task(LocalDateTime.of(2020, Month.JANUARY, 30, 13, 0), "Обед", "Task2"),
            new Task(LocalDateTime.of(2020, Month.JANUARY, 30, 20, 0), "Ужин", "Task3"),
            new Task(LocalDateTime.of(2020, Month.JANUARY, 31, 0, 0), "Еда на граничное значение", "Task4"),
            new Task(LocalDateTime.of(2020, Month.JANUARY, 31, 10, 0), "Завтрак", "Task5"),
            new Task(LocalDateTime.of(2020, Month.JANUARY, 31, 13, 0), "Обед", "Task6"),
            new Task(LocalDateTime.of(2020, Month.JANUARY, 31, 20, 0), "Ужин", "Task7")
    );

    public static List<Task> getFilteredTos(Collection<Task> tasks, LocalTime startTime, LocalTime endTime) {
        return tasks.stream()
                .filter(task -> Util.isBetweenHalfOpen(task.getTime(), startTime, endTime))
                .collect(Collectors.toList());
    }

/*
    public static List<Task> getTos(Collection<Task> tasks, int caloriesPerDay) {
        return filterByPredicate(tasks, caloriesPerDay, meal -> true);
    }

    public static List<MealTo> getFilteredTos(Collection<Meal> meals, int caloriesPerDay, LocalTime startTime, LocalTime endTime) {
        return filterByPredicate(meals, caloriesPerDay, meal -> DateTimeUtil.isBetweenHalfOpen(meal.getTime(), startTime, endTime));
    }

    public static List<Task> filterByPredicate(Collection<Task> tasks, int caloriesPerDay, Predicate<Task> filter) {
        Map<LocalDate, Integer> caloriesSumByDate = tasks.stream()
                .collect(
                        Collectors.groupingBy(Task::getDateTime, Collectors.summingInt(Meal::getCalories))
                        Collectors.groupingBy(Task::getDateTime, Collectors.summingInt(Meal::getCalories))
//                      Collectors.toMap(Meal::getDate, Meal::getCalories, Integer::sum)
                );

        return tasks.stream()
                .filter(filter)
                .map(meal -> createTo(meal, caloriesSumByDate.get(meal.getDate()) > caloriesPerDay))
                .collect(Collectors.toList());
    }

    private static MealTo createTo(Meal meal, boolean excess) {
        return new MealTo(meal.getId(), meal.getDateTime(), meal.getDescription(), meal.getCalories(), excess);
    }
 */
}
