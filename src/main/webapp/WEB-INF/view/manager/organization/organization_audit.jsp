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
        $(function(){
            $("#saveButton").click(function(){
                $("#auditForm").submit();
            });
        });
    </script>
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
            <a href="<%=ctx %>/manager/organization/organizationnotauditmanager" class="tip-bottom">未审核社团</a>
            <a href="<%=ctx %>/manager/organization/organizationaudit?id=${organization.id}" class="current">
                社团审核
            </a>
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
                    <div class="widget-title"><span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5> 审核信息</h5>
                        <a class="label label-important" href="<%=ctx %>/manager/organizationmanager">返回</a>
                        <a class="label label-important" href="#" id = "saveButton">保存</a>
                    </div>
                    <div class="widget-content nopadding">
                        <form id = "auditForm" action="" method="POST" class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label">社团名称:</label>

                                <div class="controls">
                                    <input type="text" class="span11" disabled="" value="${organization.name}"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">社团创建者:</label>

                                <div class="controls">
                                    <input type="text" class="span11" disabled="" value="${student.name}"/>
                                </div>
                            </div>


                            <div class="control-group">
                                <label class="control-label">所在学校:</label>

                                <div class="controls">
                                    <input type="text" class="span11" disabled="" value="${student.school.sh_school}"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">联系邮箱:</label>

                                <div class="controls">
                                    <input type="text" class="span11" disabled="" value="${student.email}"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">审核图像:</label>
                                <div class="controls">
                                    <img id="organizationCheckImage"
                                         style="width:240px; height: 400px;"
                                         src="${'/clubassembly/'}${organization.organizationcheckimagelocation}"
                                         data-holder-rendered="true"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">是否通过:</label>

                                <div class="controls">
                                    <select name="auditStatus">
                                        <option value="1">通过</option>
                                        <option value="2">不通过</option>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">审核信息:</label>

                                <div class="controls">
                                    <textarea name="auditMessage" class="span11" rows="5">你好同学，你创建的社团《河北师大十字街区》已经通过审核。</textarea>
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
