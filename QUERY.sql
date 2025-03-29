-- Викладачі з академічним ступенем "Кандидат наук"
SELECT full_name, academic_degree
FROM Teachers
WHERE academic_degree = 'Doctor of Sciences'
ORDER BY full_name;

-- Групи з номером, що починається на "GROUP-1"
SELECT group_number
FROM Groups
WHERE group_number LIKE 'GROUP-1%'
ORDER BY group_number;

-- Предмети, що викладаються у лекційних аудиторіях
SELECT DISTINCT Subjects.name
FROM Subjects
JOIN Auditoriums ON Auditoriums.type = 'Lecture'
ORDER BY Subjects.name;

-- Викладачі, які читають лише лекції
SELECT full_name
FROM Teachers
WHERE teaching_types LIKE '%Lecture%'
AND teaching_types NOT LIKE '%Practice%'
ORDER BY full_name;

-- Аудиторії лекційного типу
SELECT room_number
FROM Auditoriums
WHERE type = 'Laboratory'
ORDER BY room_number;


/* ================================================
   Завдання 3. Формування запитів із застосуванням WHERE
   ================================================ */
SELECT
    full_name,
    department,
    academic_degree,
    teaching_types
FROM Teachers
WHERE academic_degree = 'PhD'
ORDER BY full_name;

/* ================================================
   Завдання 4. Застосування логічних операторів (AND, OR, NOT)
   ================================================ */
SELECT
    full_name,
    department,
    academic_degree,
    teaching_types
FROM Teachers
WHERE department = 'Informatics'
  AND (academic_degree = 'PhD' OR teaching_types NOT LIKE '%Practice%')
ORDER BY full_name;

/* ================================================
   Завдання 5. Використання оператора LIKE для пошуку шаблонів
   ================================================ */
SELECT
    group_number,
    headman,
    course,
    specialty
FROM Groups
WHERE group_number LIKE '%01%'
ORDER BY group_number;

/* ================================================
   Завдання 6. Застосування оператора JOIN для виконання багатотабличних запитів
   ================================================ */
SELECT
    T.full_name AS Teacher,
    S.name AS Subject
FROM Teachers T
CROSS JOIN Subjects S
WHERE S.name LIKE '%Programming%'
ORDER BY T.full_name;

/* ================================================
   Завдання 7. Розширене використання оператора JOIN
   (LEFT JOIN, RIGHT JOIN, FULL JOIN)
   ================================================ */
SELECT
    G.group_number,
    G.specialty,
    T.full_name AS Teacher
FROM Groups G
LEFT JOIN Teachers T ON T.department = G.specialty
ORDER BY G.group_number;

/* RIGHT JOIN: Всі викладачі та відповідні групи, де співпадає кафедра викладача і спеціальність групи.
   Якщо група відсутня, дані групи будуть NULL.
*/
SELECT
    T.full_name,
    T.department,
    G.group_number,
    G.specialty
FROM Groups G
RIGHT JOIN Teachers T ON T.department = G.specialty
ORDER BY T.full_name;

/* FULL JOIN: Об’єднання всіх груп і викладачів за умовою співпадіння (спеціальність групи = кафедра викладача).
   Повертаються всі записи з обох таблиць, навіть якщо немає збігу.
*/
SELECT
    G.group_number,
    T.full_name,
    G.specialty,
    T.department
FROM Groups G
FULL JOIN Teachers T ON T.department = G.specialty
ORDER BY G.group_number, T.full_name;

/* ================================================
   Завдання 8. Робота з вкладеними запитами (SUBQUERY)
   ================================================ */

/* Приклад 1: Вибрати групи, спеціальність яких присутня серед кафедр викладачів
   зі ступенем 'PhD'
*/
SELECT
    group_number,
    specialty
FROM Groups
WHERE specialty IN (
    SELECT DISTINCT department
    FROM Teachers
    WHERE academic_degree = 'PhD'
)
ORDER BY group_number;

/* Приклад 2: Вибрати викладачів, які працюють у кафедрах, що зустрічаються в групах */
SELECT
    full_name,
    department,
    academic_degree
FROM Teachers
WHERE department IN (
    SELECT DISTINCT specialty
    FROM Groups
)
ORDER BY full_name;

/* ================================================
   Завдання 9. Застосування оператора GROUP BY та умови HAVING у поєднанні з JOIN
   ================================================ */
SELECT
    department,
    COUNT(*) AS TeacherCount
FROM Teachers
GROUP BY department
HAVING COUNT(*) > 1
ORDER BY TeacherCount DESC;

/* ================================================
   Завдання 10. Формування складних багатотабличних запитів
   ================================================ */
SELECT
    G.group_number,
    G.specialty,
    COUNT(T.id) AS TeacherCount
FROM Groups G
LEFT JOIN Teachers T ON T.department = G.specialty
GROUP BY G.group_number, G.specialty
ORDER BY G.group_number;

/* ================================================
   Завдання 11. Поєднання умов WHERE із операторами JOIN
   ================================================ */
SELECT
    T.full_name,
    T.department,
    G.group_number,
    G.specialty,
    T.academic_degree
FROM Teachers T
JOIN Groups G ON T.department = G.specialty
WHERE T.academic_degree = 'PhD'
  AND G.specialty = 'Mathematics'
ORDER BY T.full_name;

