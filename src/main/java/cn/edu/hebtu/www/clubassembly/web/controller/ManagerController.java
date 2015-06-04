package cn.edu.hebtu.www.clubassembly.web.controller;

import cn.edu.hebtu.www.clubassembly.common.model.Reply;
import cn.edu.hebtu.www.clubassembly.utils.BaseUtils;
import cn.edu.hebtu.www.clubassembly.utils.Constant;
import cn.edu.hebtu.www.clubassembly.web.model.*;
import cn.edu.hebtu.www.clubassembly.web.service.AdminServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.RoleServiceI;
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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@Controller
@RequestMapping(value = "/manager")
public class ManagerController {
    private Logger logger = Logger.getLogger(ManagerController.class);

    @Resource
    private AdminServiceI adminService;

    @Resource
    private RoleServiceI roleServiceI;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        logger.info("login request");
        return "/manager/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam("email") String email, @RequestParam("password") String password, Model model) {
        logger.info("login post request");
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(Constant.ADMINISTRATOR + ":" + email, password, false);
        try {
            subject.login(token);
            return "redirect:/manager/home";
        } catch (UnknownAccountException e) {
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.NO_THIS_ACCOUNT);
            reply.setReply("没有这个用户");
            model.addAttribute("reply", reply);
            return "/manager/login";
        } catch (IncorrectCredentialsException e) {
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.Name_OR_PASSWORD_ERROR);
            reply.setReply("用户名或密码错误。");
            model.addAttribute("reply", reply);
            return "/manager/login";
        }
    }


    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String home() {
        logger.info("home request");
        SecurityUtils.getSubject().checkRole("student_manager");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        shiroUser.setManagerMenuStatus(Constant.MANAGER_MAIN);
        return "/manager/home";
    }

    @RequestMapping(value = "/adminprofile", method = RequestMethod.GET)
    public String adminProfile(Model model) {
        logger.info("adminprofile request");
        SecurityUtils.getSubject().checkRole("student_manager");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        Admin admin = adminService.getAdminByEmail(shiroUser.getEmail());
        model.addAttribute("admin", admin);
        return "/manager/admin_profile";
    }


    @RequestMapping(value = "/systemmonitor", method = RequestMethod.GET)
    public String systemMonitor() {
        logger.info("systemmonitor request");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        shiroUser.setManagerMenuStatus(Constant.MANAGER_SYSTEM_MANAGER);
        return "/manager/system_monitor";
    }


    @RequestMapping(value = "/systemconfig", method = RequestMethod.GET)
    public String systemConfig() {
        logger.info("systemconfig request");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        shiroUser.setManagerMenuStatus(Constant.MANAGER_SYSTEM_MANAGER);
        return "/manager/system_config";
    }

    @RequestMapping(value = "/rolemanager", method = RequestMethod.GET)
    public String roleManager(Model model) {
        logger.info("rolemanager request");
        SecurityUtils.getSubject().checkRole("admin");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        shiroUser.setManagerMenuStatus(Constant.MANAGER_ROLE_MANAGER);
        List<Role> roles = roleServiceI.getAllRole();
        model.addAttribute("roles", roles);
        return "/manager/role_manager";
    }



    @RequestMapping(value = "/membermanager", method = RequestMethod.GET)
    public String memberManager(Model model) {
        logger.info("membermanager request");
        SecurityUtils.getSubject().checkRole("admin");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        shiroUser.setManagerMenuStatus(Constant.MANAGER_ADMIN_MANAGER);
        List<Admin> adminList = adminService.getAllAdmins();
        model.addAttribute("adminList", adminList);
        return "/manager/member_manager";
    }


    @RequestMapping(value = "/membermanageradd", method = RequestMethod.GET)
    public String memberManagerAdd(Model model) {
        logger.info("membermanageradd get request");
        SecurityUtils.getSubject().checkRole("admin");
        return "/manager/member_manager_add";
    }

    @RequestMapping(value = "/membermanageradd", method = RequestMethod.POST)
    public String memberManagerAdd(@RequestParam("name") String name,
                                   @RequestParam("email") String email,
                                   @RequestParam("telephone") String telephone,
                                   @RequestParam("roles") String roles,
                                   @RequestParam("password") String password,
                                   Model model) {
        logger.info("membermanageradd post request");
        SecurityUtils.getSubject().checkRole("admin");
        try {
            Admin admin = new Admin();
            admin.setEmail(email);
            String[] role = roles.split(",");
            admin.setRoles(roleServiceI.getRolesByNames(role));
            admin.setName(name);
            admin.setPassword(password);
            admin.setTelephone(telephone);
            adminService.addAdmin(admin);
            Reply<String> reply = new Reply<String>();
            reply.setDetail("添加管理员成功.");
            reply.setCode(Constant.MANAGER_ADD_ADMIN_SUCCESS);
            reply.setReply("添加管理员成功");
            model.addAttribute("reply", reply);
            return "/manager/member_manager_add";
        } catch (Exception e) {
            e.printStackTrace();
            Reply<String> reply = new Reply<String>();
            reply.setDetail("添加管理员失败.");
            reply.setCode(Constant.MANAGER_ADD_ADMIN_FAIL);
            reply.setReply("添加管理员失败");
            model.addAttribute("reply", reply);
            return "/manager/member_manager_add";
        }
    }


    @RequestMapping(value = "/studentmanager", method = RequestMethod.GET)
    public String studentManager() {
        logger.info("studentmanager request");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        shiroUser.setManagerMenuStatus(Constant.MANAGER_STUDENT_MANAGER);
        return "redirect:/manager/student/studentmanager";
    }

    @RequestMapping(value = "/organizationmanager", method = RequestMethod.GET)
    public String organizationManager() {
        logger.info("organizationmanager request");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        shiroUser.setManagerMenuStatus(Constant.MANAGER_ORGANIZATION_MANAGER);
        return "redirect:/manager/organization/organizationmanager";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout() {
        logger.info("logout request");
        SecurityUtils.getSubject().logout();
        return "redirect:/manager/login";
    }

    @RequestMapping(value = "/getmenustatus", method = RequestMethod.POST)
    public void getOrganizationSecondCategoryByMainCatgoryId(HttpServletResponse response) throws IOException {
        logger.info("/manager/getmenustatus request");
        SecurityUtils.getSubject().checkRole("student_manager");
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        try {
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_GET_MENU_STATUS_SUCCESS);
            reply.setReply(shiroUser.getManagerMenuStatus());
            reply.setDetail("得到菜单状态成功");
            response.getWriter().write(BaseUtils.gson.toJson(reply));
        } catch (IOException e) {
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_GET_MENU_STATUS_FAIL);
            reply.setReply(shiroUser.getManagerMenuStatus());
            reply.setDetail("得到菜单状态失败");
            response.getWriter().write(BaseUtils.gson.toJson(reply));
            e.printStackTrace();
        }
    }
}
