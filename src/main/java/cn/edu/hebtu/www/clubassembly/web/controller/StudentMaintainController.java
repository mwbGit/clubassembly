package cn.edu.hebtu.www.clubassembly.web.controller;

import cn.edu.hebtu.www.clubassembly.web.model.*;
import cn.edu.hebtu.www.clubassembly.web.service.OrganizationServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.SchoolServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.StudentMaintainServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.StudentServiceI;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by Administrator on 15-4-12.
 */
@RequestMapping("/studentmaintain")
@Controller
public class StudentMaintainController {
    private Logger logger = Logger.getLogger(HomeController.class);

    @Resource
    private OrganizationServiceI organizationServiceI;

    @Resource
    private StudentServiceI studentService;

    @Resource
    private StudentMaintainServiceI studentMaintainService;


    @Resource
    private SchoolServiceI schoolService;

    @RequestMapping(value = "addnews", method = RequestMethod.POST)
    public String addNews(@RequestParam("newscontent") String content
    ) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("---------------addnews get request ------------------");
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student me = studentService.getStudentByID(user.getUserId());
        StudentNews news = new StudentNews();
        news.setContent(content);
        news.setStudent(me);
        news.setReleaseTime(new Date());
        studentMaintainService.addNews(news);
        return "redirect:/student/studentprofilemain";
    }
}
