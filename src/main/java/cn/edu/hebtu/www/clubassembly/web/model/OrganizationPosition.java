package cn.edu.hebtu.www.clubassembly.web.model;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 职位表
 * Created by Administrator on 15-3-28.
 */
@Entity
@Table(name = "position")
public class OrganizationPosition implements Serializable {
    private int id;
    private String position;
    private Organization organization;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(name = "position", length = 20)
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }


    @ManyToOne
    @JoinColumn(name = "organizationid")
    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }
}
