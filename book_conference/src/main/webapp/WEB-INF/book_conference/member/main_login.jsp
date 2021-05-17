<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script language="JavaScript" src="./js/main.js" charset="utf-8"></script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
</head>
<%
	String user = (String)session.getAttribute("id");
	String admin = (String)session.getAttribute("admin");
%>
<% 
		if (user != null && admin != null){
			if(admin.equals("y")){
%>
				<script>
				location.href="./AdminReserve";
				alert("이미 로그인 되어있습니다.")
				</script> 
<%
			}else if(admin.equals("n")){
%>
				<script>
				location.href="./MemberReserve";
				alert("이미 로그인 되어있습니다.")
				</script> 
<%
			}else{
%>
				<script>
				location.href="./MemberReserve";
				alert("이미 로그인 되어있습니다.")
				</script> 
<%				
			}
%>        
<%
} else{}
%>
<script>
function openDeptList(){			
	var url="./DeptList?close=n"
	open(url, "confirm", "toolbar=no,location=no,"
						+"status=no,menubar=no,"
						+"scrollbars=yes,resizable=no,"
						+"width=410,height=800");
}
function openConfirmId(joinform){			
	var id=joinform.MEMBER_ID.value;
	var url="./MemberIDCheckAction.me?MEMBER_ID="+joinform.MEMBER_ID.value;
	if(id.length == 0){
		alert("아이디를 올바르게 입력해주세요.");
		joinform.MEMBER_ID.focus();
		return false;
	}
	open(url, "confirm", "toolbar=no,location=no,status=no,menubar=no,"+
						 "scrollbars=no,resizable=no,width=400,height=200");
}
function logincheck(){
	var id=loginform.MEMBER_ID.value;
	var pass=loginform.MEMBER_PW.value;
	if(id.length == 0){
		alert("아이디를 입력 해주세요.");
		loginform.MEMBER_ID.focus();
		return false;
	} 
	if(pass.length == 0){
		alert("패스워드를 입력 해주세요.");
		loginform.MEMBER_PW.focus();
		return false;
	}
	return true;
}
function openfindId(loginform){	
	var url="./MemberFind";
	open(url, "confirm", "toolbar=no,location=no,status=no,menubar=no,"+
						 "scrollbars=no,resizable=no,width=450px,height=300");
}
function openfindPw(loginform){	
	var url="./MemberFindPw";
	open(url, "confirm", "toolbar=no,location=no,status=no,menubar=no,"+
						 "scrollbars=no,resizable=no,width=470px,height=350");
}
</script>
<style type="text/css">
#login_content{
	height:700px;width: 960px;
	margin: 0 auto;
	overflow: hidden;
	text-align: center;
}
#login_image {
	margin-top:100px;
}
#loginform {
	width: 450px;height: 200px;
	border: 1px solid #999;
	margin-top:100px;
	display: inline-block;
	vertical-align: middle;
	text-align: center;
}
#logintop{
	width:300px;
	display:inline-block;
	margin-left:100px;
	margin-top:20px;
}
#loginbottom{
	margin-top:10px;
	border-top: 1px solid black;
	float:right;
	width:350px;
	margin-left:15px;
	margin-top:20px;
	display:inline-block;
}
#loginbottom  b {
	color:black;
	text-decoration:none;
	cursor:pointer
}
#loginbottom b:hover {
	color: red;
	cursor:pointer
}
</style>
<body>
<div id="login_content">
<div id="login_image">
<img src="./image/mettingroom/booklogin.jpg" width="600px"/>
</div>
<form action="MemberLogin" method="post" name="loginform" onsubmit="return logincheck()">
	<div id="loginform" style="vertical-align:middel;text-align:center;">

	<div id="logintop">
<table class="login" border="0" style="margin-top:10px;">
	<tr>
		<td width=103>
		<input type=text name="MEMBER_ID" placeholder="아이디"  align=center style="width: 170px" />
	    </td>
		<td width=66 rowspan=2 > 
		<input type="image" src="./image/formimage/ok.png" value="submit" style= "width: 50px;  margin-left:10px" ></td>
	<tr>
		<td><input type=password name="MEMBER_PW" placeholder="비밀번호" style="width: 170px"/></td>
	</tr>
</table>
	</div>
	<br>
<div id="loginbottom">
<table style="margin-left:15px; margin-top:20px;">
    <tr>
    	<td align="right">이용 신청을 하시겠습니까?</td>
    	<td><b onclick="javascript:openDeptList()">이용신청</b></td>
	</tr>
	<tr>
    	<td align="right">계정 정보를 잊어버리셨나요?</td>
		<td><b onclick="openfindPw(this.form)">PW찾기</b></td>
	</tr>
</table>
</div>
</div>
</form>
</body>
</html>