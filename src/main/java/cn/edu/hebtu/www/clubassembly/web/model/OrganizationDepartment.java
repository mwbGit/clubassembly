package cn.edu.hebtu.www.clubassembly.web.model;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 部门表
 * Created by Administrator on 15-3-28.
 */
@Entity
@Table(name = "department")
public class OrganizationDepartment implements Serializable {
    private int id;
    private String department;
    private int maxNumbers;
    private Organization organization;
    private boolean open;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(name = "department", length = 20)
    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }


    @Column(name = "maxnumbers")
    public int getMaxNumbers() {
        return maxNumbers;
    }

    public void setMaxNumbers(int maxNumbers) {
        this.maxNumbers = maxNumbers;
    }


    @ManyToOne
    @JoinColumn(name = "organizationid")
    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }


    @Column(name = "isopen")
    public boolean isOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }
}
