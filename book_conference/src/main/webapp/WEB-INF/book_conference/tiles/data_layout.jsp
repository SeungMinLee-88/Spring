<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<html>

<head>
<meta charset="UTF-8">

<tiles:insertAttribute name="header" />
</head>
<body>
		<tiles:insertAttribute name="dataaside"/>
		<tiles:insertAttribute name="content"/>


</body>
<tiles:insertAttribute name="footer" />
</html>
