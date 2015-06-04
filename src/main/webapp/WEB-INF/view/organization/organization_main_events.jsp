<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>社团集结号</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <script src="<%=ctx %>/static/editor/kindeditor-min.js"></script>


    <!-- Loading Bootstrap -->
    <link href="<%=ctx %>/static/Flat-UI-master/dist/css/vendor/bootstrap.min.css" rel="stylesheet">

    <!-- Loading Flat UI -->
    <link href="<%=ctx %>/static/Flat-UI-master/dist/css/flat-ui.min.css" rel="stylesheet">
    <link href="<%=ctx %>/static/css/index.css" rel="stylesheet">

    <link rel="shortcut icon" href="img/favicon.ico">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
    <script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/html5shiv.js"></script>
    <script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/respond.min.js"></script>
    <script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
    <![endif]-->


    <script src="<%=ctx %>/static/jquery/jquery-2.1.3.min.js.js"></script>
    <script src="<%=ctx %>/static/js/utils.js"></script>
    <script type="text/javascript">

    </script>
</head>
<body style="background-color: #d8d6d3">

<div class="container-fluid organization_background" style="margin-top:53px;padding-top: 50px;">
    <div class="container">
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12">
                <center>
                    <img class="img-circle"
                         alt="140x140"
                         style="width: 140px; height: 140px;" src="${"/clubassembly/"}${organization.image}"
                         data-holder-rendered="true"/>
                </center>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-offset-4 col-sm-4 col-md-4 col-lg-4" style="height:180px;">
                <div class="row" style="height: 50px">
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        <p class="text-center">${organization.name}</p>
                    </div>
                </div>

                <div class="row" style="height: 50px">
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        <p class="text-center">${organization.slogan}</p>
                    </div>
                </div>
                <c:if test="${iscommender != null && iscommender || ismember != null && ismember}">
                    <div class="row">
                        <button type="button" id="organizationManageButton" value="${organization.id}"
                                class="btn btn-block btn-lg btn-inverse">主页管理
                        </button>
                    </div>
                </c:if>
                <c:if test="${iscommender != null && !iscommender && ismember != null && !ismember}">
                    <button type="button" id="organizationApplyInButton" value="${organization.id}"
                            data-toggle="modal" data-backdrop="static"
                            data-target="#myModal"
                            class="btn btn-block btn-lg btn-inverse">申请加入
                    </button>
                </c:if>
            </div>
        </div>
    </div>
</div>


<!--<img height="300px;" width="1700px" src="<%=ctx %>/static/image/1.png"/>-->
<div class="container-fluid" style="margin-top: 20px;">
    <div class="container">
        <div class="row">
            <div class="col-sm-1 col-md-1 col-lg-1">
                <a href="<c:url value="/organization/organizationmain?organizationid=${organization.id}"/>"><p
                        class="text-center">首页</p></a>
            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">
                <a href="<c:url value="/organization/organizationmainprofile?organizationid=${organization.id}"/>"><p
                        class="text-center">资料</p></a>
            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">
                <a href="<c:url value="/organization/organizationmainevents?organizationid=${organization.id}"/>"><p
                        class="text-center">活动</p></a>
            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">
                <a href="<c:url value="/organization/organizationmainnews?organizationid=${organization.id}"/>"><p
                        class="text-center">新鲜事</p></a>
            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">
                <a href="<c:url value="/organization/organizationmainphotos?organizationid=${organization.id}"/>"><p
                        class="text-center">相册</p></a>
            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">
                <a href="<c:url value="/organization/organizationmainmessages?organizationid=${organization.id}"/>"><p
                        class="text-center">留言板</p></a>
            </div>
        </div>
        <div class="row" style="">
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1" style="height:5px; background-color: #2c3e50">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
        </div>
    </div>
</div>
<div class="container-fluid" style="margin-top: 20px;">
    <div class="container">
        <div class="row" style="margin-top: 20px;">
            <div class="col-sm-2 col-md-2 col-lg-2">
                <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>社团活动
            </div>
        </div>

        <c:if test="${events != null && events.size() > 0}">
        <c:forEach var="event" items="${events}" varStatus="status">
        <c:if test="${status.index % 2 == 0}">
        <div class="row" style="margin-top: 20px;margin-bottom: 30px;">
            <div class="col-lg-offset-1 col-sm-6 col-md-6 col-lg-6">
                </c:if>
                <c:if test="${status.index % 2 != 0}">
                <div class="col-sm-5 col-md-5 col-lg-5">
                    </c:if>
                    <div class="row">
                        <a href="<c:url value="/organization/organizationmaineventsdetail/${organization.id}/${event.id}"/>">
                            <div class="col-sm-4 col-md-4 col-lg-4">
                                <div>
                                    <img alt="First slide [1140x500]"
                                         width="150px" height="200px"
                                         src="${"/clubassembly/"}${event.poster}" data-holder-rendered="true">
                                </div>
                            </div>
                            <div class="col-sm-8 col-md-8 col-lg-8">
                                <div class="row">
                                    <ul style="list-style-type:none;">
                                        <li></li>
                                        <li></li>
                                        <li></li>
                                        <li>${event.title}</li>
                                        <li>主办方:${event.sponsor}</li>
                                        <li>开始时间:${event.beginDate}</li>
                                        <li>结束时间:${event.endDate}</li>
                                        <li>活动规模:${event.sponsor}</li>
                                        <li>活动地点:${event.location}</li>
                                    </ul>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <c:if test="${ status.last == true  ||  status.index  % 2 == 1 }">
            </div>
            </c:if>
            </c:forEach>
            </c:if>
            <hr/>
        </div>
    </div>

    <c:if test="${iscommender != null && !iscommender && ismember != null && !ismember }">
    <!-- Modal -->
    <div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="<c:url value="/organization/organizationapplyin"/>"
                      method="post">
                    <input type="hidden" value="${organization.id}" name="organizationid"/>

                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span
                                aria-hidden="true">&times;</span><span
                                class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myModalLabel">申请设置</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                                <p class="text-center">可选部门</p>
                            </div>
                            <div class="col-sm-3 col-md-3 col-lg-3">
                                <p class="text-center">当前可接受申请人数</p>
                            </div>
                            <div class="col-sm-3 col-md-3 col-lg-3">
                                <p class="text-center">申请</p>
                            </div>
                        </div>
                        <c:if test="${departments != null && departments.size() > 0}">
                            <c:forEach var="department" items="${departments}" varStatus="statys">
                                <div class="row">
                                    <c:if test="${department.open}">
                                        <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                                            <label class="radio" type="mydepartment" id="${department.id}">
                                                    ${department.department}
                                            </label>
                                        </div>
                                        <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                                            <input class="form-control" type="text"
                                                   value="${department.maxNumbers}" readonly>
                                        </div>
                                        <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                                            <c:if test="${department.maxNumbers  > 0}">
                                                <input class="form-control" type="radio" value="${department.id}"
                                                       name="chooseradio">
                                            </c:if>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:if>


                        <div class="row">
                            <div class="form-group">
                                <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label">
                                    <p class="text-right">允许调剂</p></label>

                                <div class="col-sm-3">
                                    <select class="form-control" name="adjust">
                                        <option value="1" selected="selected">
                                            允许
                                        </option>

                                        <option value="0">
                                            不允许
                                        </option>
                                    </select>
                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="form-group">
                                <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label"
                                       for="formGroupInputDefault">
                                    <p class="text-right">申请理由</p></label>

                                <div class="col-sm-8">
                                    <textarea class="form-control" rows="5" cols="20" id="formGroupInputDefault"
                                              name="reason"
                                            >
                                    </textarea>
                                </div>

                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="submit" class="btn btn-primary">提交申请</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    </c:if>
    <!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
    <script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/video.js"></script>
    <script src="<%=ctx %>/static/Flat-UI-master/dist/js/flat-ui.min.js"></script>
</body>
</html>
