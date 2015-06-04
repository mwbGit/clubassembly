package cn.edu.hebtu.www.clubassembly.web.service;

import cn.edu.hebtu.www.clubassembly.web.model.*;

import java.util.List;

/**
 * Created by Administrator on 15-3-21.
 */
public interface OrganizationServiceI {
    public List<OrganizationMainCategory> getAllOrganizationMainCategory();

    public List<OrganizationSecondCategory> getOrganizationSecondCategoryByMainCategoryId(int id);

    public void addOrganization(String name, int property_id, int maincategory_id, int secondcategory_id, String imagelocation, String organizationcheckimagelocation);

    public Organization getOrganizationById(int organization_id);


    public Organization getOrganizationByName(String organization_name);

    public OrganizationDepartment getOrganizationDepartment(int department_id);

    public OrganizationPosition getOrganizationPosition(int position_id);

    public List<OrganizationProperty> getAllOrganizationProperty();

    public void updateOrganization(Organization organization);

    public OrganizationProperty getOrganizationPropertyById(int property_id);

    public OrganizationMainCategory getOrganizationMainCategoryById(int maincategory_id);

    public OrganizationSecondCategory getOrganizationSecondCategoryById(int secondcategory_id);


    public void addStudentOrganizationLink(boolean isCommander, int student_id, int organization_id, int department_id, int position_id, int adjust, String reason);

    public void addStudentOrganizationLink(boolean isCommander, int student_id, int organization_id);

    public void addStudentOrganizationLink(boolean isCommander, int student_id, int organization_id, int department_id, int adjust, String reason);

    public void addOrganizationDepartment(Organization organization, String department);

    public void addOrganizationDepartment(Organization organization, String[] departments);

    public void addOrganizationPosition(Organization organization, String position);

    public void addOrganizationPosition(Organization organization, String[] positions);

    public Student getStudentById(int id);

    public List<Organization> getAllOrganizationBySomeStudentIsCammander(List<Student> sameCityStudents);

    public List<Organization> getAllOrganizationByIsCammander(Student student);

    public List<Organization> getAlreadyInOrganizations(Student student);

    public List<Organization> getWaitAuditOrganizations(Student student);

    public List<Student> getAllMembersByOrganization(Organization organization);

    public Student getCommenderByOrganization(Organization organization);

    public List<StudentOrganizationLink> getAllNotAuditStudentOrganization(Organization organization);

    public List<StudentOrganizationLink> getAllAlreadyAuditStudentOrganization(Organization organization);

    public List<OrganizationPosition> getAllPositionsByOrganization(Organization organization);

    public List<OrganizationDepartment> getAllDepartmentsByOrganization(Organization organization);

    public StudentOrganizationLink getAStudentOrganizationLink(int studentid, int organizationid);

    public void updateStudentOrganization(StudentOrganizationLink link);

    public void updateOrganizationDepartment(OrganizationDepartment department);

    public List<StudentOrganizationLink> getStudentOrganizationLinkByNotCommenderNotAudit(Organization organization);

    public void deleteStudentOrganizationLink(StudentOrganizationLink link);

    public List<Organization> getAllOrganization();

    public List<Organization> getAllAuditSuccessOrganization();

    public List<Organization> getAllAuditFailOrganization();

    public List<Organization> getAllNotAuditOrganization();

    public List<Organization> getAllDeleteOrganization();

    public List<Organization> getAllOrganizationByIds(String[] id);
}
