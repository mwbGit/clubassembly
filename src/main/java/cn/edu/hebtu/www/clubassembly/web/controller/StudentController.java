package cn.edu.hebtu.www.clubassembly.web.controller;

import cn.edu.hebtu.www.clubassembly.web.model.*;
import cn.edu.hebtu.www.clubassembly.web.service.OrganizationServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.SchoolServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.StudentMaintainServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.StudentServiceI;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 15-3-30.
 */
@RequestMapping("/student")
@Controller
public class StudentController {
    private Logger logger = Logger.getLogger(HomeController.class);

    @Resource
    private OrganizationServiceI organizationServiceI;

    @Resource
    private StudentServiceI studentService;

    @Resource
    private StudentMaintainServiceI studentMaintainService;


    @Resource
    private SchoolServiceI schoolService;

    @RequestMapping(value = "/studentprofilemanager", method = RequestMethod.GET)
    public String studentProfileManager(Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("student/studentprofilemanager  get request");


        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student student = studentService.getStudentByEmail(user.getEmail());

//      得到所有省份
        List<Province> provinces = schoolService.getAllProvince();

        List<City> cities = schoolService.getCities(student.getProvince().getPr_province());

        List<School> schools = schoolService.getSchools(student.getCity().getCi_city());

        model.addAttribute("student", student);

        model.addAttribute("provinces", provinces);

        model.addAttribute("cities", cities);

        model.addAttribute("schools", schools);
        return "/student/student_profile_manager";
    }


    @RequestMapping(value = "/studentprofilemanager", method = RequestMethod.POST)
    public String studentProfileManager(String imagelocation,
                                        @RequestParam(value = "city") int cityid,
                                        @RequestParam(value = "province") int provinceid,
                                        @RequestParam(value = "school") int schoolid,
                                        @RequestParam String sex,
                                        @RequestParam String major,
                                        @RequestParam String telephone,
                                        @RequestParam String qq,
                                        @RequestParam String number,
                                        @RequestParam String personcode


    )

    {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("student/studentprofilemanager  get request");
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student student = studentService.getStudentByEmail(user.getEmail());
        Province province = schoolService.getProvinceByProvinceID(provinceid);
        City city = schoolService.getCityByCityID(cityid);
        School school = schoolService.getSchoolBySchoolID(schoolid);
        student.setSchool(school);
        student.setProvince(province);
        student.setCity(city);
        student.setQQ(qq);
        student.setNumber(number);
        student.setTelephone(telephone);
        student.setPersoncode(personcode);
        student.setMajor(major);
        if (imagelocation != null) {
            student.setImage(imagelocation);
        }
        student.setSex(sex);
        studentService.updateStudent(student);
        if (imagelocation != null) {
            user.setImage("/clubassembly/" + imagelocation);
        }

        user.setPersoncode(personcode);
        return "redirect:/student/studentprofilemanager";
    }


    @RequestMapping(value = "/studentprofileupdatepasswordmanager", method = RequestMethod.GET)
    public String studentProfileUpdatePasswordManager(Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("student/studentprofileupdatepasswordmanager  get request");
        return "/student/student_profile_update_password_manager";
    }


    @RequestMapping(value = "/studentprofilemain", method = RequestMethod.GET)
    public String studentProfileMain(String studentid, Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("student/studentprofilemain  get request");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student me = studentService.getStudentByID(shiroUser.getUserId());
        Student student = null;
        if (studentid != null) {
            student = studentService.getStudentByID(Integer.valueOf(studentid));
        } else {
            student = me;
        }
        if (me != null && student != null) {
            if (me.getId() == student.getId()) {
                List<StudentNews> newses = studentMaintainService.getAllNewsByStudent(me);
                model.addAttribute("newses", newses);
                model.addAttribute("isme", true);
                model.addAttribute("student", me);
            } else {
                List<StudentNews> newses = studentMaintainService.getAllNewsByStudent(student);
                model.addAttribute("newses", newses);
                model.addAttribute("student", student);
                StudentWatchLink link = studentService.getAStudentWatchLink(student, me);
                if (link != null) {
                    model.addAttribute("iswatched", true);
                }
            }
            return "/student/student_profile_main";
        } else {
            return "redirect:/";
        }
    }

    @RequestMapping(value = "/studentprofilemainmessages", method = RequestMethod.GET)
    public String studentProfileMainMessages(@RequestParam("studentid") int studentid,
                                             Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("student/studentprofilemainmessages  get request");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student me = studentService.getStudentByID(shiroUser.getUserId());
        Student student = studentService.getStudentByID(studentid);
        if (me != null && student != null) {
            if (me.getId() == student.getId()) {
                model.addAttribute("isme", true);
            } else {
                StudentWatchLink link = studentService.getAStudentWatchLink(student, me);
                if (link != null) {
                    model.addAttribute("iswatched", true);
                }
            }
            model.addAttribute("student", student);
            return "/student/student_profile_main_messages";
        } else {
            return "redirect:/";
        }

    }

    @RequestMapping(value = "/studentprofilemainnews", method = RequestMethod.GET)
    public String studentProfileMainNews(@RequestParam("studentid") int studentid,
                                         Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("student/studentprofilemainnews  get request");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student me = studentService.getStudentByID(shiroUser.getUserId());
        Student student = studentService.getStudentByID(studentid);
        if (me != null && student != null) {
            if (me.getId() == student.getId()) {
                model.addAttribute("isme", true);
            } else {
                StudentWatchLink link = studentService.getAStudentWatchLink(student, me);
                if (link != null) {
                    model.addAttribute("iswatched", true);
                }
            }
            model.addAttribute("student", student);
            return "/student/student_profile_main_news";
        } else {
            return "redirect:/";
        }
    }

    @RequestMapping(value = "/studentprofilemainphotos", method = RequestMethod.GET)
    public String studentProfileMainPhotos(@RequestParam("studentid") int studentid,
                                           Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("student/studentprofilemainphotos  get request");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student me = studentService.getStudentByID(shiroUser.getUserId());
        Student student = studentService.getStudentByID(studentid);
        if (me != null && student != null) {
            if (me.getId() == student.getId()) {
                model.addAttribute("isme", true);
            } else {
                StudentWatchLink link = studentService.getAStudentWatchLink(student, me);
                if (link != null) {
                    model.addAttribute("iswatched", true);
                }
            }
            model.addAttribute("student", student);
            return "/student/student_profile_main_photos";
        } else {
            return "redirect:/";
        }

    }

    @RequestMapping(value = "/studentprofilemainprofile", method = RequestMethod.GET)
    public String studentProfileMainProfile(@RequestParam("studentid") int studentid,
                                            Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("student/studentprofilemainprofile  get request");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student me = studentService.getStudentByID(shiroUser.getUserId());
        Student student = studentService.getStudentByID(studentid);
        if (me != null && student != null) {
            if (me.getId() == student.getId()) {
                model.addAttribute("isme", true);
            } else {
                StudentWatchLink link = studentService.getAStudentWatchLink(student, me);
                if (link != null) {
                    model.addAttribute("iswatched", true);
                }
            }
            model.addAttribute("student", student);
            return "/student/student_profile_main_profile";
        } else {
            return "redirect:/";
        }

    }


    @RequestMapping(value = "/watchstudent", method = RequestMethod.GET)
    public String watchStudent(@RequestParam("studentid") int studentid) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("student/watchstudent  get request");
        Student beWatchedStudent = studentService.getStudentByID(studentid);
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student me = studentService.getStudentByID(shiroUser.getUserId());
        //不能关注自己
        if (beWatchedStudent.getId() != me.getId()) {
            StudentWatchLink link = new StudentWatchLink();
            link.setBeWatchedStudent(beWatchedStudent);
            link.setWatchStudent(me);
            studentService.addStudentWatchLink(link);
        }
        return "redirect:/student/studentprofilemain?studentid=" + studentid;
    }


    //取消关注
    @RequestMapping(value = "/cancelwatchstudent", method = RequestMethod.GET)
    public String cancelWatchStudent(@RequestParam("studentid") int studentid) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("student/watchstudent  get request");
        Student beWatchedStudent = studentService.getStudentByID(studentid);
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student me = studentService.getStudentByID(shiroUser.getUserId());
        StudentWatchLink link = studentService.getAStudentWatchLink(beWatchedStudent, me);
        studentService.deleteStudentWatchLink(link);
        return "redirect:/student/studentprofilemain?studentid=" + studentid;
    }


}
