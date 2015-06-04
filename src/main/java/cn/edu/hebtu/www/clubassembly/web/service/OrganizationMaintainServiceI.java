package cn.edu.hebtu.www.clubassembly.web.service;

import cn.edu.hebtu.www.clubassembly.web.model.Organization;
import cn.edu.hebtu.www.clubassembly.web.model.OrganizationEvents;
import cn.edu.hebtu.www.clubassembly.web.model.OrganizationMessages;
import cn.edu.hebtu.www.clubassembly.web.model.OrganizationNews;

import java.util.List;

/**
 * Created by Administrator on 15-4-11.
 */
public interface OrganizationMaintainServiceI {
    public void addEvent(OrganizationEvents events);

    public List<OrganizationEvents> getAllEventsByOrganization(Organization organization);

    public void addNews(OrganizationNews news);

    public List<OrganizationNews> getAllNewsByOrganization(Organization organization);

    public List<OrganizationEvents> getAllEvents();

    public void addMessage(OrganizationMessages messages);

    public List<OrganizationMessages> getAllMessagesByOrganization(Organization organization);


    public OrganizationEvents getEventByEventid(int eventid);
}
