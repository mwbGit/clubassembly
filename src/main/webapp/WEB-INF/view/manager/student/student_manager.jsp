<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<script>
$(function () {
    $("#alreadyActiveStudentscheckbox").click(function () {
        var checked = $(this).attr("checked");
        if (checked != null && checked == "checked") {
            //选中状态 --> 非选中
            $(this).removeAttr("checked");
            var checkboxs = $("#alreadyActiveStudentstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).removeAttr("checked");
                });
            }
        } else {
            //非选中状态 --> 选中
            $(this).attr("checked", "checked");
            var checkboxs = $("#alreadyActiveStudentstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).attr("checked", "checked");
                });
            }
        }
    });
    $("#notActiveStudentscheckbox").click(function () {
        var checked = $(this).attr("checked");
        if (checked != null && checked == "checked") {
            //选中状态 --> 非选中
            $(this).removeAttr("checked");
            var checkboxs = $("#notActiveStudentstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).removeAttr("checked");
                });
            }
        } else {
            //非选中状态 --> 选中
            $(this).attr("checked", "checked");
            var checkboxs = $("#notActiveStudentstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).attr("checked", "checked");
                });
            }
        }
    });

    $("#deleteStudentscheckbox").click(function () {
        var checked = $(this).attr("checked");
        if (checked != null && checked == "checked") {
            //选中状态 --> 非选中
            $(this).removeAttr("checked");
            var checkboxs = $("#deleteStudentstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).removeAttr("checked");
                });
            }
        } else {
            //非选中状态 --> 选中
            $(this).attr("checked", "checked");
            var checkboxs = $("#deleteStudentstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).attr("checked", "checked");
                });
            }
        }
    });


    //个人主页
    $("#studentmainpage").click(function () {
        var checkboxs = $("#alreadyActiveStudentstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个学生");
            } else {
                document.location.href = "studentmainpage?id=" + ids;
            }
        } else {
            alert("您未选择学生");
        }
    });

    // 激活学生
    $("#notActiveStudentsActive").click(function () {
        var checkboxs = $("#notActiveStudentstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });

        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            document.location.href = "studentactive?ids=" + ids;
        } else {
            alert("您未选择学生");
        }
    });


    // 还原学生
    $("#deleteStudentsRestore").click(function () {
        var checkboxs = $("#deleteStudentstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            document.location.href = "studentrestore?ids=" + ids;
        } else {
            alert("您未选择学生");
        }
    });
});


function studentView(flag) {
    //已删除学生列表
    if (flag == 'deleteStudents') {
        var checkboxs = $("#deleteStudentstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个学生");
            } else {
                document.location.href = "studentprofileview?id=" + ids;
            }
        } else {
            alert("您未选择学生");
        }
    } else if (flag == 'notActiveStudents') {
        var checkboxs = $("#notActiveStudentstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个学生");
            } else {
                document.location.href = "studentprofileview?id=" + ids;
            }
        } else {
            alert("您未选择学生");
        }
    } else if (flag == 'alreadyActiveStudents') {
        var checkboxs = $("#alreadyActiveStudentstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个学生");
            } else {
                document.location.href = "studentprofileview?id=" + ids;
            }
        } else {
            alert("您未选择学生");
        }
    } else {

    }
}

function studentUpdate(flag) {
    if (flag == 'notActiveStudents') {
        var checkboxs = $("#notActiveStudentstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个学生");
            } else {
                document.location.href = "studentprofileupdate?id=" + ids;
            }
        } else {
            alert("您未选择学生");
        }
    } else if (flag == 'alreadyActiveStudents') {
        var checkboxs = $("#alreadyActiveStudentstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个学生");
            } else {
                document.location.href = "studentprofileupdate?id=" + ids;
            }
        } else {
            alert("您未选择学生");
        }
    } else {

    }
}

function studentDelete(flag) {
    //已删除学生列表
    if (flag == 'deleteStudents') {
        var checkboxs = $("#deleteStudentstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            document.location.href = "studentcompletedelete?ids=" + ids;
        } else {
            alert("您未选择学生");
        }
    } else if (flag == 'notActiveStudents') {
        var checkboxs = $("#notActiveStudentstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            document.location.href = "studentdelete?ids=" + ids;
        } else {
            alert("您未选择学生");
        }
    } else if (flag == 'alreadyActiveStudents') {
        var checkboxs = $("#alreadyActiveStudentstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            document.location.href = "studentdelete?ids=" + ids;
        } else {
            alert("您未选择学生");
        }
    } else {

    }
}


function changecheckboxstatus(id) {
    var checked = $("#" + id).attr("checked");
    if (checked != null && checked == "checked") {
        //选中状态
        $("#" + id).removeAttr("checked");
    } else {
        //非选中状态
        $("#" + id).attr("checked", "checked");
    }
}
</script>
</head>
<body>
<!--主容器开始-->
<div id="content">
<!--痕迹导航开始 -->
<div id="content-header">
    <div id="breadcrumb"><a href="<%=ctx %>/manager/home" class="tip-bottom"><i class="icon-home"></i> 首页</a> <a
            href="<%=ctx %>/manager/studentmanager" class="current">学生管理</a>
    </div>
</div>
<!--痕迹导航结束-->
<div class="container-fluid">
<div class="row-fluid">
    <div class="span12">
        <c:if test="${reply != null }">
            <div id = "tip" class="alert alert-info"><a class="close" data-dismiss="alert" href="#">×</a>
                <center>
                        ${reply.reply}
                </center>
            </div>
        </c:if>
        <div class="widget-box">
            <div class="widget-title"><span class="icon"> <i class="icon-th"></i> </span>
                <h5>已激活的学生</h5>
                <a class="label label-important" href="#" onclick="studentDelete('alreadyActiveStudents')">删除</a>
                <a class="label label-important" href="#" onclick="studentUpdate('alreadyActiveStudents')">修改</a>
                <a class="label label-important" href="#" id="studentmainpage">个人主页</a>
                <a class="label label-important" href="#" onclick="studentView('alreadyActiveStudents')">查看详情</a>
            </div>

            <div class="widget-content ">
                <table class="table table-bordered table-striped with-check">
                    <thead>
                    <tr>
                        <th><input type="checkbox" id="alreadyActiveStudentscheckbox" name="title-table-checkbox"/></th>
                        <th>姓名</th>
                        <th>邮箱</th>
                        <th>学校</th>
                        <th>联系方式</th>
                        <th>注册时间</th>
                    </tr>
                    </thead>
                    <tbody id="alreadyActiveStudentstbody">
                    <c:if test="${alreadyActiveStudents != null&& alreadyActiveStudents.size() > 0}">
                        <c:forEach var="student" items="${alreadyActiveStudents}" varStatus="status">
                            <tr>
                                <td>
                                    <center>
                                        <input type="checkbox" value="${student.id}" id="${student.id}"
                                               onclick="changecheckboxstatus(${student.id})"/>
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.name}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.email}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.school.sh_school}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.telephone}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.registerTime}
                                    </center>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="widget-box">
            <div class="widget-title"><span class="icon"> <i class="icon-th"></i> </span>
                <h5>未激活的学生</h5>
                <a class="label label-important" href="#" onclick="studentDelete('notActiveStudents')">删除</a>
                <a class="label label-important" href="#" onclick="studentUpdate('notActiveStudents')">修改</a>
                <a class="label label-important" href="#" id="notActiveStudentsActive">激活</a>
                <a class="label label-important" href="#" onclick="studentView('notActiveStudents')">查看详情</a>
            </div>

            <div class="widget-content ">
                <table class="table table-bordered table-striped with-check">
                    <thead>
                    <tr>
                        <th><input type="checkbox" id="notActiveStudentscheckbox" name="title-table-checkbox"/></th>
                        <th>姓名</th>
                        <th>邮箱</th>
                        <th>学校</th>
                        <th>联系方式</th>
                        <th>注册时间</th>
                    </tr>
                    </thead>
                    <tbody id="notActiveStudentstbody">
                    <c:if test="${notActiveStudents != null&& notActiveStudents.size() > 0}">
                        <c:forEach var="student" items="${notActiveStudents}" varStatus="status">
                            <tr>
                                <td>
                                    <center>
                                        <input type="checkbox" value="${student.id}" id="${student.id}"
                                               onclick="changecheckboxstatus(${student.id})"/>
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.name}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.email}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.school.sh_school}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.telephone}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.registerTime}
                                    </center>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="widget-box">
            <div class="widget-title"><span class="icon"> <i class="icon-th"></i> </span>
                <h5>已删除的学生</h5>
                <a class="label label-important" href="#" onclick="studentDelete('deleteStudents')">删除</a>
                <a class="label label-important" href="#" id="deleteStudentsRestore">还原</a>
                <a class="label label-important" href="#" onclick="studentView('deleteStudents')">查看详情</a>
            </div>

            <div class="widget-content ">
                <table class="table table-bordered table-striped with-check">
                    <thead>
                    <tr>
                        <th><input type="checkbox" id="deleteStudentscheckbox" name="title-table-checkbox"/></th>
                        <th>姓名</th>
                        <th>邮箱</th>
                        <th>学校</th>
                        <th>联系方式</th>
                        <th>注册时间</th>
                    </tr>
                    </thead>
                    <tbody id="deleteStudentstbody">
                    <c:if test="${deleteStudents != null&& deleteStudents.size() > 0}">
                        <c:forEach var="student" items="${deleteStudents}" varStatus="status">
                            <tr>
                                <td>
                                    <center>
                                        <input type="checkbox" value="${student.id}" id="${student.id}"
                                               onclick="changecheckboxstatus(${student.id})"/>
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.name}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.email}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.school.sh_school}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.telephone}
                                    </center>
                                </td>
                                <td>
                                    <center>
                                            ${student.registerTime}
                                    </center>
                                </td>
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
<!--主容器结束-->
</body>
</html>
