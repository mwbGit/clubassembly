package cn.edu.hebtu.www.clubassembly.web.model;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 15-4-9.
 */
@Entity
@Table(name = "studentmessages")
public class StudentMessages {
    private int id;
    private Student student;
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
    @JoinColumn(name = "student_id")
    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
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
