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
<script>
function cancelmodify(){
	var Answer = confirm("취소 하시겠습니까??");
		if (Answer == true){ 
		location.href =
'./NoticeView?notice_number='+${Dto.NOTICE_NUM}+'&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>';
		}
}
</script>
<html>
<head>
<title>공지사항</title>
</head>
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
<body>
<form name="noticeform" action="./NoticeModifyProcess" method="post" onsubmit="return noticecheck()">
<table class="noticewrite" width="600px" height="80%" align="center" border="0">
	<input type="hidden" name="page" value=<%=nowpage%>>
	<input type="hidden" name="searchtype" value="<%=searchtype%>">
	<input type="hidden" name="searchkeyword" value="<%=searchkeyword%>">
	<input type="hidden" name="NOTICE_NUM" value="${Dto.NOTICE_NUM}">
	<tr>
		<td width="150px" bgcolor="#f5f5f5" rows="2" align="center">작성자  </td>
		<td>${Dto.NOTICE_WRITER}</td>
		<tr>
		<td bgcolor="#f5f5f5" rows="2" align="center">제목 </td>
		<td>
		<input type="text" name="NOTICE_TITLE" placeholder="제목을 입력해 주세요" style="width:100%; border: 0;" value="${Dto.NOTICE_TITLE}">	
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		상단노출여부 
		</td>
		<td>
		<input type="checkbox" name="NOTICE_TOP" value="y" <c:if test= "${Dto.NOTICE_TOP =='y'}"> checked</c:if> >상단노출
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">내용 </td>
		<td>
		<textarea name = "NOTICE_CONTENT"  placeholder="내용을 입력해 주세요" rows=20 style="width:100%; height:100%; border: 0;">${Dto.NOTICE_CONTENT} </textarea>	
		</td>
	</tr>
	<tr>
	<td colspan="2" align="center">
	<div id="noticeul">
	<ul>
		<li><input type="image" src="./image/noticeimage/modify.png" value="submit" width="50px"></li>
		<li><a href="javascript:document.noticeform.reset()"><img src="./image/noticeimage/reset.png" width="70px"></a></li>
		<li><a href="javascript:cancelmodify()"><img src="./image/noticeimage/cancel.png" width="50px"></a></li>
		
	</ul>
		</div>
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>