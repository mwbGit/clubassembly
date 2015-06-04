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
                href="<%=ctx %>/manager/systemconfig" class="current">系统配置</a></div>
    </div>
    <!--痕迹导航结束-->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5>基本配置</h5>
                        <a class="label label-important" href="#">修改</a>
                        <a class="label label-important" href="#">保存</a>
                    </div>
                    <div class="widget-content nopadding">
                        <form action="#" method="get" class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label">运行平台:</label>

                                <div class="controls">
                                    <input type="text" class="span11" placeholder="CentOS 6.3"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">JDK 版本:</label>

                                <div class="controls">
                                    <input type="text" class="span11" placeholder="1.7"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Tomcat 版本:</label>

                                <div class="controls">
                                    <input type="password" class="span11" placeholder="7.0.53"/>
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
