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
		alert("�����ڸ� �ۼ� �����մϴ�.");
 		history.go(0);
</script>
 <%
}
%>
<title>�ڷ��</title>
</head>
<script>
function cancel(){
	var Answer = confirm("����Ͻðڽ��ϱ�?");
 		if (Answer == true){ 
 		location.href="./DownloadList";
 	}
 }
function downloadcheck(){
	var title=downloadform.DOWNLOAD_TITLE.value;
	var content=downloadform.DOWNLOAD_CONTENT.value;	
	if ((title=="")||(title<=1)){
		alert("������ �ùٸ����Է� ���ּ���.");
		downloadform.DOWNLOAD_TITLE.focus();
         return false;
	}
	if(content.length < 1){
		alert("������ �ùٸ����Է� ���ּ���.)");
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
		�ۼ���  
		</td>
		<td>
		<%=user %>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" rows="2" align="center">
		���� 
		</td>
		<td><input type="text" name = "DOWNLOAD_TITLE" placeholder="������ �Է��� �ּ���" style="width:100%; border: 0; ">
		</td>
	</tr>
		<tr>
		<td bgcolor="#f5f5f5" align="center">
		��ܳ��⿩�� 
		</td>
		<td>
		<input type="checkbox" name = "DOWNLOAD_TOP" value="y" onclick="javascript:alert(document.getElementByName('DOWNLOAD_TOP').value)">��ܳ���
		</td>
	</tr>
		<tr>
		<td bgcolor="#f5f5f5" align="center">
		���� 
		</td>
		<td>
		<textarea name = "DOWNLOAD_CONTENT"  placeholder="������ �Է��� �ּ���(20�� �̻�)" rows=20 style="width:100%; height:100%; border: 0;" ></textarea>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center" height="25px">÷������1</td>
		<td><input type="file" name="file3" style="width:100%; height:100%; border: 0;"></td></tr>
		<tr>
		<td bgcolor="#f5f5f5" align="center" height="25px">÷������2</td>
		<td><input type="file" name="file2" style="width:100%; height:100%;  border: 0;"></td></tr>
		
	<tr>
		<td bgcolor="#f5f5f5" align="center" height="25px">÷������3</td>
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