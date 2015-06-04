package cn.edu.hebtu.www.clubassembly.web.model;

import com.google.gson.annotations.Expose;

import javax.persistence.*;
import java.io.Serializable;


@Entity
@Table(name = "school_info")
public class School implements Serializable {
    @Expose
    private int sh_id;
    private City city;
    @Expose
    private String sh_school;

    @Id
    @Column(name = "sh_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getSh_id() {
        return sh_id;
    }

    public void setSh_id(int sh_id) {
        this.sh_id = sh_id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sh_city")
    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }


    @Column(name = "sh_school", length = 32)
    public String getSh_school() {
        return sh_school;
    }

    public void setSh_school(String sh_school) {
        this.sh_school = sh_school;
    }
}
