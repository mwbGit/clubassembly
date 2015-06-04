package cn.edu.hebtu.www.clubassembly.web.model;

import com.google.gson.annotations.Expose;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 15-3-28.
 */

@Entity
@Table(name = "organization_second_category")
public class OrganizationSecondCategory implements Serializable {
    @Expose
    private int id;
    private OrganizationMainCategory organizationMainCategory;
    @Expose
    private String name;


    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "main_id")
    public OrganizationMainCategory getOrganizationMainCategory() {
        return organizationMainCategory;
    }

    public void setOrganizationMainCategory(OrganizationMainCategory organizationMainCategory) {
        this.organizationMainCategory = organizationMainCategory;
    }

    @Column(name = "name", length = 20)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
