package cn.edu.hebtu.www.clubassembly.web.model;

import cn.edu.hebtu.www.clubassembly.web.service.StudentServiceI;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

/**
 * 角色表
 * Created by Administrator on 15-3-15.
 */
@Entity
@Table(name = "role")
public class Role implements Serializable {
    private int id;
    private String role; //角色标识 程序中判断使用,如"web"
    private Set<Student> students = new HashSet<Student>();  //用户表。
    private Set<Admin> admins = new HashSet<Admin>();  //管理员表。
    private String description; //角色描述,UI界面显示使用
    private int available; //是否可用,如果不可用将不会添加给用户


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(name = "role", length = 50)
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Column(name = "description", length = 100)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name = "available")
    public int getAvailable() {
        return available;
    }

    public void setAvailable(int available) {
        this.available = available;
    }


    @ManyToMany(mappedBy = "roles")
    public Set<Student> getStudents() {
        return students;
    }

    public void setStudents(Set<Student> students) {
        this.students = students;
    }


    @ManyToMany(mappedBy = "roles")
    public Set<Admin> getAdmins() {
        return admins;
    }

    public void setAdmins(Set<Admin> admins) {
        this.admins = admins;
    }
}
