package cn.edu.hebtu.www.clubassembly.web.model;

import com.google.gson.annotations.Expose;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Administrator on 15-3-28.
 */

@Entity
@Table(name = "organization")
public class Organization implements Serializable {
    @Expose
    private int id;
    @Expose
    private String name;
    @Expose
    private OrganizationProperty property;
    @Expose
    private int status;
    @Expose
    private String auditMessage;
    @Expose
    private String image;
    @Expose
    private String organizationcheckimagelocation;
    @Expose
    private OrganizationMainCategory organizationMainCategory;
    @Expose
    private OrganizationSecondCategory organizationSecondCategory;
    //社团口号
    @Expose
    private String slogan;
    //社团介绍
    @Expose
    private String organizationIntroduce;
    @Expose
    private String departmentIntroduce;
    @Expose
    private String contactInformation;


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(name = "name", length = 50, unique = true)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @ManyToOne
    @JoinColumn(name = "property")
    public OrganizationProperty getProperty() {
        return property;
    }

    public void setProperty(OrganizationProperty property) {
        this.property = property;
    }

    @Column(name = "status")
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }


    @Column(name = "auditMessage", length = 300)
    public String getAuditMessage() {
        return auditMessage;
    }

    public void setAuditMessage(String auditMessage) {
        this.auditMessage = auditMessage;
    }

    @Column(name = "image", length = 100)
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Column(name = "organizationcheckimagelocation", length = 100)
    public String getOrganizationcheckimagelocation() {
        return organizationcheckimagelocation;
    }

    public void setOrganizationcheckimagelocation(String organizationcheckimagelocation) {
        this.organizationcheckimagelocation = organizationcheckimagelocation;
    }

    @ManyToOne
    @JoinColumn(name = "maincategory")
    public OrganizationMainCategory getOrganizationMainCategory() {
        return organizationMainCategory;
    }

    public void setOrganizationMainCategory(OrganizationMainCategory organizationMainCategory) {
        this.organizationMainCategory = organizationMainCategory;
    }

    @ManyToOne
    @JoinColumn(name = "secondcategory")
    public OrganizationSecondCategory getOrganizationSecondCategory() {
        return organizationSecondCategory;
    }

    public void setOrganizationSecondCategory(OrganizationSecondCategory organizationSecondCategory) {
        this.organizationSecondCategory = organizationSecondCategory;
    }


    @Column(name = "slogan", length = 50)
    public String getSlogan() {
        return slogan;
    }

    public void setSlogan(String slogan) {
        this.slogan = slogan;
    }


    @Column(name = "organizationIntroduce", length = 500)
    public String getOrganizationIntroduce() {
        return organizationIntroduce;
    }

    public void setOrganizationIntroduce(String organizationIntroduce) {
        this.organizationIntroduce = organizationIntroduce;
    }


    @Column(name = "departmentIntroduce", length = 500)
    public String getDepartmentIntroduce() {
        return departmentIntroduce;
    }

    public void setDepartmentIntroduce(String departmentIntroduce) {
        this.departmentIntroduce = departmentIntroduce;
    }


    @Column(name = "contactInformation", length = 50)
    public String getContactInformation() {
        return contactInformation;
    }

    public void setContactInformation(String contactInformation) {
        this.contactInformation = contactInformation;
    }
}
