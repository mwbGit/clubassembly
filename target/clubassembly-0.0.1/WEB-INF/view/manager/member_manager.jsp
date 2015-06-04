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
                href="<%=ctx %>/manager/membermanager" class="current">人员管理</a></div>
    </div>
    <!--痕迹导航结束-->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-th"></i> </span>
                        <a class="label label-important" href="#">删除</a>
                        <a class="label label-important" href="#">修改</a>
                        <a class="label label-important" href="<%=ctx %>/manager/membermanageradd">增加</a>
                    </div>

                    <div class="widget-content ">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th><input type="checkbox" id="title-table-checkbox" name="title-table-checkbox"/></th>
                                <th>用户名</th>
                                <th>用户邮箱</th>
                                <th>联系电话</th>
                                <th>拥有角色</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${adminList != null && adminList.size() > 0}">
                                <c:forEach var="admin" items="${adminList}" varStatus="status">
                                    <tr>
                                        <td>
                                            <center>
                                                <input type="checkbox" id="${admin.id}"/>
                                            </center>
                                        </td>
                                        <td>
                                            <center>
                                                    ${admin.name}
                                            </center>
                                        </td>
                                        <td>
                                            <center>
                                                    ${admin.email}
                                            </center>
                                        </td>
                                        <td>
                                            <center>
                                                    ${admin.telephone}
                                            </center>
                                        </td>
                                        <td>
                                            <c:if test="${admin.roles != null && admin.roles.size() > 0}">
                                                <center>
                                                    <c:forEach var="role" items="${admin.roles}" varStatus="rolestatus">
                                                        ${role.description}&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </c:forEach>
                                                </center>
                                            </c:if>
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
