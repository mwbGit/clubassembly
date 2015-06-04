package cn.edu.hebtu.www.clubassembly.web.model;

import com.google.gson.annotations.Expose;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 学生表
 * Created by Administrator on 15-3-15.
 */
@Entity
@Table(name = "student")
public class Student implements Serializable {
    // 主键
    @Expose
    private int id;
    // 姓名
    @Expose
    private String name;
    @Expose
    private String image;
    // 邮箱
    @Expose
    private String email;
    //省份
    @Expose
    private Province province;
    //城市
    @Expose
    private City city;
    //学校
    @Expose
    private School school;
    //  密码
    @Expose
    private String password;

    @Expose
    private String personcode;

    //  专业
    @Expose
    private String major;
    //  电话
    @Expose
    private String telephone;
    //  QQ号
    @Expose
    private String QQ;
    @Expose
    private String number;
    //  性别
    @Expose
    private String sex;
    //加密盐
    private String salt;
    //所包含的角色
    private Set<Role> roles = new HashSet<Role>();
    //激活状态
    @Expose
    private int activate;
    //用户注册时间
    @Expose
    private Date registerTime;
//    private Set<Organization> organizations = new HashSet<Organization>();


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

    @ManyToOne
    @JoinColumn(name = "provinceid")
    public Province getProvince() {
        return province;
    }

    public void setProvince(Province province) {
        this.province = province;
    }

    @ManyToOne
    @JoinColumn(name = "cityid")
    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    @ManyToOne
    @JoinColumn(name = "schoolid")
    public School getSchool() {
        return school;
    }

    public void setSchool(School school) {
        this.school = school;
    }

    @Column(name = "image", length = 100)
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }


    @Column(name = "password", length = 50)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column(name = "major", length = 20)
    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    @Column(name = "telephone", length = 11)
    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    @Column(name = "qq", length = 11)
    public String getQQ() {
        return QQ;
    }

    public void setQQ(String QQ) {
        this.QQ = QQ;
    }

    @Column(name = "number", length = 20)
    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    @Column(name = "sex", length = 2)
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Column(name = "salt", length = 50)
    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }


    @ManyToMany
    @JoinTable(name = "student_role",
            //本表的id
            joinColumns = {@JoinColumn(name = "student_id")},
            //另一张表用inverseJoinColumns..
            inverseJoinColumns = {@JoinColumn(name = "role_id")}
    )
    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    @Column(name = "activate")
    public int getActivate() {
        return activate;
    }

    public void setActivate(int activate) {
        this.activate = activate;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "registerTime")
    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    @Column(name = "personcode", length = 50)
    public String getPersoncode() {
        return personcode;
    }

    public void setPersoncode(String personcode) {
        this.personcode = personcode;
    }


    //    @ManyToMany
//    @JoinTable(name = "student_organization",
//            //本表的id
//            joinColumns = {@JoinColumn(name = "student_id")},
//            //另一张表用inverseJoinColumns..
//            inverseJoinColumns = {@JoinColumn(name = "organization_id")}
//    )
//    public Set<Organization> getOrganizations() {
//        return organizations;
//    }
//
//    public void setOrganizations(Set<Organization> organizations) {
//        this.organizations = organizations;
//    }


}
