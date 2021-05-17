<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<html>
<head>
<title>자료실</title>
</head>
<%
String user = (String)session.getAttribute("id");
String admin =(String)session.getAttribute("admin");
%>
<script>
function reset(){
	history.go(0);
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
function selecttype(){
	var checkedValue = $("input[type=radio][name=VIDEO_TYPE]:checked").val()
	if(checkedValue =="file"){
	$("#inputarea").val("");
	$("#inputarea").html('<input type="file" name="file1" style="width:60%; height:60%;  border: 0;">');
	}else if(checkedValue =="link"){
		$("#inputarea").val("");
		$("#inputarea").html('<input type="text" name="VIDEO_LINK" id="VIDEO_LINK" placeholder="영상타입을 선택 해주세요.">');
	}else{
		$("#inputarea").val("");
		$("#inputarea").html('<input type="text" name="VIDEO_LINK" id="VIDEO_LINK" placeholder="영상타입을 선택 해주세요.">');
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
<table border="0" width="700px"  style="margin-left:20px;">
	<tr>
	<td height="50px">
	<img id="topimage" src="./image/videoimage/video.jpg" width="700px" >
	</td>
	</tr>
</table>
<form name="videoform" action="./VideoWriteProcess" method="post" enctype="multipart/form-data" onsubmit="return videocheck()">
<table class="videowrite" width="600px" height="80%" align="center" border="0">
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
		<td><input type="text" name = "VIDEO_TITLE" placeholder="제목을 입력해 주세요" style="width:100%; border: 0; ">
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		상단노출여부 
		</td>
		<td>
		<input type="checkbox" name = "VIDEO_TOP" value="y" onclick="javascript:alert(document.getElementByName('VIDEO_TOP').value)">상단노출
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		내용 
		</td>
		<td>
		<textarea name = "VIDEO_CONTENT"  placeholder="내용을 입력해 주세요(20자 이상)" rows=20 style="width:100%; height:100%; border: 0;" ></textarea>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center" height="25px">영상자료</td>
		<td>
		<div id="inputarea" style="width:300px;">
		<input type="text" name="VIDEO_LINK" id="VIDEO_LINK" size="50" placeholder="영상타입을 선택 해주세요.">
		</div>
		<input type="radio" id="VIDEO_TYPE" name="VIDEO_TYPE" value="link" checked onclick="javascript:selecttype();"/>링크
		<input type="radio" id="VIDEO_TYPE" name="VIDEO_TYPE" value="file" onclick="javascript:selecttype();" />파일
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<div id="videoul">
	<ul>
			<li><input type="image" src="./image/videoimage/ok.png" value="submit" width="50px"></li>
			<li><a href="javascript:document.videoform.reset()"><img src="./image/videoimage/reset.png" width="70px"></a>
			<li><a href="javascript:cancel()"><img src="./image/videoimage/cancel.png" width="50px"></a></li>
	</ul>
	</div>
		</td>
	</tr>
</table>
</form>	
</body>
</div>
</html>