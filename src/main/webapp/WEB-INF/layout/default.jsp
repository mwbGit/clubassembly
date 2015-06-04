<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<head>
    <title><sitemesh:title/></title>
    <sitemesh:head/>
</head>
<body style="background-color: #d8d6d3">
<jsp:include page="header.jsp"/>
<sitemesh:body/>
<jsp:include page="footer.jsp"/>
</body>
</html>