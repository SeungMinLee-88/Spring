<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
<script>
function reset(){
	history.go(0);
}
</script>
<%
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
<title>자료실</title>
</head>
<script>
function cancel(){
	var Answer = confirm("취소하시겠습니까?");
 		if (Answer == true){ 
 		location.href="./DownloadList";
 	}
 }
function downloadcheck(){
	var title=downloadform.DOWNLOAD_TITLE.value;
	var content=downloadform.DOWNLOAD_CONTENT.value;	
	if ((title=="")||(title<=1)){
		alert("제목을 올바르게입력 해주세요.");
		downloadform.DOWNLOAD_TITLE.focus();
         return false;
	}
	if(content.length < 1){
		alert("내용을 올바르게입력 해주세요.)");
		downloadform.DOWNLOAD_CONTENT.focus();
		return false;
	}
	return true;
}
</script>
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

<form name="downloadform" action="./DownloadWriteProcess" method="post" enctype="multipart/form-data" onsubmit="return downloadcheck()">
<table class="downloadwrite" width="600px" height="80%" align="center" border="0">
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
		<td><input type="text" name = "DOWNLOAD_TITLE" placeholder="제목을 입력해 주세요" style="width:100%; border: 0; ">
		</td>
	</tr>
		<tr>
		<td bgcolor="#f5f5f5" align="center">
		상단노출여부 
		</td>
		<td>
		<input type="checkbox" name = "DOWNLOAD_TOP" value="y" onclick="javascript:alert(document.getElementByName('DOWNLOAD_TOP').value)">상단노출
		</td>
	</tr>
		<tr>
		<td bgcolor="#f5f5f5" align="center">
		내용 
		</td>
		<td>
		<textarea name = "DOWNLOAD_CONTENT"  placeholder="내용을 입력해 주세요(20자 이상)" rows=20 style="width:100%; height:100%; border: 0;" ></textarea>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center" height="25px">첨부파일1</td>
		<td><input type="file" name="file3" style="width:100%; height:100%; border: 0;"></td></tr>
		<tr>
		<td bgcolor="#f5f5f5" align="center" height="25px">첨부파일2</td>
		<td><input type="file" name="file2" style="width:100%; height:100%;  border: 0;"></td></tr>
		
	<tr>
		<td bgcolor="#f5f5f5" align="center" height="25px">첨부파일3</td>
		<td><input type="file" name="file1" style="width:100%; height:100%;  border: 0;"></td>
	</tr>

	<tr>
	<td colspan="2" align="center">
	<div id="downloadul">
	<ul>
		<li><input type="image" src="./image/downloadimage/ok.png" value="submit" width="50px"></li>
		<li><a href="javascript:document.downloadform.reset()"><img src="./image/downloadimage/reset.png" width="70px"></a>
		<li><a href="javascript:cancel()"><img src="./image/downloadimage/cancel.png" width="50px"></a></li>
	</ul>
</div>
	</td>
	</tr>
</table>
</form>
</body>
</div>
</html>