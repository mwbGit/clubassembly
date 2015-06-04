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
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1" style="height:5px; background-color: #2c3e50">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
        </div>
        <hr/>
    </div>
</div>




<!-- 发布活动 -->
<div class="modal fade bs-example-modal-lg" id="releaseEventModal" role="dialog" aria-labelledby="releaseEventTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="form-horizontal" role="form">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                    <h6 class="modal-title" id="releaseEventTitle">发布活动</h6>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12">
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
                                        <p class="text-right">活动标题</p></label>

                                    <div class="col-sm-8">
                                        <input class="form-control" type="text" id="formGroupInputDefault"
                                               placeholder="请填写活动标题">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
                                        <p class="text-right">活动分类</p></label>

                                    <div class="col-sm-2">
                                        <select class="form-control">
                                            <option>纳新</option>
                                            <option>晚会</option>
                                        </select>
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
                                        <p class="text-right">活动地址</p></label>

                                    <div class="col-sm-3">
                                        <select class="form-control">
                                            <option>河北省</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-2">
                                        <select class="form-control">
                                            <option>河北师范大学</option>
                                            <option>河北师范大学</option>
                                            <option>河北师范大学</option>
                                            <option>河北师范大学</option>
                                            <option>河北师范大学</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-2">
                                        <input class="form-control" type="text" id="formGroupInputDefault"
                                               placeholder="学校具体地点">
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-sm-12 col-md-12 col-lg-12">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-sm-2 col-md-2 col-lg-2 control-label"
                                                   for="formGroupInputDefault">
                                                <p class="text-right">活动时间</p></label>

                                            <div class="col-sm-2">
                                                <input class="form-control" type="text" id="formGroupInputDefault"
                                                       placeholder="开始时间">
                                            </div>
                                            <div class="col-sm-2">
                                                <select class="form-control">
                                                    <option>08:00</option>
                                                    <option>08:30</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <div class="col-lg-offset-2 col-sm-2">
                                                <input class="form-control" type="text" id="formGroupInputDefault2"
                                                       placeholder="结束时间">
                                            </div>
                                            <div class="col-sm-2">
                                                <select class="form-control">
                                                    <option>08:00</option>
                                                    <option>08:30</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
                                        <p class="text-right">主办方</p></label>

                                    <div class="col-sm-3">
                                        <input class="form-control" type="text" id="formGroupInputDefault"
                                               placeholder="请填写真实姓名">
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
                                        <p class="text-right">活动规模</p></label>

                                    <div class="col-sm-2">
                                        <select class="form-control">
                                            <option>20-50</option>
                                            <option>50-70</option>
                                            <option>70-100</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
                                        <p class="text-right">活动描述</p></label>

                                    <div class="col-sm-8">
                                        <textarea class="form-control" name="content" rows="10"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <div class="row">
                        <div class="col-lg-offset-7 col-sm-2 col-md-2 col-lg-2">
                            <button type="button" class="btn btn-block btn-lg btn-inverse" data-dismiss="modal">取消
                            </button>
                        </div>
                        <div class="col-sm-3 col-md-3 col-lg-3">
                            <button type="submit" class="btn btn-block btn-lg btn-primary" id="modalBackButtion">发布
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
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
<!-- 发布新鲜事 -->
<div class="modal fade bs-example-modal-lg" id="releaseNewsModal" role="dialog" aria-labelledby="releaseNewsTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="form-horizontal" role="form">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                    <h6 class="modal-title" id="releaseNewsTitle">发布新鲜事</h6>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
                                <p class="text-right">内容</p></label>

                            <div class="col-sm-8">
                                <textarea class="form-control" rows="5"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-lg-offset-7 col-sm-2 col-md-2 col-lg-2">
                            <button type="button" class="btn btn-block btn-lg btn-inverse" data-dismiss="modal">取消
                            </button>
                        </div>
                        <div class="col-sm-3 col-md-3 col-lg-3">
                            <button type="submit" class="btn btn-block btn-lg btn-primary">发布
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- 发布相册 -->
<div class="modal fade bs-example-modal-lg" id="releasePhotosModal" role="dialog" aria-labelledby="releasePhotosTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="form-horizontal" role="form">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                    <h6 class="modal-title" id="releasePhotosTitle">发布相册</h6>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12" style="height: 500px; background-color: #bdc3c7">
                            <div class="row">
                                <div class="col-lg-offset-4 col-sm-4 col-md-4 col-lg-4" style="padding-top: 200px;">
                                    <button type="button" class="btn btn-block btn-lg btn-inverse" data-dismiss="modal">
                                        点击上传照片
                                    </button>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-offset-2 col-sm-8 col-md-8 col-lg-8" style="padding-top: 80px;">
                                    <center><h3>每次最多可以上传100张照片</h3></center>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-lg-offset-7 col-sm-2 col-md-2 col-lg-2">
                            <button type="button" class="btn btn-block btn-lg btn-inverse" data-dismiss="modal">取消
                            </button>
                        </div>
                        <div class="col-sm-3 col-md-3 col-lg-3">
                            <button type="submit" class="btn btn-block btn-lg btn-primary">发布
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/video.js"></script>
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/flat-ui.min.js"></script>
</body>
</html>
