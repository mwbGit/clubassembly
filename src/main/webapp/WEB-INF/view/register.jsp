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
        $("#backButtion").click(function () {
            document.location.href = "login";
        });
        $("#modalBackButtion").click(function () {
            document.location.href = "login";
        });

        //验证登陆账号(字母或数字)
        jQuery.validator.addMethod("passwordValidate", function (value, element) {
            if (value != null && value != "") {
                return checknum(value);
            } else {
                return false;
            }
        }, "");


        //验证表单
        $("#registerForm").validate({
            rules: {
                name: {
                    required: true,
                    rangelength: [2, 10]
                },
                email: {
                    required: true,
                    remote: "/clubassembly/checkemail?" + $("#email").val(),
                    email: true
                },
                password: {
                    required: true,
                    rangelength: [6, 10],
                    passwordValidate: true
                },
                password2: {
                    required: true,
                    rangelength: [6, 10],
                    passwordValidate: true,
                    equalTo: "#password"
                }
            },
            messages: {
                name: {
                    required: "请输入姓名",
                    rangelength: "姓名不能小于2个字符多于20个字符"
                },
                email: {
                    required: "请输入邮箱",
                    remote: "该邮箱已被注册",
                    email: "请输入正确的email地址"
                },
                password: {
                    required: "请输入登陆密码",
                    rangelength: "密码不能小于6个字符多于10个字符",
                    passwordValidate: "密码只能为字母或数字"
                },
                password2: {
                    required: "请输入确认密码",
                    rangelength: "确认密码不能小于6个字符多于10个字符",
                    passwordValidate: "确认密码只能为字母或数字",
                    equalTo: "两次输入密码不一致"
                }
            }
        });

    });


    //        上传头像
    function ajaxFileUpload() {
        $.ajaxFileUpload({
            url: "/clubassembly/uploadstudentimage",
            secureuri: false,
            fileElementId: 'fileToUpload',
            dataType: 'json',
            success: function (data, status) {
                if (data.code == 0) {
                    alert("上传失败")
                } else {
                    $("#studentImage").attr("src", "/clubassembly/" + data.reply);
                    $("#registerForm").append("<input type='hidden' value = " + data.reply + " name=" + "imagelocation" + " >");

                }
            },
            error: function (data, status, e) {
                alert("上传出错")
            }
        });
        return false;
    }


    //  判断是否是字母或数字
    function checknum(value) {
        var Regx = /^[A-Za-z0-9]*$/;
        if (Regx.test(value)) {
            return true;
        } else {
            return false;
        }
    }


    function getCity(i) {
//          要得到省份为i的所有城市
//            alert(i);
        $.ajax({
            async: false,
            type: "POST",
            data: {
                provinceid: i
            },
            url: "/clubassembly/getcity",
            dataType: 'json',
            success: function (data) {
                if (data.code == 0) {
                    alert("没得到数据")
                } else {
                    $("#citySelect").empty();
//                        将得到的数据，放到cities列表中，并重写
                    //jquery解析map数据
                    $.each(data.reply, function (key, value) {
                        if (key == 0) {
                            getSchool(value.ci_id)
                        }
                        $("#citySelect").append(
                                "<option value = " + value.ci_id + ">" +
                                        value.ci_city +
                                        "</option>"

                        );
                    });
                }
            }
        });
    }

    function getSchool(i) {
//            要得到i城市里的所有学校
        $.ajax({
            async: false,
            type: "POST",
            data: {
                cityid: i
            },
            url: "/clubassembly/getschool",
            dataType: 'json',
            success: function (data) {
                if (data.code == 0) {
                    alert("没得到数据")
                } else {
                    $("#schoolSelect").empty();
//                        将得到的数据，放到cities列表中，并重写
                    //jquery解析map数据
                    $.each(data.reply, function (key, value) {
                        $("#schoolSelect").append(
                                "<option value = " + value.sh_id + ">" +
                                        value.sh_school +
                                        "</option>"
                        );
                    });
                }
            }
        });
    }


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
                <li><a href="<c:url value="/login"/>">登陆</a></li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
</nav>

<div class="container-fluid" style="margin-top:100px;margin-bottom: 160px;">
    <div class="container">
        <form id="registerForm" class="form-horizontal" role="form" method="post" action="">
            <div class="row">
                <div class="form-group">
                    <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label" for="name">
                        <p class="text-right">姓名</p></label>

                    <div class="col-sm-4">
                        <input class="form-control" type="text" id="name" name="name">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label" for="email">
                        <p class="text-right">邮箱</p></label>

                    <div class="col-sm-4">
                        <input class="form-control" type="text" id="email" name="email">

                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">个人头像</p></label>

                    <div class="col-sm-2">
                        <center>
                            <img id="studentImage"
                                 class="img-circle"
                                 alt="140x140"
                                 style="width: 140px; height: 140px;" src="<%=ctx %>/static/image/2.jpg"
                                 data-holder-rendered="true"/>
                        </center>

                    </div>
                    <div class="col-sm-3" style="margin-top: 20px;">
                        <div>
                            请上传个人头像<br/>
                        </div>
                        <input id="fileToUpload" type="file"
                               name="fileToUpload">
                        <button class="btn btn-block btn-lg btn-default" id="buttonUpload"
                                onclick="return ajaxFileUpload();">上传头像
                        </button>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="form-group">
                    <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label" for="provinceSelect">
                        <p class="text-right">所在省份</p></label>

                    <div class="col-sm-4">
                        <select class="form-control" name="province" id="provinceSelect"
                                onchange="getCity(this[selectedIndex].value)">
                            <c:forEach var="province" items="${provinces}" varStatus="status">
                                <option value="${province.pr_id}">
                                        ${province.pr_province}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="form-group">
                    <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label" for="citySelect">
                        <p class="text-right">所在城市</p></label>

                    <div class="col-sm-4">
                        <select class="form-control" name="city" id="citySelect"
                                onchange="getSchool(this[selectedIndex].value)">
                            <c:forEach var="city" items="${cities}" varStatus="status">
                                <option value="${city.ci_id}">
                                        ${city.ci_city}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="form-group">
                    <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label" for="schoolSelect">
                        <p class="text-right">所在学校</p></label>

                    <div class="col-sm-4">
                        <select class="form-control" name="school" id="schoolSelect">
                            <c:forEach var="school" items="${schools}" varStatus="status">
                                <option value="${school.sh_id}">
                                        ${school.sh_school}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="form-group">
                    <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label" for="password">
                        <p class="text-right">密码</p></label>

                    <div class="col-sm-4">
                        <input class="form-control" type="password" id="password" name="password">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label" for="password2">
                        <p class="text-right">确认密码</p></label>

                    <div class="col-sm-4">
                        <input class="form-control" type="password" id="password2" name="password2">
                    </div>
                </div>
            </div>

            <div class="row">

                <div class="col-lg-offset-3 col-sm-3 col-md-3 col-lg-3">
                    <button class="btn btn-block btn-lg btn-primary" type="submit">注册
                    </button>
                </div>

                <div class="col-sm-2 col-md-2 col-lg-2">
                    <button class="btn btn-block btn-lg btn-inverse" id="backButtion"
                            type="button">返回
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <!--<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                -->
                <h4 class="modal-title" id="myModalLabel">注册提醒</h4>
            </div>
            <div class="modal-body">
                <c:if test="${reply.code == 1}">
                    ${reply.reply}
                </c:if>
            </div>
            <div class="modal-footer">
                <!--<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>-->
                <button type="button" class="btn btn-primary" id="modalBackButtion">返回登陆页</button>
            </div>
        </div>
    </div>
</div>

<c:if test="${reply.code == 1}">
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
<script src="<%=ctx %>/static/jquery-validation-1.13.1/dist/jquery.validate.js"></script>
<script src="<%=ctx %>/static/AjaxFileUploaderV2.1/ajaxfileupload.js"></script>
</body>
</html>


