-- Groups
INSERT INTO Groups (group_number, headman, course, specialty) VALUES
('GROUP-101', 'Ivanov', 1, 'Informatics'),
('GROUP-102', 'Petrov', 2, 'Mathematics');

-- Auditoriums
INSERT INTO Auditoriums (room_number, type, building) VALUES
('101', 'Lecture', 'Building A'),
('202', 'Laboratory', 'Building B');

-- Teachers
INSERT INTO Teachers (full_name, department, position, academic_degree, teaching_types) VALUES
('Sidorov A.A.', 'Mathematics', 'Associate Professor', 'PhD', 'Lecture, Practice'),
('Kozlov V.V.', 'Informatics', 'Professor', 'Doctor of Sciences', 'Lecture');

-- Subjects
INSERT INTO Subjects (name) VALUES
('Algebra'),
('Programming');

ALTER TABLE Schedule
DROP CONSTRAINT CK__Schedule__day_of__4222D4EF;


-- Schedule
INSERT INTO Schedule (day_of_week, pair_number, teacher_id, group_id, subject_id, auditorium_id) VALUES
(N'Понедельник', 1, 1, 1, 1, 1);