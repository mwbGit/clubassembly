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
        });


        function distributedepartment(departmentid, organizaitionid) {
            var checkboxs = $("#mybody input");
            var deleteids = "";
            $.each(checkboxs, function (n, value) {
                if ($(this).attr("checked") == "checked") {
                    deleteids = deleteids + $(this).attr("id").substr("checkbox".length) + ",";
                }
            });
            if (deleteids.length > 0) {
                deleteids = deleteids.substr(0, deleteids.length - 1);
                document.location.href = "distributedepartment?studentids=" + deleteids + "&departmentid=" + departmentid + "&organizationid=" + organizaitionid;
            } else {
                alert("您未选择任何要分配部门的学生");
            }
        }


        function distributeposition(positionid, organizaitionid) {
            var checkboxs = $("#mybody input");
            var deleteids = "";
            $.each(checkboxs, function (n, value) {
                if ($(this).attr("checked") == "checked") {
                    deleteids = deleteids + $(this).attr("id").substr("checkbox".length) + ",";
                }
            });
            if (deleteids.length > 0) {
                deleteids = deleteids.substr(0, deleteids.length - 1);
                document.location.href = "distributeposition?studentids=" + deleteids + "&positionid=" + positionid + "&organizationid=" + organizaitionid;
            } else {
                alert("您未选择任何要分配职位的学生");
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
                document.location.href = "removestudent?studentids=" + deleteids + "&organizationid=" + organizaitionid + "&status=member";
            } else {
                alert("您未选择任何要移除的学生");
            }
        }


        //        单击后，改变单选按钮状态
        function changestatus(i) {
            if ($("#" + i).attr("checked") == "checked") {
                $("#" + i).removeAttr("checked");
            } else {
                $("#" + i).attr("checked", "checked");
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
                        <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>部门架构
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
                                    <input type="radio" data-toggle="radio" name="departmentsRadio"
                                           value="${department.id}" data-radiocheck-toggle="radio">
                                        ${department.department}
                                </label>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
                <c:if test="${iscommender != null && iscommender}">
                    <hr/>
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12">
                            &nbsp;&nbsp;&nbsp;&nbsp;<a href="#" data-toggle="modal" data-backdrop="static"
                                                       data-target="#myModal">架构设置</a>
                        </div>
                    </div>
                </c:if>
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

                    <div class="col-sm-2 col-md-2 col-lg-2">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search" id="search-query-3">
                        <span class="input-group-btn">
                                <button type="submit" class="btn"><span class="fui-search"></span></button>
                        </span>
                        </div>
                    </div>

                    <c:if test="${iscommender != null && iscommender}">


                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-primary dropdown-toggle" type="button">
                                    分配部门
                                    <span class="caret"></span></button>
                                <ul role="menu" class="dropdown-menu">
                                    <c:if test="${departments != null && departments.size() > 0}">
                                        <c:forEach var="department" items="${departments}" varStatus="status">
                                            <li><a href="#"
                                                   onclick="distributedepartment(${department.id},${organization.id})">${department.department}</a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-primary dropdown-toggle" type="button">
                                    分配职位
                                    <span class="caret"></span></button>
                                <ul role="menu" class="dropdown-menu">
                                    <c:if test="${positions != null && positions.size() > 0}">
                                        <c:forEach var="position" items="${positions}" varStatus="status">
                                            <li><a href="#"
                                                   onclick="distributeposition(${position.id},${organization.id})">${position.position}</a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <button class="btn btn-block btn-lg btn-primary" type="button"
                                    onclick="removestudent(${organization.id})"
                                    >移除人员
                            </button>
                        </div>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <button class="btn btn-block btn-lg btn-primary" type="submit">导出excel</button>
                        </div>
                    </c:if>
                </div>

                <div class="row" style="margin-top: 20px;">
                    <div class="table-responsive">
                        <table class="table" style="border: solid;border-width: 3px;border-color:  #1abc9c">
                            <tbody id="mybody">

                            <tr style="background-color: #1abc9c">
                                <td><p class="text-center"></p>
                                </td>
                                <td><p class="text-center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓名</p>
                                </td>
                                <td><p class="text-center">部门</p>
                                </td>
                                <td><p class="text-center">职位</p>
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
                            </tr>

                            <c:if test="${alreadyAuditStudentOrganizationLink != null && alreadyAuditStudentOrganizationLink.size()> 0}">
                                <c:forEach var="studentorganization" items="${alreadyAuditStudentOrganizationLink}"
                                           varStatus="status">
                                    <tr>
                                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <input id="${"checkbox"}${studentorganization.student.id}" type="radio"
                                                   onclick="changestatus('${"checkbox"}${studentorganization.student.id}')"/>
                                        </td>
                                        <td>
                                            <c:if test="${studentorganization.commander}">
                                                <img src="<%=ctx %>/static/image/admin.png" width="18px;"
                                                     height="20px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </c:if>
                                            <c:if test="${!studentorganization.commander}">
                                             <span class="fui-user">&nbsp;&nbsp;
                                         </c:if>
                                        ${studentorganization.student.name}
                                        </td>
                                        <td>${studentorganization.organizationDepartment.department}</td>
                                        <td>${studentorganization.organizationPosition.position}</td>
                                        <td>${studentorganization.student.sex}</td>
                                        <td>${studentorganization.student.major}</td>
                                        <td>${studentorganization.student.telephone}</td>
                                        <td>${studentorganization.student.number}</td>
                                        <td>${studentorganization.student.QQ}</td>
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
            <form method="post" class="form-horizontal" role="form"
                  action="<c:url value="/organization/addorganizationdepartmentandposition"/>">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">架构设置</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-3 col-md-3 col-lg-3">
                            <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>部门设置
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12">
                            <c:if test="${departments != null && departments.size() > 0}">
                                <c:set var="departmentString" value="${''}"></c:set>
                                <c:forEach var="department" items="${departments}" varStatus="status">
                                    <c:if test="${status.last || status.first}">
                                        <c:set var="departmentString"
                                               value="${departmentString}${department.department}"></c:set>
                                    </c:if>
                                    <c:if test="${!status.first && !status.last}">
                                        <c:set var="departmentString"
                                               value="${departmentString}${','}${department.department}"></c:set>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <input name="departments" class="tagsinput"
                                   value="${departmentString}"/>
                        </div>
                    </div>

                    <input type="hidden" name="organizationid" value="${organization.id}"/>

                    <div class="row">
                        <div class="col-sm-3 col-md-3 col-lg-3">
                            <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>职位设置
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12">
                            <c:if test="${positions != null && positions.size() > 0}">
                                <c:set var="positionString" value="${''}"></c:set>
                                <c:forEach var="position" items="${positions}" varStatus="status">
                                    <c:if test="${status.last || status.first}">
                                        <c:set var="positionString"
                                               value="${positionString}${position.position}"></c:set>
                                    </c:if>
                                    <c:if test="${!status.first && !status.last}">
                                        <c:set var="positionString"
                                               value="${positionString}${','}${position.position}"></c:set>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <input name="positions" class="tagsinput" value="${positionString}"/>
                        </div>
                    </div>
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
<script>

    var states = new Bloodhound({
        datumTokenizer: function (d) {
            return Bloodhound.tokenizers.whitespace(d.word);
        },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        limit: 4,
        local: [
            { word: "Alabama" },
            { word: "Alaska" },
            { word: "Arizona" },
            { word: "Arkansas" },
            { word: "California" },
            { word: "Colorado" }
        ]
    });
    states.initialize();
    $('input.tagsinput').tagsinput();
    $('input.tagsinput-typeahead').tagsinput('input').typeahead(null, {
        name: 'states',
        displayKey: 'word',
        source: states.ttAdapter()
    });
    $('input.typeahead-only').typeahead(null, {
        name: 'states',
        displayKey: 'word',
        source: states.ttAdapter()
    });
</script>


</body>
</html>

