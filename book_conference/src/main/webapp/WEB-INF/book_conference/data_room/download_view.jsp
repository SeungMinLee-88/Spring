<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.*"%>
<head>
<title>공지사항</title>
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
<html>
<script>
function backlist() {
		location.href = "./DownloadList?page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>";
}
function deleteconfirm(DOWNLOAD_NUM){
	var download_number =DOWNLOAD_NUM;
	var Answer = confirm("삭제하시겠습니까??");
		if (Answer == true){ 
	 	location.href = "./DownloadDelete?download_number="+download_number+"&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>";
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
#downloadul > ul { 
	overflow: hidden; 
}
#downloadul > ul > li {
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
	<img id="topimage" src="./image/downloadimage/download.jpg" width="700px" >
	</td>
	</tr>
</table>

<table class="downloadwrite" width="600px" height="80%" align="center" border="1">

	<tr>
	<td width="100px" bgcolor="#f5f5f5" rows="2" align="center">제목</td>
	<td colspan="3">
	${Dto.DOWNLOAD_TITLE}
	</td>
	</tr>
	<tr>
	<td width="100px" bgcolor="#f5f5f5" rows="2" align="center">글번호 </td>
	<td width="200px">
	<input type="hidden" name="DOWNLOAD_NUM" value="${DtoDOWNLOAD_NUM}">	
	${Dto.DOWNLOAD_NUM}
	</td>
	<td width="100px" bgcolor="#f5f5f5" align="center" >작성일자</td>		
	<td width="200px">
	${Dto.CREATE_DATE}
	</td>
	</tr>
	<tr>
	<td colspan="4" height="70%" valign=top >
	<pre id="pre">${Dto.DOWNLOAD_CONTENT}</pre>
	</td>
</tr>
	<tr>
	<td width="100px" bgcolor="#f5f5f5" rows="2" align="center">첨부파일</td>
	
	<td colspan="3">
<%
List<String> realfilenamelist = Arrays.asList(((String)request.getAttribute("realfilenamelist")).split(","));
List<String> savefilenamelist = Arrays.asList(((String)request.getAttribute("savefilenamelist")).split(","));
for(int i=0;i<realfilenamelist.size();i++){
	if(!savefilenamelist.get(i).equals("null")){
%>
<a href="./FileDownload?filename=<%=savefilenamelist.get(i)%>&downname=<%=realfilenamelist.get(i)%>">
<%=realfilenamelist.get(i)%></a><br>
<%
	}
}
%>
	</td>
	</tr>
	<tr>
	<td height="75px" colspan="4" align="center">
	<div id="downloadul">
	<ul>		
<% 
if(user != null && admin.equals("y")){
%>	
	<li><a href="./DownloadModify?download_number=${Dto.DOWNLOAD_NUM}&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>">
	<img src="./image/downloadimage/modify.png" width="50px"></a></li>
	<li><a href="#" onclick="deleteconfirm(${Dto.DOWNLOAD_NUM})">
	<img src="./image/downloadimage/delete.png" width="50px"></a></li>
<%
}
%>		
	<li><a href="#" onclick="backlist()"><img src="./image/downloadimage/list.png" width="50px"></a></li>
	</ul>
	</div>
	</td>
	</tr>
</table>
</body>
</div>	
</html>