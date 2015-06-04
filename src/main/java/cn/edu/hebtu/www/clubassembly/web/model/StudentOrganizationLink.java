package cn.edu.hebtu.www.clubassembly.web.model;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 学生和社团的关联表
 * Created by Administrator on 15-3-28.
 */
@Entity
@Table(name = "student_organization")
public class StudentOrganizationLink implements Serializable {
    private int id;
    private boolean commander;
    private int status;
    private Student student;
    //    同意调剂
    private boolean agreeAdjust;
    //    申请理由
    private String applyReason;
    private Organization organization;
    private OrganizationDepartment organizationDepartment;
    private OrganizationPosition organizationPosition;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(name = "isCommander")
    public boolean isCommander() {
        return commander;
    }

    public void setCommander(boolean commander) {
        this.commander = commander;
    }


    @Column(name = "status")
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }


    @Column(name = "agreeAdjust")
    public boolean isAgreeAdjust() {
        return agreeAdjust;
    }

    public void setAgreeAdjust(boolean agreeAdjust) {
        this.agreeAdjust = agreeAdjust;
    }


    @Column(name = "applyReason", length = 50)
    public String getApplyReason() {
        return applyReason;
    }

    public void setApplyReason(String applyReason) {
        this.applyReason = applyReason;
    }

    @ManyToOne
    @JoinColumn(name = "student_id")
    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    @ManyToOne
    @JoinColumn(name = "organization_id")
    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }

    @ManyToOne
    @JoinColumn(name = "department_id")
    public OrganizationDepartment getOrganizationDepartment() {
        return organizationDepartment;
    }

    public void setOrganizationDepartment(OrganizationDepartment organizationDepartment) {
        this.organizationDepartment = organizationDepartment;
    }

    @ManyToOne
    @JoinColumn(name = "position_id")
    public OrganizationPosition getOrganizationPosition() {
        return organizationPosition;
    }

    public void setOrganizationPosition(OrganizationPosition organizationPosition) {
        this.organizationPosition = organizationPosition;
    }
}
