package cn.edu.hebtu.www.clubassembly.web.service.implement;

import cn.edu.hebtu.www.clubassembly.common.dao.BaseDaoI;
import cn.edu.hebtu.www.clubassembly.web.model.Student;
import cn.edu.hebtu.www.clubassembly.web.model.StudentNews;
import cn.edu.hebtu.www.clubassembly.web.service.StudentMaintainServiceI;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 15-4-12.
 */
@Service
public class StudentMaintainServiceImplement implements StudentMaintainServiceI {
    @Resource
    private BaseDaoI<StudentNews> newsdao;

    @Override
    public void addNews(StudentNews news) {
        newsdao.save(news);
    }

    @Override
    public List<StudentNews> getAllNewsByStudent(Student student) {
        String hql = "from StudentNews t where t.student=:student order by t.releaseTime desc";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("student", student);
        return newsdao.find(hql, params);
    }
}
