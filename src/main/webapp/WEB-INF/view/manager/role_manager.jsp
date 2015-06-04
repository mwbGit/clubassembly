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
                href="<%=ctx %>/manager/rolemanager" class="current">角色管理</a></div>
    </div>
    <!--痕迹导航结束-->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-th"></i> </span>

                    </div>
                    <div class="widget-content ">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th><input type="checkbox" id="title-table-checkbox" name="title-table-checkbox"/></th>
                                <th>角色名称</th>
                                <th>角色标识</th>
                                <th>是否可用</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${roles != null && roles.size() > 0 }">
                                <c:forEach var="role"  items="${roles}" varStatus="status">
                                    <tr>
                                        <td><center><input type="checkbox"/></center></td>
                                        <td><center>${role.description}</center></td>
                                        <td><center>${role.role}</center></td>
                                        <td><center>${role.available}</center></td>
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
