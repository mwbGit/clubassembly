<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>
<!--主容器开始-->
<div id="content">
    <!--痕迹导航开始 -->
    <div id="content-header">
        <div id="breadcrumb"><a href="<%=ctx %>/manager/home" class="tip-bottom"><i class="icon-home"></i>
            首页</a></div>
    </div>
    <!--痕迹导航开始结束-->

    <!--Action boxes-->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="quick-actions_homepage">
                    <ul class="quick-actions">

                        <shiro:hasRole name="student_manager">
                            <li class="bg_lg span3">
                                <a href="<%=ctx %>/manager/studentmanager">
                                    <i class="icon-signal"></i>
                                    学生管理
                                </a>
                            </li>
                        </shiro:hasRole>
                        <shiro:hasRole name="organization_manager">
                            <li class="bg_ly span3">
                                <a href="<%=ctx %>/manager/organizationmanager">
                                    <i class="icon-inbox"></i>
                                    社团管理
                                </a>
                            </li>
                        </shiro:hasRole>
                        <shiro:hasRole name="admin">
                            <li class="bg_lo span3"><a href="<%=ctx %>/manager/systemmonitor"> <i
                                    class="icon-th-list"></i>
                                系统监测</a>
                            </li>
                        </shiro:hasRole>
                    </ul>
                </div>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span12">
                <div class="quick-actions_homepage">
                    <ul class="quick-actions">
                        <shiro:hasRole name="admin">
                            <li class="bg_lr span3">
                                <a href="<%=ctx %>/manager/systemconfig">
                                    <i class="icon-th"></i>
                                    系统配置
                                </a>
                            </li>
                        </shiro:hasRole>
                        <shiro:hasRole name="admin">
                            <li class="bg_ls span3">
                                <a href="<%=ctx %>/manager/rolemanager">
                                    <i class="icon-tint"></i>
                                    角色管理
                                </a>
                            </li>
                        </shiro:hasRole>
                        <shiro:hasRole name="admin">
                            <li class="bg_lb span3">
                                <a href="<%=ctx %>/manager/membermanager">
                                    <i class="icon-pencil"></i>
                                    人员管理
                                </a>
                            </li>
                        </shiro:hasRole>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!--End-Action boxes-->
</div>
<!--主容器结束-->
</body>
</html>
