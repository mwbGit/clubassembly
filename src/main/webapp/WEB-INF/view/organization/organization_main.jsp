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


    <script src="<%=ctx %>/static/editor/kindeditor-min.js"></script>


    <!-- Loading Bootstrap -->
    <link href="<%=ctx %>/static/Flat-UI-master/dist/css/vendor/bootstrap.min.css" rel="stylesheet">

    <!-- Loading Flat UI -->
    <link href="<%=ctx %>/static/Flat-UI-master/dist/css/flat-ui.min.css" rel="stylesheet">
    <link href="<%=ctx %>/static/css/index.css" rel="stylesheet">

    <link rel="shortcut icon" href="img/favicon.ico">
    <link rel="stylesheet" type="text/css" href="<%=ctx %>/static/webuploader-0.1.5/css/webuploader.css" />
    <link rel="stylesheet" type="text/css" href="<%=ctx %>/static/webuploader-0.1.5/examples/image-upload/style.css" />


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
                document.location.href = "home.html";
            });

            //验证表单
            $("#releaseEventform").validate({
                rules: {
                    title: {
                        required: true
                    },
                    category: {
                        required: true
                    },
                    sponsor: {
                        required: true
                    },
                    scale: {
                        required: true
                    },
                    endtime: {
                        required: true
                    },
                    content: {
                        required: true
                    },
                    enddate: {
                        required: true
                    },
                    begintime: {
                        required: true
                    },
                    begindate: {
                        required: true
                    }
                },
                messages: {
                    title: {
                        required: "请输入活动标题"
                    },
                    category: {
                        required: "请输入活动类别"
                    },
                    sponsor: {
                        required: "请输入活动主办方"
                    },
                    scale: {
                        required: "请输入活动规模"
                    },
                    endtime: {
                        required: "请输入活动结束时间"
                    },
                    content: {
                        required: "请输入活动内容"
                    },
                    enddate: {
                        required: "请输入活动结束时间"
                    },
                    begintime: {
                        required: "请输入活动开始时间"
                    },
                    begindate: {
                        required: "请输入活动开始时间"
                    }
                }
            });
        });


        //        上传头像
        function ajaxFileUpload() {
            $.ajaxFileUpload({
                url: "/clubassembly/organizationmaintain/uploadeventimage",
                secureuri: false,
                fileElementId: 'fileToUpload',
                dataType: 'json',
                success: function (data, status) {
                    if (data.code == 0) {
                        alert("上传失败")
                    } else {
                        $("#eventImage").attr("src", "/clubassembly/" + data.reply);
                        $("#releaseEventform").remove("input[name=poster]");
                        $("#releaseEventform").append("<input type='hidden' value = " + data.reply + " name=" + "poster" + " >");
                    }
                },
                error: function (data, status, e) {
                    alert("上传出错")
                }
            });

            return false;
        }
    </script>
    <script type="text/javascript">
        var editor;
        KindEditor.ready(function (K) {
            editor = K.create(
                    'textarea[name="content"]',
                    {
                        width: '600px',
                        height: '600px',
                        cssPath: '<c:url value="/static/editor/plugins/code/prettify.css"/>',
                        uploadJson: '<c:url value="/static/editor/jsp/upload_json.jsp"/>',
                        fileManagerJson: '<c:url value="/static/editor/jsp/file_manager_json.jsp"/>',
                        allowFileManager: true,
                        resizeType: 0,
                        items: [
                            'source', '|', 'undo', 'redo', '|', 'preview', 'cut', 'copy', 'paste', 'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript', 'superscript', 'clearhtml', 'quickformat', 'selectall', '/', 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'table', 'hr', 'emoticons', 'link', 'unlink'
                        ],
                        afterCreate: function () {
                            var self = this;
                            K.ctrl(document, 13, function () {
                                self.sync();
                                document.forms['contributionform'].submit();
                            });
                            K.ctrl(self.edit.doc, 13, function () {
                                self.sync();
                                document.forms['contributionform'].submit();
                            });
                        },
                        afterBlur: function () {
                            this.sync();
                        }});
        });
    </script>
</head>
<body style="background-color: #d8d6d3">


<div class="container-fluid organization_background" style="margin-top:53px;padding-top: 50px;">
    <div class="container">
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12">
                <center>
                    <img class="img-circle"
                         alt="140x140"
                         style="width: 140px; height: 140px;" src="${"/clubassembly/"}${organization.image}"
                         data-holder-rendered="true"/>
                </center>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-offset-4 col-sm-4 col-md-4 col-lg-4" style="height:180px;">
                <div class="row" style="height: 50px">
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        <p class="text-center">${organization.name}</p>
                    </div>
                </div>

                <div class="row" style="height: 50px">
                    <div class="col-sm-12 col-md-12 col-lg-12">
                        <p class="text-center">${organization.slogan}</p>
                    </div>
                </div>
                <c:if test="${iscommender != null && iscommender || ismember != null && ismember}">
                    <div class="row">
                        <button type="button" id="organizationManageButton" value="${organization.id}"
                                class="btn btn-block btn-lg btn-inverse">主页管理
                        </button>
                    </div>
                </c:if>
                <c:if test="${iscommender != null && !iscommender && ismember != null && !ismember}">
                    <button type="button" id="organizationApplyInButton" value="${organization.id}"
                            data-toggle="modal" data-backdrop="static"
                            data-target="#myModal"
                            class="btn btn-block btn-lg btn-inverse">申请加入
                    </button>
                </c:if>
            </div>
        </div>
    </div>
</div>


<!--<img height="300px;" width="1700px" src="<%=ctx %>/static/image/1.png"/>-->
<div class="container-fluid" style="margin-top: 20px;">
<div class="container">
<div class="row">
    <div class="col-sm-1 col-md-1 col-lg-1">
        <a href="<c:url value="/organization/organizationmain?organizationid=${organization.id}"/>"><p
                class="text-center">首页</p></a>
    </div>
    <div class="col-sm-1 col-md-1 col-lg-1">
        <a href="<c:url value="/organization/organizationmainprofile?organizationid=${organization.id}"/>"><p
                class="text-center">资料</p></a>
    </div>
    <div class="col-sm-1 col-md-1 col-lg-1">
        <a href="<c:url value="/organization/organizationmainevents?organizationid=${organization.id}"/>"><p
                class="text-center">活动</p></a>
    </div>
    <div class="col-sm-1 col-md-1 col-lg-1">
        <a href="<c:url value="/organization/organizationmainnews?organizationid=${organization.id}"/>"><p
                class="text-center">新鲜事</p></a>
    </div>
    <div class="col-sm-1 col-md-1 col-lg-1">
        <a href="<c:url value="/organization/organizationmainphotos?organizationid=${organization.id}"/>"><p
                class="text-center">相册</p></a>
    </div>
    <div class="col-sm-1 col-md-1 col-lg-1">
        <a href="<c:url value="/organization/organizationmainmessages?organizationid=${organization.id}"/>"><p
                class="text-center">留言板</p></a>
    </div>
</div>
<div class="row" style="">
    <div class="col-sm-1 col-md-1 col-lg-1" style="height:5px; background-color: #2c3e50">

    </div>
    <div class="col-sm-1 col-md-1 col-lg-1">

    </div>
    <div class="col-sm-1 col-md-1 col-lg-1">

    </div>
    <div class="col-sm-1 col-md-1 col-lg-1">

    </div>
    <div class="col-sm-1 col-md-1 col-lg-1">

    </div>
    <div class="col-sm-1 col-md-1 col-lg-1">

    </div>
</div>

<%--只有社长才可以看见这条信息--%>
<c:if test="${iscommender != null && iscommender}">
<div class="row" style="margin-top: 20px;">
    <div class="col-sm-1 col-md-2 col-lg-2">
        <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>发布内容
    </div>
</div>

<div class="row" style="margin-top: 20px;">
    <div class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2">
        <a href="#" data-toggle="modal" data-backdrop="static"
           data-target="#releaseEventModal">
            <img class="img-circle"
                 alt="140x140"
                 style="width: 100px; height: 100px;" src="<%=ctx %>/static/image/event.png"
                 data-holder-rendered="true"/>
        </a>
    </div>
    <div class="col-sm-2 col-md-2 col-lg-2">
        <a href="#" data-toggle="modal" data-backdrop="static"
           data-target="#releaseNewsModal">
            <img class="img-circle"
                 alt="140x140"
                 style="width: 100px; height: 100px;" src="<%=ctx %>/static/image/news.png"
                 data-holder-rendered="true"/>
        </a>
    </div>
    <div class="col-sm-2 col-md-2 col-lg-2">
        <a href="#" data-toggle="modal" data-backdrop="static"
           data-target="#releasePhotosModal">
            <img class="img-circle"
                 alt="140x140"
                 style="width: 100px; height: 100px;" src="<%=ctx %>/static/image/photo.png"
                 data-holder-rendered="true"/>
        </a>
    </div>
</div>
<hr/>
</c:if>

<div class="row" style="margin-top: 20px;">
    <div class="col-sm-2 col-md-2 col-lg-2">
        <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>社团成员
    </div>
</div>


<div class="row" style="margin-top: 20px;">
    <c:if test="${members != null && members.size() > 0}">
    <c:forEach var="member" items="${members}" varStatus="status">

    <c:if test="${status.index % 8 == 0}">
    <div class="row" style="margin-top: 20px;margin-bottom: 30px;">
        <div class="col-lg-offset-1 col-sm-1 col-md-1 col-lg-1">
            </c:if>
            <c:if test="${status.index % 8 != 0}">
            <div class="col-sm-1 col-md-1 col-lg-1">
                </c:if>
                <center>
                    <a href="<c:url value="/student/studentprofilemain?studentid=${member.id}"/>">
                        <img class="img-circle"
                             alt="140x140"
                             style="width: 50px; height: 50px;" src="${"/clubassembly/"}${member.image}"
                             data-holder-rendered="true"/>
                    </a>
                </center>
                <p class="text-center" style="color: #090909;">${member.name}</p>
            </div>
            <c:if test="${ status.last == true  ||  status.index  % 8 == 7 }">
        </div>
        </c:if>
        </c:forEach>
        </c:if>
    </div>


    <hr/>
    <div class="row" style="margin-top: 20px;">
        <div class="col-sm-2 col-md-2 col-lg-2">
            <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>社团活动
        </div>
    </div>

    <c:if test="${events != null && events.size() > 0}">
    <c:forEach var="event" items="${events}" varStatus="status">
    <c:if test="${status.index % 2 == 0}">
    <div class="row" style="margin-top: 20px;margin-bottom: 30px;">
        <div class="col-lg-offset-1 col-sm-6 col-md-6 col-lg-6">
            </c:if>
            <c:if test="${status.index % 2 != 0}">
            <div class="col-sm-5 col-md-5 col-lg-5">
                </c:if>
                <div class="row">
                    <a href="<c:url value="/organization/organizationmaineventsdetail/${organization.id}/${event.id}"/>">
                        <div class="col-sm-4 col-md-4 col-lg-4">
                            <div>
                                <img alt="First slide [1140x500]"
                                     width="150px" height="200px"
                                     src="${"/clubassembly/"}${event.poster}" data-holder-rendered="true">
                            </div>
                        </div>
                        <div class="col-sm-8 col-md-8 col-lg-8">
                            <div class="row">
                                <ul style="list-style-type:none;">
                                    <li></li>
                                    <li></li>
                                    <li></li>
                                    <li>${event.title}</li>
                                    <li>主办方:${event.sponsor}</li>
                                    <li>开始时间:${event.beginDate}</li>
                                    <li>结束时间:${event.endDate}</li>
                                    <li>活动规模:${event.scale}</li>
                                    <li>活动地点:${event.location}</li>
                                </ul>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            <c:if test="${ status.last == true  ||  status.index  % 2 == 1 }">
        </div>
        </c:if>
        </c:forEach>
        </c:if>
        <hr/>

        <div class="row" style="margin-top: 20px;">
            <div class="col-sm-2 col-md-2 col-lg-2">
                <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>新鲜事
            </div>
        </div>
        <c:if test="${newses != null && newses.size() > 0}">
            <c:forEach var="news" varStatus="status" items="${newses}">
                <div class="row" style="margin-top: 20px;margin-bottom: 30px;">
                    <div class="form-group">
                        <div class="col-lg-offset-1  col-sm-8">
                            <textarea class="form-control" rows="3">${news.content}</textarea>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <hr/>

        <div class="row" style="margin-top: 20px;">
            <div class="col-sm-2 col-md-2 col-lg-2">
                <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>最新相册
            </div>
        </div>
        <hr/>
    </div>
</div>

<c:if test="${iscommender != null && iscommender}">
<!-- 发布活动 -->
<div class="modal fade bs-example-modal-lg" id="releaseEventModal" role="dialog" aria-labelledby="releaseEventTitle"
     aria-hidden="true">
<div class="modal-dialog modal-lg">
<div class="modal-content">
<form action="<c:url value="/organizationmaintain/addevent"/>" id="releaseEventform" method="post"
      class="form-horizontal" role="form">
<input type="hidden" value="${organization.id}" name="organizationid"/>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"><span
            aria-hidden="true">&times;</span><span
            class="sr-only">Close</span></button>
    <h6 class="modal-title" id="releaseEventTitle">发布活动</h6>
</div>
<div class="modal-body">
<div class="row">
<div class="col-sm-12 col-md-12 col-lg-12">
<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="title">
            <p class="text-right">活动标题</p></label>

        <div class="col-sm-8">
            <input class="form-control" type="text" id="title" name="title"
                   placeholder="请填写活动标题">
        </div>
    </div>
</div>

<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="category">
            <p class="text-right">活动分类</p></label>

        <div class="col-sm-4">
            <select class="form-control" name="category" id="category">
                <option>晚会</option>
                <option>派对</option>
                <option>体育</option>
                <option>展览</option>
                <option>讲座</option>
                <option>公益</option>
                <option>环保</option>
                <option>聚会</option>
                <option>演出</option>
                <option>电影</option>
                <option>其他</option>
            </select>
        </div>
    </div>
</div>


<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="location">
            <p class="text-right">活动地址</p></label>

        <div class="col-sm-6">
            <input class="form-control" type="text" id="location"
                   name="location"
                   placeholder="学校具体地点">
        </div>
    </div>
</div>


<div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">
        <div class="row">
            <div class="form-group">
                <label class="col-sm-2 col-md-2 col-lg-2 control-label"
                       for="begindate">
                    <p class="text-right">活动时间</p></label>

                <div class="col-sm-3">
                    <input class="form-control" type="text"
                           placeholder="yyyy-MM-dd" name="begindate" id="begindate">
                </div>
                <div class="col-sm-2">
                    <select class="form-control" name="begintime" id="begintime">
                        <option>08:00</option>
                        <option>08:30</option>
                        <option>09:00</option>
                        <option>09:30</option>
                        <option>10:00</option>
                        <option>10:30</option>
                        <option>11:00</option>
                        <option>11:30</option>
                        <option>12:00</option>
                        <option>12:30</option>
                        <option>13:00</option>
                        <option>13:30</option>
                        <option>14:00</option>
                        <option>14:30</option>
                        <option>15:00</option>
                        <option>15:30</option>
                        <option>16:00</option>
                        <option>16:30</option>
                        <option>17:00</option>
                        <option>17:30</option>
                        <option>18:00</option>
                        <option>18:30</option>
                        <option>19:00</option>
                        <option>19:30</option>
                        <option>20:00</option>
                        <option>20:30</option>
                        <option>21:00</option>
                        <option>21:30</option>
                        <option>22:00</option>
                        <option>22:30</option>
                        <option>23:00</option>
                        <option>23:30</option>
                        <option>01:00</option>
                        <option>01:30</option>
                        <option>02:00</option>
                        <option>02:30</option>
                        <option>03:00</option>
                        <option>03:30</option>
                        <option>04:00</option>
                        <option>04:30</option>
                        <option>05:00</option>
                        <option>05:30</option>
                        <option>06:00</option>
                        <option>06:30</option>
                        <option>07:00</option>
                        <option>07:30</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <div class="col-lg-offset-2 col-sm-3">
                    <input class="form-control" type="text"
                           placeholder="yyyy-MM-dd" name="enddate" id="enddate">
                </div>
                <div class="col-sm-2">
                    <select class="form-control" name="endtime" id="endtime">
                        <option>08:00</option>
                        <option>08:30</option>
                        <option>09:00</option>
                        <option>09:30</option>
                        <option>10:00</option>
                        <option>10:30</option>
                        <option>11:00</option>
                        <option>11:30</option>
                        <option>12:00</option>
                        <option>12:30</option>
                        <option>13:00</option>
                        <option>13:30</option>
                        <option>14:00</option>
                        <option>14:30</option>
                        <option>15:00</option>
                        <option>15:30</option>
                        <option>16:00</option>
                        <option>16:30</option>
                        <option>17:00</option>
                        <option>17:30</option>
                        <option>18:00</option>
                        <option>18:30</option>
                        <option>19:00</option>
                        <option>19:30</option>
                        <option>20:00</option>
                        <option>20:30</option>
                        <option>21:00</option>
                        <option>21:30</option>
                        <option>22:00</option>
                        <option>22:30</option>
                        <option>23:00</option>
                        <option>23:30</option>
                        <option>01:00</option>
                        <option>01:30</option>
                        <option>02:00</option>
                        <option>02:30</option>
                        <option>03:00</option>
                        <option>03:30</option>
                        <option>04:00</option>
                        <option>04:30</option>
                        <option>05:00</option>
                        <option>05:30</option>
                        <option>06:00</option>
                        <option>06:30</option>
                        <option>07:00</option>
                        <option>07:30</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="sponsor">
            <p class="text-right">主办方</p></label>

        <div class="col-sm-5">
            <input class="form-control" type="text" id="sponsor" name="sponsor"
                   placeholder="请填写主办方名称">
        </div>
    </div>
</div>


<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="scale">
            <p class="text-right">活动规模</p></label>

        <div class="col-sm-4">
            <select class="form-control" name="scale" id="scale">
                <option>小型活动(50人以内)</option>
                <option>中型活动(50-200人)</option>
                <option>大型活动(200人以上)</option>
            </select>
        </div>
    </div>
</div>


<div class="row" style="padding-top: 20px;padding-bottom: 20px;">


    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label">
            <p class="text-right">活动海报</p></label>

        <div class="col-sm-3 col-md-3 col-lg-3">
            <img id="eventImage"
                 alt="340x140"
                 style="width:240px; height: 400px;" src="<%=ctx %>/static/image/event1.jpg"
                 data-holder-rendered="true"/>
        </div>
        <div class="col-lg-offset-1 col-sm-4 col-md-4 col-lg-4">

            <div style="margin-top: 100px;">
                请上传本次活动宣传海报<br/>
                海报大小为240x400效果最佳<br/>
                它会成为热门活动评选的参照条件<br/>
            </div>
            <input id="fileToUpload" type="file"
                   name="fileToUpload">
            <button class="btn btn-block btn-lg btn-default" id="buttonUpload"
                    onclick="return ajaxFileUpload();">上传海报
            </button>
        </div>
    </div>
</div>


<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="content">
            <p class="text-right">活动详情</p></label>

        <div class="col-sm-8">
            <textarea class="form-control" name="content" id="content" rows="20"></textarea>
        </div>
    </div>
</div>
</div>
</div>
</div>

<div class="modal-footer">
    <div class="row">
        <div class="col-lg-offset-7 col-sm-2 col-md-2 col-lg-2">
            <button type="button" class="btn btn-block btn-lg btn-inverse" data-dismiss="modal">取消
            </button>
        </div>
        <div class="col-sm-3 col-md-3 col-lg-3">
            <button type="submit" class="btn btn-block btn-lg btn-primary" id="releaseButtion">发布
            </button>
        </div>
    </div>
</div>
</form>
</div>
</div>
</div>
</c:if>

<c:if test="${iscommender != null && iscommender}">
<!-- 发布新鲜事 -->
<div class="modal fade bs-example-modal-lg" id="releaseNewsModal" role="dialog" aria-labelledby="releaseNewsTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form action="<c:url value="/organizationmaintain/addnews"/>" method="post" class="form-horizontal"
                  role="form">
                <input type="hidden" value="${organization.id}" name="organizationid"/>

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                    <h6 class="modal-title" id="releaseNewsTitle">发布新鲜事</h6>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="newscontent">
                                <p class="text-right">内容</p></label>

                            <div class="col-sm-8">
                                <textarea class="form-control" rows="3" name="newscontent" id="newscontent"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-lg-offset-7 col-sm-2 col-md-2 col-lg-2">
                            <button type="button" class="btn btn-block btn-lg btn-inverse" data-dismiss="modal">取消
                            </button>
                        </div>
                        <div class="col-sm-3 col-md-3 col-lg-3">
                            <button type="submit" class="btn btn-block btn-lg btn-primary">发布
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</c:if>


<c:if test="${iscommender != null && iscommender}">
<!-- 发布相册 -->
<div class="modal fade bs-example-modal-lg" id="releasePhotosModal" role="dialog" aria-labelledby="releasePhotosTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="form-horizontal" role="form">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                    <h6 class="modal-title" id="releasePhotosTitle">发布相册</h6>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12" >
                            <div id="wrapper">
                                <div id="container">
                                    <!--头部，相册选择和格式选择-->
                                    <div id="uploader">
                                        <div class="queueList">
                                            <div id="dndArea" class="placeholder">
                                                <div id="filePicker"></div>
                                                <p>或将照片拖到这里，单次最多可选300张</p>
                                            </div>
                                        </div>
                                        <div class="statusBar" style="display:none;">
                                            <div class="progress">
                                                <span class="text">0%</span>
                                                <span class="percentage"></span>
                                            </div><div class="info"></div>
                                            <div class="btns">
                                                <div id="filePicker2"></div><div class="uploadBtn">开始上传</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </form>
        </div>
    </div>
</div>
</c:if>

<c:if test="${iscommender != null && !iscommender && ismember != null && !ismember }">
<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form action="<c:url value="/organization/organizationapplyin"/>"
                  method="post">
                <input type="hidden" value="${organization.id}" name="organizationid"/>

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">申请设置</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                            <p class="text-center">可选部门</p>
                        </div>
                        <div class="col-sm-3 col-md-3 col-lg-3">
                            <p class="text-center">当前可接受申请人数</p>
                        </div>
                        <div class="col-sm-3 col-md-3 col-lg-3">
                            <p class="text-center">申请</p>
                        </div>
                    </div>
                    <c:if test="${departments != null && departments.size() > 0}">
                        <c:forEach var="department" items="${departments}" varStatus="statys">
                            <div class="row">
                                <c:if test="${department.open}">
                                    <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                                        <label class="radio" type="mydepartment" id="${department.id}">
                                                ${department.department}
                                        </label>
                                    </div>
                                    <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                                        <input class="form-control" type="text"
                                               value="${department.maxNumbers}" readonly>
                                    </div>
                                    <div class="col-lg-offset-1 col-sm-3 col-md-3 col-lg-3">
                                        <c:if test="${department.maxNumbers  > 0}">
                                            <input class="form-control" type="radio" value="${department.id}"
                                                   name="chooseradio">
                                        </c:if>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:if>


                    <div class="row">
                        <div class="form-group">
                            <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label">
                                <p class="text-right">允许调剂</p></label>

                            <div class="col-sm-3">
                                <select class="form-control" name="adjust">
                                    <option value="1" selected="selected">
                                        允许
                                    </option>

                                    <option value="0">
                                        不允许
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="form-group">
                            <label class="col-lg-offset-1 col-sm-2 col-md-2 col-lg-2 control-label"
                                   for="formGroupInputDefault">
                                <p class="text-right">申请理由</p></label>

                            <div class="col-sm-8">
                                <textarea class="form-control" rows="5" cols="20" id="formGroupInputDefault"
                                          name="reason"
                                        >
                                </textarea>
                            </div>

                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">提交申请</button>
                </div>
            </form>
        </div>
    </div>
</div>
</c:if>


<!-- jQuery (necessary for Flat UI's JavaScript plugins) -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/video.js"></script>
<script src="<%=ctx %>/static/Flat-UI-master/dist/js/flat-ui.min.js"></script>
<script src="<%=ctx %>/static/jquery-validation-1.13.1/dist/jquery.validate.js"></script>
<script src="<%=ctx %>/static/AjaxFileUploaderV2.1/ajaxfileupload.js"></script>
<script src="<%=ctx %>/static/webuploader-0.1.5/dist/webuploader.js"></script>
<script src="<%=ctx %>/static/webuploader-0.1.5/examples/image-upload/upload.js"></script>

</body>
</html>
