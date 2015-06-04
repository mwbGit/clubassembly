package cn.edu.hebtu.www.clubassembly.web.model;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 社团属性
 * Created by Administrator on 15-3-28.
 */
@Entity
@Table(name = "property")
public class OrganizationProperty implements Serializable {
    private int id;
    private String property;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(name = "property", length = 10, unique = true)
    public String getProperty() {
        return property;
    }

    public void setProperty(String property) {
        this.property = property;
    }
}
