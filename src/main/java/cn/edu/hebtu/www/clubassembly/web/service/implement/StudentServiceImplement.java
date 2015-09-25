package cn.edu.hebtu.www.clubassembly.web.service.implement;

import cn.edu.hebtu.www.clubassembly.common.dao.BaseDaoI;
import cn.edu.hebtu.www.clubassembly.utils.BaseUtils;
import cn.edu.hebtu.www.clubassembly.utils.PasswordHelper;
import cn.edu.hebtu.www.clubassembly.web.model.City;
import cn.edu.hebtu.www.clubassembly.web.model.School;
import cn.edu.hebtu.www.clubassembly.web.model.Student;
import cn.edu.hebtu.www.clubassembly.web.model.StudentWatchLink;
import cn.edu.hebtu.www.clubassembly.web.service.StudentServiceI;
import com.sun.org.apache.bcel.internal.generic.LLOAD;
import org.apache.log4j.Logger;
import org.apache.log4j.spi.LoggerRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by Administrator on 15-3-21.
 */
@SuppressWarnings("unchecked")
@Service
public class StudentServiceImplement implements StudentServiceI {
    private static Logger logger = Logger.getLogger(StudentServiceImplement.class);
    @Resource
    private BaseDaoI<Student> studentDao;
    @Resource
    private PasswordHelper passwordHelper;
    @Resource
    private BaseDaoI<StudentWatchLink> watchdao;

    @Override
    public void addStudent(Student student) {
        studentDao.save(passwordHelper.encryptStudentPassword(student));
    }

    @Override
    public void updateStudent(Student student) {
        studentDao.update(student);
    }

    @Override
    public void deleteStudent(Student student) {
        studentDao.delete(student);
    }

    @Override
    public Student getStudentByID(int id) {
        String hql = "from Student t where t.id=:id";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return studentDao.get(hql, params);
    }

    @Override
    public Student getStudentByEmail(String email) {
        String hql = "from Student t where t.email=:email";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("email", email);
        return studentDao.get(hql, params);
    }

    @Override
    public void activeStudentScheduler() {
//        超过24小时未激活的用户将被移除
        Date date = new Date();
        Date expectMinRegisterDate = BaseUtils.StringToDate(BaseUtils.getSpecifiedDay(BaseUtils.DateToString(date), -1));
        logger.info(date);
        logger.info(expectMinRegisterDate);
//        未激活的，并且注册时间小于等于系统当前时间的前一天。
        String hql = "from Student t where t.activate=:activate and t.registerTime<=:expectMinRegisterDate";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("activate", 0);
        params.put("expectMinRegisterDate", expectMinRegisterDate);
        List<Student> students = studentDao.find(hql, params);
        if (students != null && students.size() > 0) {
            for (Student student : students) {
                logger.info("删除了一个过时未激活的用户");
                studentDao.delete(student);
            }
        }
    }

    @Override
    public List<Student> getAllStudentBySameCity(City city) {
        String hql = "from Student t where t.city=:city";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("city", city);
        return studentDao.find(hql, params);
    }

    @Override
    public List<Student> getAllStudentBySameSchool(School school) {
        String hql = "from Student t where t.school=:school";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("school", school);
        return studentDao.find(hql, params);
    }

    @Override
    public void addStudentWatchLink(StudentWatchLink link) {
        watchdao.save(link);
    }

    @Override
    public List<StudentWatchLink> getAllStudentWatchLinkByBeWatchedStudent(Student student) {
        String hql = "from StudentWatchLink t where t.beWatchedStudent=:student";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("student", student);
        return watchdao.find(hql, params);
    }

    @Override
    public StudentWatchLink getAStudentWatchLink(Student bewatchedstudent, Student watchedstudent) {
        String hql = "from StudentWatchLink t where t.beWatchedStudent=:bewatchedstudent and t.watchStudent=:watchedstudent";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("bewatchedstudent", bewatchedstudent);
        params.put("watchedstudent", watchedstudent);
        return watchdao.get(hql, params);
    }

    @Override
    public void deleteStudentWatchLink(StudentWatchLink link) {
        watchdao.delete(link);
    }


    @Override
    public List<Student> getAllWatchedStudents(Student student) {
        String hql = "from StudentWatchLink t where t.watchStudent=:student";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("student", student);
        List<StudentWatchLink> studentWatchLinks = watchdao.find(hql, params);
        if (studentWatchLinks != null && studentWatchLinks.size() > 0) {
            List<Student> students = new ArrayList<Student>();
            for (StudentWatchLink link : studentWatchLinks) {
                students.add(link.getBeWatchedStudent());
            }
            if (students != null && students.size() > 0) {
                return students;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public List<Student> getAllBeWatchedStudents(Student student) {
        String hql = "from StudentWatchLink t where t.beWatchedStudent=:student";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("student", student);
        List<StudentWatchLink> studentWatchLinks = watchdao.find(hql, params);
        if (studentWatchLinks != null && studentWatchLinks.size() > 0) {
            List<Student> students = new ArrayList<Student>();
            for (StudentWatchLink link : studentWatchLinks) {
                students.add(link.getWatchStudent());
            }
            if (students != null && students.size() > 0) {
                return students;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public List<Student> getAllInterWatchedStudents(Student student) {
        List<Student> watchedstudents = getAllWatchedStudents(student);
        List<Student> bewatchedStudents = getAllBeWatchedStudents(student);
        if (watchedstudents != null && bewatchedStudents != null) {
            List<Student> interwatchedstudents = new LinkedList<Student>();
            for (int i = 0; i < watchedstudents.size(); i++) {
                for (int j = 0; j < bewatchedStudents.size(); j++) {
                    if (watchedstudents.get(i).getId() == bewatchedStudents.get(j).getId()) {
                        interwatchedstudents.add(watchedstudents.get(i));
                        break;
                    }
                }
            }
            if (interwatchedstudents != null && interwatchedstudents.size() > 0) {
                return interwatchedstudents;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public List<Student> getAllAlreadyActiveStudent() {
        String hql = "from Student t where t.activate=:activate";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("activate", 1);
        return studentDao.find(hql, params);
    }

    @Override
    public List<Student> getAllNotActiveStudent() {
        String hql = "from Student t where t.activate=:activate";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("activate", 0);
        return studentDao.find(hql, params);
    }

    @Override
    public List<Student> getAllDeleteStudent() {
        String hql = "from Student t where t.activate=:activate";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("activate", 2);
        return studentDao.find(hql, params);
    }

    @Override
    public List<Student> getAllStudentByStudentIds(String[] id) {
        List<Student> students = new ArrayList<Student>();
        for(String str : id){
            Student student = getStudentByID(Integer.valueOf(str));
            students.add(student);
        }
        return students;
    }
}