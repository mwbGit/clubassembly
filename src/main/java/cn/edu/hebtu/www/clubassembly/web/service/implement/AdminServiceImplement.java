package cn.edu.hebtu.www.clubassembly.web.service.implement;

import cn.edu.hebtu.www.clubassembly.common.dao.BaseDaoI;
import cn.edu.hebtu.www.clubassembly.utils.PasswordHelper;
import cn.edu.hebtu.www.clubassembly.web.model.Admin;
import cn.edu.hebtu.www.clubassembly.web.service.AdminServiceI;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Created by Administrator on 15-5-6.
 */
@Service
public class AdminServiceImplement implements AdminServiceI {
    @Resource
    private PasswordHelper passwordHelper;
    @Resource
    private BaseDaoI<Admin> admindao;

    @Override
    public void addAdmin(Admin admin) {
        admindao.save(passwordHelper.encryptAdminPassword(admin));
    }

    @Override
    public Admin getAdminByEmail(String email) {
        String hql = "from Admin t where t.email=:email";
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("email", email);
        return admindao.get(hql, param);
    }

    @Override
    public List<Admin> getAllAdmins() {
        String hql = "from Admin";
        return admindao.find(hql);
    }
}
