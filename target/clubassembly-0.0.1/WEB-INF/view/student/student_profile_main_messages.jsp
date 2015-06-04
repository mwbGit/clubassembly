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
        $(function () {
            $("#watchbutton").click(function () {
                document.location.href = "watchstudent?studentid=" + $("#watchbutton").val();
            });

            $("#cancelwatchbutton").click(function () {
                document.location.href = "cancelwatchstudent?studentid=" + $("#cancelwatchbutton").val();
            });
        });
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
                         style="width: 140px; height: 140px;" src="${"/clubassembly/"}${student.image}"
                         data-holder-rendered="true"/>
                </center>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-offset-4 col-sm-4 col-md-4 col-lg-4" style="height:180px;">
                <div class="row" style="height: 50px">
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        <p class="text-center">${student.name}</p>
                    </div>
                </div>

                <div class="row" style="height: 50px">
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        <p class="text-center">${student.personcode}</p>
                    </div>
                </div>
                <c:if test="${isme != null && isme}">
                    <div class="row">
                        <button type="button" id="mainpagebutton"
                                class="btn btn-block btn-lg btn-inverse">主页管理
                        </button>
                    </div>
                </c:if>

                <c:if test="${isme == null || isme != null && !isme}">
                    <c:if test="${iswatched == null}">
                        <div class="row">
                            <button type="button" id="watchbutton" value="${student.id}"
                                    class="btn btn-block btn-lg btn-inverse">关注
                            </button>
                        </div>
                    </c:if>

                    <c:if test="${iswatched != null && iswatched}">
                        <div class="row">
                            <button type="button" id="cancelwatchbutton" value="${student.id}"
                                    class="btn btn-block btn-lg btn-inverse">取消关注
                            </button>
                        </div>
                    </c:if>
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
                <a href="<c:url value="/student/studentprofilemain?studentid=${student.id}"/>"><p class="text-center">首页</p>
                </a>
            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">
                <a href="<c:url value="/student/studentprofilemainprofile?studentid=${student.id}"/>"><p class="text-center">
                    资料</p>
                </a>
            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">
                <a href="<c:url value="/student/studentprofilemainnews?studentid=${student.id}"/>"><p class="text-center">
                    新鲜事</p>
                </a>
            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">
                <a href="<c:url value="/student/studentprofilemainphotos?studentid=${student.id}"/>"><p class="text-center">
                    相册</p>
                </a>
            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">
                <a href="<c:url value="/student/studentprofilemainmessages?studentid=${student.id}"/>"><p class="text-center">
                    留言板</p>
                </a>
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
