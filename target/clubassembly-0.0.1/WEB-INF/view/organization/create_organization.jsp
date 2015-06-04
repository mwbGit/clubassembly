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
                document.location.href = "main";
            });

            //验证表单
            $("#createorganizationform").validate({
                rules: {
                    organizationname: {
                        required: true,
                        remote: "/clubassembly/organization/checkorganizationname?" + $("#organizationname").val()
                    },
                    fileToUpload: {
                        required: true
                    },
                    fileToUpload2: {
                        required: true
                    }
                },
                messages: {
                    organizationname: {
                        required: "请输入社团名称",
                        remote: "该社团已被注册"
                    },
                    fileToUpload: {
                        required: "请上传头像"
                    },
                    fileToUpload2: {
                        required: "请上传验证照片"
                    }
                }
            });
        });


        function ajaxFileUpload() {
            $.ajaxFileUpload({
                url: "/clubassembly/organization/uploadorganizationimage",
                secureuri: false,
                fileElementId: 'fileToUpload',
                dataType: 'json',
                success: function (data, status) {
                    if (data.code == 0) {
                        alert("上传失败")
                    } else {
                        $("#organizationImage").attr("src", "/clubassembly/" + data.reply);
                        $("#createorganizationform").append("<input type='hidden' value = " + data.reply + " name=" + "imagelocation" + " >");

                    }
                },
                error: function (data, status, e) {
                    alert("上传出错")
                }
            });

            return false;
        }


        //        上传验证图片
        function ajaxFileUpload2() {
            $.ajaxFileUpload({
                url: "/clubassembly/organization/uploadorganizationcheckimage",
                secureuri: false,
                fileElementId: 'fileToUpload2',
                dataType: 'json',
                success: function (data, status) {
                    if (data.code == 0) {
                        alert("上传失败")
                    } else {
                        $("#organizationCheckImage").attr("src", "/clubassembly/" + data.reply);
                        $("#createorganizationform").append("<input type='hidden' value = " + data.reply + " name=" + "organizationcheckimagelocation" + " >");

                    }
                },
                error: function (data, status, e) {
                    alert("上传出错")
                }
            });

            return false;
        }


        function getSecondCategory(i) {
            $.ajax({
                async: false,
                type: "POST",
                data: {
                    maincategoryid: i
                },
                url: "/clubassembly/organization/getsecondcategory",
                dataType: 'json',
                success: function (data) {
                    if (data.code == 0) {
                        alert("没得到数据")
                    } else {
                        $("#secondcategorySelect").empty();
                        $.each(data.reply, function (key, value) {
                            $("#secondcategorySelect").append(
                                    "<option value = " + value.id + ">" +
                                            value.name +
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



<div class="container-fluid" style="margin-top:80px;margin-bottom: 100px;">
    <div class="container">
        <form id="createorganizationform" action="" method="post" class="form-horizontal" role="form">
            <div class="row" style="">
                <div class="col-sm-2 col-md-2 col-lg-2">
                    <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>基本信息
                </div>

            </div>
            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="organizationname">
                        <p class="text-right">社团名称</p></label>

                    <div class="col-sm-4">
                        <input class="form-control" type="text" name="organizationname" id="organizationname">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">社团头像</p></label>

                    <div class="col-sm-2">
                        <center>
                            <img id="organizationImage"
                                 class="img-circle"
                                 alt="140x140"
                                 style="width: 140px; height: 140px;" src="<%=ctx %>/static/image/2.jpg"
                                 data-holder-rendered="true"/>
                        </center>

                    </div>
                    <div class="col-sm-3" style="margin-top: 20px;">
                        <div>
                            请上传本社团的LOGO<br/>
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
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">社团属性</p></label>
                    <c:if test="${properties != null}">
                        <c:forEach var="property" items="${properties}" varStatus="status">
                            <div class="col-sm-2" style="margin-top: 10px;">
                                <label class="radio">

                                    <input type="radio" data-toggle="radio" name="property"
                                           value="${property.id}"
                                    <c:if test="${property.property eq '校级组织'}"> checked="checked"  </c:if>
                                           data-radiocheck-toggle="radio" required>
                                        ${property.property}

                                </label>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">社团类别</p></label>

                    <div class="col-sm-3">
                        <select class="form-control" name="maincategory" id="maincategorySelect"
                                onchange="getSecondCategory(this[selectedIndex].value)">

                            <c:if test="${mainCategories != null}">
                                <c:forEach var="mainCategory" items="${mainCategories}" varStatus="status">
                                    <option value="${mainCategory.id}">
                                            ${mainCategory.name}
                                    </option>
                                </c:forEach>
                            </c:if>
                        </select>
                    </div>


                    <div class="col-sm-2">
                        <select class="form-control" name="secondcategory" id="secondcategorySelect">
                            <c:if test="${secondCategories != null}">
                                <c:forEach var="secondCategory" items="${secondCategories}" varStatus="status">
                                    <option value="${secondCategory.id}">
                                            ${secondCategory.name}
                                    </option>
                                </c:forEach>
                            </c:if>
                        </select>
                    </div>
                </div>
            </div>


            <hr/>
            <div class="row" style="">
                <div class="col-sm-2 col-md-2 col-lg-2">
                    <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>验证信息
                </div>
            </div>


            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">身份核验</p></label>

                    <div class="col-sm-3">
                        <center>
                            <img id="organizationCheckImage"
                                 alt="140x140"
                                 style="width:240px; height: 400px;" src="<%=ctx %>/static/image/organizationcheckimage.jpg"
                                 data-holder-rendered="true"/>
                        </center>

                    </div>

                    <div class="col-sm-3">
                        <div style="margin-top: 100px;">
                            请按示例上传身份证与学生证照片<br/>
                            信息须清晰可见<br/>
                            我们会严格保护您的隐私<br/>
                        </div>

                        <input id="fileToUpload2" type="file"
                               name="fileToUpload2">
                        <button class="btn btn-block btn-lg btn-default" id="buttonUpload2"
                                onclick="return ajaxFileUpload2();">上传
                        </button>
                    </div>
                </div>
            </div>


            <div class="row">

            <div class="col-lg-offset-2 col-sm-3 col-md-3 col-lg-3">
                <button class="btn btn-block btn-lg btn-primary" type="submit">创建
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



<!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/video.js"></script>
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/flat-ui.min.js"></script>

<script src="<%=ctx %>/static/jquery-validation-1.13.1/dist/jquery.validate.js"></script>
<script src="<%=ctx %>/static/AjaxFileUploaderV2.1/ajaxfileupload.js"></script>
</body>
</html>

