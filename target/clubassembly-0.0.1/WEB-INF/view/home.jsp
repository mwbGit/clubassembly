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
            $("#createOrganizationButtion").click(function () {
                document.location.href = "createorganization";
            });
        });
    </script>
</head>
<body style="background-color: #d8d6d3">


<div class="container-fluid" style="margin-top:50px; height:400px;background-color: #bdc3c7">
    <div class="container">

        <div>
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-12">
                    <div style="color:#090909; margin-top: 80px ">
                        <center>
                            <h3>社团集结号</h3>
                        </center>
                    </div>
                </div>

                <div class="col-sm-12 col-md-12 col-lg-12">
                    <div style="color:#090909;margin-top: 30px ">
                        <center>
                            <h4>高校社团信息交流平台,让社团交流更加方便。</h4>
                        </center>
                    </div>
                </div>

                <div class="col-sm-12 col-md-12 col-lg-12">
                    <center>
                        <div style="color:#090909;margin-top: 30px">
                            <button class="btn btn-inverse" id="createOrganizationButtion">创建一个社团</button>
                        </div>
                    </center>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="container" style="margin-bottom: 20px;margin-top:50px;">
    热门活动<br/>

    <div class="row" style="padding-top: 20px;padding-bottom: 20px;">
        <div class="col-sm-7 col-md-7 col-lg-7">
            <div data-ride="carousel" class="carousel slide" id="carousel-example-generic">
                <ol class="carousel-indicators">
                    <li data-slide-to="0" data-target="#carousel-example-generic" class="active"></li>
                    <li data-slide-to="1" data-target="#carousel-example-generic"></li>
                    <li data-slide-to="2" data-target="#carousel-example-generic"></li>
                    <li data-slide-to="3" data-target="#carousel-example-generic"></li>
                    <li data-slide-to="4" data-target="#carousel-example-generic"></li>
                    <li data-slide-to="5" data-target="#carousel-example-generic"></li>
                </ol>
                <div role="listbox" class="carousel-inner">
                    <div class="item active">
                        <img alt="First slide [1140x500]"
                             src="<%=ctx %>/static/image/1.png" data-holder-rendered="true">
                    </div>
                    <div class="item">
                        <img alt="Second slide [1140x500]"
                             src="<%=ctx %>/static/image/2.png" data-holder-rendered="true">
                    </div>
                    <div class="item">
                        <img alt="Third slide [1140x500]"
                             src="<%=ctx %>/static/image/3.png" data-holder-rendered="true">
                    </div>
                    <div class="item">
                        <img alt="fourth slide [1140x500]"
                             src="<%=ctx %>/static/image/1.png" data-holder-rendered="true">
                    </div>
                    <div class="item">
                        <img alt="fiveth slide [1140x500]"
                             src="<%=ctx %>/static/image/2.png" data-holder-rendered="true">
                    </div>
                    <div class="item">
                        <img alt="sixth slide [1140x500]"
                             src="<%=ctx %>/static/image/3.png" data-holder-rendered="true">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-5 col-md-5 col-lg-5">
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-12">
                    <ol>
                        <li>原剧社微电影</li>
                        <li>你的愿望 我来实现</li>
                        <li>北方工业大学"创业协会的辉煌"</li>
                        <li>第十七届辩论赛圆满落幕</li>
                        <li>社团之夜圆满落幕</li>
                        <li>莫邪君攻略 新疆之旅</li>
                        <!--<li><button class="btn btn-inverse">我要成为热门</button></li>-->
                    </ol>

                </div>
            </div>

            <div class="row" style="margin-top: 5px;">
                <div class="col-lg-offset-1 col-sm-12 col-md-12 col-lg-12">
                    <button class="btn btn-inverse">我要上头条</button>
                </div>
            </div>
        </div>
    </div>
    <hr/>
    本校社团<br/>
    <c:if test="${sameSchoolOrganizations != null && sameSchoolOrganizations.size() > 0}">
        <c:forEach var="organization" items="${sameSchoolOrganizations}" varStatus="status">
            <c:if test="${status.index % 4 == 0}">
                <div class="row" style="padding-top: 20px;padding-bottom: 20px;">
            </c:if>
            <div class="col-sm-3 col-md-3 col-lg-3">
                <center>
                    <a href="<c:url value="/organization/organizationmain?organizationid=${organization.id}"/>">
                            <%--<c:set var="str" value="${'/clubassembly/'}${organization.image}">--%>
                        <img class="img-circle"
                             alt="140x140"
                             style="width: 140px; height: 140px;"
                             src="${'/clubassembly/'}${organization.image}"
                             data-holder-rendered="true"/>
                            <%--</c:set>--%>
                    </a>
                </center>
                <h6><p class="text-center" style="color: #090909;">${organization.name}</p></h6>
            </div>

            <c:if test="${ status.last == true  ||  status.index  % 4 == 3 }">
                </div>
            </c:if>
        </c:forEach>
    </c:if>
    <hr/>
    本地社团<br/>
    <c:if test="${sameCityOrganizations != null && sameCityOrganizations.size() > 0}">
        <c:forEach var="organization" items="${sameCityOrganizations}" varStatus="status">
            <c:if test="${status.index % 4 == 0}">
                <div class="row" style="padding-top: 20px;padding-bottom: 20px;">
            </c:if>
            <div class="col-sm-3 col-md-3 col-lg-3">
                <center>
                    <a href="<c:url value="/organization/organizationmain?organizationid=${organization.id}"/>">
                            <%--<c:set var="str" value="${'/clubassembly/'}${organization.image}">--%>
                        <img class="img-circle"
                             alt="140x140"
                             style="width: 140px; height: 140px;"
                             src="${'/clubassembly/'}${organization.image}"
                             data-holder-rendered="true"/>
                            <%--</c:set>--%>
                    </a>
                </center>
                <h6><p class="text-center" style="color: #090909;">${organization.name}</p></h6>
            </div>
            <c:if test="${status.last == true  || status.index % 4 == 3}">
                </div>
            </c:if>
        </c:forEach>
    </c:if>
</div>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <%--<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>--%>
                <h4 class="modal-title" id="myModalLabel">提醒</h4>
            </div>
            <div class="modal-body">
                <c:if test="${reply.code == 203}">
                    ${reply.reply}
                </c:if>
            </div>
            <div class="modal-footer">
                <!--<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>-->
                <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>


<c:if test="${reply.code == 203}">
    <script type="text/javascript">
        $(function () {
            $("#myModal").modal();
        });
    </script>
</c:if>


<!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/video.js"></script>
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/flat-ui.min.js"></script>
</body>
</html>
