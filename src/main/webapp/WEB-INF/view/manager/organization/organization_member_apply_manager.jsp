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
        <div id="breadcrumb">
            <a href="<%=ctx %>/manager/home" class="tip-bottom">
                <i class="icon-home"></i> 首页
            </a>
            <a href="<%=ctx %>/manager/organizationmanager" class="tip-bottom">
                社团管理
            </a>
            <a href="<%=ctx %>/manager/organization/organizationmemberapplymanager?id=${organization.id}"
               class="current">
                社团成员申请信息
            </a>
        </div>
    </div>
    <!--痕迹导航开始结束-->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <c:if test="${reply != null}">
                    <div  id = "tip" class="alert alert-info"><a class="close" data-dismiss="alert" href="#">×</a>
                        <center>
                                ${reply.reply}
                        </center>
                    </div>
                </c:if>
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-th"></i> </span>
                        <h5>成员申请信息</h5>
                        <a class="label label-important" href="#">返回</a>
                        <a class="label label-important" href="#">删除</a>
                        <a class="label label-important" href="#">审核成员</a>
                        <a class="label label-important" href="#">查看学生详情</a>
                    </div>

                    <div class="widget-content ">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th><input type="checkbox" id="title-table-checkbox" name="title-table-checkbox"/></th>
                                <th>姓名</th>
                                <th>部门</th>
                                <th>职位</th>
                                <th>申请原因</th>
                                <th>允许调剂</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><input type="checkbox"/></td>
                                <td>陈志兵</td>
                                <td>办公室部</td>
                                <td>社长</td>
                                <td>喜欢</td>
                                <td>允许</td>
                            </tr>
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
