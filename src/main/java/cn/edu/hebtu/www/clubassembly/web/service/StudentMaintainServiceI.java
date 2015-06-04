package cn.edu.hebtu.www.clubassembly.web.service;

import cn.edu.hebtu.www.clubassembly.web.model.Student;
import cn.edu.hebtu.www.clubassembly.web.model.StudentNews;

import java.util.List;

/**
 * Created by Administrator on 15-4-12.
 */
public interface StudentMaintainServiceI {
    public void addNews(StudentNews news);

    public List<StudentNews> getAllNewsByStudent(Student me);
}
