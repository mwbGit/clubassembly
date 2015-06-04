<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script>
        $(function () {
            $("#savebutton").click(function () {
                var roles = $("#rolesdiv input");
                var rolesString = "";
                if (roles != null && roles.length > 0) {
                    $.each(roles, function (n, value) {
                        var checked = $(this).attr("checked");
                        if (checked != null && checked == "checked") {
                            //选中状态
                            rolesString = rolesString + $(this).val() + ","
                        }
                    });
                } else {
                    alert("角色元素未找到");
                }
                if (rolesString != null && rolesString.length > 0) {
                    rolesString = rolesString.substr(0, rolesString.length - 1);
                }

                $("#roleshidden").attr("value", rolesString);

                $("#saveform").submit();
            });

            var roles = $("#rolesdiv input");

            if (roles != null && roles.length > 0) {
                $.each(roles, function (n, value) {
                    $(this).click(function () {
                        var checked = $(this).attr("checked");
                        if (checked != null && checked == "checked") {
                            //选中状态
                            $(this).removeAttr("checked");
                        } else {
                            //非选中状态
                            $(this).attr("checked", "checked");
                        }
                    });
                });
            } else {
                alert("角色元素未找到");
            }
        });
    </script>
</head>
<body>
<!--主容器开始-->
<div id="content">
    <!--痕迹导航开始 -->
    <div id="content-header">
        <div id="breadcrumb"><a href="<%=ctx %>/manager/home" class="tip-bottom"><i class="icon-home"></i> 首页</a>
            <a href="<%=ctx %>/manager/membermanager" class="tip-bottom">人员管理</a>
            <a href="<%=ctx %>/manager/membermanageradd" class="current">人员新增</a>
        </div>
    </div>
    <!--痕迹导航结束-->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span8">
                <c:if test="${reply != null}">
                    <div id = "tip" class="alert alert-info"><a class="close" data-dismiss="alert" href="#">×</a>
                        <center>
                                ${reply.reply}
                        </center>
                    </div>
                </c:if>
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5>基本信息</h5>
                        <a class="label label-important" href="#" id="savebutton">保存</a>
                    </div>
                    <div class="widget-content nopadding">
                        <form id="saveform" action="" method="post" class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label">用户名:</label>

                                <div class="controls">
                                    <input type="text" class="span11" name="name" placeholder="用户名"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">邮箱:</label>

                                <div class="controls">
                                    <input type="email" class="span11" name="email" placeholder="邮箱"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">电话:</label>

                                <div class="controls">
                                    <input type="text" class="span11" name="telephone" placeholder="电话"/>
                                </div>
                            </div>
                            <div class="control-group" id="rolesdiv">
                                <label class="control-label">角色分配:</label>

                                <div class="controls">
                                    <label>
                                        <input type="checkbox" value="student_manager"/>
                                        学生管理员</label>
                                    <label>
                                        <input type="checkbox" value="organization_manager"/>
                                        社团管理员</label>
                                    <label>
                                        <input type="checkbox" value="admin"/>
                                        超级管理员</label>
                                </div>
                            </div>

                            <input type="hidden" name="roles" id="roleshidden">

                            <div class="control-group">
                                <label class="control-label">密码:</label>

                                <div class="controls">
                                    <input type="password" class="span11" name="password" placeholder="密码"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">确认密码:</label>

                                <div class="controls">
                                    <input type="password" class="span11" placeholder="确认密码"/>
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
