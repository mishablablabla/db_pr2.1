

-- Розклад для групи і кількість пар
SELECT day_of_week, pair_number, Subjects.name AS subject, Teachers.full_name AS teacher, Auditoriums.room_number
FROM Schedule
JOIN Subjects ON Schedule.subject_id = Subjects.id
JOIN Teachers ON Schedule.teacher_id = Teachers.id
JOIN Auditoriums ON Schedule.auditorium_id = Auditoriums.id
WHERE group_id = (SELECT id FROM Groups WHERE group_number = 'ГРУППА-101')
ORDER BY day_of_week, pair_number;

SELECT COUNT(*) AS total_pairs FROM Schedule
WHERE group_id = (SELECT id FROM Groups WHERE group_number = 'ГРУППА-101');

-- Розклад викладачів з заданою степеню і найзавантаженіший викладач
SELECT Teachers.full_name, day_of_week, pair_number, Subjects.name AS subject, Groups.group_number, Auditoriums.room_number
FROM Schedule
JOIN Teachers ON Schedule.teacher_id = Teachers.id
JOIN Subjects ON Schedule.subject_id = Subjects.id
JOIN Groups ON Schedule.group_id = Groups.id
JOIN Auditoriums ON Schedule.auditorium_id = Auditoriums.id
WHERE Teachers.academic_degree = 'Кандидат наук'
ORDER BY Teachers.full_name, day_of_week, pair_number;

SELECT TOP 1 teacher_id, COUNT(*) AS load
FROM Schedule
GROUP BY teacher_id
ORDER BY load DESC;

-- Лекційні аудиторії, де не проводяться лекції по предмету
SELECT room_number FROM Auditoriums
WHERE type = 'Лекционная'
AND id NOT IN (
    SELECT auditorium_id FROM Schedule
    JOIN Subjects ON Schedule.subject_id = Subjects.id
    WHERE Subjects.name = 'Алгебра'
);

-- Пошук заміни для викладача
SELECT full_name FROM Teachers
WHERE id NOT IN (
    SELECT teacher_id FROM Schedule
    WHERE day_of_week = 'Понедельник' AND pair_number = 2
)
AND teaching_types LIKE '%Лекция%';

-- Вільні аудиторії того ж типу
SELECT room_number FROM Auditoriums
WHERE type = (SELECT type FROM Auditoriums WHERE id = (SELECT auditorium_id FROM Schedule WHERE day_of_week = 'Среда' AND pair_number = 3))
AND id NOT IN (
    SELECT auditorium_id FROM Schedule
    WHERE day_of_week = 'Среда' AND pair_number = 3
);
