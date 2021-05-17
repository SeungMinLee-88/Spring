<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>자료실</title>
</head>
<%
int nowpage=1;
if(request.getParameter("page")!=null){
	nowpage=Integer.parseInt(request.getParameter("page"));
}
String searchtype = "";
if(request.getParameter("searchtype")!=null){
	searchtype = (String)request.getParameter("searchtype");
}
String searchkeyword ="";
if(request.getParameter("searchkeyword")!=null){
	searchkeyword = (String)request.getParameter("searchkeyword");
}
String user = (String)session.getAttribute("id");
String admin =(String)session.getAttribute("admin");
%>
<script>
function backlist() {
		location.href = "./VideoList?page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>";
}
function deleteconfirm(VIDEO_NUM){
	var video_number =VIDEO_NUM;
	var Answer = confirm("삭제하시겠습니까??");
		if (Answer == true){ 
	 	location.href = "./VideoDelete?video_number="+video_number+"&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>";
	}else {
		history(0);
	}		
}
</script>
<% 
		if (user == null && admin.equals("n")){
%>        
<script>
		alert("관리자만 작성 가능합니다.");
 		history.go(0);
</script>
 <%
}
%>
<style type="text/css">
#videoul > ul { 
	overflow: hidden; 
}
        
#videoul > ul > li {
	margin-top:20px;
	margin-left:10px;	
	display:inline;  
}

#data_form{
	margin-left:200px;
	margin-top: 40px;
	position:relative;
	display: inline-block;
	clear:both;
}
</style>
<div id="data_form">
<body>
<table border="0" width="700px"  style="margin-left:20px;">
	<tr>
	<td height="50px">
	<img id="topimage" src="./image/videoimage/video.jpg" width="700px" >
	</td>
	</tr>
</table>
<table class="videowrite" width="600px" height="80%" align="center" border="1">
	<tr>
		<td width="100px" bgcolor="#f5f5f5" rows="2" align="center">제목</td>
		<td colspan="3">
		${Dto.VIDEO_TITLE}
		</td>
	</tr>
	<tr>
		<td width="100px" bgcolor="#f5f5f5" rows="2" align="center">글번호 </td>
		<td width="200px">
		<input type="hidden" name="VIDEO_NUM" value="${DtoVIDEO_NUM}">	
		${Dto.VIDEO_NUM}
		</td>
		<td width="100px" bgcolor="#f5f5f5" align="center" >작성일자</td>		
		<td width="200px">
		${Dto.CREATE_DATE}
		</td>
	</tr>
	<tr>
		<td colspan="4" height="70%" valign=top >
		<pre id="pre">${Dto.VIDEO_CONTENT}</pre><br>
	<c:if test= "${Dto.VIDEO_TYPE =='link'}">
<iframe width="640" height="360" src="${Dto.VIDEO_LINK}" 
frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</c:if>
<c:if test= "${Dto.VIDEO_TYPE =='file'}">
<c:if test="${Dto.VIDEO_FILE !=null && Dto.VIDEO_FILE !='null' && Dto.VIDEO_FILE !='' }">
<video width="400" controls>
  <source src="${fileFullPath}" type="video/mp4">
  <source src="${fileFullPath}" type="video/ogg">
  Your browser does not support HTML5 video.
</video>
</c:if>
</c:if>
	</td>
	</tr>
	<tr>
	<td height="75px" colspan="4" align="center">
	<div id="videoul">
	<ul>		
<% 
if(user != null && admin.equals("y")){
%>	
	<li><a href="./VideoModify?video_number=${Dto.VIDEO_NUM}&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>"><img src="./image/videoimage/modify.png" width="50px"></a></li>
	<li><a href="#" onclick="deleteconfirm(${Dto.VIDEO_NUM})"><img src="./image/videoimage/delete.png" width="50px"></a></li>
<%
}
%>		
	<li><a href="#" onclick="backlist()"><img src="./image/videoimage/list.png" width="50px"></a></li>
	</ul>
	</div>
	</td>
	</tr>
</table>	
</body>
</div>
</html>