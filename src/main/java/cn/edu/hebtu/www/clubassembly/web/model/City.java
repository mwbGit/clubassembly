package cn.edu.hebtu.www.clubassembly.web.model;

import com.google.gson.annotations.Expose;

import javax.persistence.*;
import java.io.Serializable;


@Entity
@Table(name = "city_info")
public class City implements Serializable {
    @Expose
    private int ci_id;
    private Province province;
    @Expose
    private String ci_city;

    @Id
    @Column(name = "ci_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getCi_id() {
        return ci_id;
    }

    public void setCi_id(int ci_id) {
        this.ci_id = ci_id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ci_province")
    public Province getProvince() {
        return province;
    }

    public void setProvince(Province province) {
        this.province = province;
    }


    @Column(name = "ci_city", length = 32)
    public String getCi_city() {
        return ci_city;
    }

    public void setCi_city(String ci_city) {
        this.ci_city = ci_city;
    }
}
