<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<head>
<link rel="stylesheet" href="/movie/CSS/StyleSheet.css" />
<link rel="stylesheet" href="/movie/notice/notice.css" />
<script language="JavaScript" src="/movie/js/script.js" charset="euc-kr"></script>
<script language="JavaScript" src="/movie/notice/notice.js" charset="euc-kr"></script>
<script>
function backlist() {
		location.href = "./NoticeList?page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>";
}
function deleteconfirm(NOTICE_NUM){
	var notice_number =NOTICE_NUM;
	var Answer = confirm("삭제하시겠습니까??");
		if (Answer == true){ 
	 	location.href = "./NoticeDelete?notice_number="+notice_number+"&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>";
	}else {
		history(0);
	}		
}
</script>
<title>공지사항</title>
</head>
<body>
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
<script>
function cancel(){
	var Answer = confirm("취소하시겠습니까?");
 		if (Answer == true){ 
 		location.href="./NoticeList";
 	}
 }
function noticecheck(){
	var title=noticeform.NOTICE_TITLE.value;
	var content=noticeform.NOTICE_CONTENT.value;	
	if ((title=="")||(title<=1)){
		alert("제목을 올바르게입력 해주세요.");
		noticeform.NOTICE_TITLE.focus();
         return false;
	}
	if(content.length < 1){
		alert("내용을 올바르게입력 해주세요.)");
		noticeform.NOTICE_CONTENT.focus();
		return false;
	}
	return true;
}
</script>
<style type="text/css">
#noticeul > ul { 
	overflow: hidden; 
 }     
#noticeul > ul > li {
	margin-top:20px;
	margin-left:10px;	
	display:inline;  
}
#notice_form{
	margin-left:200px;
	margin-top: 40px;
	position:relative;
	display: inline-block;
	clear:both;
}
 </style>
<div id="notice_form">
<table border="0" width="700px"  style="margin-left:20px;">
	<tr>
		<td height="50px">
		<img id="topimage" src="./image/noticeimage/noticelist.png" width="700px" >
		</td>
	</tr>
</table>
<table class="noticewrite" width="600px" height="80%" align="center" border="1">
	<tr>
		<td width="100px" bgcolor="#f5f5f5" rows="2" align="center">제목</td>
		<td colspan="3">
		<div id="noticecontent">
		${Dto.NOTICE_TITLE}
		</div>
		</td>
	</tr>
	<tr>
	<td width="100px" bgcolor="#f5f5f5" rows="2" align="center">글번호 </td>
		<td width="200px">
		<div id="noticecontent">
		<input type="hidden" name="BOARD_NUM" value="${DtoNOTICE_NUM}">	
		${Dto.NOTICE_NUM}
		</div>
		</td>
		<td width="100px" bgcolor="#f5f5f5" align="center" >작성일자</td>		
		<td width="200px">
		<div id="noticecontent">
		${Dto.CREATE_DATE}
		</div>
		</td>
	</tr>
	<tr>
		<td colspan="4" height="70%" valign=top >
		<div id="noticecontent">
		<pre id="pre">${Dto.NOTICE_CONTENT}</pre>
		</div>
		</td>
	</tr>
	<tr>
		<td height="75px" colspan="4" align="center">
		<div id="noticeul">
		<ul>		
<% 
if(user != null && admin.equals("y")){
%>	
		<li><a href="./NoticeModify?notice_number=${Dto.NOTICE_NUM}&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>"><img src="./image/noticeimage/modify.png" width="50px"></a></li>
		<li><a href="#" onclick="deleteconfirm(${Dto.NOTICE_NUM})"><img src="./image/noticeimage/delete.png" width="50px"></a></li>
<%
}
%>		
		<li><a href="#" onclick="backlist()"><img src="./image/noticeimage/list.png" width="50px"></a></li>
		</ul>
		</div>
		</td>
	</tr>
</table>
</div>
</body>
</html>