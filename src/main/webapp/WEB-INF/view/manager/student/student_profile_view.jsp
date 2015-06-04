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
            <a href="<%=ctx %>/manager/student/studentprofileview?id=${student.id}" class="current">
                学生详情
            </a>
        </div>
    </div>
    <!--痕迹导航开始结束-->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">

                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5>学生详情</h5>
                        <a class="label label-important" href="<%=ctx %>/manager/studentmanager">返回</a>
                    </div>
                    <div class="widget-content nopadding">
                        <form action="#" method="get" class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label">姓名:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.name}" disabled=""/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">邮箱:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.email}" disabled=""/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">激活状态:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.activate}" disabled=""/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">座右铭:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.personcode}" disabled=""/>
                                </div>
                            </div>


                            <div class="control-group">
                                <label class="control-label">省份:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.province.pr_province}"
                                           disabled=""/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">城市:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.city.ci_city}" disabled=""/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">学校:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.school.sh_school}"
                                           disabled=""/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">专业:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.major}" disabled=""/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">性别:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.sex}" disabled=""/>
                                </div>
                            </div>


                            <div class="control-group">
                                <label class="control-label">注册时间:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.registerTime}" disabled=""/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">学号:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.number}" disabled=""/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">联系电话:</label>

                                <div class="controls">
                                    <input type="text" class="span11" value="${student.telephone}" disabled=""/>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--主容器结束-->
</body>
</html>
