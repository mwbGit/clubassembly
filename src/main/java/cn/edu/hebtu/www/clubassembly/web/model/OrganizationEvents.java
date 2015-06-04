package cn.edu.hebtu.www.clubassembly.web.model;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 15-4-9.
 */

@Entity
@Table(name = "organizationevents")
public class OrganizationEvents {
    private int id;
    private Organization organization;
    private String title;
    private String category;
    private Date releaseTime;
    private String sponsor;
    private String content;
    private String location;
    private Date beginDate;
    private Date endDate;
    private String scale;
    //    海报
    private String poster;
    //    活动状态:0 正在进行;1 已经结束 ,3已经上传活动总结,
    private int status;


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

    @Column(name = "title", length = 50)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(name = "category", length = 20)
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }


    @Column(name = "sponsor", length = 30)
    public String getSponsor() {
        return sponsor;
    }

    public void setSponsor(String sponsor) {
        this.sponsor = sponsor;
    }


    @Column(name = "content", length = 4000)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "releaseTime")
    public Date getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(Date releaseTime) {
        this.releaseTime = releaseTime;
    }

    @Column(name = "location", length = 50)
    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "beginDate")
    public Date getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }


    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "endDate")
    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }


    @Column(name = "scale", length = 20)
    public String getScale() {
        return scale;
    }

    public void setScale(String scale) {
        this.scale = scale;
    }


    @Column(name = "poster", length = 100)
    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    @Column(name = "status")
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
