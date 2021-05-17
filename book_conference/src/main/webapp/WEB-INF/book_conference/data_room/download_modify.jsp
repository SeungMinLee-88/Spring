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
function cancelmodify(){
	var Answer = confirm("취소 하시겠습니까??");
		if (Answer == true){ 
		location.href =
'./DownloadView?download_number='+${Dto.DOWNLOAD_NUM}+'&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>';
		}
}
function chgfilebox(fileboxid,chkboxval){
	var fileboxid = fileboxid;
	var chkboxval = chkboxval;
	var cssfileboxid= "#"+fileboxid; 
	if(document.getElementsByName(chkboxval)[0].checked ==true){
		 $("input[name="+fileboxid+"]").css('visibility', 'visible');
	}else if(document.getElementsByName(chkboxval)[0].checked ==false){
		 $("input[name="+fileboxid+"]").css('visibility', 'hidden');
	}
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
<form name="downloadform" action="./DownloadModifyProcess" method="post" enctype="multipart/form-data"  onsubmit="return downloadcheck()">
<table class="downloadwrite" width="600px" height="80%" align="center" border="0">
	<input type="hidden" name="page" value=<%=nowpage%>>
	<input type="hidden" name="searchtype" value="<%=searchtype%>">
	<input type="hidden" name="searchkeyword" value="<%=searchkeyword%>">
	<input type="hidden" name="download_number" value="${Dto.DOWNLOAD_NUM}">
	<tr>
	<td width="150px" bgcolor="#f5f5f5" rows="2" align="center">작성자  </td>
	<td>${Dto.DOWNLOAD_WRITER}</td>
	<tr>
	<td bgcolor="#f5f5f5" rows="2" align="center">제목 </td>
	<td>
	<input type="text" name="DOWNLOAD_TITLE" placeholder="제목을 입력해 주세요" style="width:100%; border: 0;" value="${Dto.DOWNLOAD_TITLE}">	
	</td>
	</tr>
	<tr>
	<td bgcolor="#f5f5f5" align="center">
	상단노출여부 
	</td>
	<td>
	<input type="checkbox" name="DOWNLOAD_TOP" value="y" <c:if test= "${Dto.DOWNLOAD_TOP =='y'}"> checked</c:if> >상단노출
	</td>
	</tr>
	<tr>
	<td bgcolor="#f5f5f5" align="center">내용 </td>
	<td>
	<textarea name="DOWNLOAD_CONTENT"  placeholder="내용을 입력해 주세요" rows=20 style="width:100%; height:100%; border: 0;">${Dto.DOWNLOAD_CONTENT} </textarea>	
	</td>
	</tr>

<%
List<String> realfilenamelist = Arrays.asList(((String)request.getAttribute("realfilenamelist")).split(","));
List<String> savefilenamelist = Arrays.asList(((String)request.getAttribute("savefilenamelist")).split(","));
for(int i=0, j=realfilenamelist.size();i<realfilenamelist.size();i++,j--){
%>
	<tr>
	<td bgcolor="#f5f5f5" align="center" height="25px">첨부파일<%=i+1 %></td>
	<td><input type="file" name="file<%=j%>" 
	 <%if(savefilenamelist.get(i).equals("null") || savefilenamelist.get(i).equals("") || savefilenamelist.get(i)==null){ %>
	 style="width:50%; height:100%; border: 0;">
	 <%}else{%>
	 style="visibility:hidden;width:50%; height:100%; border: 0;">
	 <%=realfilenamelist.get(i)%>
	<input type="checkbox" name="checkbox<%=i+1%>" id="checkbox<%=i+1%>" value="y" onclick="chgfilebox('file<%=j%>','checkbox<%=i+1%>');"/>삭제
	<input type="hidden" name="realname<%=i+1%>" id="realname=<%=i+1%>" value="<%=realfilenamelist.get(i)%>">
	<input type="hidden" name="savename<%=i+1%>" id="savename=<%=i+1%>" value="<%=savefilenamelist.get(i)%>">
	<%} %>
	 </td></tr>
	<tr>
<%
}
%>
	<tr>
	<td colspan="2" align="center">
	<div id="downloadul">
	<ul>
		<li><input type="image" src="./image/downloadimage/modify.png" value="submit" width="50px"></li>
		<li><a href="javascript:document.downloadform.reset()"><img src="./image/downloadimage/reset.png" width="70px"></a></li>
		<li><a href="javascript:cancelmodify()"><img src="./image/downloadimage/cancel.png" width="50px"></a></li>
		
	</ul>
		</div>
		</td>
	</tr>
</table>
</form>
</body>
</div>
</html>