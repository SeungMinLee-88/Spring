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
	var Answer = confirm("��� �Ͻðڽ��ϱ�??");
		if (Answer == true){ 
		location.href =
'./NoticeView?notice_number='+${Dto.NOTICE_NUM}+'&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>';
		}
}
</script>
<html>
<head>
<title>��������</title>
</head>
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
<script>
function cancel(){
	var Answer = confirm("����Ͻðڽ��ϱ�?");
 		if (Answer == true){ 
 		location.href="./NoticeList";
 	}
 }
function noticecheck(){
	var title=noticeform.NOTICE_TITLE.value;
	var content=noticeform.NOTICE_CONTENT.value;	
	if ((title=="")||(title<=1)){
		alert("������ �ùٸ����Է� ���ּ���.");
		noticeform.NOTICE_TITLE.focus();
         return false;
	}
	if(content.length < 1){
		alert("������ �ùٸ����Է� ���ּ���.)");
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
		<td width="150px" bgcolor="#f5f5f5" rows="2" align="center">�ۼ���  </td>
		<td>${Dto.NOTICE_WRITER}</td>
		<tr>
		<td bgcolor="#f5f5f5" rows="2" align="center">���� </td>
		<td>
		<input type="text" name="NOTICE_TITLE" placeholder="������ �Է��� �ּ���" style="width:100%; border: 0;" value="${Dto.NOTICE_TITLE}">	
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		��ܳ��⿩�� 
		</td>
		<td>
		<input type="checkbox" name="NOTICE_TOP" value="y" <c:if test= "${Dto.NOTICE_TOP =='y'}"> checked</c:if> >��ܳ���
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">���� </td>
		<td>
		<textarea name = "NOTICE_CONTENT"  placeholder="������ �Է��� �ּ���" rows=20 style="width:100%; height:100%; border: 0;">${Dto.NOTICE_CONTENT} </textarea>	
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