package cn.edu.hebtu.www.clubassembly.web.service;

import cn.edu.hebtu.www.clubassembly.web.model.Role;

import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 15-3-21.
 */
public interface RoleServiceI {

    public void addRole(Role role);

    public void updateRole(Role role);

    public Role getRole(int id);

    public Role getRoleByName(String name);

    public Set<Role> getRolesByNames(String [] role);

    public void deleteRole(Role role);

    public List<Role> getAllRole();
}
