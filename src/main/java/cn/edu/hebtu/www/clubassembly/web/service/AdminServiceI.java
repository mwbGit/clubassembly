package cn.edu.hebtu.www.clubassembly.web.service;

import cn.edu.hebtu.www.clubassembly.web.model.*;

import java.util.List;

/**
 * Created by Administrator on 15-3-21.
 */
public interface AdminServiceI {
    public void addAdmin(Admin admin);

    public Admin getAdminByEmail(String email);

    public List<Admin> getAllAdmins();
}
