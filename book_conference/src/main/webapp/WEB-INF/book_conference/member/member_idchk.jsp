<%@ page contentType="text/html; charset=euc-kr" %>
<%
	String id=(String)request.getAttribute("id");
	int check=((Integer)(request.getAttribute("check"))).intValue();
%>
<html>
<head>
<title>아이디 중복확인</title>
<link rel="stylesheet" href="/movie/CSS/StyleSheet.css" />
<link rel="stylesheet" href="/movie/Login/member.css" />
<script language="JavaScript" src="/movie/js/script.js" charset="euc-kr"></script>
<script>
function windowclose(){
	opener.document.applyform.MEMBER_ID.value="<%=id %>";
	self.close();
}
</script>
</head>
<style type="text/css">
#popuptop{
	width:450px;
	height:50px;
	margin-top:10px;
	background: #088A08;

}
#popuptop > table{
	font-weight: bold;
	font-size:15px;
	color:#F7F1E0;

}
#popupbottom {
	background:#F7F1E0;
}
</style>
<body style="width:400px">
<div id="popuptop" style="width:400px; 	margin-top:0px;">
<table width="400px" height="50px">
	<tr><td>아이디 중복 체크</td></tr>
</table>
</div>
<% if(check >= 1){ %>
<form action="./MemberIDCheck" method="post" name="checkForm" >
<div id="popupbottom">
<table width="400px" height="20px" border="0">
	<tr>
		<td height="30px" colspan="2" align="center">
		<font style="margin-right:30px; font-size:15px; font-weight: bold; color:FD005D;"><%=id %> 는 이미 사용 중인 아이디입니다.</font>
		</td>
	</tr>
</table>
</div>	
<table width="400px" height="110px" border="0">
	<tr>
		<td align="center" colspan="2">
		<font style="font-size:12px; ;margin-left:10px; ">다른 아이디를 입력하세요.</font>   
		</td>
	</tr>
	<tr>
		<td align="right">
		<input type="text" size="12" maxlength="12" name="MEMBER_ID" style="margin-right:10px;"></td>
		<td align="left">	
		<input type="image" src="./image/formimage/findid2.png" value="submit" style=" margin-right:50px; width:70px" >			
		</td>					
	</tr>
</table>
</form>
<% }else{ %>
<table width="450px">
	<tr>
		<td align="center"  height="80px" bgcolor="F7F1E0">
		<font style="margin-right:30px; font-size:15px; font-weight: bold;">입력하신 <%=id %> 는 사용할 수 있는 아이디입니다.</font>
		</td>
	</tr>
	<tr>
		<td align="center">
		<input type="image" src="./image/formimage/close.png" onclick="windowclose()" value="submit" style="margin-right:60px;width:50px" >				
	</tr>
</table>
<% } %>
</body>
</html>