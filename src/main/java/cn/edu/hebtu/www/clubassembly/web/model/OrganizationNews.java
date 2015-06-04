package cn.edu.hebtu.www.clubassembly.web.model;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 15-4-9.
 */

@Entity
@Table(name = "organizationnews")
public class OrganizationNews {
    private int id;
    private Organization organization;
    private Date releaseTime;
    private String content;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @ManyToOne
    @JoinColumn(name = "organization_id")
    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "releaseTime")
    public Date getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(Date releaseTime) {
        this.releaseTime = releaseTime;
    }


    @Column(name = "content", length = 140)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
