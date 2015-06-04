/**
 * Created by Administrator on 15-4-5.
 */
$(function () {
//            得到已经加入的社团
    $.ajax({
        async: false,
        type: "POST",
        url: "/clubassembly/home/alreadyInOrganizations",
        dataType: 'json',
        success: function (data) {
            if (data.code == 0) {
                $("#alreadyindivider").after("<li><a href='#'>&nbsp;&nbsp;&nbsp;&nbsp;" +
                    "无" +
                    "</span></a></li>"
                );
            } else {
                $.each(data.reply, function (key, value) {
                    $("#alreadyindivider").after("<li><a href='" +
                        "/clubassembly/organization/organizationmain?organizationid=" +
                        value.id +
                        "'>&nbsp;" +
                        "<img class='img-circle' alt='30x30' style='width: 30px; height: 30px;' src='/clubassembly/" + value.image + "'data-holder-rendered='true'/>" +
                        "&nbsp;&nbsp;" +
                        value.name +
                        "</span></a></li>"
                    );
                });
            }
        }
    });


//            得到待审核的社团
    $.ajax({
        async: false,
        type: "POST",
        url: "/clubassembly/home/waitauditorganizations",
        dataType: 'json',
        success: function (data) {
            if (data.code == 0) {
                $("#waitauditdivider").after("<li><a href='#'>&nbsp;&nbsp;&nbsp;&nbsp;" +
                    "无" +
                    "</span></a></li>"
                );
            } else {
                $.each(data.reply, function (key, value) {
                    $("#waitauditdivider").after("<li><a href='" +
                        "/clubassembly/organization/organizationmain?organizationid=" +
                        value.id +
                        "'>&nbsp;" +
                        "<img class='img-circle' alt='30x30' style='width: 30px; height: 30px;' src='/clubassembly/" + value.image + "'data-holder-rendered='true'/>" +
                        "&nbsp;&nbsp;" +
                        value.name +
                        "</span></a></li>"
                    );
                });
            }
        }
    });


    //得到当前有所有选中的社团
    $.ajax({
        async: false,
        type: "POST",
        url: "/clubassembly/home/getchoseorganization",
        dataType: 'json',
        success: function (data) {
            if (data.code == 0) {
                $("#clubnav").attr("style", "display: none;");
            } else if (data.code == 206) {
                //IS_COMMENDER
                $("#clubnav").attr("style", "display: block;");
                $("#clubcontrolla").empty();
                $("#clubcontrolla").append(data.detail);
                $("#clubcontrolla").append("<span class='caret'></span>");
                $("#clubcontrollul").empty();
                $("#clubcontrollul").append("<li><a href='/clubassembly/organization/organizationprofile?organizationid="
                    + data.reply
                    + "'>社团资料</a></li>");
                $("#clubcontrollul").append("<li class='divider'>");
                $("#clubcontrollul").append("<li><a href='/clubassembly/organization/organizationmain?organizationid="
                    + data.reply
                    + "'>社团主页</a></li>");
                $("#clubcontrollul").append("<li class='divider'>");
                $("#clubcontrollul").append("<li><a href='/clubassembly/organization/organizationmember?organizationid="
                    + data.reply
                    + "'>成员信息</a></li>");
                $("#clubcontrollul").append("<li class='divider'>");
                $("#clubcontrollul").append("<li><a href='/clubassembly/organization/organizationmemberapply?organizationid="
                    + data.reply
                    + "'>成员申请</a></li>");
            } else if (data.code == 207) {
                //IS_MEMBER
                $("#clubnav").attr("style", "display: block;");
                $("#clubcontrolla").empty();
                $("#clubcontrolla").append(data.detail);
                $("#clubcontrolla").append("<span class='caret'></span>");
                $("#clubcontrollul").empty();
                $("#clubcontrollul").append("<li><a href='/clubassembly/organization/organizationprofile?organizationid="
                    + data.reply
                    + "'>社团资料</a></li>");
                $("#clubcontrollul").append("<li class='divider'>");
                $("#clubcontrollul").append("<li><a href='/clubassembly/organization/organizationmain?organizationid="
                    + data.reply
                    + "'>社团主页</a></li>");
                $("#clubcontrollul").append("<li class='divider'>");
                $("#clubcontrollul").append("<li><a href='/clubassembly/organization/organizationmember?organizationid="
                    + data.reply
                    + "'>成员信息</a></li>");
            } else {
                $("#clubnav").attr("style", "display: none;");
            }
        }
    });


    //我关注的人
    $.ajax({
        async: false,
        type: "POST",
        url: "/clubassembly/home/watchedstudents",
        dataType: 'json',
        success: function (data) {
            if (data.code == 0) {
                $("#watched").after("<li><a href='#'>&nbsp;&nbsp;&nbsp;&nbsp;" +
                    "无" +
                    "</span></a></li>"
                );
            } else {
                $.each(data.reply, function (key, value) {
                    $("#watched").after("<li><a href='" +
                        "/clubassembly/student/studentprofilemain?studentid=" +
                        value.id +
                        "'>&nbsp;" +
                        "<img class='img-circle' alt='30x30' style='width: 30px; height: 30px;' src='/clubassembly/" + value.image + "'data-holder-rendered='true'/>" +
                        "&nbsp;&nbsp;" +
                        value.name +
                        "</span></a></li>"
                    );
                });
            }
        }
    });

    //关注我的人
    $.ajax({
        async: false,
        type: "POST",
        url: "/clubassembly/home/bewatchedstudents",
        dataType: 'json',
        success: function (data) {
            if (data.code == 0) {
                $("#bewatched").after("<li><a href='#'>&nbsp;&nbsp;&nbsp;&nbsp;" +
                    "无" +
                    "</span></a></li>"
                );
            } else {
                $.each(data.reply, function (key, value) {
                    $("#bewatched").after("<li><a href='" +
                        "/clubassembly/student/studentprofilemain?studentid=" +
                        value.id +
                        "'>&nbsp;" +
                        "<img class='img-circle' alt='30x30' style='width: 30px; height: 30px;' src='/clubassembly/" + value.image + "'data-holder-rendered='true'/>" +
                        "&nbsp;&nbsp;" +
                        value.name +
                        "</span></a></li>"
                    );
                });
            }
        }
    });


    //互相关注的人
    $.ajax({
        async: false,
        type: "POST",
        url: "/clubassembly/home/interwatchedstudents",
        dataType: 'json',
        success: function (data) {
            if (data.code == 0) {
                $("#interwatched").after("<li><a href='#'>&nbsp;&nbsp;&nbsp;&nbsp;" +
                    "无" +
                    "</span></a></li>"
                );
            } else {
                $.each(data.reply, function (key, value) {
                    $("#interwatched").after("<li><a href='" +
                        "/clubassembly/student/studentprofilemain?studentid=" +
                        value.id +
                        "'>&nbsp;" +
                        "<img class='img-circle' alt='30x30' style='width: 30px; height: 30px;' src='/clubassembly/" + value.image + "'data-holder-rendered='true'/>" +
                        "&nbsp;&nbsp;" +
                        value.name +
                        "</span></a></li>"
                    );
                });
            }
        }
    });
});


