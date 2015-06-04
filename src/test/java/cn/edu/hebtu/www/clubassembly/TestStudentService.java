package cn.edu.hebtu.www.clubassembly;


import cn.edu.hebtu.www.clubassembly.common.dao.BaseDaoI;
import cn.edu.hebtu.www.clubassembly.web.model.*;
import cn.edu.hebtu.www.clubassembly.web.service.*;
import org.apache.log4j.Logger;
import org.junit.Assert;
import org.junit.Test;
import org.omg.DynamicAny._DynAnyFactoryStub;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Administrator on 15-3-21.
 */
public class TestStudentService {
    private Logger logger = Logger.getLogger(TestStudentService.class);
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Logger getLogger() {

        return logger;
    }

    public void setLogger(Logger logger) {
        this.logger = logger;
    }

    //@Test
    public void testStudent() {
        ApplicationContext ac = new ClassPathXmlApplicationContext(new String[]{"classpath:spring.xml", "classpath:spring-hibernate.xml"});
        RoleServiceI roleServiceI = (RoleServiceI) ac.getBean("roleServiceImplement");
        StudentServiceI studentServiceI = (StudentServiceI) ac.getBean("studentServiceImplement");
        SchoolServiceI schoolServiceI = (SchoolServiceI) ac.getBean("schoolServiceImplement");
        OrganizationServiceI organizationServiceI = (OrganizationServiceI) ac.getBean("organizationServiceImplement");

        Role studentRole = new Role();
        studentRole.setRole("student");
        studentRole.setAvailable(1);
        studentRole.setDescription("学生角色");
        roleServiceI.addRole(studentRole);

        Role adminRole = new Role();
        adminRole.setRole("admin");
        adminRole.setAvailable(1);
        adminRole.setDescription("管理员角色");
        roleServiceI.addRole(adminRole);

        Set<Role> studentRoles = new HashSet<Role>();
        studentRoles.add(studentRole);


        Province province = schoolServiceI.getProvinceByProvinceName("河北");
        City city = schoolServiceI.getCityByCityName("石家庄市");
        School school = schoolServiceI.getSchoolBySchoolName("河北师范大学");

        Student student = new Student();
        student.setName("陈志兵");
        student.setEmail("641041018@qq.com");
        student.setMajor("计算机科学与技术");
        student.setPassword("admin");
        student.setQQ("641041018");
        student.setProvince(province);
        student.setCity(city);
        student.setSchool(school);
        student.setTelephone("18233158677");
        student.setSex("男");
        student.setActivate(1);
        student.setRegisterTime(new Date());
        student.setRoles(studentRoles);

        studentServiceI.addStudent(student);

    }

    //@Test
    public void testEntity() {
        boolean flag = false;
        try {
            Student student = new Student();
            student.setName("陈志兵");
            student.setEmail("641041018@qq.com");
            student.setMajor("计算机科学与技术");
            student.setPassword("admin");
            student.setQQ("641041018");
            student.setTelephone("18233158677");
            student.setSex("男");
            student.setActivate(1);
            student.setRegisterTime(new Date());
            flag = true;
        } catch (Exception e) {
            flag = false;
        }
        Assert.assertTrue("学生实体逻辑性不正确", flag);
    }


    //@Test
    public void testDao() {
        boolean flag = false;
        try {
            ApplicationContext ac = new ClassPathXmlApplicationContext(
                    new String[]{"classpath:spring.xml", "classpath:spring-hibernate.xml"});
            BaseDaoI<Student> studentdao = (BaseDaoI) ac.getBean("studentdao");
            Student student = new Student();
            student.setName("陈志兵");
            student.setEmail("641041018@qq.com");
            student.setMajor("计算机科学与技术");
            student.setPassword("admin");
            student.setQQ("641041018");
            student.setTelephone("18233158677");
            student.setSex("男");
            student.setActivate(1);
            student.setRegisterTime(new Date());
            studentdao.save(student);
            flag = true;
        } catch (Exception e) {
            flag = false;
        }
        Assert.assertTrue("数据库访问层保存学生实体出错", flag);
    }

    //@Test
    public void testService() {
        boolean flag = false;
        try {
            ApplicationContext ac = new ClassPathXmlApplicationContext(
                    new String[]{"classpath:spring.xml", "classpath:spring-hibernate.xml"});
            StudentServiceI studentServiceI = (StudentServiceI) ac.getBean("studentServiceImplement");
            Student student = new Student();
            student.setName("陈志兵");
            student.setEmail("641041018@qq.com");
            student.setMajor("计算机科学与技术");
            student.setPassword("admin");
            student.setQQ("641041018");
            student.setTelephone("18233158677");
            student.setSex("男");
            student.setActivate(1);
            student.setRegisterTime(new Date());
            studentServiceI.addStudent(student);
            flag = true;
        } catch (Exception e) {
            flag = false;
        }
        Assert.assertTrue("业务逻辑层保存学生实体出错", flag);
    }

    //        @Test
    public void ssTess() {
//        Date registerDate = new Date();
//        // 过期时间
//        Date outime = BaseUtils.StringToDate(BaseUtils.getSpecifiedDay(BaseUtils.DateToString(registerDate), 1));
//        logger.info(outime);
//        logger.info(registerDate);

//        Date date = new Date();
//        Date expectMinRegisterDate = BaseUtils.StringToDate(BaseUtils.getSpecifiedDay(BaseUtils.DateToString(date), -1));

//        logger.info(date);
//        logger.info(expectMinRegisterDate);
    }


//    public static void main(String[] args) {
//        String a = "Programming";
//        String b = new String("Programming");
//        String c = "Program" + "ming";
//
//        System.out.println(a == b);
//        System.out.println(a == c);
//        System.out.println(a.equals(b));
//        System.out.println(a.equals(c));
//        System.out.println(a.intern() == b.intern());
//
//
//        System.out.println(Math.round(-11.6));
//        System.out.println(Math.round(-11.1));
//
//    }


   //@Test
    public void testAdmin() {
        ApplicationContext ac = new ClassPathXmlApplicationContext(
                new String[]{
                        "classpath:spring.xml",
                        "classpath:spring-hibernate.xml"
                       });
        RoleServiceI roleServiceI = (RoleServiceI) ac.getBean("roleServiceImplement");
        AdminServiceI adminServiceI = (AdminServiceI) ac.getBean("adminServiceImplement");


        String [] adminRoles  = {
                "student_manager",
                "organization_manager" ,
                "admin"};
        Admin admin = new Admin();
        admin.setEmail("641041018@qq.com");
        admin.setName("超级管理员");
        admin.setPassword("admin");
        admin.setRegisterTime(new Date());
        admin.setTelephone("18233158677");
        admin.setRoles(roleServiceI.getRolesByNames(adminRoles));
        adminServiceI.addAdmin(admin);
    }
}
