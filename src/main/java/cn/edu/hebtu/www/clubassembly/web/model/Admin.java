package cn.edu.hebtu.www.clubassembly.web.model;

import com.google.gson.annotations.Expose;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 管理员
 * Created by Administrator on 15-3-15.
 */
@Entity
@Table(name = "admin")
public class Admin implements Serializable {
    //主键
    @Expose
    private int id;
    //姓名
    @Expose
    private String name;
    //邮箱
    @Expose
    private String email;
    //密码
    @Expose
    private String password;
    //电话
    @Expose
    private String telephone;
    //加密盐
    private String salt;
    //所包含的角色
    private Set<Role> roles = new HashSet<Role>();

    //用户注册时间
    @Expose
    private Date registerTime;

    @Id
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

    @Column(name = "email", unique = true, length = 20)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    @Column(name = "password", length = 50)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    @Column(name = "telephone", length = 11)
    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }


    @Column(name = "salt", length = 50)
    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }


    @ManyToMany
    @JoinTable(name = "admin_role",
            //本表的id
            joinColumns = {@JoinColumn(name = "admin_id")},
            //另一张表用inverseJoinColumns..
            inverseJoinColumns = {@JoinColumn(name = "role_id")}
    )
    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }


    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "registerTime")
    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }
}
