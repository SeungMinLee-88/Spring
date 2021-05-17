<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<%
String user = (String)session.getAttribute("id");
String admin =(String)session.getAttribute("admin");
%>
<head>
<script>
function reset(){
	history.go(0);
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
<body>
<table border="0" width="700px"  style="margin-left:20px;">
	<tr>
	<td height="50px">
	<img id="topimage" src="./image/noticeimage/noticelist.png" width="700px" >
	</td>
	</tr>
</table>
<form name="noticeform" action="./NoticeWriteProcess" method="post" onsubmit="return noticecheck()">
<table class="noticewrite" width="600px" height="80%" align="center" border="0">
	<tr>
		<td width="150px" bgcolor="#f5f5f5" rows="2" align="center">
		작성자  
		</td>
		<td>
		<%=user %>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" rows="2" align="center">
		제목 
		</td>
		<td><input type="text" name="NOTICE_TITLE" placeholder="제목을 입력해 주세요" style="width:100%; border: 0; ">
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		상단노출여부 
		</td>
		<td>
		<input type="checkbox" name="NOTICE_TOP" value="y" onclick="javascript:alert(document.getElementByName('NOTICE_TOP').value)">상단노출
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		내용 
		</td>
		<td>
		<textarea name = "NOTICE_CONTENT"  placeholder="내용을 입력해 주세요(20자 이상)" rows=20 style="width:100%; height:100%; border: 0;" ></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<div id="noticeul">
		<ul>
		<li><input type="image" src="./image/noticeimage/ok.png" value="submit" width="50px"></li>
		<li><a href="javascript:document.noticeform.reset()"><img src="./image/noticeimage/reset.png" width="70px"></a>
		<li><a href="javascript:cancel()"><img src="./image/noticeimage/cancel.png" width="50px"></a></li>
		</ul>
		</div>
		</td>
	</tr>
</table>
</form>
</body>
</div>	
</html>