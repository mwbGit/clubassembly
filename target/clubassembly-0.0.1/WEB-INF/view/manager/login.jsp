<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>社团集结号</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="<%=ctx %>/static/matrix/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=ctx %>/static/matrix/css/bootstrap-responsive.min.css"/>
    <link rel="stylesheet" href="<%=ctx %>/static/matrix/css/matrix-login.css"/>
    <link href="<%=ctx %>/static/matrix/font-awesome/css/font-awesome.css" rel="stylesheet"/>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>

</head>
<body>

<div id="loginbox">
    <c:if test="${reply != null}">
        <div id="tip" class="alert alert-info"><a class="close" data-dismiss="alert" href="#">×</a>
            <center>
                ${reply.reply}
            </center>
        </div>
    </c:if>
    <!--登陆表单-->
    <form id="loginform" class="form-vertical" action="" method="post">
        <div class="control-group normal_text"><h3><img src="<%=ctx %>/static/matrix/img/logo.png" alt="Logo"/></h3></div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_lg"><i class="icon-user"></i></span><input type="email" name = "email" placeholder="邮箱"/>
                </div>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_ly"><i class="icon-lock"></i></span><input type="password" name = "password" placeholder="密码"/>
                </div>
            </div>
        </div>
        <div class="form-actions">
            <span class="pull-left"><a href="#" class="flip-link btn btn-info" id="to-recover">忘记密码?</a></span>
            <span class="pull-right"><a type="submit" id="submitButton" class="btn btn-success">登陆</a></span>
        </div>
    </form>

    <!--还原密码表单-->
    <form id="recoverform" action="#" class="form-vertical">
        <p class="normal_text">Enter your e-mail address below and we will send you instructions how to recover a
            password.</p>

        <div class="controls">
            <div class="main_input_box">
                <span class="add-on bg_lo"><i class="icon-envelope"></i></span><input type="text"
                                                                                      placeholder="E-mail address"/>
            </div>
        </div>

        <div class="form-actions">
            <span class="pull-left"><a href="#" class="flip-link btn btn-success" id="to-login">&laquo; Back to
                login</a></span>
            <span class="pull-right"><a class="btn btn-info">Reecover</a></span>
        </div>
    </form>
</div>

<script src="<%=ctx %>/static/matrix/js/matrix.login.js"></script>
<script src="<%=ctx %>/static/matrix/js/excanvas.min.js"></script>
<script src="<%=ctx %>/static/matrix/js/jquery.min.js"></script>
<script src="<%=ctx %>/static/matrix/js/jquery.ui.custom.js"></script>
<script src="<%=ctx %>/static/matrix/js/bootstrap.min.js"></script>
<script src="<%=ctx %>/static/matrix/js/jquery.flot.min.js"></script>
<script src="<%=ctx %>/static/matrix/js/jquery.flot.resize.min.js"></script>
<script src="<%=ctx %>/static/matrix/js/jquery.peity.min.js"></script>
<script src="<%=ctx %>/static/matrix/js/fullcalendar.min.js"></script>
<script src="<%=ctx %>/static/matrix/js/matrix.js"></script>
<script src="<%=ctx %>/static/matrix/js/matrix.dashboard.js"></script>
<script src="<%=ctx %>/static/matrix/js/jquery.gritter.min.js"></script>
<script src="<%=ctx %>/static/matrix/js/matrix.interface.js"></script>
<script src="<%=ctx %>/static/matrix/js/matrix.chat.js"></script>
<script src="<%=ctx %>/static/matrix/js/jquery.validate.js"></script>
<script src="<%=ctx %>/static/matrix/js/matrix.form_validation.js"></script>
<script src="<%=ctx %>/static/matrix/js/jquery.wizard.js"></script>
<script src="<%=ctx %>/static/matrix/js/jquery.uniform.js"></script>
<script src="<%=ctx %>/static/matrix/js/select2.min.js"></script>
<script src="<%=ctx %>/static/matrix/js/matrix.popover.js"></script>
<script src="<%=ctx %>/static/matrix/js/jquery.dataTables.min.js"></script>
<script src="<%=ctx %>/static/matrix/js/matrix.tables.js"></script>
<script src="<%=ctx %>/static/jquery/jquery-2.1.3.min.js.js"></script>
<script >
    $(function(){
        $("#submitButton").click(function(){
            $("#loginform").submit();
        });

        //管理端提示延时
        setTimeout(function () {
            var tip =  $('#tip');
            if(tip != null){
                tip.remove();
            }
        }, 3000);

    });
</script>
</body>
</html>
