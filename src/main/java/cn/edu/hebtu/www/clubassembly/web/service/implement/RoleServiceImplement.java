package cn.edu.hebtu.www.clubassembly.web.service.implement;

import cn.edu.hebtu.www.clubassembly.common.dao.BaseDaoI;
import cn.edu.hebtu.www.clubassembly.web.model.Role;
import cn.edu.hebtu.www.clubassembly.web.service.RoleServiceI;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by Administrator on 15-3-21.
 */
@Service
public class RoleServiceImplement implements RoleServiceI {
    private Logger logger = Logger.getLogger(RoleServiceImplement.class);
    @Resource
    private BaseDaoI<Role> roleDao;

    @Override
    public void addRole(Role role) {
        roleDao.save(role);
    }

    @Override
    public void updateRole(Role role) {
        roleDao.update(role);
    }

    @Override
    public Role getRole(int id) {
        String hql = "from Role t where t.id=:id";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        return roleDao.get(hql, params);
    }


    @Override
    public Role getRoleByName(String name) {
        String hql = "from Role t where t.role=:name";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("name", name);
        return roleDao.get(hql, params);
    }

    @Override
    public Set<Role> getRolesByNames(String[] role) {
        Set<Role> roles = new HashSet<Role>();
        for (String temp : role) {
            roles.add(getRoleByName(temp));
        }
        if(roles != null && roles.size() > 0){
            logger.info(roles.size());
            return roles;
        }else {
            return null;
        }

    }

    @Override
    public void deleteRole(Role role) {
        roleDao.delete(role);
    }

    @Override
    public List<Role> getAllRole() {
        String hql = "from Role t ";
        return roleDao.find(hql);
    }
}
