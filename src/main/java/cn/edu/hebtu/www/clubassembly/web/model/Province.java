package cn.edu.hebtu.www.clubassembly.web.model;


import com.google.gson.annotations.Expose;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "province_info")
public class Province implements Serializable {
    @Expose
    private int pr_id;
    @Expose
    private String pr_province;

    @Id
    @Column(name = "pr_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getPr_id() {
        return pr_id;
    }

    public void setPr_id(int pr_id) {
        this.pr_id = pr_id;
    }

    @Column(name = "pr_province", length = 32)
    public String getPr_province() {
        return pr_province;
    }

    public void setPr_province(String pr_province) {
        this.pr_province = pr_province;
    }
}
