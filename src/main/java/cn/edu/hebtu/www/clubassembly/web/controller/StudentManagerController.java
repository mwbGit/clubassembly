package cn.edu.hebtu.www.clubassembly.web.controller;

import cn.edu.hebtu.www.clubassembly.common.model.Reply;
import cn.edu.hebtu.www.clubassembly.utils.Constant;
import cn.edu.hebtu.www.clubassembly.web.model.Student;
import cn.edu.hebtu.www.clubassembly.web.service.StudentServiceI;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.List;


@RequestMapping(value = "/manager/student")
@Controller
public class StudentManagerController {
    private Logger logger = Logger.getLogger(StudentManagerController.class);

    @Resource
    private StudentServiceI studentService;

    @RequestMapping(value = "/studentmanager", method = RequestMethod.GET)
    public String studentManager(Model model) {
        logger.info("/manager/student/studentmanager request");
        SecurityUtils.getSubject().checkRole("student_manager");
        List<Student> alreadyActiveStudents = studentService.getAllAlreadyActiveStudent();
        List<Student> notActiveStudents = studentService.getAllNotActiveStudent();
        List<Student> deleteStudents = studentService.getAllDeleteStudent();
        model.addAttribute("alreadyActiveStudents", alreadyActiveStudents);
        model.addAttribute("notActiveStudents", notActiveStudents);
        model.addAttribute("deleteStudents", deleteStudents);
        return "/manager/student/student_manager";
    }


    @RequestMapping(value = "/studentmainpage", method = RequestMethod.GET)
    public String studentMainPage(@RequestParam("id") int id,Model model){
        logger.info("/manager/student/studentmainpage request");
        SecurityUtils.getSubject().checkRole("student_manager");
        Student student = studentService.getStudentByID(id);
        model.addAttribute("student",student);
        return "/manager/student/student_main_page";
    }


    @RequestMapping(value = "/studentprofileview", method = RequestMethod.GET)
    public String studentView(@RequestParam("id") int id,Model model){
        logger.info("/manager/student/studentprofileview request");
        SecurityUtils.getSubject().checkRole("student_manager");
        Student student = studentService.getStudentByID(id);
        model.addAttribute("student",student);
        return "/manager/student/student_profile_view";
    }


    @RequestMapping(value = "/studentprofileupdate", method = RequestMethod.GET)
    public String studentProfileUpdate(@RequestParam("id") int id,Model model){
        logger.info("/manager/student/studentprofileview request");
        SecurityUtils.getSubject().checkRole("student_manager");
        Student student = studentService.getStudentByID(id);
        model.addAttribute("student",student);
        return "/manager/student/student_profile_update";
    }


    /**
     * 激活学生
     * @param ids
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/studentactive", method = RequestMethod.GET)
    public String studentActive(@RequestParam("ids")  String ids,RedirectAttributes redirectAttributes){
        logger.info("/manager/student/studentactive request");
        SecurityUtils.getSubject().checkRole("student_manager");
        try{
            String [] id = ids.split(",");
            List<Student> students = studentService.getAllStudentByStudentIds(id);
            for(Student student : students){
                student.setActivate(1);
                studentService.updateStudent(student);
            }
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_ACTIVE_STUDENT_SUCCESS);
            reply.setDetail("激活学生成功");
            reply.setReply("激活学生成功");
            redirectAttributes.addFlashAttribute("reply",reply);
            return "redirect:/manager/student/studentmanager";
        }catch (Exception e){
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_ACTIVE_STUDENT_FAIL);
            reply.setDetail("激活学生失败");
            reply.setReply("激活学生失败");
            redirectAttributes.addFlashAttribute("reply",reply);
            return "redirect:/manager/student/studentmanager";
        }
    }


    /**
     * 还原学生
     * @param ids
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/studentrestore", method = RequestMethod.GET)
    public String studentRestore(@RequestParam("ids") String ids,RedirectAttributes redirectAttributes){
        logger.info("/manager/student/studentrestore request");
        SecurityUtils.getSubject().checkRole("student_manager");
        try{
            String [] id = ids.split(",");
            List<Student> students = studentService.getAllStudentByStudentIds(id);
            for(Student student : students){
                student.setActivate(0);
                studentService.updateStudent(student);
            }
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_RESTORE_STUDENT_SUCCESS);
            reply.setDetail("还原学生成功");
            reply.setReply("还原学生成功");
            redirectAttributes.addFlashAttribute("reply",reply);
            return "redirect:/manager/student/studentmanager";
        }catch (Exception e){
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_RESTORE_STUDENT_FAIL);
            reply.setDetail("还原学生失败");
            reply.setReply("还原学生失败");
            redirectAttributes.addFlashAttribute("reply",reply);
            return "redirect:/manager/student/studentmanager";
        }
    }


    /**
     * 将激活状态置2，并未真正删除学生
     * @param ids
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/studentdelete", method = RequestMethod.GET)
    public String studentDelete(@RequestParam("ids") String ids,RedirectAttributes redirectAttributes){
        logger.info("/manager/student/studentdelete request");
        SecurityUtils.getSubject().checkRole("student_manager");
        try{
            String [] id = ids.split(",");
            List<Student> students = studentService.getAllStudentByStudentIds(id);
            for(Student student : students){
                student.setActivate(2);
                studentService.updateStudent(student);
            }
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_DELETE_STUDENT_SUCCESS);
            reply.setDetail("删除学生成功");
            reply.setReply("删除学生成功");
            redirectAttributes.addFlashAttribute("reply",reply);
            return "redirect:/manager/student/studentmanager";
        }catch (Exception e){
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_DELETE_STUDENT_FAIL);
            reply.setDetail("删除学生失败");
            reply.setReply("删除学生失败");
            redirectAttributes.addFlashAttribute("reply",reply);
            return "redirect:/manager/student/studentmanager";
        }
    }

    /**
     * 彻底删除学生
     * @param ids
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/studentcompletedelete", method = RequestMethod.GET)
    public String studentCompleteDelete(@RequestParam("ids") String ids,RedirectAttributes redirectAttributes){
        logger.info("/manager/student/studentdelete request");
        SecurityUtils.getSubject().checkRole("student_manager");
        try{
            String [] id = ids.split(",");
            List<Student> students = studentService.getAllStudentByStudentIds(id);
            for(Student student : students){
                student.setActivate(3);
                studentService.updateStudent(student);
            }
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_COMPLETE_DELETE_STUDENT_SUCCESS);
            reply.setDetail("彻底删除学生成功");
            reply.setReply("彻底删除学生成功");
            redirectAttributes.addFlashAttribute("reply",reply);
            return "redirect:/manager/student/studentmanager";
        }catch (Exception e){
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_COMPLETE_DELETE_STUDENT_FAIL);
            reply.setDetail("彻底删除学生失败");
            reply.setReply("彻底删除学生失败");
            redirectAttributes.addFlashAttribute("reply",reply);
            return "redirect:/manager/student/studentmanager";
        }
    }
}
