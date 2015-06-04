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
        <div id="breadcrumb"><a href="<%=ctx %>/manager/home" class="tip-bottom"><i class="icon-home"></i> 首页</a> <a
                href="<%=ctx %>/manager/organizationmanager" class="current">社团管理</a>
        </div>
    </div>
    <!--痕迹导航结束-->



    <!--Action boxes-->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <c:if test="${reply != null}">
                    <div id="tip" class="alert alert-info"><a class="close" data-dismiss="alert" href="#">×</a>
                        <center>
                                ${reply.reply}
                        </center>
                    </div>
                </c:if>
                <div class="quick-actions_homepage">
                    <ul class="quick-actions">

                        <li class="bg_lg span3">
                            <a href="<%=ctx %>/manager/organization/organizationauditsuccessmanager">
                                <i class="icon-signal"></i>
                                审核已通过社团
                            </a>
                        </li>

                        <li class="bg_ly span3">
                            <a href="<%=ctx %>/manager/organization/organizationauditfailmanager">
                                <i class="icon-inbox"></i>
                                审核未通过社团
                            </a>
                        </li>
                        <li class="bg_lo span3"><a href="<%=ctx %>/manager/organization/organizationnotauditmanager"> <i
                                class="icon-th-list"></i> 未审核社团</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span12">
                <div class="quick-actions_homepage">
                    <ul class="quick-actions">
                        <li class="bg_lr span3"><a href="<%=ctx %>/manager/organization/organizationalreadydeletemanager"> <i class="icon-th"></i> 已删除社团</a></li>
                        <li class="bg_ls span3"><a href="#"> <i class="icon-tint"></i> 查询社团</a></li>
                        <li class="bg_lb span3"><a href="#"> <i class="icon-pencil"></i>社团配置</a></li>
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
