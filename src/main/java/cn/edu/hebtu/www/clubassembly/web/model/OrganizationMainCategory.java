package cn.edu.hebtu.www.clubassembly.web.model;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 15-3-28.
 */


@Entity
@Table(name = "organization_main_category")
public class OrganizationMainCategory implements Serializable {
    private int id;
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

    @Column(name = "name", length = 20)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
