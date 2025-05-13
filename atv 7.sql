
-- Questão 1:
CREATE PROCEDURE student_grade_points
    @grade VARCHAR(2)
AS
BEGIN
    SELECT 
        s.name AS Nome_Estudante,
        s.dept_name AS Departamento_Estudante,
        c.title AS Titulo_Curso,
        c.dept_name AS Departamento_Curso,
        t.semester AS Semestre_Curso,
        t.year AS Ano_Curso,
        t.grade AS Pontuacao_Alfabetica,
        gp.points AS Pontuacao_Numerica
    FROM student s
    JOIN takes t ON s.ID = t.ID
    JOIN course c ON t.course_id = c.course_id
    JOIN grade_points gp ON t.grade = gp.grade
    WHERE t.grade = @grade;
END;

-- Questão 2:
CREATE FUNCTION return_instructor_location
(
    @instructor_name VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        i.name AS Nome_Instrutor,
        c.title AS Curso_Ministrado,
        sec.semester AS Semestre_Curso,
        sec.year AS Ano_Curso,
        sec.building AS Predio,
        sec.room_number AS Sala
    FROM instructor i
    JOIN teaches t ON i.ID = t.ID
    JOIN section sec ON t.course_id = sec.course_id AND t.sec_id = sec.sec_id AND t.semester = sec.semester AND t.year = sec.year
    JOIN course c ON sec.course_id = c.course_id
    WHERE i.name = @instructor_name
);
SELECT * FROM dbo.return_instructor_location('Gustafsson');

