package cn.edu.hebtu.www.clubassembly.web.service.implement;

import cn.edu.hebtu.www.clubassembly.common.dao.BaseDaoI;
import cn.edu.hebtu.www.clubassembly.web.model.*;
import cn.edu.hebtu.www.clubassembly.web.service.OrganizationMaintainServiceI;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Created by Administrator on 15-4-11.
 */
@Service
public class OrganizationMaintainServiceImplement implements OrganizationMaintainServiceI {
    @Resource
    private BaseDaoI<OrganizationEvents> eventsdao;
    @Resource
    private BaseDaoI<OrganizationNews> newsdao;
    @Resource
    private BaseDaoI<OrganizationMessages> messagedao;


    @Override
    public void addEvent(OrganizationEvents events) {
        eventsdao.save(events);
    }

    @Override
    public List<OrganizationEvents> getAllEventsByOrganization(Organization organization) {
        String hql = "from OrganizationEvents t where t.organization=:organization";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("organization", organization);
        return eventsdao.find(hql, params);
    }

    @Override
    public void addNews(OrganizationNews news) {
        newsdao.save(news);
    }

    @Override
    public List<OrganizationNews> getAllNewsByOrganization(Organization organization) {
        String hql = "from OrganizationNews t where t.organization=:organization";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("organization", organization);
        return newsdao.find(hql, params);
    }


    @Override
    public List<OrganizationEvents> getAllEvents() {
        String hql = "from OrganizationEvents t ";
        return eventsdao.find(hql);
    }

    @Override
    public void addMessage(OrganizationMessages messages) {
        messagedao.save(messages);
    }

    @Override
    public List<OrganizationMessages> getAllMessagesByOrganization(Organization organization) {
        String hql = "from OrganizationMessages t where t.organization=:organization order by t.releaseTime desc";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("organization", organization);
        return messagedao.find(hql, params);
    }

    @Override
    public OrganizationEvents getEventByEventid(int eventid) {
        String hql = "from OrganizationEvents t where t.id=:eventid";
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("eventid", eventid);
        return eventsdao.get(hql, params);
    }
}
