

-- Змінити фамілію старости групи
UPDATE Groups SET headman = 'Смирнов' WHERE group_number = 'ГРУППА-101';

-- Оновити посаду викладача
UPDATE Teachers SET position = 'Профессор' WHERE full_name = 'Сидоров А.А.';

-- Видалити пару з розкладу
DELETE FROM Schedule WHERE day_of_week = 'Вторник' AND pair_number = 2;

-- Змінити аудиторію пари
UPDATE Schedule SET auditorium_id = 1 WHERE day_of_week = 'Понедельник' AND pair_number = 1;
