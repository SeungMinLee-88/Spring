<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호 찾기</title>
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
<body style="width:450px">

<div id="popuptop">
<table width="430px" height="50px">
	<tr><td>비밀번호 찾기</td></tr>
</table>
</div>
<form action="./MemberFindPwProcess" method="post" name="findform" onSubmit="return formSubmit();">
<table width="450px"border="0">
	<tr>
		<td colspan="2" height="80px">
		<div id="popupcontent">
		<font style="margin-left:5px; font-size:15px; font-weight: bold; color:FD005D"> 아이디와 이메일주소를 정확히 입력해주세요.</font>
		</div>
		</td>
	</tr>
</table>
<div id="popupbottom">
<table width="450px" border="0">

	<tr>
		<td height="40px">
		<font size="2" style="margin-left:10px;">아이디</font>
		</td>
		<td>
	<input type="text" name="MEMBER_ID" maxlength="12" size="14">
		</td>
	</tr>
	<tr>
		<td colspan="2" height="1"></td>
	</tr>
	<tr>
		<td height="40px">
		<font size="2" style="margin-left:10px;">이메일</font>
		</td>
		<td>
	<input type="text" name="MEMBER_EMAIL" maxlength="50" size="30">
		</td>
	</tr>
</table>
</div>
<table width="450px">
	<tr>
		<td height="70px" colspan="2" align="center">
		<input type="image" src="./image/formimage/ok.png" value="submit" style="width:60px;"/>
		</td>
	</tr>	
</table>
</form>	
</body>
</html>