package cn.edu.hebtu.www.clubassembly.web.service;

import cn.edu.hebtu.www.clubassembly.web.model.*;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 15-3-21.
 */
public interface StudentServiceI {
    public void addStudent(Student student);

    public void updateStudent(Student student);

    public void deleteStudent(Student student);

    public Student getStudentByID(int id);

    public Student getStudentByEmail(String email);

    public void activeStudentScheduler();

    public List<Student> getAllStudentBySameCity(City city);

    public List<Student> getAllStudentBySameSchool(School school);

    public void addStudentWatchLink(StudentWatchLink link);

    public List<StudentWatchLink> getAllStudentWatchLinkByBeWatchedStudent(Student student);

    public StudentWatchLink getAStudentWatchLink(Student bewatchedstudent, Student watchedstudent);

    public void deleteStudentWatchLink(StudentWatchLink link);

    public List<Student> getAllWatchedStudents(Student student);

    public List<Student> getAllBeWatchedStudents(Student student);

    public List<Student> getAllInterWatchedStudents(Student student);

    public List<Student> getAllAlreadyActiveStudent();

    public List<Student> getAllNotActiveStudent();

    public List<Student> getAllDeleteStudent();

    public List<Student> getAllStudentByStudentIds(String[] id);
}
