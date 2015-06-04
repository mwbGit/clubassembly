package cn.edu.hebtu.www.clubassembly.web.controller;

import cn.edu.hebtu.www.clubassembly.common.model.Reply;
import cn.edu.hebtu.www.clubassembly.utils.BaseUtils;
import cn.edu.hebtu.www.clubassembly.utils.Constant;
import cn.edu.hebtu.www.clubassembly.web.model.*;
import cn.edu.hebtu.www.clubassembly.web.service.OrganizationServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.SchoolServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.StudentServiceI;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@RequestMapping("/home")
@Controller
public class HomeController {
    private Logger logger = Logger.getLogger(HomeController.class);
    @Resource
    private OrganizationServiceI organizationServiceI;

    @Resource
    private StudentServiceI studentService;


    @Resource
    private SchoolServiceI schoolService;

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String homemain(Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("home/main  get request");
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student student = studentService.getStudentByEmail(user.getEmail());


//      本地社团(前4个)
        List<Student> sameCityStudents = studentService.getAllStudentBySameCity(student.getCity());
        List<Organization> sameCityOrganizations = organizationServiceI.getAllOrganizationBySomeStudentIsCammander(sameCityStudents);

//      本校社团(前16个)
        List<Student> sameSchoolStudents = studentService.getAllStudentBySameSchool(student.getSchool());
        List<Organization> sameSchoolOrganizations = organizationServiceI.getAllOrganizationBySomeStudentIsCammander(sameSchoolStudents);
//


        model.addAttribute("sameCityOrganizations", sameCityOrganizations);
        model.addAttribute("sameSchoolOrganizations", sameSchoolOrganizations);

        return "/home";
    }

    @RequestMapping(value = "/createorganization", method = RequestMethod.GET)
    public String createOrganization(Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("home/createorganization  get request");
        return "redirect:/organization/createorganization";
    }

    @RequestMapping(value = "/studentprofilemanager", method = RequestMethod.GET)
    public String studentProfileManager(Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("home/studentprofilemanager  get request");
        return "redirect:/student/studentprofilemanager";
    }


    @RequestMapping(value = "/alreadyInOrganizations", method = RequestMethod.POST)
    public void alreadyInOrganizations(HttpServletResponse response) throws IOException {
        SecurityUtils.getSubject().checkRole("student");
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student student = studentService.getStudentByEmail(user.getEmail());
        //        已加入社团
        List<Organization> alreadyInOrganizations = organizationServiceI.getAlreadyInOrganizations(student);
        try {
            if (alreadyInOrganizations != null && alreadyInOrganizations.size() > 0) {
                Reply<List<Organization>> reply = new Reply<List<Organization>>();
                reply.setCode(1);
                reply.setReply(alreadyInOrganizations);
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            } else {
                Reply<String> reply = new Reply<String>();
                reply.setCode(0);
                reply.setReply("");
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @RequestMapping(value = "/waitauditorganizations", method = RequestMethod.POST)
    public void waitAuditOrganizations(HttpServletResponse response) throws IOException {
        SecurityUtils.getSubject().checkRole("student");
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student student = studentService.getStudentByEmail(user.getEmail());
        //        等待审核社团
        List<Organization> waitAuditOrganizations = organizationServiceI.getWaitAuditOrganizations(student);
        try {
            if (waitAuditOrganizations != null && waitAuditOrganizations.size() > 0) {
                Reply<List<Organization>> reply = new Reply<List<Organization>>();
                reply.setCode(1);
                reply.setReply(waitAuditOrganizations);
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            } else {
                Reply<String> reply = new Reply<String>();
                reply.setCode(0);
                reply.setReply("");
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @RequestMapping(value = "/getchoseorganization", method = RequestMethod.POST)
    public void getChoseOrganization(HttpServletResponse response) throws IOException {
        SecurityUtils.getSubject().checkRole("student");
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        try {
            if (user.getCurrentOrganizationID() != null && user.getCurrentOrganizationID().length() > 0) {
                Organization organization = organizationServiceI.getOrganizationById(Integer.valueOf(user.getCurrentOrganizationID()));
                if (organization != null) {
                    Student student = organizationServiceI.getCommenderByOrganization(organization);
                    if (student.getId() == user.getUserId()) {
//                        是社长
                        Reply<String> reply = new Reply<String>();
                        reply.setCode(Constant.IS_COMMENDER);
                        reply.setDetail(organization.getName());
                        reply.setReply(user.getCurrentOrganizationID());
                        response.getWriter().write(BaseUtils.gson.toJson(reply));
                    } else {
                        //是社员
                        Reply<String> reply = new Reply<String>();
                        reply.setCode(Constant.IS_MEMBER);
                        reply.setDetail(organization.getName());
                        reply.setReply(user.getCurrentOrganizationID());
                        response.getWriter().write(BaseUtils.gson.toJson(reply));
                    }
                } else {
                    Reply<String> reply = new Reply<String>();
                    reply.setCode(0);
                    reply.setReply("");
                    response.getWriter().write(BaseUtils.gson.toJson(reply));
                }
            } else {
                Reply<String> reply = new Reply<String>();
                reply.setCode(0);
                reply.setReply("");
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



    @RequestMapping(value = "/watchedstudents", method = RequestMethod.POST)
    public void watchedStudents(HttpServletResponse response) throws IOException {
        SecurityUtils.getSubject().checkRole("student");
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student student = studentService.getStudentByEmail(user.getEmail());
        List<Student> students = studentService.getAllWatchedStudents(student);
        try {
            if (students != null && students.size() > 0) {
                Reply<List<Student>> reply = new Reply<List<Student>>();
                reply.setCode(Constant.INTER_WATCHED_STUDENTS_SUCCESS);
                reply.setReply(students);
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            } else {
                Reply<String> reply = new Reply<String>();
                reply.setCode(0);
                reply.setReply("");
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @RequestMapping(value = "/bewatchedstudents", method = RequestMethod.POST)
    public void bewatchedStudents(HttpServletResponse response) throws IOException {
        SecurityUtils.getSubject().checkRole("student");
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student student = studentService.getStudentByEmail(user.getEmail());
        List<Student> students = studentService.getAllBeWatchedStudents(student);
        try {
            if (students != null && students.size() > 0) {
                Reply<List<Student>> reply = new Reply<List<Student>>();
                reply.setCode(Constant.BEWATCHED_STUDENTS_SUCCESS);
                reply.setReply(students);
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            } else {
                Reply<String> reply = new Reply<String>();
                reply.setCode(0);
                reply.setReply("");
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @RequestMapping(value = "/interwatchedstudents", method = RequestMethod.POST)
    public void interwatchedstudents(HttpServletResponse response) throws IOException {
        SecurityUtils.getSubject().checkRole("student");
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student student = studentService.getStudentByEmail(user.getEmail());
        List<Student> students = studentService.getAllInterWatchedStudents(student);
        try {
            if (students != null && students.size() > 0) {
                Reply<List<Student>> reply = new Reply<List<Student>>();
                reply.setCode(Constant.WATCHED_STUDENTS_SUCCESS);
                reply.setReply(students);
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            } else {
                Reply<String> reply = new Reply<String>();
                reply.setCode(0);
                reply.setReply("");
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }




}
