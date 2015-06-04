package cn.edu.hebtu.www.clubassembly.web.model;

import javax.persistence.*;

/**
 * 学生之间的关注
 * Created by Administrator on 15-4-9.
 */
@Entity
@Table(name = "studentwatch")
public class StudentWatchLink {
    private int id;
    //  关注者
    private Student watchStudent;
    // 被关注者
    private Student beWatchedStudent;


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    @ManyToOne
    @JoinColumn(name = "watch_student_id")
    public Student getWatchStudent() {
        return watchStudent;
    }

    public void setWatchStudent(Student watchStudent) {
        this.watchStudent = watchStudent;
    }


    @ManyToOne
    @JoinColumn(name = "bewatched_student_id")
    public Student getBeWatchedStudent() {
        return beWatchedStudent;
    }

    public void setBeWatchedStudent(Student beWatchedStudent) {
        this.beWatchedStudent = beWatchedStudent;
    }
}
