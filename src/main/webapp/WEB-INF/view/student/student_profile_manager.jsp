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
                        $("#updateStudentForm").append("<input type='hidden' value = " + data.reply + " name=" + "imagelocation" + " >");

                    }
                },
                error: function (data, status, e) {
                    alert("上传出错")
                }
            });
            return false;
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

<div class="container-fluid" style="margin-bottom: 100px;margin-top: 50px;padding-top: 50px;">
<div class="container">
<form action="" method="post" id="updateStudentForm" class="form-horizontal" role="form">
<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">姓名</p></label>

        <div class="col-sm-4">
            <input class="form-control" type="text" readonly
                   value="<shiro:principal  property="userName" />"
                   id="formGroupInputDefault"
                    >
        </div>
    </div>
</div>
<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">邮箱</p></label>

        <div class="col-sm-4">
            <input class="form-control" type="text" readonly value="<shiro:principal  property="email" />"
                   id="formGroupInputDefault"
                    >
        </div>
    </div>
</div>


<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">座右铭</p></label>

        <div class="col-sm-4">
            <input class="form-control" type="text" name="personcode" value="<shiro:principal  property="personcode"/>"
                   id="formGroupInputDefault"
                    >
        </div>
    </div>
</div>


<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label">
            <p class="text-right">个人头像</p></label>

        <div class="col-sm-2">
            <center>
                <img id="studentImage"
                     class="img-circle"
                     alt="140x140"
                     style="width: 140px; height: 140px;" src="${"/clubassembly/"}${student.image}"
                     data-holder-rendered="true"/>
            </center>

        </div>
        <div class="col-sm-3" style="margin-top: 20px;">
            <div>
                更改个人头像<br/>
            </div>
            <input id="fileToUpload" type="file"
                   name="fileToUpload">
            <button class="btn btn-block btn-lg btn-default" id="buttonUpload"
                    onclick="return ajaxFileUpload();">更改头像
            </button>
        </div>
    </div>
</div>

<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="provinceSelect">
            <p class="text-right">所在省份</p></label>

        <div class="col-sm-4">
            <select class="form-control" name="province" id="provinceSelect"
                    onchange="getCity(this[selectedIndex].value)">
                <c:if test="${provinces != null}">
                    <c:forEach var="province" items="${provinces}" varStatus="status">
                        <option value="${province.pr_id}" <c:if
                                test="${province.pr_id == student.province.pr_id}">
                            selected="selected"
                        </c:if>>
                                ${province.pr_province}
                        </option>
                    </c:forEach>
                </c:if>
            </select>
        </div>
    </div>
</div>


<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="citySelect">
            <p class="text-right">所在城市</p></label>

        <div class="col-sm-4">
            <select class="form-control" name="city" id="citySelect"
                    onchange="getSchool(this[selectedIndex].value)">
                <c:if test="${cities != null}">
                    <c:forEach var="city" items="${cities}" varStatus="status">
                        <option value="${city.ci_id}" <c:if
                                test="${city.ci_id == student.city.ci_id}">
                            selected="selected"
                        </c:if>>
                                ${city.ci_city}
                        </option>
                    </c:forEach>
                </c:if>
            </select>
        </div>
    </div>
</div>


<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="schoolSelect">
            <p class="text-right">所在学校</p></label>

        <div class="col-sm-4">
            <select class="form-control" name="school" id="schoolSelect">
                <c:if test="${schools != null}">
                    <c:forEach var="school" items="${schools}" varStatus="status">
                        <option value="${school.sh_id}" <c:if
                                test="${school.sh_id == student.school.sh_id}">
                            selected="selected"
                        </c:if>>
                                ${school.sh_school}
                        </option>
                    </c:forEach>
                </c:if>
            </select>
        </div>
    </div>
</div>

<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">性别</p></label>

        <div class="col-sm-4">
            <input class="form-control" type="text" id="formGroupInputDefault" name="sex"
                   value="${student.sex}">
        </div>
    </div>
</div>

<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">专业</p></label>

        <div class="col-sm-4">
            <input class="form-control" type="text" id="formGroupInputDefault" name="major"
                   value="${student.major}">
        </div>
    </div>
</div>
<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">手机号</p></label>

        <div class="col-sm-4">
            <input class="form-control" type="text" id="formGroupInputDefault" name="telephone"
                   value="${student.telephone}">
        </div>
    </div>
</div>
<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">学号</p></label>

        <div class="col-sm-4">
            <input class="form-control" type="text" name="number" id="formGroupInputDefault"
                   value="${student.number}">
        </div>
    </div>
</div>

<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">QQ号</p></label>

        <div class="col-sm-4">
            <input class="form-control" type="text" name="qq" id="formGroupInputDefault"
                   value="${student.QQ}">
        </div>
    </div>
</div>
<div class="row">
    <div class="col-lg-offset-2 col-sm-3 col-md-3 col-lg-3">
        <button class="btn btn-block btn-lg btn-primary" type="submit">保存</button>
    </div>
    <div class="col-sm-2 col-md-2 col-lg-2">
        <button class="btn btn-block btn-lg btn-inverse" type="button" id="backButtion">返回
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
<script src="<%=ctx %>/static/jquery-validation-1.13.1/dist/jquery.validate.js"></script>
<script src="<%=ctx %>/static/AjaxFileUploaderV2.1/ajaxfileupload.js"></script>
</body>
</html>
