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
            <a href="<%=ctx %>/manager/studentmanager" class="tip-bottom">
                学生管理
            </a>
            <a href="<%=ctx %>/manager/student/studentmainpage?id=${student.id}"  class="current">
                个人主页管理
            </a>
        </div>
    </div>
    <!--痕迹导航结束-->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">

                <c:if test="${reply != null}">
                    <div id = "tip" class="alert alert-info"><a class="close" data-dismiss="alert" href="#">×</a>
                        <center>
                            您已成功删除新鲜事,相册,留言。
                        </center>
                    </div>
                </c:if>



                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-th"></i> </span>
                        <h5>新鲜事管理</h5>
                        <a class="label label-important" href="#">删除</a>
                        <a class="label label-important" href="#">修改</a>
                        <a class="label label-important" href="#">查看详情</a>
                    </div>

                    <div class="widget-content ">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th><input type="checkbox" id="title-table-checkbox" name="title-table-checkbox"/></th>
                                <th>内容</th>
                                <th>发布时间</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><input type="checkbox"/></td>
                                <td>没有什么新鲜事。</td>
                                <td>2015-05-02</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-th"></i> </span>
                        <h5>相册管理</h5>
                        <a class="label label-important" href="#">删除</a>
                        <a class="label label-important" href="#">修改</a>
                        <a class="label label-important" href="#">查看详情</a>
                    </div>

                    <div class="widget-content ">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th><input type="checkbox" id="title-table-checkbox" name="title-table-checkbox"/></th>
                                <th>相册名称</th>
                                <th>创建时间</th>
                                <th>照片个数</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><input type="checkbox"/></td>
                                <td>大一</td>
                                <td>2015-05-02</td>
                                <td>10</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-th"></i> </span>
                        <h5>留言管理</h5>
                        <a class="label label-important" href="#">删除</a>
                        <a class="label label-important" href="#">修改</a>
                        <a class="label label-important" href="#">查看详情</a>
                    </div>

                    <div class="widget-content ">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th><input type="checkbox" id="title-table-checkbox" name="title-table-checkbox"/></th>
                                <th>留言人</th>
                                <th>留言内容</th>
                                <th>留言时间</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><input type="checkbox"/></td>
                                <td>刘行</td>
                                <td>亲，加油。</td>
                                <td>2014-05-02</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<!--主容器结束-->
</body>
</html>
