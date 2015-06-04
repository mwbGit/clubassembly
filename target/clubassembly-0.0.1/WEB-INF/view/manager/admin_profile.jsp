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
        <div id="breadcrumb"><a href="<%=ctx %>/manager/home" class="tip-bottom"><i class="icon-home"></i> 首页</a>
            <a href="<%=ctx %>/manager/adminprofile" class="current">个人资料</a></div>
    </div>
    <!--痕迹导航结束-->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span6">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5>基本信息</h5>
                        <a class="label label-important" href="#">保存</a>
                    </div>
                    <div class="widget-content nopadding">
                        <c:if test="${admin != null}">
                            <form action="" method="post" class="form-horizontal">
                                <div class="control-group">
                                    <label class="control-label">用户名:</label>

                                    <div class="controls">
                                        <input type="text" class="span11" value="${admin.name}"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">邮箱:</label>

                                    <div class="controls">
                                        <input type="text" class="span11"  disabled="" value="${admin.email}"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">联系电话:</label>

                                    <div class="controls">
                                        <input type="text" class="span11" value="${admin.telephone}"/>
                                    </div>
                                </div>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="span6">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5>修改密码</h5>
                        <a class="label label-important" href="#">保存</a>
                    </div>
                    <div class="widget-content nopadding">
                        <c:if test="${admin != null}">
                            <form action="#" method="post" class="form-horizontal">
                                <div class="control-group">
                                    <label class="control-label">当前密码:</label>

                                    <div class="controls">
                                        <input type="text" class="span11" placeholder="当前密码"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">新密码:</label>
                                    <div class="controls">
                                        <input type="password" class="span11" placeholder="新密码"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">确认密码:</label>
                                    <div class="controls">
                                        <input type="password" class="span11" placeholder="确认密码"/>
                                    </div>
                                </div>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<!--主容器结束-->
</body>
</html>
