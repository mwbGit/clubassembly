<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String ctx = request.getContextPath();
%>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-01">
                <span class="sr-only">Toggle navigation</span>
            </button>
            <a class="navbar-brand" href="<c:url value="/home/main"/>">首页</a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-collapse-01">
            <ul class="nav navbar-nav" style="display: none;" id="clubnav">
                <li class="dropdown">
                    <a href="#fakelink" class="dropdown-toggle" data-toggle="dropdown" id="clubcontrolla">
                    </a>
                    <ul class="dropdown-menu" id="clubcontrollul">
                    </ul>
                </li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="<c:url value="/organization/organizationeventall"/>">社团活动</a></li>
                <li><a href="<c:url value="/organization/organizationsquareall"/>">社团广场</a></li>
                <li class="dropdown">
                    <a href="#fakelink" class="dropdown-toggle" data-toggle="dropdown">
                        我的社团
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="#"> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;已加入社团</a>
                        </li>
                        <li id="alreadyindivider">
                        </li>


                        <li class="divider">
                        </li>

                        <li>
                            <a href="#"> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;待审核社团</a>
                        </li>

                        <li id="waitauditdivider">

                        </li>
                    </ul>
                    <!-- /Sub menu -->
                </li>

                <li class="dropdown">
                    <a href="#fakelink" class="dropdown-toggle" data-toggle="dropdown">
                        我的关注
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="#"> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;我关注的人</a>
                        </li>

                        <li id="watched">
                        </li>
                        <li class="divider">
                        </li>

                        <li>
                            <a href="#"> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;关注我的人</a>
                        </li>
                        <li id="bewatched">
                        </li>
                        <li class="divider">
                        </li>

                        <li>
                            <a href="#"> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;互相关注的人</a>
                        </li>
                        <li id="interwatched">
                        </li>
                        <li class="divider">
                        </li>
                    </ul>
                    <!-- /Sub menu -->
                </li>


                <li class="dropdown">
                    <a href="#fakelink" class="dropdown-toggle" data-toggle="dropdown">
                        <img src="<shiro:principal property="image"/>" width="20px;" height="20px;"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;<shiro:principal/>
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="<c:url value="/home/studentprofilemanager"/>">个人信息</a></li>
                        <li class="divider">
                        <li><a href="<c:url value="/student/studentprofilemain"/>">个人主页</a></li>
                        <li class="divider">
                        <li><a href="<c:url value="/student/studentprofileupdatepasswordmanager"/>">修改密码</a></li>
                        <li class="divider">
                        <li><a href="<c:url value="/logout"/>">退出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
