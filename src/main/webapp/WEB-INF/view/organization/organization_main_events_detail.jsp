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

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
    <script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/html5shiv.js"></script>
    <script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/respond.min.js"></script>
    <script src="<%=ctx %>/static/Flat-UI-master/dist/js/vendor/jquery.min.js"></script>
    <![endif]-->


    <script src="<%=ctx %>/static/jquery/jquery-2.1.3.min.js.js"></script>
    <script src="<%=ctx %>/static/js/utils.js"></script>
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
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1" style="height:5px; background-color: #2c3e50">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
            <div class="col-sm-1 col-md-1 col-lg-1">

            </div>
        </div>
    </div>
</div>
<div class="container-fluid" style="margin-top: 20px;">
    <div class="container">
        <c:if test="${event != null}">
            <div class="row" style="margin-top: 20px;">
                <div class="col-sm-2 col-md-2 col-lg-2">
                    <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>基本信息
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">活动标题</p></label>

                    <div class="col-sm-8">
                            ${event.title}
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">活动分类</p></label>

                    <div class="col-sm-8">
                            ${event.category}
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">活动地址</p></label>

                    <div class="col-sm-8">
                            ${event.location}
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">活动时间</p></label>

                    <div class="col-sm-8">
                            ${event.beginDate} 至 ${event.endDate}
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">主办方</p></label>

                    <div class="col-sm-8">
                            ${event.sponsor}
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">活动规模</p></label>

                    <div class="col-sm-8">
                            ${event.scale}
                    </div>
                </div>
            </div>

            <div class="row" style="margin-top: 20px;">
                <div class="form-group">
                    <label class="col-sm-2 col-md-2 col-lg-2 control-label">
                        <p class="text-right">活动海报</p></label>

                    <div class="col-sm-3 col-md-3 col-lg-3">
                        <img
                                alt="340x140"
                                style="width:240px; height: 400px;" src="${'/clubassembly/'}${event.poster}"
                                data-holder-rendered="true"/>
                    </div>
                </div>
            </div>

            <hr/>

            <div class="row" style="margin-top: 20px;">
                <div class="col-sm-2 col-md-2 col-lg-2">
                    <img src="<%=ctx %>/static/image/tip.png" width="10px" height="20px;"/>活动详情
                </div>
            </div>
            <div class="row">
                <div class="col-lg-offset-2 col-lg-10">
                    <div>
                            ${event.content}
                    </div>
                </div>
            </div>

            <c:if test="${iscommender != null && iscommender}">
                <div class="row">
                    <div class="col-lg-offset-2 col-sm-3 col-md-3 col-lg-3">
                        <button data-toggle="modal" data-backdrop="static"
                                data-target="#updateEventModal" class="btn btn-block btn-lg btn-primary" type="submit">
                            修改
                        </button>
                    </div>
                    <div class="col-sm-2 col-md-2 col-lg-2">
                        <button class="btn btn-block btn-lg btn-inverse" id="backButtion"
                                type="button">删除
                        </button>
                    </div>
                </div>
            </c:if>
        </c:if>
    </div>
</div>


<c:if test="${iscommender != null && iscommender && event != null}">
<!-- 更新活动 -->
<div class="modal fade bs-example-modal-lg" id="updateEventModal" role="dialog" aria-labelledby="releaseEventTitle"
     aria-hidden="true">
<div class="modal-dialog modal-lg">
<div class="modal-content">
<form action="#" id="releaseEventform" method="post"
      class="form-horizontal" role="form">
<input type="hidden" value="${organization.id}" name="organizationid"/>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal"><span
            aria-hidden="true">&times;</span><span
            class="sr-only">Close</span></button>
    <h6 class="modal-title" id="releaseEventTitle">修改活动</h6>
</div>
<div class="modal-body">
<div class="row">
<div class="col-sm-12 col-md-12 col-lg-12">
<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="title">
            <p class="text-right">活动标题</p></label>

        <div class="col-sm-8">
            <input class="form-control" type="text" id="title" name="title" value="${event.title}"
                    >
        </div>
    </div>
</div>

<div class="row">
    <div class="form-group">
        <label class="col-sm-2 col-md-2 col-lg-2 control-label" for="category">
            <p class="text-right">活动分类</p></label>

        <div class="col-sm-4">
            <select class="form-control" name="category" id="category">
                <option <c:if test="${event.category eq '晚会'}">
                    selected
                </c:if> >晚会
                </option>
                <option <c:if test="${event.category eq '派对'}">
                    selected
                </c:if> >派对
                </option>
                <option <c:if test="${event.category eq '体育'}">
                    selected
                </c:if> >体育
                </option>
                <option <c:if test="${event.category eq '展览'}">
                    selected
                </c:if> >展览
                </option>
                <option <c:if test="${event.category eq '讲座'}">
                    selected
                </c:if> >讲座
                </option>
                <option <c:if test="${event.category eq '公益'}">
                    selected
                </c:if> >公益
                </option>
                <option <c:if test="${event.category eq '环保'}">
                    selected
                </c:if> >环保
                </option>
                <option <c:if test="${event.category eq '聚会'}">
                    selected
                </c:if> >聚会
                </option>
                <option <c:if test="${event.category eq '演出'}">
                    selected
                </c:if> >演出
                </option>
                <option <c:if test="${event.category eq '电影'}">
                    selected
                </c:if> >电影
                </option>
                <option <c:if test="${event.category eq '其他'}">
                    selected
                </c:if> >其他
                </option>
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
                   name="location" value="${event.location}"
                    >
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
                           name="enddate" id="enddate">
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
            <input class="form-control" type="text" id="sponsor" name="sponsor" value="${event.sponsor}"
                    >
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
                 style="width:240px; height: 400px;" src="${'/clubassembly/'}${event.poster}"
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
            <textarea class="form-control" name="content" id="content" rows="20">${event.content}</textarea>
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
</body>
</html>
