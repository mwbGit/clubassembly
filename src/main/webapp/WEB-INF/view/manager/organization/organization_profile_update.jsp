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
            <a href="<%=ctx %>/manager/organization/organizationprofileupdate?id=${organization.id}" class="current">
                社团信息修改
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
                    <div class="widget-title"><span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5> 基本信息</h5>
                        <a class="label label-important" href="<%=ctx %>/manager/organizationmanager">返回</a>
                        <a class="label label-important" href="#">保存</a>
                    </div>
                    <div class="widget-content nopadding">
                        <form action="#" method="get" class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label">社团名称:</label>

                                <div class="controls">
                                    <input type="text" class="span11"  value="${organization.name}"/>
                                </div>
                            </div>


                            <div class="control-group">
                                <label class="control-label">社团口号:</label>

                                <div class="controls">
                                    <input type="text" class="span11"  value="${organization.slogan}"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">当前状态:</label>

                                <div class="controls">
                                    <c:if test="${organization.status == 0}">
                                        <input type="text" class="span3"  disabled = "" value="未审核"/>
                                    </c:if>
                                    <c:if test="${organization.status == 1}">
                                        <input type="text" class="span3"  disabled = "" value="已审核"/>
                                    </c:if>
                                    <c:if test="${organization.status == 2}">
                                        <input type="text" class="span3"  disabled = "" value="已删除"/>
                                    </c:if>
                                </div>
                            </div>

                            <c:if test="${organization.status == 1}">
                                <div class="control-group">
                                    <label class="control-label">审核信息:</label>
                                    <div class="controls">
                                        <textarea class="span11" rows="5"
                                                  disabled="">${organization.auditMessage}</textarea>
                                    </div>
                                </div>
                            </c:if>



                            <div class="control-group">
                                <label class="control-label">社团类别:</label>

                                <div class="controls">
                                    <input type="text" class="span4"  value="${organization.organizationMainCategory.name}"/>
                                    <input type="text" class="span4"  value="${organization.organizationSecondCategory.name}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">社团性质:</label>

                                <div class="controls">
                                    <input type="text" class="span11"  value="${organization.property.property}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">社团介绍:</label>

                                <div class="controls">
                                    <textarea class="span11" rows="5" >${organization.organizationIntroduce}</textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">部门介绍:</label>

                                <div class="controls">
                                    <textarea class="span11" rows="5" >${organization.departmentIntroduce}</textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">联系方式:</label>

                                <div class="controls">
                                    <textarea class="span11" rows="5" >${organization.contactInformation}</textarea>
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
