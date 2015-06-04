package cn.edu.hebtu.www.clubassembly.web.controller;

import cn.edu.hebtu.www.clubassembly.web.model.Organization;
import cn.edu.hebtu.www.clubassembly.web.service.OrganizationServiceI;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import java.util.List;


/**
 * 名称：游客主页控制器
 * 作者：陈志兵
 */
@Controller
public class IndexController {
    private Logger logger = Logger.getLogger(IndexController.class);
    @Resource
    private OrganizationServiceI organizationServiceI;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(Model model) {
        logger.info("index request");
        List<Organization> organizations = organizationServiceI.getAllOrganization();
        model.addAttribute("organizations",organizations);
        return "/index";
    }
}
