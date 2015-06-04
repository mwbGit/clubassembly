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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.UUID;

/**
 * http://localhost:8080/home/organization/getsecondcategory
 * Created by Administrator on 15-3-28.
 */
@RequestMapping("/organization")
@Controller
public class OrganizationController {
    private Logger logger = Logger.getLogger(HomeController.class);
    @Resource
    private OrganizationServiceI organizationServiceI;
    @Resource
    private OrganizationMaintainServiceI organizationMaintainServiceI;
    @Resource
    private StudentServiceI studentService;

    @RequestMapping(value = "/createorganization", method = RequestMethod.GET)
    public String createOrganization(Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/createorganization  get request");

        List<OrganizationProperty> properties = organizationServiceI.getAllOrganizationProperty();
        List<OrganizationMainCategory> mainCategories = organizationServiceI.getAllOrganizationMainCategory();
        List<OrganizationSecondCategory> secondCategories = organizationServiceI.getOrganizationSecondCategoryByMainCategoryId(mainCategories.get(0).getId());

        model.addAttribute("properties", properties);
        model.addAttribute("mainCategories", mainCategories);
        model.addAttribute("secondCategories", secondCategories);
        return "/organization/create_organization";
    }


    @RequestMapping(value = "/createorganization", method = RequestMethod.POST)
    public String createOrganization(@RequestParam int maincategory,
                                     @RequestParam String organizationname,
                                     @RequestParam int property,
                                     @RequestParam int secondcategory,
                                     @RequestParam String imagelocation,
                                     @RequestParam String organizationcheckimagelocation,
                                     Model model
    ) {
        SecurityUtils.getSubject().checkRole("student");
        ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        logger.info("organization/createorganization  post request");
        organizationServiceI.addOrganization(organizationname, property, maincategory, secondcategory, imagelocation, organizationcheckimagelocation);
        Organization organization = organizationServiceI.getOrganizationByName(organizationname);
        organizationServiceI.addStudentOrganizationLink(true, user.getUserId(), organization.getId());
        Reply<String> reply = new Reply<String>();
        reply.setCode(Constant.NOT_AUDIT_ORGANIZATION);
        reply.setReply("我们会在两个工作日内审核您注册的社团，介时我们会发邮件到您的邮箱");
        model.addAttribute("reply", reply);
        return "redirect:/home/main";
    }

    @RequestMapping(value = "/getsecondcategory", method = RequestMethod.POST)
    public void getOrganizationSecondCategoryByMainCatgoryId(@RequestParam int maincategoryid, HttpServletResponse response) throws IOException {
        SecurityUtils.getSubject().checkRole("student");
        List<OrganizationSecondCategory> secondCategories = organizationServiceI.getOrganizationSecondCategoryByMainCategoryId(maincategoryid);

        try {
            if (secondCategories != null && secondCategories.size() > 0) {
                Reply<List<OrganizationSecondCategory>> reply = new Reply<List<OrganizationSecondCategory>>();
                reply.setCode(1);
                reply.setReply(secondCategories);
                response.getWriter().write(BaseUtils.gson.toJson(reply));
            } else {
                Reply<String> reply = new Reply<String>();
                reply.setCode(0);
                reply.setReply("");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @RequestMapping(value = "/checkorganizationname", method = RequestMethod.GET)
    public void checkOrganizationName(@RequestParam String organizationname, HttpServletResponse response) {
        SecurityUtils.getSubject().checkRole("student");

        try {
            organizationname = new String(organizationname.getBytes("ISO-8859-1"), "UTF-8");
            logger.info(organizationname);
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        try {
            Organization organization = organizationServiceI.getOrganizationByName(organizationname);
            if (organization != null) {
                response.getWriter().print(false);
            } else {
                response.getWriter().print(true);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @RequestMapping(value = "/uploadorganizationimage", method = RequestMethod.POST)
    public void uploadOrganizationImage(HttpServletRequest request,
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

    @RequestMapping(value = "/uploadorganizationcheckimage", method = RequestMethod.POST)
    public void uploadOrganizationCheckImage(HttpServletRequest request,
                                             HttpServletResponse response,
                                             @RequestParam("fileToUpload2") CommonsMultipartFile commonsMultipartFile1) {
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


    @RequestMapping(value = "/organizationeventall", method = RequestMethod.GET)
    public String organizationEventAll(Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationeventall  get request");
        List<OrganizationEvents> events = organizationMaintainServiceI.getAllEvents();
        model.addAttribute("events", events);
        return "/organization/organization_event_all";
    }


    @RequestMapping(value = "/organizationsquareall", method = RequestMethod.GET)
    public String organizationSquareAll(Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationsquarelocal  get request");
        List<Organization> organizations = organizationServiceI.getAllOrganization();
        model.addAttribute("organizations", organizations);
        return "/organization/organization_square_all";
    }


    @RequestMapping(value = "/organizationprofile", method = RequestMethod.GET)
    public String organizatioProfile(@RequestParam("organizationid") int organizationid,
                                     Model model) {
        SecurityUtils.getSubject().checkRole("student");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        logger.info("organization/organizationprofile  get request");

        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        List<OrganizationProperty> properties = organizationServiceI.getAllOrganizationProperty();
        List<OrganizationMainCategory> mainCategories = organizationServiceI.getAllOrganizationMainCategory();
        List<OrganizationSecondCategory> secondCategories = organizationServiceI.getOrganizationSecondCategoryByMainCategoryId(
                organization.getOrganizationMainCategory().getId());
        boolean iscommender = false;
        Student commender = organizationServiceI.getCommenderByOrganization(organization);
        if (shiroUser.getEmail().equals(commender.getEmail())) {
            iscommender = true;
        } else {
            iscommender = false;
        }
        model.addAttribute("iscommender", iscommender);
        model.addAttribute("properties", properties);
        model.addAttribute("mainCategories", mainCategories);
        model.addAttribute("secondCategories", secondCategories);
        model.addAttribute("organization", organization);
        return "/organization/organization_profile";
    }


    @RequestMapping(value = "/organizationprofile", method = RequestMethod.POST)
    public String organizatioProfile(@RequestParam("organizationid") int organizationid,
                                     String imagelocation,
                                     @RequestParam("property") int propertyid,
                                     @RequestParam("maincategory") int maincategoryid,
                                     @RequestParam("secondcategory") int secondcategoryid,
                                     @RequestParam("slogan") String slogan,
                                     @RequestParam("organizationIntroduce") String organizationIntroduce,
                                     @RequestParam("departmentIntroduce") String departmentIntroduce,
                                     @RequestParam("contactInformation") String contactInformation,
                                     Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationprofile  post request");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        if (imagelocation != null) {
            organization.setImage(imagelocation);
        }
        organization.setOrganizationIntroduce(organizationIntroduce);
        organization.setSlogan(slogan);
        organization.setDepartmentIntroduce(departmentIntroduce);
        organization.setContactInformation(contactInformation);
        organization.setProperty(organizationServiceI.getOrganizationPropertyById(propertyid));
        organization.setOrganizationMainCategory(organizationServiceI.getOrganizationMainCategoryById(maincategoryid));
        organization.setOrganizationSecondCategory(organizationServiceI.getOrganizationSecondCategoryById(secondcategoryid));
        organizationServiceI.updateOrganization(organization);
        List<OrganizationProperty> properties = organizationServiceI.getAllOrganizationProperty();
        List<OrganizationMainCategory> mainCategories = organizationServiceI.getAllOrganizationMainCategory();
        List<OrganizationSecondCategory> secondCategories = organizationServiceI.getOrganizationSecondCategoryByMainCategoryId(
                organization.getOrganizationMainCategory().getId());
        model.addAttribute("properties", properties);
        model.addAttribute("mainCategories", mainCategories);
        model.addAttribute("secondCategories", secondCategories);
        model.addAttribute("organization", organization);
        return "/organization/organization_profile";
    }


    @RequestMapping(value = "/organizationmain", method = RequestMethod.GET)
    public String organizationMain(@RequestParam("organizationid") int organizationid,
                                   Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationmain  get request");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        List<Student> members = organizationServiceI.getAllMembersByOrganization(organization);
        Student commender = organizationServiceI.getCommenderByOrganization(organization);
        List<OrganizationEvents> events = organizationMaintainServiceI.getAllEventsByOrganization(organization);
        List<OrganizationDepartment> departments = organizationServiceI.getAllDepartmentsByOrganization(organization);
        List<OrganizationNews> newses = organizationMaintainServiceI.getAllNewsByOrganization(organization);

        boolean ismember = false;
        boolean iscommender = false;

        if (shiroUser.getEmail().equals(commender.getEmail())) {
            iscommender = true;
        } else {
            iscommender = false;
        }

        if (members != null && members.size() > 0) {
            for (Student student : members) {
                if (student.getEmail().equals(shiroUser.getEmail())) {
                    ismember = true;
                } else {
                    ismember = false;
                }
            }
        }

        model.addAttribute("events", events);
        model.addAttribute("newses", newses);
        model.addAttribute("organization", organization);
        model.addAttribute("members", members);
        model.addAttribute("organization", organization);
        model.addAttribute("departments", departments);
        model.addAttribute("iscommender", iscommender);
        model.addAttribute("ismember", ismember);
        if (iscommender || ismember) {
            shiroUser.setCurrentOrganizationID(String.valueOf(organizationid));
        }

        return "/organization/organization_main";
    }

    @RequestMapping(value = "/organizationmainevents", method = RequestMethod.GET)
    public String organizationMainEvents(@RequestParam("organizationid") int organizationid,
                                         Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationmainevents  get request");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
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
        List<OrganizationEvents> events = organizationMaintainServiceI.getAllEventsByOrganization(organization);
        model.addAttribute("events", events);
        model.addAttribute("organization", organization);
        return "/organization/organization_main_events";
    }


    @RequestMapping(value = "/organizationmaineventsdetail/{organizationid}/{eventid}", method = RequestMethod.GET)
    public String organizationMainEventsDetail(@PathVariable int organizationid, @PathVariable int eventid, Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationmaineventsdetail  get request");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        Student commender = organizationServiceI.getCommenderByOrganization(organization);
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        if (shiroUser.getEmail().equals(commender.getEmail())) {
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

        List<OrganizationEvents> events = organizationMaintainServiceI.getAllEventsByOrganization(organization);
        model.addAttribute("events", events);

        OrganizationEvents event = organizationMaintainServiceI.getEventByEventid(eventid);
        model.addAttribute("event", event);

        model.addAttribute("organization", organization);
        return "/organization/organization_main_events_detail";
    }


    @RequestMapping(value = "/organizationmainmessages", method = RequestMethod.GET)
    public String organizationMainMessages(@RequestParam("organizationid") int organizationid,
                                           Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationmainmessages  get request");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        Student commender = organizationServiceI.getCommenderByOrganization(organization);
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        if (shiroUser.getEmail().equals(commender.getEmail())) {
//            是社团创建人员
            model.addAttribute("iscommender", true);
        } else {
            model.addAttribute("iscommender", false);
        }
        List<OrganizationMessages> messageses = organizationMaintainServiceI.getAllMessagesByOrganization(organization);
        model.addAttribute("messageses", messageses);
        model.addAttribute("organization", organization);

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
        model.addAttribute("organization", organization);

        return "/organization/organization_main_messages";
    }

    @RequestMapping(value = "/organizationmainnews", method = RequestMethod.GET)
    public String organizationMainNews(@RequestParam("organizationid") int organizationid,
                                       Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationmainnews  get request");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        Student commender = organizationServiceI.getCommenderByOrganization(organization);
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        if (shiroUser.getEmail().equals(commender.getEmail())) {
//            是社团创建人员
            model.addAttribute("iscommender", true);
        } else {
            model.addAttribute("iscommender", false);
        }
        List<OrganizationNews> newses = organizationMaintainServiceI.getAllNewsByOrganization(organization);
        model.addAttribute("newses", newses);
        model.addAttribute("organization", organization);

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
        return "/organization/organization_main_news";
    }

    @RequestMapping(value = "/organizationmainphotos", method = RequestMethod.GET)
    public String organizationMainPhotos(@RequestParam("organizationid") int organizationid,
                                         Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationmainphotos  get request");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
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
        model.addAttribute("organization", organization);
        return "/organization/organization_main_photos";
    }

    @RequestMapping(value = "/organizationmainprofile", method = RequestMethod.GET)
    public String organizationMainProfile(@RequestParam("organizationid") int organizationid,
                                          Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationmainprofile  get request");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
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
        model.addAttribute("organization", organization);
        return "/organization/organization_main_profile";
    }


    @RequestMapping(value = "/organizationmemberapply", method = RequestMethod.GET)
    public String organizationMemberApply(@RequestParam("organizationid") int organizationid,
                                          Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationmemberapply  get request");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        List<StudentOrganizationLink> notAuditStudentOrganizationLinks = organizationServiceI.getAllNotAuditStudentOrganization(organization);
        List<OrganizationDepartment> departments = organizationServiceI.getAllDepartmentsByOrganization(organization);
        Student commender = organizationServiceI.getCommenderByOrganization(organization);
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        if (shiroUser.getEmail().equals(commender.getEmail())) {
//            是社团创建人员
            model.addAttribute("iscommender", true);
        } else {
            model.addAttribute("iscommender", false);
        }
        model.addAttribute("departments", departments);
        model.addAttribute("organization", organization);
        model.addAttribute("notAuditStudentOrganizationLinks", notAuditStudentOrganizationLinks);
        return "/organization/organization_member_apply";
    }

    @RequestMapping(value = "/organizationmember", method = RequestMethod.GET)
    public String organizationMember(@RequestParam("organizationid") int organizationid,
                                     Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationmember  get request");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        List<StudentOrganizationLink> alreadyAuditStudentOrganizationLink = organizationServiceI.getAllAlreadyAuditStudentOrganization(organization);
        List<OrganizationPosition> positions = organizationServiceI.getAllPositionsByOrganization(organization);
        List<OrganizationDepartment> departments = organizationServiceI.getAllDepartmentsByOrganization(organization);
        Student commender = organizationServiceI.getCommenderByOrganization(organization);
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        if (shiroUser.getEmail().equals(commender.getEmail())) {
//            是社团创建人员
            model.addAttribute("iscommender", true);
        } else {
            model.addAttribute("iscommender", false);
        }
        model.addAttribute("positions", positions);
        model.addAttribute("departments", departments);
        model.addAttribute("alreadyAuditStudentOrganizationLink", alreadyAuditStudentOrganizationLink);
        model.addAttribute("organization", organization);
        return "/organization/organization_member";
    }


    /**
     * 申请加入一个社团
     *
     * @param organizationid
     * @param model
     * @return
     */
    @RequestMapping(value = "/organizationapplyin", method = RequestMethod.POST)
    public String organizationApplyIn(@RequestParam("organizationid") int organizationid,
                                      @RequestParam("chooseradio") int departmentid,
                                      @RequestParam("adjust") int adjust,
                                      @RequestParam("reason") String reason,
                                      Model model) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("organization/organizationapplyin  get request");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Student me = studentService.getStudentByEmail(shiroUser.getEmail());
        organizationServiceI.addStudentOrganizationLink(false, me.getId(), organization.getId(), departmentid, adjust, reason);
        OrganizationDepartment department = organizationServiceI.getOrganizationDepartment(departmentid);
        department.setMaxNumbers(department.getMaxNumbers() - 1);
        organizationServiceI.updateOrganizationDepartment(department);
        return "redirect:/organization/organizationmain?organizationid=" + organizationid;
    }

    @RequestMapping(value = "addorganizationdepartmentandposition", method = RequestMethod.POST)
    public String addOrganizationDepartmentAndPostion(@RequestParam("departments") String departments,
                                                      @RequestParam("positions") String positions,
                                                      @RequestParam("organizationid") int organizationid) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("addorganizationdepartmentandposition post request");
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        organizationServiceI.addOrganizationPosition(organization, positions.split(","));
        organizationServiceI.addOrganizationDepartment(organization, departments.split(","));
        return "redirect:/organization/organizationmember?organizationid=" + organizationid;
    }


    @RequestMapping(value = "distributedepartment", method = RequestMethod.GET)
    public String distributeDepartment(@RequestParam("departmentid") int departmentid,
                                       @RequestParam("organizationid") int organizationid,
                                       @RequestParam("studentids") String studentids) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("addorganizationdepartmentandposition post request");
        String[] ids = studentids.split(",");
        for (String id : ids) {
            StudentOrganizationLink link = organizationServiceI.getAStudentOrganizationLink(Integer.valueOf(id), organizationid);
            link.setOrganizationDepartment(organizationServiceI.getOrganizationDepartment(departmentid));
            organizationServiceI.updateStudentOrganization(link);
        }
        return "redirect:/organization/organizationmember?organizationid=" + organizationid;
    }

    @RequestMapping(value = "distributeposition", method = RequestMethod.GET)
    public String distributePosition(@RequestParam("positionid") int positionid,
                                     @RequestParam("organizationid") int organizationid,
                                     @RequestParam("studentids") String studentids) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("addorganizationdepartmentandposition post request");
        String[] ids = studentids.split(",");
        for (String id : ids) {
            StudentOrganizationLink link = organizationServiceI.getAStudentOrganizationLink(Integer.valueOf(id), organizationid);
            link.setOrganizationPosition(organizationServiceI.getOrganizationPosition(positionid));
            organizationServiceI.updateStudentOrganization(link);
        }
        return "redirect:/organization/organizationmember?organizationid=" + organizationid;
    }


    @RequestMapping(value = "departmentconfig", method = RequestMethod.POST)
    public String departmentConfig(@RequestParam("ids") String ids,
                                   @RequestParam("numbers") String numbers,
                                   @RequestParam("checkeds") String checkeds,
                                   @RequestParam("organizationid") int organizationid
    ) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("departmentconfig post request");
        logger.info("ids:" + ids);
        logger.info("numbers:" + numbers);
        logger.info("checkeds:" + checkeds);
        Organization organization = organizationServiceI.getOrganizationById(organizationid);
        List<OrganizationDepartment> departments = organizationServiceI.getAllDepartmentsByOrganization(organization);
        String[] str_id = ids.split(",");
        String[] str_number = numbers.split(",");
        String[] str_open = checkeds.split(",");
        if (departments != null && departments.size() > 0 && departments.size() == str_id.length && str_number.length == str_open.length && str_id
                .length == str_number.length) {
            for (int i = 0; i < departments.size(); i++) {
                for (int j = 0; j < str_id.length; j++) {
                    if (departments.get(i).getId() == Integer.valueOf(str_id[j])) {
                        departments.get(i).setMaxNumbers(Integer.valueOf(str_number[j]));
                        departments.get(i).setOpen(Integer.valueOf(str_open[j]) == 1 ? true : false);
                    }
                }
            }
            for (OrganizationDepartment department : departments) {
                organizationServiceI.updateOrganizationDepartment(department);
            }
        }
        return "redirect:/organization/organizationmemberapply?organizationid=" + organizationid;
    }


    @RequestMapping(value = "auditstudent", method = RequestMethod.GET)
    public String auditStudent(@RequestParam("organizationid") int organizationid,
                               @RequestParam("studentids") String studentids,
                               @RequestParam("auditresult") boolean auditresult
    ) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("auditstudent get request");
        String[] ids = studentids.split(",");
        for (String id : ids) {
            StudentOrganizationLink link = organizationServiceI.getAStudentOrganizationLink(Integer.valueOf(id), organizationid);
            if (auditresult) {
                link.setStatus(1);
                organizationServiceI.updateStudentOrganization(link);
            } else {
                organizationServiceI.deleteStudentOrganizationLink(link);
            }
        }
        return "redirect:/organization/organizationmemberapply?organizationid=" + organizationid;
    }


    @RequestMapping(value = "removestudent", method = RequestMethod.GET)
    public String removeStudent(@RequestParam("organizationid") int organizationid,
                                @RequestParam("studentids") String studentids,
                                @RequestParam("status") String status
    ) {
        SecurityUtils.getSubject().checkRole("student");
        logger.info("removestudent get request");
        String[] ids = studentids.split(",");
        for (String id : ids) {
            StudentOrganizationLink link = organizationServiceI.getAStudentOrganizationLink(Integer.valueOf(id), organizationid);
            organizationServiceI.deleteStudentOrganizationLink(link);
        }
        if (status.equals("member")) {
            return "redirect:/organization/organizationmember?organizationid=" + organizationid;
        } else if (status.equals("memberapply")) {
            return "redirect:/organization/organizationmemberapply?organizationid=" + organizationid;
        } else {
            return "redirect:/";
        }
    }
}
