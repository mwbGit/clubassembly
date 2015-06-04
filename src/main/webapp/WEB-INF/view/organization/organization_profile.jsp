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

        });


        //        上传头像
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
                        $("#updateOrganizationForm").append("<input type='hidden' value = " + data.reply + " name=" + "imagelocation" + " >");

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

<div class="container-fluid" style="margin-top:53px;padding-top: 50px;">
<div class="container">
<form id="updateOrganizationForm" action="" method="post" class="form-horizontal" role="form">

<input type="hidden" value="${organization.id}" name="organizationid"/>

<div class="row" style="">
    <div class="col-sm-2 col-md-2 col-lg-2">
        <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>基本信息
    </div>

</div>


<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">社团名称</p></label>

        <div class="col-sm-4">
            <input class="form-control" type="text" id="formGroupInputDefault" value="${organization.name}"
                   readonly>
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
                     style="width: 140px; height: 140px;" src="${"/clubassembly/"}${organization.image}"
                     data-holder-rendered="true"/>
            </center>

        </div>
        <div class="col-sm-3" style="margin-top: 20px;">
            <div>
                请上传本社团的LOGO<br/>
            </div>
            <input id="fileToUpload" type="file"
            <c:if test="${iscommender != null && !iscommender}">
                   readonly
            </c:if>
                   name="fileToUpload">
            <button class="btn btn-block btn-lg btn-default" id="buttonUpload"
                    <c:if test="${iscommender != null && !iscommender}">
                        readonly
                    </c:if>
                    onclick="return ajaxFileUpload();">更改头像
            </button>
        </div>
    </div>
</div>


<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">社团属性</p></label>

        <c:if test="${properties != null}">
            <c:forEach var="property" items="${properties}" varStatus="status">
                <div class="col-sm-2" style="margin-top: 10px;">
                    <label class="radio">

                        <input type="radio" data-toggle="radio" name="property"
                        <c:if test="${iscommender != null && !iscommender}">
                               readonly
                        </c:if>
                               value="${property.id}"
                        <c:if test="${property.property eq organization.property.property}">
                               checked="checked"  </c:if>
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
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">社团类别</p></label>

        <div class="col-sm-3">
            <select class="form-control" name="maincategory" id="maincategorySelect"
                    onchange="getSecondCategory(this[selectedIndex].value)"
                    <c:if test="${iscommender != null && !iscommender}">
                        readonly
                    </c:if>
                    >

                <c:if test="${mainCategories != null}">
                    <c:forEach var="mainCategory" items="${mainCategories}" varStatus="status">
                        <option value="${mainCategory.id}"
                                <c:if test="${mainCategory.id == organization.organizationMainCategory.id}">
                                    selected="selected" </c:if>
                                >
                                ${mainCategory.name}
                        </option>
                    </c:forEach>
                </c:if>
            </select>
        </div>


        <div class="col-sm-2">
            <select class="form-control" name="secondcategory" id="secondcategorySelect"
                    <c:if test="${iscommender != null && !iscommender}">
                        readonly
                    </c:if>
                    >
                <c:if test="${secondCategories != null}">
                    <c:forEach var="secondCategory" items="${secondCategories}" varStatus="status">
                        <option value="${secondCategory.id}"
                                <c:if test="${secondCategory.id == organization.organizationSecondCategory.id}">
                                    selected="selected" </c:if>
                                >
                                ${secondCategory.name}
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
            <p class="text-right">社团口号</p></label>

        <div class="col-sm-4">
            <input class="form-control" type="text" id="formGroupInputDefault" name="slogan"
            <c:if test="${iscommender != null && !iscommender}">
                   readonly
            </c:if>
                   value="${organization.slogan}">
        </div>

    </div>
</div>

<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">社团介绍</p></label>

        <div class="col-sm-8">
            <textarea class="form-control" rows="8" cols="20" id="formGroupInputDefault"
                    <c:if test="${iscommender != null && !iscommender}">
                        readonly
                    </c:if>
                      name="organizationIntroduce"
                    >
                ${organization.organizationIntroduce}</textarea>
        </div>

    </div>
</div>

<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">部门介绍</p></label>

        <div class="col-sm-8">
            <textarea class="form-control" rows="8" cols="20" id="formGroupInputDefault"
                    <c:if test="${iscommender != null && !iscommender}">
                        readonly
                    </c:if>
                      name="departmentIntroduce"
                    >
                ${organization.departmentIntroduce}
            </textarea>
        </div>

    </div>
</div>
<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="formGroupInputDefault">
            <p class="text-right">联系方式</p></label>

        <div class="col-sm-4">
            <input class="form-control" type="text" id="formGroupInputDefault" name="contactInformation"
            <c:if test="${iscommender != null && !iscommender}">
                   readonly
            </c:if>
                   value="${organization.contactInformation}">
        </div>

    </div>
</div>

<div class="row">
    <div class="col-lg-offset-2 col-sm-3 col-md-3 col-lg-3">
        <button class="btn btn-block btn-lg btn-primary" type="submit">提交修改
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
