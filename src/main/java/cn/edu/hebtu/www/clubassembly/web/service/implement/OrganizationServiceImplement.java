package cn.edu.hebtu.www.clubassembly.web.service.implement;

import cn.edu.hebtu.www.clubassembly.common.dao.BaseDaoI;
import cn.edu.hebtu.www.clubassembly.web.model.*;
import cn.edu.hebtu.www.clubassembly.web.service.OrganizationServiceI;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by Administrator on 15-3-28.
 */
@Service
public class OrganizationServiceImplement implements OrganizationServiceI {
    @Resource
    private BaseDaoI<OrganizationSecondCategory> organizationSecondCategorydao;
    @Resource
    private BaseDaoI<OrganizationMainCategory> organizationMainCategorydao;
    @Resource
    private BaseDaoI<Organization> organizationdao;
    @Resource
    private BaseDaoI<OrganizationDepartment> departmentdao;
    @Resource
    private BaseDaoI<OrganizationPosition> positiondao;
    @Resource
    private BaseDaoI<OrganizationProperty> propertydao;
    @Resource
    private BaseDaoI<StudentOrganizationLink> studentOrganizationdao;
    @Resource
    private BaseDaoI<Student> studentdao;

    @Override
    public List<OrganizationMainCategory> getAllOrganizationMainCategory() {
        String hql = "from OrganizationMainCategory t ";
        return organizationMainCategorydao.find(hql);
    }

    @Override
    public List<OrganizationSecondCategory> getOrganizationSecondCategoryByMainCategoryId(int id) {
        OrganizationMainCategory main = getOrganizationMainCategoryById(id);
        String hql = "from OrganizationSecondCategory t where t.organizationMainCategory=:main";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("main", main);
        return organizationSecondCategorydao.find(hql, params);
    }

    @Override
    public void addOrganization(String name, int property_id, int maincategory_id, int secondcategory_id, String imagelocation, String organizationcheckimagelocation) {
        OrganizationProperty property = getOrganizationPropertyById(property_id);
        OrganizationMainCategory mainCategory = getOrganizationMainCategoryById(maincategory_id);
        OrganizationSecondCategory secondCategory = getOrganizationSecondCategoryById(secondcategory_id);
        Organization organization = new Organization();
        organization.setName(name);
        organization.setStatus(0);
        organization.setImage(imagelocation);
        organization.setOrganizationcheckimagelocation(organizationcheckimagelocation);
        organization.setOrganizationMainCategory(mainCategory);
        organization.setOrganizationSecondCategory(secondCategory);
        organization.setProperty(property);
        organizationdao.save(organization);
    }

    @Override
    public void addStudentOrganizationLink(boolean isCommander, int student_id, int organization_id,
                                           int department_id, int position_id, int adjust, String reason) {
        Student student = getStudentById(student_id);
        Organization organization = getOrganizationById(organization_id);

        OrganizationDepartment department = null;
        if (department_id != 0) {
            department = getOrganizationDepartment(department_id);
        }
        OrganizationPosition position = null;
        if (organization_id != 0) {
            position = getOrganizationPosition(position_id);
        }

        StudentOrganizationLink studentOrganizationLink = new StudentOrganizationLink();
        if (isCommander) {
            studentOrganizationLink.setStatus(1);
            studentOrganizationLink.setAgreeAdjust(false);
        } else {
            studentOrganizationLink.setAgreeAdjust(adjust == 1 ? true : false);
            studentOrganizationLink.setStatus(0);
        }

        studentOrganizationLink.setApplyReason(reason);
        studentOrganizationLink.setCommander(isCommander);
        studentOrganizationLink.setOrganization(organization);
        if (department != null) {
            studentOrganizationLink.setOrganizationDepartment(department);
        }
        if (position != null) {
            studentOrganizationLink.setOrganizationPosition(position);
        }
        studentOrganizationLink.setStudent(student);
        studentOrganizationdao.save(studentOrganizationLink);
    }


    @Override
    public void addStudentOrganizationLink(boolean isCommander, int student_id, int organization_id) {
        addStudentOrganizationLink(isCommander, student_id, organization_id, 0, 0, 0, "");
    }

    @Override
    public void addStudentOrganizationLink(boolean isCommander, int student_id, int organization_id, int department_id, int adjust, String reason) {
        addStudentOrganizationLink(isCommander, student_id, organization_id, department_id, 0, adjust, reason);
    }

    @Override
    public void addOrganizationDepartment(Organization organization, String department) {
        OrganizationDepartment organizationDepartment = new OrganizationDepartment();
        organizationDepartment.setDepartment(department);
        organizationDepartment.setOrganization(organization);
        organizationDepartment.setMaxNumbers(0);
        organizationDepartment.setOpen(false);
        departmentdao.save(organizationDepartment);
    }


    @Override
    public OrganizationDepartment getOrganizationDepartment(int department_id) {
        String hql = "from OrganizationDepartment t where t.id=:id";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", department_id);
        return departmentdao.get(hql, params);
    }

    @Override
    public OrganizationPosition getOrganizationPosition(int position_id) {
        String hql = "from OrganizationPosition t where t.id=:id";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", position_id);
        return positiondao.get(hql, params);
    }

    @Override
    public List<OrganizationProperty> getAllOrganizationProperty() {
        String hql = "from OrganizationProperty";
        return propertydao.find(hql);
    }

    @Override
    public void updateOrganization(Organization organization) {
        organizationdao.update(organization);
    }

    @Override
    public Organization getOrganizationById(int organization_id) {
        String hql = "from Organization t where t.id=:id";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", organization_id);
        return organizationdao.get(hql, params);
    }

    @Override
    public Organization getOrganizationByName(String organization_name) {
        String hql = "from Organization t where t.name=:name";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("name", organization_name);
        return organizationdao.get(hql, params);
    }

    @Override
    public void addOrganizationPosition(Organization organization, String position) {
        OrganizationPosition organizationPosition = new OrganizationPosition();
        organizationPosition.setPosition(position);
        organizationPosition.setOrganization(organization);
        positiondao.save(organizationPosition);
    }

    @Override
    public void addOrganizationDepartment(Organization organization, String[] departments) {
        if (departments != null && departments.length > 0) {
            for (String department : departments) {
                addOrganizationDepartment(organization, department);
            }
        }
    }

    @Override
    public void addOrganizationPosition(Organization organization, String[] positions) {
        if (positions != null && positions.length > 0) {
            for (String position : positions) {
                addOrganizationPosition(organization, position);
            }
        }
    }

    @Override
    public OrganizationProperty getOrganizationPropertyById(int property_id) {
        String hql = "from OrganizationProperty t where t.id=:id";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", property_id);
        return propertydao.get(hql, params);
    }

    @Override
    public OrganizationMainCategory getOrganizationMainCategoryById(int maincategory_id) {
        String hql = "from OrganizationMainCategory t where t.id=:id";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", maincategory_id);
        return organizationMainCategorydao.get(hql, params);
    }

    @Override
    public OrganizationSecondCategory getOrganizationSecondCategoryById(int secondcategory_id) {
        String hql = "from OrganizationSecondCategory t where t.id=:id";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", secondcategory_id);
        return organizationSecondCategorydao.get(hql, params);
    }


    public Student getStudentById(int id) {
        String hql = "from Student t where t.id=:id";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return studentdao.get(hql, params);
    }

    @Override
    public List<Organization> getAllOrganizationBySomeStudentIsCammander(List<Student> sameCityStudents) {
//得到学生列表内所有学生创建的社团
        List<Organization> organizations = new ArrayList<Organization>();
        for (Student student : sameCityStudents) {
            List<Organization> temp = getAllOrganizationByIsCammander(student);
            if (temp != null && temp.size() > 0) {
                organizations.addAll(temp);
            }
        }
        if (organizations != null && organizations.size() > 0) {
            return organizations;
        } else {
            return null;
        }
    }

    @Override
    public List<Organization> getAllOrganizationByIsCammander(Student student) {
//        通过一个学生，得到这个学生创建的所有组织
        String hql = "from StudentOrganizationLink t where t.student=:student and t.commander=:iscommander";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("student", student);
        params.put("iscommander", true);
        List<StudentOrganizationLink> studentOrganizationLinks = studentOrganizationdao.find(hql, params);
        if (studentOrganizationLinks != null && studentOrganizationLinks.size() > 0) {
            List<Organization> organizations = new ArrayList<Organization>();
            for (StudentOrganizationLink studentOrganizationLink : studentOrganizationLinks) {
                organizations.add(studentOrganizationLink.getOrganization());
            }
            if (organizations != null && organizations.size() > 0) {
                return organizations;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public List<Organization> getAlreadyInOrganizations(Student student) {
//      得到一个学生已经加入的社团
        String hql = "from StudentOrganizationLink t where t.student=:student and t.status=:status";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("student", student);
        params.put("status", 1);
        List<StudentOrganizationLink> studentOrganizationLinks = studentOrganizationdao.find(hql, params);
        if (studentOrganizationLinks != null && studentOrganizationLinks.size() > 0) {
            List<Organization> organizations = new ArrayList<Organization>();
            for (StudentOrganizationLink studentOrganizationLink : studentOrganizationLinks) {
                organizations.add(studentOrganizationLink.getOrganization());
            }
            if (organizations != null && organizations.size() > 0) {
                return organizations;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public List<Organization> getWaitAuditOrganizations(Student student) {
        String hql = "from StudentOrganizationLink t where t.student=:student and t.status=:status";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("student", student);
        params.put("status", 0);
        List<StudentOrganizationLink> studentOrganizationLinks = studentOrganizationdao.find(hql, params);
        if (studentOrganizationLinks != null && studentOrganizationLinks.size() > 0) {
            List<Organization> organizations = new ArrayList<Organization>();
            for (StudentOrganizationLink studentOrganizationLink : studentOrganizationLinks) {
                organizations.add(studentOrganizationLink.getOrganization());
            }
            if (organizations != null && organizations.size() > 0) {
                return organizations;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public List<Student> getAllMembersByOrganization(Organization organization) {
        String hql = "from StudentOrganizationLink t where t.organization=:organization";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("organization", organization);
        List<StudentOrganizationLink> studentOrganizationLinks = studentOrganizationdao.find(hql, params);
        if (studentOrganizationLinks != null && studentOrganizationLinks.size() > 0) {
            List<Student> students = new ArrayList<Student>();
            for (StudentOrganizationLink studentOrganizationLink : studentOrganizationLinks) {
                students.add(studentOrganizationLink.getStudent());
            }
            if (students != null && students.size() > 0) {
                return students;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public Student getCommenderByOrganization(Organization organization) {
        String hql = "from StudentOrganizationLink t where t.organization=:organization and t.commander=:commander";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("organization", organization);
        params.put("commander", true);
        StudentOrganizationLink studentOrganizationLink = studentOrganizationdao.get(hql, params);
        if (studentOrganizationLink != null) {
            return studentOrganizationLink.getStudent();
        } else {
            return null;
        }
    }

    @Override
    public List<StudentOrganizationLink> getAllNotAuditStudentOrganization(Organization organization) {
        String hql = "from StudentOrganizationLink t where t.organization=:organization and t.status=:status";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("organization", organization);
        params.put("status", 0);
        List<StudentOrganizationLink> studentOrganizationLinks = studentOrganizationdao.find(hql, params);
        if (studentOrganizationLinks != null && studentOrganizationLinks.size() > 0) {
            return studentOrganizationLinks;
        } else {
            return null;
        }
    }


    @Override
    public List<StudentOrganizationLink> getAllAlreadyAuditStudentOrganization(Organization organization) {
        String hql = "from StudentOrganizationLink t where t.organization=:organization and t.status=:status";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("organization", organization);
        params.put("status", 1);
        List<StudentOrganizationLink> studentOrganizationLinks = studentOrganizationdao.find(hql, params);
        if (studentOrganizationLinks != null && studentOrganizationLinks.size() > 0) {
            return studentOrganizationLinks;
        } else {
            return null;
        }
    }

    @Override
    public List<OrganizationPosition> getAllPositionsByOrganization(Organization organization) {
        String hql = "from OrganizationPosition t where t.organization=:organization";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("organization", organization);
        return positiondao.find(hql, params);
    }

    @Override
    public List<OrganizationDepartment> getAllDepartmentsByOrganization(Organization organization) {
        String hql = "from OrganizationDepartment t where t.organization=:organization";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("organization", organization);
        return departmentdao.find(hql, params);
    }

    @Override
    public StudentOrganizationLink getAStudentOrganizationLink(int studentid, int organizationid) {
        Student student = getStudentById(studentid);
        Organization organization = getOrganizationById(organizationid);
        String hql = "from StudentOrganizationLink t where t.student=:student and t.organization=:organization";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("student", student);
        params.put("organization", organization);
        return studentOrganizationdao.get(hql, params);
    }

    @Override
    public void updateStudentOrganization(StudentOrganizationLink link) {
        studentOrganizationdao.update(link);
    }

    @Override
    public void updateOrganizationDepartment(OrganizationDepartment department) {
        departmentdao.update(department);
    }


    @Override
    public List<StudentOrganizationLink> getStudentOrganizationLinkByNotCommenderNotAudit(Organization organization) {
        String hql = "from StudentOrganizationLink t where t.commander=:commander and t.organization=:organization and t.status=:status";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("commander", false);
        params.put("status", 0);
        params.put("organization", organization);
        return studentOrganizationdao.find(hql, params);
    }

    @Override
    public void deleteStudentOrganizationLink(StudentOrganizationLink link) {
        studentOrganizationdao.delete(link);
    }

    @Override
    public List<Organization> getAllOrganization() {
        String hql = "from Organization ";
        return organizationdao.find(hql);
    }

    @Override
    public List<Organization> getAllAuditSuccessOrganization() {
        String hql = "from Organization t where t.status=:status";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", 1);
        return organizationdao.find(hql, params);
    }


    @Override
    public List<Organization> getAllAuditFailOrganization() {
        String hql = "from Organization t where t.status=:status";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", 2);
        return organizationdao.find(hql, params);
    }



    @Override
    public List<Organization> getAllNotAuditOrganization() {
        String hql = "from Organization t where t.status=:status";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", 0);
        return organizationdao.find(hql, params);
    }

    @Override
    public List<Organization> getAllDeleteOrganization() {
        String hql = "from Organization t where t.status=:status";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", 3);
        return organizationdao.find(hql, params);
    }


    @Override
    public List<Organization> getAllOrganizationByIds(String[] id) {
        List<Organization> organizations = new ArrayList<Organization>();
        for(String str : id){
            organizations.add(getOrganizationById(Integer.valueOf(str)));
        }
        return  organizations;
    }
}
