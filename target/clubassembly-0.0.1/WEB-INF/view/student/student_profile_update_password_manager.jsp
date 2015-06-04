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


    </script>
</head>
<body style="background-color: #d8d6d3">
<div class="container-fluid" style="margin-bottom: 200px;margin-top: 100px;">
    <div class="container">
        <form class="form-horizontal" role="form">
            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
                        <p class="text-right">当前密码</p></label>

                    <div class="col-sm-4">
                        <input class="form-control" type="text" id="formGroupInputDefault" placeholder="请填写真实姓名">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
                        <p class="text-right">新密码</p></label>

                    <div class="col-sm-4">
                        <input class="form-control" type="text" id="formGroupInputDefault" placeholder="请填写真实姓名">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
                        <p class="text-right">确认密码</p></label>

                    <div class="col-sm-4">
                        <input class="form-control" type="text" id="formGroupInputDefault" placeholder="请填写真实姓名">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-offset-2 col-sm-2 col-md-2 col-lg-2">
                    <button class="btn btn-block btn-lg btn-primary" type="button">保存
                    </button>
                </div>
                <div class="col-sm-2 col-md-2 col-lg-2">
                    <button class="btn btn-block btn-lg btn-inverse"
                            type="button" id="backButtion">返回
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>


<!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/video.js"></script>
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/flat-ui.min.js"></script>
</body>
</html>
