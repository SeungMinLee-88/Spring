<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
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
 		location.href="./VideoList";
 	}
 }
function videocheck(){
	var title=videoform.VIDEO_TITLE.value;
	var content=videoform.VIDEO_CONTENT.value;	

	if ((title=="")||(title<=1)){
		alert("제목을 올바르게입력 해주세요.");
		videoform.VIDEO_TITLE.focus();
         return false;

	}
	if(content.length < 1){
		alert("내용을 올바르게입력 해주세요.)");
		videoform.VIDEO_CONTENT.focus();
		return false;
	}
	return true;
}
function cancelmodify(){
	var Answer = confirm("취소 하시겠습니까??");
		if (Answer == true){ 
		location.href =
'./VideoView?video_number='+${Dto.VIDEO_NUM}+'&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>';
		}
}
function selecttype(){
	var checkedValue = $("input[type=radio][name=VIDEO_TYPE]:checked").val()
	alert(checkedValue);
	if(checkedValue =="file"){
		var innerHTML='';
		innerHTML +=
		'<input type="file" name="file1" style="width:100%; height:60%;  border: 0;">';
		$("#inputarea").val("");
		$("#inputarea").html(innerHTML);
		$("#filearea").css('display', 'block');
	}else if(checkedValue =="link"){
		$("#inputarea").val("");
		$("#inputarea").html('<input type="text" value="${Dto.VIDEO_LINK}" size="25" name="VIDEO_LINK" id="VIDEO_LINK" placeholder="영상타입을 선택 해주세요.">');
		$("#filearea").css('display', 'none');
	}else{
		$("#inputarea").val("");
		$("#inputarea").html('<input type="text" value="${Dto.VIDEO_LINK}" size="25" name="VIDEO_LINK" id="VIDEO_LINK" placeholder="영상타입을 선택 해주세요.">');
	}
 }
</script>
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
<form name="videoform" action="./VideoModifyProcess" method="post" enctype="multipart/form-data"  onsubmit="return videocheck()">
<table class="videowrite" width="800px" height="80%" align="center" border="0">
		<input type="hidden" name="page" value=<%=nowpage%>>
		<input type="hidden" name="searchtype" value="<%=searchtype%>">
		<input type="hidden" name="searchkeyword" value="<%=searchkeyword%>">
		<input type="hidden" name="video_number" value="${Dto.VIDEO_NUM}">
	<tr>
		<td width="150px" bgcolor="#f5f5f5" rows="2" align="center">작성자  </td>
		<td>${Dto.VIDEO_WRITER}</td>
	<tr>
		<td bgcolor="#f5f5f5" rows="2" align="center">제목 </td>
		<td>
		<input type="text" name="VIDEO_TITLE" placeholder="제목을 입력해 주세요" style="width:100%; border: 0;" value="${Dto.VIDEO_TITLE}">	
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		상단노출여부 
		</td>
		<td>
		<input type="checkbox" name="VIDEO_TOP" value="y" <c:if test= "${Dto.VIDEO_TOP =='y'}"> checked</c:if> >상단노출
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">내용 </td>
		<td>
		<textarea name="VIDEO_CONTENT"  placeholder="내용을 입력해 주세요" rows=20 style="width:100%; height:100%; border: 0;">${Dto.VIDEO_CONTENT} </textarea>	
		</td>
	</tr>
<%
String videotype ="";
if(request.getAttribute("videotype")!=null && request.getAttribute("videotype") !=""){
	videotype = (String)request.getAttribute("videotype");
}
%>
	<tr>
		<td bgcolor="#f5f5f5" align="center" height="25px">영상자료</td>
		<td>
		<div id="inputarea" style="width:200px;float:left">
		<%if(videotype.equals("file")){%>
		<input type="file" name="file1" style="width:100%; height:60%;  border: 0;">
		<%}else if(videotype.equals("link")){ %>
		<input type="text" name="VIDEO_LINK" size="25" value ="${Dto.VIDEO_LINK}"id="VIDEO_LINK" placeholder="영상 링크를 입력해주세요.">
		<%} %>
		</div>
		<c:if test="${Dto.VIDEO_FILE !=null && Dto.VIDEO_FILE !='null' && Dto.VIDEO_FILE !='' }">
		<div id="filearea" style="width:150px;float:left;">
		${Dto.VIDEO_FILENAME}
		<input type="checkbox" name="checkbox1" id="checkbox1" value="y"/>삭제
		</div>
		</c:if>
		<input type="hidden" name="realname1" id="realname1" value="${Dto.VIDEO_FILENAME}">
		<input type="hidden" name="savename1" id="savename1" value="${Dto.VIDEO_FILE}">
		<input type="radio" id="VIDEO_TYPE" name="VIDEO_TYPE" value="link" onclick="javascript:selecttype();"
		<%if(videotype.equals("link")){%> checked
		<%}else{}%>/>링크
		<input type="radio" id="VIDEO_TYPE" name="VIDEO_TYPE" value="file" onclick="javascript:selecttype();"
		<%if(videotype.equals("file")){%> checked
		<%}else{}%>/>파일
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
	<div id="videoul">
	
	<ul>
		<li><input type="image" src="./image/videoimage/modify.png" value="submit" width="50px"></li>
		<li><a href="javascript:document.videoform.reset()"><img src="./image/videoimage/reset.png" width="70px"></a></li>
		<li><a href="javascript:cancelmodify()"><img src="./image/videoimage/cancel.png" width="50px"></a></li>
		
	</ul>
		</div>
		</td>
	</tr>
</table>
</form>
</body>
</div>
</html>