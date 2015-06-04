package cn.edu.hebtu.www.clubassembly.web.controller;

import cn.edu.hebtu.www.clubassembly.common.model.Reply;
import cn.edu.hebtu.www.clubassembly.common.service.EmailService;
import cn.edu.hebtu.www.clubassembly.utils.BaseUtils;
import cn.edu.hebtu.www.clubassembly.utils.Constant;
import cn.edu.hebtu.www.clubassembly.utils.FileUtils;
import cn.edu.hebtu.www.clubassembly.utils.PasswordHelper;
import cn.edu.hebtu.www.clubassembly.web.model.*;
import cn.edu.hebtu.www.clubassembly.web.service.RoleServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.SchoolServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.StudentServiceI;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
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
import java.io.IOException;
import java.util.*;


@Controller
public class LoginController {

    private Logger logger = Logger.getLogger(LoginController.class);
    @Resource
    private StudentServiceI studentService;
    @Resource
    private SchoolServiceI schoolService;
    @Resource
    private RoleServiceI roleService;
    @Resource
    private EmailService emailService;
    @Resource
    private PasswordHelper passwordHelper;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        logger.info("login get request");
        return "/login";
    }


//    @RequestMapping(value = "list")
//    public String list(@RequestParam(value = "sortType", defaultValue = "auto") String sortType,
//                       @RequestParam(value = "page", defaultValue = "1") int pageNumber, Model model, HttpServletRequest request) {
//
//        model.addAttribute("schlAdmins", adminUsers);
//        model.addAttribute("sortType", sortType);
//        model.addAttribute("sortTypes", sortTypes);
//        model.addAttribute("searchParams", Servlets.encodeParameterStringWithPrefix(searchParams, "search_"));
//        model.addAttribute("searchParamsMap", searchParams);
//
//        return "account/schoolAdminList";
//    }


    /**
     * @param email
     * @param password
     * @param model
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam String email, @RequestParam String password, Model model) {
        logger.info("login post request");
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(Constant.STUDENT + ":" + email, password, false);
        try {
            subject.login(token);
            Student student = studentService.getStudentByEmail(email);
            if (student != null && student.getActivate() == 0) {
                //用户未激活
                SecurityUtils.getSubject().logout();
                Reply<String> reply = new Reply<String>();
                reply.setCode(Constant.NOT_ACTIVATE);
                reply.setReply("您的账号未被激活，请先去您的邮箱进行激活。");
                model.addAttribute("reply", reply);
                return "/login";
            } else {
                return "redirect:/home/main";
            }
        } catch (UnknownAccountException e) {
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.NO_THIS_ACCOUNT);
            reply.setReply("没有这个用户");
            model.addAttribute("reply", reply);
            return "/login";
        } catch (IncorrectCredentialsException e) {
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.Name_OR_PASSWORD_ERROR);
            reply.setReply("用户名或密码错误。");
            model.addAttribute("reply", reply);
            return "/login";
        }
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register(Model model) {
        logger.info("register  get request");

//      得到所有省份
        List<Province> provinces = schoolService.getAllProvince();

        List<City> cities = schoolService.getCities(Constant.CITY_DEFAULT);

        List<School> schools = schoolService.getSchools(Constant.SCHOOL_DEFAULT);

        model.addAttribute("provinces", provinces);

        model.addAttribute("cities", cities);

        model.addAttribute("schools", schools);
        return "/register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(@RequestParam(value = "city") int cityid,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam(value = "province") int provinceid,
                           @RequestParam(value = "school") int schoolid,
                           @RequestParam(value = "name") String name,
                           @RequestParam String imagelocation,
                           Model model) {
        logger.info("register  post request");
        try {
            Province province = schoolService.getProvinceByProvinceID(provinceid);
            City city = schoolService.getCityByCityID(cityid);
            School school = schoolService.getSchoolBySchoolID(schoolid);
            Role role = roleService.getRoleByName(Constant.STUDENT);
            Set<Role> roles = new HashSet<Role>();
            roles.add(role);
            Student student = new Student();
            student.setRegisterTime(new Date());
            student.setSchool(school);
            student.setProvince(province);
            student.setCity(city);
            student.setEmail(email);
            student.setRoles(roles);
            student.setPassword(password);
            student.setImage(imagelocation);
            student.setActivate(0);
            student.setName(name);

            studentService.addStudent(student);
            String content = passwordHelper.generateContent(student);
            emailService.sendMail("激活账号邮件", content, student.getEmail());
            Reply<String> reply = new Reply<String>();
            reply.setCode(1);
            reply.setReply("你在24小时内激活您的账号。");
            model.addAttribute("reply", reply);
            return "/register";
        } catch (Exception exception) {
            exception.printStackTrace();
            return "redirect:/";
        }
    }


    @RequestMapping(value = "/getcity", method = RequestMethod.POST)
    public void getCitesByProvinceId(@RequestParam int provinceid, HttpServletResponse response) throws IOException {
        logger.info("getcity request");
        List<City> cities = schoolService.getCitiesByID(provinceid);
        try {
            if (cities != null && cities.size() > 0) {
                Reply<List<City>> reply = new Reply<List<City>>();
                reply.setCode(1);
                reply.setReply(cities);
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

    @RequestMapping(value = "/getschool", method = RequestMethod.POST)
    public void getSchoolsByCityId(@RequestParam int cityid, HttpServletResponse response) throws IOException {
        List<School> schools = schoolService.getSchoolsByID(cityid);
        try {
            if (schools != null && schools.size() > 0) {
                Reply<List<School>> reply = new Reply<List<School>>();
                reply.setCode(1);
                reply.setReply(schools);
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

    @RequestMapping(value = "/active", method = RequestMethod.GET)
    public String activeStudent(@RequestParam String token) {
//      激活账号接口
        String email = passwordHelper.parseEmailFromToken(token);
        Student student = studentService.getStudentByEmail(email);
        if (student != null) {
//           此用户没有被删除呢，
            if (student.getActivate() == 0) {
                //未激活
                //注册时间
                Date registerDate = passwordHelper.parseRegisterDateFromToken(token);
                logger.info("registerDate:" + registerDate);
                // 过期时间
                Date outime = BaseUtils.StringToDate(BaseUtils.getSpecifiedDay(BaseUtils.DateToString(registerDate), 1));
                //      当前时间
                logger.info("outime:" + outime);
                Date nowDate = new Date();
                logger.info("nowDate:" + nowDate);
                //日期型数据的比较..
                int i = nowDate.compareTo(outime);
                if (i == -1 || i == 0) {
                    //当前时间小于等于过期时间
                    //可以激活
                    student.setActivate(1);
                    studentService.updateStudent(student);
                    return "redirect:/";
                } else {
                    //当前时间大于过期时间
                    //激活过时
//                  删除此用户
                    studentService.deleteStudent(student);
                    return "redirect:/";
                }
            } else {
//                重复激活
                return "redirect:/";
            }
        } else {
//            此用户已经超过24个小时,已被删除了。
            return "redirect:/";
        }
    }


    @RequestMapping(value = "/checkemail", method = RequestMethod.GET)
    public void checkEmail(@RequestParam String email, HttpServletResponse response) {
        try {
            Student student = studentService.getStudentByEmail(email);
            if (student != null) {
                response.getWriter().print(false);
            } else {
                response.getWriter().print(true);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/uploadstudentimage", method = RequestMethod.POST)
    public void uploadStudentImage(HttpServletRequest request,
                                   HttpServletResponse response,
                                   @RequestParam("fileToUpload") CommonsMultipartFile commonsMultipartFile1) {
        //物理存储路径：C:\Users\Administrator\AppData\Local\apache-tomcat-7.0.53\clubassemblyResources\organization\1\image\xxxxxxxxxx.jpg
        //逻辑路径：/clubassemblyResources\student\image\xxxxxxxxxx.jpg
        //访问路径：http://localhost：/clubassemblyResources\student\image\xxxxxxxxxx.jpg
        logger.info("判断路径存在与否");
        String str = request.getSession().getServletContext().getRealPath("");
        logger.info("上下文路径:" + str);
        str = str.replace("\\", "/");
        logger.info("上下文路径:" + str);
        str = str.substring(0, str.indexOf("/webapps/clubassembly"));
        logger.info("tomcat根路径:" + str);
        String savePath = str + "/clubassemblyResources/student/";
        logger.info(savePath);
        File myFilePath = new File(savePath);
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
                reply.setCode(Constant.UPLOAD_STUDENT_IMAGE_SUCCESS);
                reply.setReply(savePath + filename);
                response.getWriter().print(BaseUtils.gson.toJson(reply));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    @RequestMapping("/logout")
    public String logout() {
        SecurityUtils.getSubject().logout();
        return "redirect:/";
    }
}
