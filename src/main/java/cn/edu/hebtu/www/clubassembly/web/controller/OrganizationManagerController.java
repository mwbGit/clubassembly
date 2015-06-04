package cn.edu.hebtu.www.clubassembly.web.controller;

import cn.edu.hebtu.www.clubassembly.common.model.Reply;
import cn.edu.hebtu.www.clubassembly.common.service.EmailService;
import cn.edu.hebtu.www.clubassembly.utils.Constant;
import cn.edu.hebtu.www.clubassembly.web.model.Organization;
import cn.edu.hebtu.www.clubassembly.web.model.Student;
import cn.edu.hebtu.www.clubassembly.web.service.OrganizationServiceI;
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


/**
 * 名称：游客主页控制器
 * 作者：陈志兵
 */
@Controller
@RequestMapping(value = "/manager/organization")
public class OrganizationManagerController {
    private Logger logger = Logger.getLogger(OrganizationManagerController.class);

    @Resource
    private OrganizationServiceI organizationService;
    @Resource
    private EmailService emailService;

    @RequestMapping(value = "/organizationmanager", method = RequestMethod.GET)
    public String organizationManager() {
        logger.info("organizationmanager request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        return "/manager/organization/organization_manager";
    }

    @RequestMapping(value = "/organizationnotauditmanager", method = RequestMethod.GET)
    public String organizationNotAuditManager(Model model) {
        logger.info("organizationnotauditmanager request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        List<Organization> notAuditOrganizations = organizationService.getAllNotAuditOrganization();
        model.addAttribute("notAuditOrganizations", notAuditOrganizations);
        return "/manager/organization/organization_not_audit_manager";
    }

    @RequestMapping(value = "/organizationalreadydeletemanager", method = RequestMethod.GET)
    public String organizationAlreadyDeleteManager(Model model) {
        logger.info("organizationalreadydeletemanager request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        List<Organization> deleteOrganizations = organizationService.getAllDeleteOrganization();
        model.addAttribute("deleteOrganizations", deleteOrganizations);
        return "/manager/organization/organization_already_delete_manager";
    }

    @RequestMapping(value = "/organizationauditsuccessmanager", method = RequestMethod.GET)
    public String organizationAuditSuccessManager(Model model) {
        logger.info("organizationauditsuccessmanager request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        List<Organization> auditSuccessOrganizations = organizationService.getAllAuditSuccessOrganization();
        model.addAttribute("auditSuccessOrganizations", auditSuccessOrganizations);
        return "/manager/organization/organization_audit_success_manager";
    }

    @RequestMapping(value = "/organizationauditfailmanager", method = RequestMethod.GET)
    public String organizationAuditFailManager(Model model) {
        logger.info("organizationauditfailmanager request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        List<Organization> auditFailOrganizations = organizationService.getAllAuditFailOrganization();
        model.addAttribute("auditFailOrganizations", auditFailOrganizations);
        return "/manager/organization/organization_audit_fail_manager";
    }


    @RequestMapping(value = "/organizationmainpage", method = RequestMethod.GET)
    public String organizationMainPage(@RequestParam("id") int id, Model model) {
        logger.info("/manager/organization/organizationmainpage request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        Organization organization = organizationService.getOrganizationById(id);
        model.addAttribute("organization", organization);
        return "/manager/organization/organization_main_page";
    }

    @RequestMapping(value = "/organizationaudit", method = RequestMethod.GET)
    public String organizationAudit(@RequestParam("id") int id, Model model) {
        logger.info("/manager/organization/organizationaudit request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        Organization organization = organizationService.getOrganizationById(id);
        Student student = organizationService.getCommenderByOrganization(organization);
        model.addAttribute("organization", organization);
        model.addAttribute("student", student);
        return "/manager/organization/organization_audit";
    }


    @RequestMapping(value = "/organizationaudit", method = RequestMethod.POST)
    public String organizationAudit(@RequestParam("id") int id,
                                    @RequestParam("auditStatus") int auditStatus,
                                    @RequestParam("auditMessage") String auditMessage,
                                    RedirectAttributes redirectAttributes) {
        logger.info("/manager/organization/organizationaudit request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        Organization organization = organizationService.getOrganizationById(id);
        organization.setStatus(auditStatus);
        organization.setAuditMessage(auditMessage);
        Student student = organizationService.getCommenderByOrganization(organization);
        try {
            emailService.sendMail("社团审核邮件", organization.getAuditMessage(), student.getEmail());
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_AUDIT_ORGANIZATION_SUCCESS);
            reply.setDetail("审核社团成功，并已成功发送邮件！");
            reply.setReply("审核社团成功，并已成功发送邮件！");
            redirectAttributes.addFlashAttribute("reply", reply);
            return "redirect:/manager/organization/organizationnotauditmanager";
        } catch (Exception e) {
            e.printStackTrace();
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_AUDIT_ORGANIZATION_FAIL);
            reply.setDetail("审核社团失败或发送邮件失败！");
            reply.setReply("审核社团失败或发送邮件失败！");
            redirectAttributes.addFlashAttribute("reply", reply);
            return "redirect:/manager/organization/organizationnotauditmanager";
        }
    }


    @RequestMapping(value = "/organizationmembermanager", method = RequestMethod.GET)
    public String organizationMemberManager(@RequestParam("id") int id, Model model) {
        logger.info("/manager/organization/organizationmainpage request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        Organization organization = organizationService.getOrganizationById(id);
        model.addAttribute("organization", organization);
        return "/manager/organization/organization_member_manager";
    }

    @RequestMapping(value = "/organizationmemberapplymanager", method = RequestMethod.GET)
    public String organizationMemberApplyManager(@RequestParam("id") int id, Model model) {
        logger.info("/manager/organization/organizationmemberapplymanager request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        Organization organization = organizationService.getOrganizationById(id);
        model.addAttribute("organization", organization);
        return "/manager/organization/organization_member_apply_manager";
    }

    @RequestMapping(value = "/organizationprofileview", method = RequestMethod.GET)
    public String organizationProfileView(@RequestParam("id") int id, Model model) {
        logger.info("/manager/organization/organizationprofileview request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        Organization organization = organizationService.getOrganizationById(id);
        model.addAttribute("organization", organization);
        return "/manager/organization/organization_profile_view";
    }


    @RequestMapping(value = "/organizationprofileupdate", method = RequestMethod.GET)
    public String organizationProfileUpdate(@RequestParam("id") int id, Model model) {
        logger.info("/manager/organization/organizationprofileupdate request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        Organization organization = organizationService.getOrganizationById(id);
        model.addAttribute("organization", organization);
        return "/manager/organization/organization_profile_update";
    }

    @RequestMapping(value = "/organizationdelete", method = RequestMethod.GET)
    public String organizationDelete(@RequestParam("ids") String ids, RedirectAttributes redirectAttributes) {
        logger.info("/manager/organization/organizationdelete request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        try {
            String[] id = ids.split(",");
            List<Organization> organizations = organizationService.getAllOrganizationByIds(id);
            for (Organization organization : organizations) {
                organization.setStatus(3);
                organizationService.updateOrganization(organization);
            }
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_DELETE_ORGANIZATION_SUCCESS);
            reply.setDetail("删除社团成功");
            reply.setReply("删除社团成功");
            redirectAttributes.addFlashAttribute("reply", reply);
            return "redirect:/manager/organization/organizationmanager";
        } catch (Exception e) {
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_DELETE_ORGANIZATION_FAIL);
            reply.setDetail("删除社团失败");
            reply.setReply("删除社团失败");
            redirectAttributes.addFlashAttribute("reply", reply);
            return "redirect:/manager/organization/organizationmanager";
        }
    }


    @RequestMapping(value = "/organizationcompletedelete", method = RequestMethod.GET)
    public String organizationCompleteDelete(@RequestParam("ids") String ids, RedirectAttributes redirectAttributes) {
        logger.info("/manager/organization/organizationdelete request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        try {
            String[] id = ids.split(",");
            List<Organization> organizations = organizationService.getAllOrganizationByIds(id);
            for (Organization organization : organizations) {
                organization.setStatus(4);
                organizationService.updateOrganization(organization);
            }
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_COMPLETE_DELETE_ORGANIZATION_SUCCESS);
            reply.setDetail("彻底删除社团成功");
            reply.setReply("彻底删除社团成功");
            redirectAttributes.addFlashAttribute("reply", reply);
            return "redirect:/manager/organization/organizationmanager";
        } catch (Exception e) {
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_COMPLETE_DELETE_ORGANIZATION_FAIL);
            reply.setDetail("彻底删除社团失败");
            reply.setReply("彻底删除社团失败");
            redirectAttributes.addFlashAttribute("reply", reply);
            return "redirect:/manager/organization/organizationmanager";
        }
    }

    @RequestMapping(value = "/organizationrestore", method = RequestMethod.GET)
    public String organizationRestore(@RequestParam("ids") String ids, RedirectAttributes redirectAttributes) {
        logger.info("/manager/organization/organizationrestore request");
        SecurityUtils.getSubject().checkRole("organization_manager");
        try {
            String[] id = ids.split(",");
            List<Organization> organizations = organizationService.getAllOrganizationByIds(id);
            for (Organization organization : organizations) {
                organization.setStatus(0);
                organizationService.updateOrganization(organization);
            }
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_RESTORE_ORGANIZATION_SUCCESS);
            reply.setDetail("还原社团成功");
            reply.setReply("还原社团成功");
            redirectAttributes.addFlashAttribute("reply", reply);
            return "redirect:/manager/organization/organizationmanager";
        } catch (Exception e) {
            Reply<String> reply = new Reply<String>();
            reply.setCode(Constant.MANAGER_RESTORE_ORGANIZATION_FAIL);
            reply.setDetail("还原社团失败");
            reply.setReply("还原社团失败");
            redirectAttributes.addFlashAttribute("reply", reply);
            return "redirect:/manager/organization/organizationmanager";
        }
    }


}
