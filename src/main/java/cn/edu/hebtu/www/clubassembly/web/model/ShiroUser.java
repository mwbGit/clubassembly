package cn.edu.hebtu.www.clubassembly.web.model;

import cn.edu.hebtu.www.clubassembly.utils.Constant;

import java.io.Serializable;
import java.util.List;

public class ShiroUser implements Serializable {
    private int userId;
    private String role;
    private String userName;
    private String email;
    private String currentOrganizationID;
    //    头像
    private String image;

    private String personcode;

    private String managerMenuStatus = Constant.MANAGER_MAIN;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }


    public String getPersoncode() {
        return personcode;
    }

    public void setPersoncode(String personcode) {
        this.personcode = personcode;
    }

    @Override
    public String toString() {
        return userName;
    }


    public String getManagerMenuStatus() {
        return managerMenuStatus;
    }

    public void setManagerMenuStatus(String managerMenuStatus) {
        this.managerMenuStatus = managerMenuStatus;
    }

    public String getCurrentOrganizationID() {
        return currentOrganizationID;
    }

    public void setCurrentOrganizationID(String currentOrganizationID) {
        this.currentOrganizationID = currentOrganizationID;
    }
}