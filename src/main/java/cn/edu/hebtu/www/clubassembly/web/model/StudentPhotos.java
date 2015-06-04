package cn.edu.hebtu.www.clubassembly.web.model;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 15-4-9.
 */
@Entity
@Table(name = "studentphotos")
public class StudentPhotos {
    private int id;
    private Student student;
    //    相册名字
    private String photosname;
    //    相片名字
    private String photoname;
    //    相片路径
    private String photolocation;
    //发布时间
    private Date releaseTime;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    @ManyToOne
    @JoinColumn(name = "student_id")
    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }


    @Column(name = "photosname", length = 20)
    public String getPhotosname() {
        return photosname;
    }

    public void setPhotosname(String photosname) {
        this.photosname = photosname;
    }


    @Column(name = "photoname", length = 52)
    public String getPhotoname() {
        return photoname;
    }

    public void setPhotoname(String photoname) {
        this.photoname = photoname;
    }

    @Column(name = "photolocation", length = 150)
    public String getPhotolocation() {
        return photolocation;
    }

    public void setPhotolocation(String photolocation) {
        this.photolocation = photolocation;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "releaseTime")
    public Date getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(Date releaseTime) {
        this.releaseTime = releaseTime;
    }
}
