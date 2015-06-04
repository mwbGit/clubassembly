/**
 * Created by Administrator on 15-5-10.
 */
$(function () {
    $("#auditSuccessOrganizationscheckbox").click(function () {
        var checked = $(this).attr("checked");
        if (checked != null && checked == "checked") {
            //选中状态 --> 非选中
            $(this).removeAttr("checked");
            var checkboxs = $("#auditSuccessOrganizationstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).removeAttr("checked");
                });
            }
        } else {
            //非选中状态 --> 选中
            $(this).attr("checked", "checked");
            var checkboxs = $("#auditSuccessOrganizationstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).attr("checked", "checked");
                });
            }
        }
    });


    $("#auditFailOrganizationscheckbox").click(function () {
        var checked = $(this).attr("checked");
        if (checked != null && checked == "checked") {
            //选中状态 --> 非选中
            $(this).removeAttr("checked");
            var checkboxs = $("#auditFailOrganizationstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).removeAttr("checked");
                });
            }
        } else {
            //非选中状态 --> 选中
            $(this).attr("checked", "checked");
            var checkboxs = $("#auditFailOrganizationstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).attr("checked", "checked");
                });
            }
        }
    });



    $("#notAuditOrganizationscheckbox").click(function () {
        var checked = $(this).attr("checked");
        if (checked != null && checked == "checked") {
            //选中状态 --> 非选中
            $(this).removeAttr("checked");
            var checkboxs = $("#notAuditOrganizationstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).removeAttr("checked");
                });
            }
        } else {
            //非选中状态 --> 选中
            $(this).attr("checked", "checked");
            var checkboxs = $("#notAuditOrganizationstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).attr("checked", "checked");
                });
            }
        }
    });

    $("#deleteOrganizationscheckbox").click(function () {
        var checked = $(this).attr("checked");
        if (checked != null && checked == "checked") {
            //选中状态 --> 非选中
            $(this).removeAttr("checked");
            var checkboxs = $("#deleteOrganizationstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).removeAttr("checked");
                });
            }
        } else {
            //非选中状态 --> 选中
            $(this).attr("checked", "checked");
            var checkboxs = $("#deleteOrganizationstbody input[type=checkbox]");
            if (checkboxs != null && checkboxs.length > 0) {
                $.each(checkboxs, function (key, value) {
                    $(this).attr("checked", "checked");
                });
            }
        }
    });

    //社团主页
    $("#organizationmainpage").click(function () {
        var checkboxs = $("#auditSuccessOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个社团");
            } else {
                document.location.href = "organizationmainpage?id=" + ids;
            }
        } else {
            alert("您未选择社团");
        }
    });


    //成员信息
    $("#organizationmembermanager").click(function () {
        var checkboxs = $("#auditSuccessOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个社团");
            } else {
                document.location.href = "organizationmembermanager?id=" + ids;
            }
        } else {
            alert("您未选择社团");
        }
    });

    //成员申请
    $("#organizationmemberapplymanager").click(function () {
        var checkboxs = $("#auditSuccessOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个社团");
            } else {
                document.location.href = "organizationmemberapplymanager?id=" + ids;
            }
        } else {
            alert("您未选择社团");
        }
    });

    //审核社团
    $("#organizationaudit").click(function () {
        var checkboxs = $("#notAuditOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个社团");
            } else {
                document.location.href = "organizationaudit?id=" + ids;
            }
        } else {
            alert("您未选择社团");
        }
    });


    //还原社团
    $("#organizationrestore").click(function () {
        var checkboxs = $("#deleteOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            document.location.href = "organizationrestore?ids=" + ids;
        } else {
            alert("您未选择社团");
        }
    });
});


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

function organizationDelete(flag) {
    if (flag == 'deleteOrganizations') {
        var checkboxs = $("#deleteOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            document.location.href = "organizationcompletedelete?ids=" + ids;
        } else {
            alert("您未选择社团");
        }
    } else if (flag == 'notAuditOrganizations') {
        var checkboxs = $("#notAuditOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            document.location.href = "organizationdelete?ids=" + ids;
        } else {
            alert("您未选择社团");
        }
    } else if (flag == 'auditSuccessOrganizations') {
        var checkboxs = $("#auditSuccessOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            document.location.href = "organizationdelete?ids=" + ids;
        } else {
            alert("您未选择社团");
        }
    } else if (flag == 'auditFailOrganizations') {
        var checkboxs = $("#auditFailOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            document.location.href = "organizationdelete?ids=" + ids;
        } else {
            alert("您未选择社团");
        }
    } else{

    }
}

function organizationUpdate(flag) {
    if (flag == 'notAuditOrganizations') {
        var checkboxs = $("#notAuditOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个社团");
            } else {
                document.location.href = "organizationprofileupdate?id=" + ids;
            }
        } else {
            alert("您未选择社团");
        }
    } else if (flag == 'auditSuccessOrganizations') {
        var checkboxs = $("#auditSuccessOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个社团");
            } else {
                document.location.href = "organizationprofileupdate?id=" + ids;
            }
        } else {
            alert("您未选择社团");
        }
    } else if (flag == 'auditFailOrganizations') {
        var checkboxs = $("#auditFailOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个社团");
            } else {
                document.location.href = "organizationprofileupdate?id=" + ids;
            }
        } else {
            alert("您未选择社团");
        }
    }else{

    }
}


function organizationView(flag) {
    if (flag == 'deleteOrganizations') {
        var checkboxs = $("#deleteOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个社团");
            } else {
                document.location.href = "organizationprofileview?id=" + ids;
            }
        } else {
            alert("您未选择社团");
        }
    } else if (flag == 'notAuditOrganizations') {
        var checkboxs = $("#notAuditOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个社团");
            } else {
                document.location.href = "organizationprofileview?id=" + ids;
            }
        } else {
            alert("您未选择社团");
        }
    } else if (flag == 'auditSuccessOrganizations') {
        var checkboxs = $("#auditSuccessOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个社团");
            } else {
                document.location.href = "organizationprofileview?id=" + ids;
            }
        } else {
            alert("您未选择社团");
        }
    } else if (flag == 'auditFailOrganizations') {
        var checkboxs = $("#auditFailOrganizationstbody input[type=checkbox]");
        var ids = "";
        $.each(checkboxs, function (n, value) {
            if ($(this).attr("checked") == "checked") {
                ids = ids + $(this).attr("id") + ",";
            }
        });
        if (ids.length > 0) {
            ids = ids.substr(0, ids.length - 1);
            if (ids.indexOf(",") > 0) {
                alert("一次只能操作一个社团");
            } else {
                document.location.href = "organizationprofileview?id=" + ids;
            }
        } else {
            alert("您未选择社团");
        }
    } else{

    }
}
