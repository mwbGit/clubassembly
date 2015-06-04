package cn.edu.hebtu.www.clubassembly.web.controller;

import cn.edu.hebtu.www.clubassembly.common.model.Reply;
import cn.edu.hebtu.www.clubassembly.utils.BaseUtils;
import cn.edu.hebtu.www.clubassembly.utils.Constant;
import cn.edu.hebtu.www.clubassembly.utils.FileUtils;
import cn.edu.hebtu.www.clubassembly.web.model.*;
import cn.edu.hebtu.www.clubassembly.web.service.OrganizationMaintainServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.OrganizationServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.StudentServiceI;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by Administrator on 15-4-11.
 */

@RequestMapping("/organizationmaintain")
@Controller
public class OrganizationMaintainController {
    private Logger logger = Logger.getLogger(HomeController.class);
    @Resource
    private OrganizationServiceI organizationServiceI;

    @Resource
    private OrganizationMaintainServiceI organizationMaintainServiceI;


    @Resource
    private StudentServiceI studentService;

    //增加一个组织活动
    @RequestMapping(value = "addevent", method = RequestMethod.POST)
    public String addEvent(@RequestParam("organizationid") int organizationid,
                           @RequestParam("title") String title,
                           @RequestParam("sponsor") String sponsor,
                           @RequestParam("scale") String scale,
                           @RequestParam("location") String location,
                           @RequestParam("endtime") String endtime,
                           @RequestParam("content") String content,
                           @RequestParam("enddate") String enddate,
                           @RequestParam("category") String category,
                           @RequestParam("begintime") String begintime,
                           @RequestParam("begindate") String begindate,
                           String poster
    ) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("---------------addEvent get request ------------------");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        OrganizationEvents events = new OrganizationEvents();
        events.setOrganization(organization);
        events.setStatus(0);
        events.setCategory(category);
        events.setLocation(location);
        if (poster != null && poster.length() > 0) {
            events.setPoster(poster);
        }
        events.setContent(content);
        events.setTitle(title);
        events.setReleaseTime(new Date());
        events.setScale(scale);
        events.setSponsor(sponsor);
        events.setBeginDate(BaseUtils.StringToDateNoSecond(begindate.replace(" ", "") + " " + begintime));
        events.setEndDate(BaseUtils.StringToDateNoSecond(enddate.replace(" ", "") + " " + endtime));
        organizationMaintainServiceI.addEvent(events);
        return "redirect:/organization/organizationmain?organizationid=" + organizationid;
    }


    @RequestMapping(value = "/uploadeventimage", method = RequestMethod.POST)
    public void uploadEventImage(HttpServletRequest request,
                                 HttpServletResponse response,
                                 @RequestParam("fileToUpload") CommonsMultipartFile commonsMultipartFile1) {
        //物理存储路径：C:\Users\Administrator\AppData\Local\apache-tomcat-7.0.53\clubassemblyResources\organization\1\image\xxxxxxxxxx.jpg
        //逻辑路径：/clubassemblyResources\organization\1\image\xxxxxxxxxx.jpg
        //访问路径：http://localhost：/clubassemblyResources\organization\1\image\xxxxxxxxxx.jpg
        SecurityUtils.getSubject().checkRole("student");
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student student = studentService.getStudentByEmail(user.getEmail());
        logger.info("判断路径存在与否");
        String str = request.getSession().getServletContext().getRealPath("");
        logger.info("上下文路径:" + str);
        str = str.replace("\\", "/");
        logger.info("上下文路径:" + str);
        str = str.substring(0, str.indexOf("/webapps/clubassembly"));
        logger.info("tomcat根路径:" + str);
        String savePath = str + "/clubassemblyResources/organization/";
        logger.info(savePath);
        File myFilePath = new File(savePath);
        if (!myFilePath.exists()) {
            myFilePath.mkdir();
            logger.info(savePath + "目录不存在，已创建");
        }


        savePath = savePath + student.getId() + "/";
        logger.info(savePath);
        myFilePath = new File(savePath);
        if (!myFilePath.exists()) {
            myFilePath.mkdir();
            logger.info(savePath + "目录不存在，已创建");
        }

        savePath = savePath + "image/";
        logger.info(savePath);
        myFilePath = new File(savePath);
        if (!myFilePath.exists()) {
            myFilePath.mkdir();
            logger.info(savePath + "目录不存在，已创建");
        }

        savePath = savePath + "events/";
        logger.info(savePath);
        myFilePath = new File(savePath);
        if (!myFilePath.exists()) {
            myFilePath.mkdir();
            logger.info(savePath + "目录不存在，已创建");
        }
        String filename = UUID.randomUUID().toString() + ".jpg";
        logger.info(filename);
        logger.info(savePath);
        if (FileUtils.saveImage(savePath, filename, commonsMultipartFile1)) {
            try {
                savePath = savePath.substring(savePath.indexOf("clubassemblyResources"));
                logger.info(savePath + filename);
                Reply<String> reply = new Reply<String>();
                reply.setCode(Constant.CREATE_ORGANIZATION_IMAGE_SUCCESS);
                reply.setReply(savePath + filename);
                response.getWriter().print(BaseUtils.gson.toJson(reply));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    //增加一个组织活动
    @RequestMapping(value = "addnews", method = RequestMethod.POST)
    public String addNews(@RequestParam("organizationid") int organizationid,
                          @RequestParam("newscontent") String content
    ) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("---------------addnews get request ------------------");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        OrganizationNews news = new OrganizationNews();
        news.setContent(content);
        news.setReleaseTime(new Date());
        news.setOrganization(organization);
        organizationMaintainServiceI.addNews(news);
        return "redirect:/organization/organizationmain?organizationid=" + organizationid;
    }


    //增加一个组织留言
    @RequestMapping(value = "addmessage", method = RequestMethod.POST)
    public String addMessage(@RequestParam("organizationid") int organizationid,
                             @RequestParam("type") String type,
                             @RequestParam("content") String content
    ) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("---------------addmessage get request ------------------");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        OrganizationMessages messages = new OrganizationMessages();
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student student = studentService.getStudentByID(user.getUserId());
        messages.setContent(content);
        messages.setOrganization(organization);
        messages.setReleaseTime(new Date());
        messages.setStudent(student);
        organizationMaintainServiceI.addMessage(messages);
        if (type.equals("studentaccess")) {
            return "redirect:/organization/organizationmainstudentmessages?organizationid=" + organizationid;
        } else if (type.equals("manageraccess")) {
            return "redirect:/organization/organizationmainmessages?organizationid=" + organizationid;
        } else {
            return "redirect:/";
        }
    }


    @RequestMapping(value = "/organizationmainstudenteventsdetail", method = RequestMethod.GET)
    public String organizationMainStudentEventsDetail(
            @RequestParam("eventid") int eventid,
            Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationmainstudentevents  get request");
        OrganizationEvents event = organizationMaintainServiceI.getEventByEventid(eventid);
        Organization organization = event.getOrganization();
        //      当前学生是否是社团的创建人员
//      如果是，则界面上标签会有相应变化
        Student commender = organizationServiceI.getCommenderByOrganization(organization);
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        if (shiroUser.getEmail().equals(commender.getEmail())) {
//            是社团创建人员
            model.addAttribute("iscommender", true);
        } else {
            model.addAttribute("iscommender", false);
        }
        List<Student> members = organizationServiceI.getAllMembersByOrganization(organization);
        if (members != null && members.size() > 0) {
            for (Student student : members) {
                if (student.getEmail().equals(shiroUser.getEmail())) {
                    model.addAttribute("ismember", true);
                } else {
                    model.addAttribute("ismember", false);
                }
            }
        }
        List<OrganizationDepartment> departments = organizationServiceI.getAllDepartmentsByOrganization(organization);
        model.addAttribute("departments", departments);

       model.addAttribute("event",event);


        model.addAttribute("organization", organization);
        return "/organization/organization_main_student_events_detail";
    }
}
