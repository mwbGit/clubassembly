<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="<%=ctx %>/static/js/organizationmanager.js"></script>
</head>
<body>
<!--主容器开始-->
<div id="content">
    <!--痕迹导航开始 -->
    <div id="content-header">
        <div id="breadcrumb"><a href="<%=ctx %>/manager/home" class="tip-bottom"><i class="icon-home"></i> 首页</a>
            <a href="<%=ctx %>/manager/organizationmanager" class="tip-bottom">社团管理</a>
            <a href="<%=ctx %>/manager/organization/organizationauditsuccessmanager" class="current">审核已通过社团</a>
        </div>
    </div>
    <!--痕迹导航开始结束-->
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
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-th"></i> </span>
                        <h5>审核已通过社团</h5>
                        <a class="label label-important" href="#"
                           onclick="organizationDelete('auditSuccessOrganizations')">删除</a>
                        <a class="label label-important" href="#" id="organizationmainpage">社团主页</a>
                        <a class="label label-important" href="#" id="organizationmembermanager">成员信息</a>
                        <a class="label label-important" href="#" id="organizationmemberapplymanager">成员申请</a>
                        <a class="label label-important" href="#"
                           onclick="organizationUpdate('auditSuccessOrganizations')">修改信息</a>
                        <a class="label label-important" href="#"
                           onclick="organizationView('auditSuccessOrganizations')">查看详情</a>
                    </div>

                    <div class="widget-content ">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th><input type="checkbox" id="auditSuccessOrganizationscheckbox"
                                           name="title-table-checkbox"/></th>
                                <th>社团名称</th>
                                <th>社团性质</th>
                                <th>类型</th>
                                <th>社团审核图片</th>
                            </tr>
                            </thead>
                            <tbody id="auditSuccessOrganizationstbody">
                            <c:if test="${auditSuccessOrganizations != null && auditSuccessOrganizations.size() > 0}">
                                <c:forEach var="organization" items="${auditSuccessOrganizations}" varStatus="status">
                                    <tr>
                                        <td>
                                            <center>
                                                <input type="checkbox" value="${organization.id}"
                                                       id="${organization.id}"
                                                       onclick="changecheckboxstatus(${organization.id})"/>
                                            </center>
                                        </td>
                                        <td>
                                            <center>
                                                    ${organization.name }
                                            </center>
                                        </td>
                                        <td>
                                            <center>
                                                    ${organization.property.property}
                                            </center>
                                        </td>
                                        <td>
                                            <center>
                                                    ${organization.organizationMainCategory.name}
                                                -- ${organization.organizationSecondCategory.name}
                                            </center>
                                        </td>
                                        <td>
                                            <center>
                                                <a href="<%=ctx %>/${organization.organizationcheckimagelocation}">
                                                    审核图片
                                                </a>
                                            </center>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--主容器结束-->
</body>
</html>
