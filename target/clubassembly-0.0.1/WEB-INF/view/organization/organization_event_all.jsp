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
            $("#backButtion").click(function () {
                document.location.href = "home.html";
            });
        });
    </script>
</head>
<body style="background-color: #d8d6d3">


<div class="container-fluid" style="margin-top: 50px;padding-top: 20px">
    <div class="container">
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
                                    <li>活动规模:${event.scale}</li>
                                    <li>活动地点:${event.location}</li>
                                </ul>
                            </div>
                        </div>
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
</div>


<!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/video.js"></script>
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/flat-ui.min.js"></script>
</body>
</html>
