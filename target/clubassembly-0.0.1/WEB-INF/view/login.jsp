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

    <script type="text/javascript">
        $(function () {
            $("#registerButtion").click(function () {
                document.location.href = "register";
            });
        });
    </script>
</head>
<body style="background-color: #d8d6d3">
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-01">
                <span class="sr-only">Toggle navigation</span>
            </button>
            <a class="navbar-brand" href="<c:url value="/index"/>">首页</a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-collapse-01">
            <ul class="nav navbar-nav">
                <!--<li class="active"><a href="#fakelink">Products</a></li>-->
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <!--<li><a href="#fakelink">登陆</a></li>-->
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
</nav>
<!-- /navbar -->
<div class="container-fluid" style="margin-top:80px; padding-top: 100px; height:400px;margin-bottom: 230px;">
    <div class="container">
        <div>
            <div class="row">
                <div class="col-sm-7 col-md-7 col-lg-7">
                    <div data-ride="carousel" class="carousel slide" id="carousel-example-generic">
                        <ol class="carousel-indicators">
                            <li data-slide-to="0" data-target="#carousel-example-generic" class="active"></li>
                            <li data-slide-to="1" data-target="#carousel-example-generic"></li>
                            <li data-slide-to="2" data-target="#carousel-example-generic"></li>
                            <li data-slide-to="3" data-target="#carousel-example-generic"></li>
                        </ol>
                        <div role="listbox" class="carousel-inner">
                            <div class="item active">
                                <img alt="First slide [1140x500]"
                                     src="<%=ctx %>/static/image/first.jpg" data-holder-rendered="true">
                            </div>
                            <div class="item">
                                <img alt="Second slide [1140x500]"
                                     src="<%=ctx %>/static/image/second.jpg" data-holder-rendered="true">
                            </div>
                            <div class="item">
                                <img alt="Third slide [1140x500]"
                                     src="<%=ctx %>/static/image/third.jpg" data-holder-rendered="true">
                            </div>
                            <div class="item">
                                <img alt="fourth slide [1140x500]"
                                     src="<%=ctx %>/static/image/forth.jpg" data-holder-rendered="true">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-5 col-md-5 col-lg-5">
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12">
                            <div style="margin-top: 20px;">
                                <form action="" role="form" method="post">
                                    <div class="row">
                                        <div class="col-sm-12 col-md-12 col-lg-12">
                                            请登陆
                                        </div>
                                    </div>


                                    <div class="row" style="margin-top: 10px;">
                                        <div class="col-sm-12 col-md-12 col-lg-12">
                                            <div class="form-group">
                                                <input type="email" name="email" placeholder="邮箱"
                                                       class="form-control">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12 col-md-12 col-lg-12">
                                            <div class="form-group">
                                                <input type="password" name="password" placeholder="密码"
                                                       class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 col-md-6 col-lg-6">
                                            <label for="checkbox2" class="checkbox">
                                                <input type="checkbox" data-toggle="checkbox" checked="checked"
                                                       id="checkbox2" value="" class="custom-checkbox"><span
                                                    class="icons"><span class="icon-unchecked"></span><span
                                                    class="icon-checked"></span></span>
                                                记住我
                                            </label>
                                        </div>

                                        <div class="col-sm-6 col-md-6 col-lg-6">
                                            <a href="#"><p class="text-right">忘记密码</p></a>
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-sm-6 col-md-6 col-lg-6">
                                            <button class="btn btn-block btn-lg btn-primary" type="submit">登陆</button>
                                        </div>

                                        <div class="col-sm-6 col-md-6 col-lg-6">
                                            <button class="btn btn-block btn-lg btn-inverse" id="registerButtion"
                                                    type="button">注册
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
                <c:if test="${reply.code == 200 || reply.code == 201 || reply.code == 202}">
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


<c:if test="${reply.code == 200 || reply.code == 201 || reply.code == 202}">
    <script type="text/javascript">
        $(function () {
            $("#myModal").modal();
        });
    </script>
</c:if>


<jsp:include page="../layout/footer.jsp"/>

<!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/video.js"></script>
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/flat-ui.min.js"></script>
</body>
</html>
