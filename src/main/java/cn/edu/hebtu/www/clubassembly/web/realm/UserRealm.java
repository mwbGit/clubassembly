package cn.edu.hebtu.www.clubassembly.web.realm;


import cn.edu.hebtu.www.clubassembly.utils.Constant;
import cn.edu.hebtu.www.clubassembly.utils.PasswordHelper;
import cn.edu.hebtu.www.clubassembly.web.model.Admin;
import cn.edu.hebtu.www.clubassembly.web.model.Role;
import cn.edu.hebtu.www.clubassembly.web.model.ShiroUser;
import cn.edu.hebtu.www.clubassembly.web.model.Student;
import cn.edu.hebtu.www.clubassembly.web.service.AdminServiceI;
import cn.edu.hebtu.www.clubassembly.web.service.StudentServiceI;
import com.sun.mail.handlers.text_html;
import org.apache.log4j.Logger;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.Set;

public class UserRealm extends AuthorizingRealm {
    private Logger logger = Logger.getLogger(UserRealm.class);
    @Resource
    private StudentServiceI studentService;
    @Resource
    private AdminServiceI adminService;
    @Resource
    private PasswordHelper passwordHelper;

    /**
     * 授权。
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
        if (shiroUser.getRole().equals(Constant.ADMINISTRATOR)) {
            SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
            Admin admin = adminService.getAdminByEmail(shiroUser.getEmail());
            Set<Role> roles = admin.getRoles();
            logger.info("roles.size :" + roles.size());
            Set<String> rolesPara = new HashSet<String>();
            for (Role role : roles) {
                String str = role.getRole();
                rolesPara.add(str);
            }
            authorizationInfo.setRoles(rolesPara);
            return authorizationInfo;
        } else if (shiroUser.getRole().equals(Constant.STUDENT)) {
            SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
            Student student = studentService.getStudentByEmail(shiroUser.getEmail());
            Set<Role> roles = student.getRoles();
            logger.info("roles.size :" + roles.size());
            Set<String> rolesPara = new HashSet<String>();
            for (Role role : roles) {
                String str = role.getRole();
                rolesPara.add(str);
            }
            authorizationInfo.setRoles(rolesPara);
            return authorizationInfo;
        } else {
            return null;
        }
    }

    /**
     * 认证。
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String principal = (String) token.getPrincipal();
        String[] temp = principal.split(":");
        if (temp[0].equals(Constant.ADMINISTRATOR)) {
            String inputPassword = new String((char[]) token.getCredentials());
            try {
                Admin admin = adminService.getAdminByEmail(temp[1]);
                if (admin != null) {
                    if (passwordHelper.authenticationAdminPassword(inputPassword, admin)) {
                        ShiroUser shiroUser = new ShiroUser();
                        shiroUser.setUserId(admin.getId());
                        shiroUser.setRole(Constant.ADMINISTRATOR);
                        shiroUser.setUserName(admin.getName());
                        shiroUser.setEmail(admin.getEmail());
                        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(
                                shiroUser,
                                inputPassword,
                                getName()
                        );
                        return authenticationInfo;
                    } else {
                        throw new IncorrectCredentialsException();
                    }
                } else {
                    throw new UnknownAccountException();
                }
            } catch (Exception e) {
                e.printStackTrace();
                throw new UnknownAccountException();
            }
        } else if (temp[0].equals(Constant.STUDENT)) {
            String inputPassword = new String((char[]) token.getCredentials());
            try {
                Student student = studentService.getStudentByEmail(temp[1]);
                if (student != null) {
                    if (passwordHelper.authenticationStudentPassword(inputPassword, student)) {
                        ShiroUser shiroUser = new ShiroUser();
                        shiroUser.setUserId(student.getId());
                        shiroUser.setRole(Constant.STUDENT);
                        shiroUser.setImage(Constant.STUDENT_IMAGE_PREFIX + student.getImage());
                        if (student.getPersoncode() == null) {
                            shiroUser.setPersoncode("");
                        } else {
                            shiroUser.setPersoncode(student.getPersoncode());
                        }

                        shiroUser.setUserName(student.getName());
                        shiroUser.setEmail(student.getEmail());
                        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(
                                shiroUser,
                                inputPassword,
                                getName()
                        );
                        return authenticationInfo;
                    } else {
                        throw new IncorrectCredentialsException();
                    }
                } else {
                    throw new UnknownAccountException();
                }
            } catch (Exception e) {
                e.printStackTrace();
                throw new UnknownAccountException();
            }
        } else {
            throw new UnknownAccountException();
        }
    }
}
