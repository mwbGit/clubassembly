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


<div class="container" style="margin-bottom: 20px;margin-top:50px;">
    <div class="row" style="padding-top: 20px;padding-bottom: 20px;">
        <c:if test="${organizations != null && organizations.size() > 0}">
            <c:forEach var="organization" items="${organizations}" varStatus="status">
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

    </div>
</div>


<!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/video.js"></script>
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/flat-ui.min.js"></script>
</body>
</html>
