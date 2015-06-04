package cn.edu.hebtu.www.clubassembly.common.model;

import com.google.gson.annotations.Expose;

/**
 * Created by Administrator on 15-3-21.
 */
public class Reply<T> {
    @Expose
    private int code;
    @Expose
    private T reply;
    @Expose
    private String detail = "";

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public T getReply() {
        return reply;
    }

    public void setReply(T reply) {
        this.reply = reply;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }
}
