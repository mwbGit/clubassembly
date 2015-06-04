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

            //复选框，全选，全不选
            $("#checkAllStudent").click(function () {
                var flag = $("#checkAllStudent").attr("checked");
                if (flag == "checked") {
                    $("#checkAllStudent").removeAttr("checked");
                    var checkboxs = $("#mybody input");
                    $.each(checkboxs, function (n, value) {
                        $(this).removeAttr("checked");
                    });
                } else {
                    $("#checkAllStudent").attr("checked", "checked");
                    var checkboxs = $("#mybody input");
                    $.each(checkboxs, function (n, value) {
                        $(this).attr("checked", "checked");
                    });
                }
            });


            $("#backButtion").click(function () {
                document.location.href = "home.html";
            });
        });

        function commitForm() {
            var ids = $("#departmentSetForm label[type='mydepartment']");
            var numbers = $("#departmentSetForm input[type='text']");
            var checkboxs = $("#departmentSetForm input[type='checkbox']");
            var strids = "";
            $.each(ids, function (n, value) {
                var id = $(this).attr("id");
                strids = strids + id + ",";
            });

            var strnumbers = "";
            $.each(numbers, function (n, value) {
                var number = $(this).val();
                strnumbers = strnumbers + number + ",";
            });

            var strcheckeds = "";
            $.each(checkboxs, function (n, value) {
                var checked = $(this).attr("checked");
                if (checked != null) {
                    strcheckeds = strcheckeds + 1 + ",";
                } else {
                    strcheckeds = strcheckeds + 0 + ",";
                }
            });

            if (strids.length > 0 && strnumbers.length > 0 && strcheckeds.length > 0) {
//                alert(strids);
//                alert(strnumbers);
//                alert(strcheckeds);
                strids = strids.substr(0, strids.length - 1);
                strnumbers = strnumbers.substr(0, strnumbers.length - 1);
                strcheckeds = strcheckeds.substr(0, strcheckeds.length - 1);
                $("#departmentSetForm").append("<input type='hidden' value = '" + strids + "' name = 'ids'/>")
                $("#departmentSetForm").append("<input type='hidden' value = '" + strnumbers + "' name = 'numbers'/>")
                $("#departmentSetForm").append("<input type='hidden' value = '" + strcheckeds + "' name = 'checkeds'/>")
                return true;
            } else {
                return false
            }
        }


        function auditstudent(organizationid, auditresult) {

            var checkboxs = $("#mybody input[type='radio']");
            var deleteids = "";
            $.each(checkboxs, function (n, value) {
                if ($(this).attr("checked") == "checked") {
                    deleteids = deleteids + $(this).attr("id").substr("checkbox".length) + ",";
                }
            });
            if (deleteids.length > 0) {
                deleteids = deleteids.substr(0, deleteids.length - 1);
                document.location.href = "auditstudent?studentids=" + deleteids + "&organizationid=" + organizationid + "&auditresult=" + auditresult;
            } else {
                alert("您未选择任何要审核的学生");
            }
        }


        function removestudent(organizaitionid) {
            var checkboxs = $("#mybody input");
            var deleteids = "";
            $.each(checkboxs, function (n, value) {
                if ($(this).attr("checked") == "checked") {
                    deleteids = deleteids + $(this).attr("id").substr("checkbox".length) + ",";
                }
            });
            if (deleteids.length > 0) {
                deleteids = deleteids.substr(0, deleteids.length - 1);
                document.location.href = "removestudent?studentids=" + deleteids + "&organizationid=" + organizaitionid+ "&status=memberapply";
            } else {
                alert("您未选择任何要移除的学生");
            }
        }



        function changestatus(i) {

            if ($("#checkbox" + i).attr("checked")) {
                $("#checkbox" + i).removeAttr("checked");
            } else {
                $("#checkbox" + i).attr("checked", "checked");
            }
        }
    </script>
</head>
<body style="background-color: #d8d6d3">



<div class="container-fluid" style="margin-top:53px;padding-top: 50px;">
    <div class="container">
        <div class="row" style="margin-top: 30px;">
            <div class="col-sm-2 col-md-2 col-lg-2">
                <div class="row">
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>申请情况
                    </div>
                </div>
                <hr/>

                <div class="row">
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        <label class="radio">
                            <input type="radio" name="departmentsRadio" checked="checked"
                                   value="alldepartment" required>
                            全部
                        </label>
                        <c:if test="${departments != null && departments.size() > 0}">
                            <c:forEach var="department" items="${departments}" varStatus="status">
                                <label class="radio">
                                    <input type="radio" name="departmentsRadio"
                                           value="${department.id}">
                                        ${department.department}
                                </label>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>

                <hr/>
                <div class="row">
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        &nbsp;&nbsp;&nbsp;&nbsp;<a href="#" data-toggle="modal" data-backdrop="static"
                                                   data-target="#myModal">申请设置</a>
                    </div>
                </div>
            </div>


            <div class="col-sm-10 col-md-10 col-lg-10">
                <div class="row"
                     style="border:solid; border-width: 2px; border-color: #1abc9c;background-color: #1abc9c">

                    <div class="col-sm-2 col-md-2 col-lg-2">
                        <label class="radio">
                            <input type="radio" id="checkAllStudent"

                                    >
                            全选
                        </label>
                    </div>

                    <div class="col-sm-4 col-md-4 col-lg-4">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search" id="search-query-3">
                        <span class="input-group-btn">
                                <button type="submit" class="btn"><span class="fui-search"></span></button>
                        </span>
                        </div>

                    </div>


                    <div class="col-sm-2 col-md-2 col-lg-2">
                        <div class="btn-group">
                            <button data-toggle="dropdown" class="btn btn-primary dropdown-toggle" type="button">审核成员
                                <span class="caret"></span></button>
                            <ul role="menu" class="dropdown-menu">
                                <li><a href="#"
                                       onclick="auditstudent(${organization.id},true)">通过</a>
                                </li>
                                <li><a href="#"
                                       onclick="auditstudent(${organization.id},false)">拒绝</a></li>
                            </ul>
                        </div>
                        <!-- /btn-group -->
                    </div>

                    <div class="col-sm-2 col-md-2 col-lg-2">
                        <button class="btn btn-block btn-lg btn-primary" type="button"
                                onclick="removestudent(${organization.id})"
                                >移除人员</button>
                    </div>
                    <div class="col-sm-2 col-md-2 col-lg-2">
                        <button class="btn btn-block btn-lg btn-primary" type="submit">导出excel</button>
                    </div>
                </div>

                <div class="row" style="margin-top: 20px;">
                    <div class="table-responsive">
                        <table class="table" style="border: solid;border-width: 3px;border-color:  #1abc9c">
                            <tbody id="mybody">
                            <tr style="background-color: #1abc9c">
                                <td><p class="text-center"></p>
                                </td>
                                <td><p class="text-center">姓名</p>
                                </td>
                                <td><p class="text-center">部门</p>
                                </td>
                                <td><p class="text-center">性别</p>
                                </td>
                                <td><p class="text-center">专业</p>
                                </td>
                                <td><p class="text-center">电话</p>
                                </td>
                                <td><p class="text-center">学号</p>
                                </td>
                                <td><p class="text-center">QQ</p>
                                </td>
                                <td><p class="text-center">同意调剂</p>
                                </td>
                                <td><p class="text-center">申请理由</p>
                                </td>
                            </tr>
                            <c:if test="${notAuditStudentOrganizationLinks != null && notAuditStudentOrganizationLinks.size() > 0}">
                                <c:forEach var="studentorganization" items="${notAuditStudentOrganizationLinks}"
                                           varStatus="status">
                                    <tr>
                                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <input id="${"checkbox"}${studentorganization.student.id}" type="radio"
                                                   onclick="changestatus('${"checkbox"}${studentorganization.student.id}')"/>
                                        </td>
                                        <td>${studentorganization.student.name}</td>
                                        <td>${studentorganization.organizationDepartment.department}</td>
                                        <td>${studentorganization.student.sex}</td>
                                        <td>${studentorganization.student.major}</td>
                                        <td>${studentorganization.student.telephone}</td>
                                        <td>${studentorganization.student.number}</td>
                                        <td>${studentorganization.student.QQ}</td>
                                        <td><c:if test="${studentorganization.agreeAdjust}">
                                            是
                                        </c:if>
                                            <c:if test="${!studentorganization.agreeAdjust}">
                                                否
                                            </c:if>
                                        </td>
                                        <td>${studentorganization.applyReason}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
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
            <form id="departmentSetForm" action="<c:url value="/organization/departmentconfig"/>"
                  method="post" onsubmit="return commitForm()">
                <input type="hidden" value="${organization.id}" name="organizationid"/>

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">申请设置</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-offset-1 col-sm-12 col-md-12 col-lg-12">
                            <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>选择可以申请的部门
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                            <p class="text-center">部门</p>
                        </div>
                        <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                            <p class="text-center">人数</p>
                        </div>
                        <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                            <p class="text-center">接受申请</p>
                        </div>
                    </div>
                    <c:if test="${departments != null && departments.size() > 0}">
                        <c:forEach var="department" items="${departments}" varStatus="statys">
                            <div class="row">
                                <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                                    <label class="radio" type="mydepartment" id="${department.id}">
                                            ${department.department}
                                    </label>
                                </div>
                                <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                                    <input class="form-control" type="text"
                                           value="${department.maxNumbers}">
                                </div>


                                <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3"
                                     onclick="changestatus('${department.id}')">
                                    <input id="${'checkbox'}${department.id}" type="checkbox"
                                            <c:if test="${department.open}">
                                                checked="checked"
                                            </c:if>
                                           data-toggle="switch" data-off-color="warning"
                                           data-on-color="success"/>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">保存更改</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/video.js"></script>
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/flat-ui.min.js"></script>

<script src="<%=ctx %>/static/Flat-UI-master/docs/assets/js/application.js"></script>
</body>
</html>
