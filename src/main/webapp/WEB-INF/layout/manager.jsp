<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String ctx = request.getContextPath();
%>
<head>
    <title>社团集结号</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="<%=ctx %>/static/matrix/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=ctx %>/static/matrix/css/bootstrap-responsive.min.css"/>
    <link rel="stylesheet" href="<%=ctx %>/static/matrix/css/fullcalendar.css"/>
    <link rel="stylesheet" href="<%=ctx %>/static/matrix/css/matrix-style.css"/>
    <link rel="stylesheet" href="<%=ctx %>/static/matrix/css/matrix-media.css"/>
    <link href="<%=ctx %>/static/matrix/font-awesome/css/font-awesome.css" rel="stylesheet"/>
    <link rel="stylesheet" href="<%=ctx %>/static/matrix/css/jquery.gritter.css"/>
    <!--<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>-->
    <script src="<%=ctx %>/static/matrix/js/excanvas.min.js"></script>
    <script src="<%=ctx %>/static/matrix/js/jquery.min.js"></script>
    <script src="<%=ctx %>/static/matrix/js/jquery.ui.custom.js"></script>
    <script src="<%=ctx %>/static/matrix/js/bootstrap.min.js"></script>
    <script src="<%=ctx %>/static/matrix/js/jquery.flot.min.js"></script>
    <script src="<%=ctx %>/static/matrix/js/jquery.flot.resize.min.js"></script>
    <script src="<%=ctx %>/static/matrix/js/jquery.peity.min.js"></script>
    <script src="<%=ctx %>/static/matrix/js/fullcalendar.min.js"></script>
    <script src="<%=ctx %>/static/matrix/js/matrix.js"></script>
    <script src="<%=ctx %>/static/matrix/js/matrix.dashboard.js"></script>
    <script src="<%=ctx %>/static/matrix/js/jquery.gritter.min.js"></script>
    <script src="<%=ctx %>/static/matrix/js/matrix.interface.js"></script>
    <script src="<%=ctx %>/static/matrix/js/matrix.chat.js"></script>
    <script src="<%=ctx %>/static/matrix/js/jquery.validate.js"></script>
    <script src="<%=ctx %>/static/matrix/js/matrix.form_validation.js"></script>
    <script src="<%=ctx %>/static/matrix/js/jquery.wizard.js"></script>
    <script src="<%=ctx %>/static/matrix/js/jquery.uniform.js"></script>
    <script src="<%=ctx %>/static/matrix/js/select2.min.js"></script>
    <script src="<%=ctx %>/static/matrix/js/matrix.popover.js"></script>
    <script src="<%=ctx %>/static/matrix/js/jquery.dataTables.min.js"></script>
    <script src="<%=ctx %>/static/matrix/js/matrix.tables.js"></script>
    <script src="<%=ctx %>/static/jquery/jquery-2.1.3.min.js.js"></script>
    <script type="text/javascript">
        // This function is called from the pop-up menus to transfer to
        // a different page. Ignore if the value returned is a null string:
        function goPage(newURL) {
            // if url is empty, skip the menu dividers and reset the menu selection to default
            if (newURL != "") {

                // if url is "-", it is this page -- reset the menu:
                if (newURL == "-") {
                    resetMenu();
                }
                // else, send page to designated URL
                else {
                    document.location.href = newURL;
                }
            }
        }
        // resets the menu selection upon entry to this page:
        function resetMenu() {
            document.gomenu.selector.selectedIndex = 2;
        }
    </script>
    <script>
        $(function () {
            //得到当前管理端菜单状态
            $.ajax({
                async: false,
                type: "POST",
                url: "/clubassembly/manager/getmenustatus",
                dataType: 'json',
                success: function (data) {
                    if (data != null && data.code == 227) {
                        if (data.reply == "main_manager") {
                            $("#main_manager").attr("class","active");
                        } else if (data.reply == "student_manager") {
                            $("#student_manager").attr("class","active");
                        } else if (data.reply == "organization_manager") {
                            $("#organization_manager").attr("class","active");
                        } else if (data.reply == "system_manager") {
                            $("#system_manager").attr("class","active");
                        } else if (data.reply == "role_manager") {
                            $("#role_manager").attr("class","active");
                        } else if (data.reply == "admin_manager") {
                            $("#admin_manager").attr("class","active");
                        } else {
                        }
                    } else {
                        //未找到数据
                    }
                }
            });


            //管理端提示延时
            setTimeout(function () {
                var tip =  $('#tip');
                if(tip != null){
                    tip.remove();
                }
            }, 3000);


        });
    </script>

    <sitemesh:head/>
</head>

<body>
<!--Header-part-->
<div id="header">
    <h1><a href="<%=ctx %>/manager/home">Matrix Admin</a></h1>
</div>
<!--close-Header-part-->
<!--顶部菜单栏开始 -->
<div id="user-nav" class="navbar navbar-inverse">
    <ul class="nav">
        <li class="dropdown" id="profile-messages"><a title="" href="<%=ctx %>/manager/adminprofile"
                                                      data-toggle="dropdown"
                                                      data-target="#profile-messages" class="dropdown-toggle"><i
                class="icon icon-user"></i> <span class="text"> <shiro:principal property="userName"/></span><b
                class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a href="<%=ctx %>/manager/adminprofile"><i class="icon-user"></i> 个人资料</a></li>
            </ul>
        </li>
        <li class=""><a title="" href="<%=ctx %>/manager/logout"><i class="icon icon-share-alt"></i> <span class="text">退出</span></a>
        </li>
    </ul>
</div>
<!--顶部菜单栏结束 -->
<!--左侧菜单栏开始 -->
<div id="sidebar"><a href="<%=ctx %>/manager/home" class="visible-phone"><i class="icon icon-home"></i> 首页</a>
    <ul>
        <shiro:hasRole name="student_manager">
            <li id="main_manager"><a href="<%=ctx %>/manager/home"><i class="icon icon-home"></i>
                <span> 首页</span></a></li>
        </shiro:hasRole>
        <shiro:hasRole name="student_manager">
            <li id="student_manager"><a href="<%=ctx %>/manager/studentmanager"><i class="icon icon-th"></i> <span>学生管理</span></a>
            </li>
        </shiro:hasRole>
        <shiro:hasRole name="organization_manager">
            <li id="organization_manager"><a href="<%=ctx %>/manager/organizationmanager"><i class="icon icon-th"></i>
                <span>社团管理</span></a></li>
        </shiro:hasRole>
        <shiro:hasRole name="admin">
            <li id="system_manager" class="submenu"><a href="<%=ctx %>/manager/systemmonitor"><i
                    class="icon icon-th-list"></i>
                <span>系统管理</span></a>
                <ul>
                    <li><a href="<%=ctx %>/manager/systemmonitor">系统监测</a></li>
                    <li><a href="<%=ctx %>/manager/systemconfig">系统配置</a></li>
                </ul>
            </li>
        </shiro:hasRole>
        <shiro:hasRole name="admin">
            <li id="role_manager"><a href="<%=ctx %>/manager/rolemanager"><i class="icon icon-th"></i> <span>角色管理</span></a>
            </li>
        </shiro:hasRole>
        <shiro:hasRole name="admin">
            <li id="admin_manager"><a href="<%=ctx %>/manager/membermanager"><i class="icon icon-th"></i>
                <span>人员管理</span></a></li>
        </shiro:hasRole>
    </ul>
</div>
<!--左侧菜单栏结束 -->
<sitemesh:body/>
<!--Footer-part-->
<div class="row-fluid">
    <div id="footer" class="span12"> 2016 &copy; 社团集结号
    </div>
</div>
<!--end-Footer-part-->
</body>
</html>