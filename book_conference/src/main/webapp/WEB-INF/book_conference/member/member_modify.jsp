<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.book_conference.member.dto.MemberContentDto"%>
<!-- 회원 정보 수정 폼 -->
<%
	HttpSession sesseion=request.getSession(true);
	String id=(String)sesseion.getAttribute("id");
	MemberContentDto Dto=(MemberContentDto)request.getAttribute("Dto");
	String MEMBER_EMAIL= Dto.getMEMBER_EMAIL();
	String[] email=MEMBER_EMAIL.split("@");
%>
<html>
<head>
<title>회원정보 수정</title>
<link rel="stylesheet" href="/movie/CSS/StyleSheet.css" />
<link rel="stylesheet" href="/movie/Login/Dtocss" />
<script language="JavaScript" src="/movie/js/script.js" charset="euc-kr"></script>
</head>
<script>
function openDeptList(){
	var url="./ModiDeptList?close=n"
	open(url, "confirm", "toolbar=no,location=no,"
						+"status=no,menubar=no,"
						+"scrollbars=yes,resizable=no,"
						+"width=380,height=600");
}
function infocheck(){
	var name=modiform.MEMBER_NAME.value;
	var pass1=modiform.MEMBER_PW.value;
	var pass2=modiform.MEMBER_PW2.value;
	var email1=modiform.MEMBER_EMAIL1.value;
	var email2=modiform.MEMBER_EMAIL2.value;
	if ((name=="")||(name.length <3)){
		alert("이름을 올바르게 입력해주세요.");
		modiform.MEMBER_NAME.focus();
		return false;
	
	if(pass1.length <3 ){
		alert("비밀번호를 올바르게 입력해주세요.)");
		modiform.MEMBER_PW.focus();
		return false;
	}
	if(pass1 != pass2){
		alert("비밀번호 확인을 올바르게 입력해주세요.");
		modiform.MEMBER_PW.value="";
		modiform.MEMBER_PW2.value="";
		modiform.MEMBER_PW.focus();
		return false;
	} 				 
	if(email1.length < 1 || email2.length < 1){
		alert("이메일을 올바르게 입력해주세요.");
		modiform.MEMBER_EMAIL1.focus();
		return false;
	}
	return true;
}
</script>
<body>
<%
	String user = (String)session.getAttribute("id");
%>
<style type="text/css">
#content {
	min-height:80%;
    width: 960px; margin: 0 auto;
	overflow: hidden;
	margin-top:50px;
}
#membertop{
	text-align:center;
}
#membertableform {
align:center;
	border: 2px solid E8F8EB;
	width: 700px;
	margin-top: 30px;
	margin:0 auto;
}	
#membertableform   a {
	color:black;
	text-decoration:none;
}
#membertableform a:hover {
	color: red;} </style>
<div id="content">
<div id="membertop">
<img src="./image/memberimage/memberinfo.png" width="500px" >
</div>
<div id="membertableform">
<form name="modiform" action="./MemberModifyProcess" method="post" onsubmit="return infocheck()">
<table class="membertable" width="600px" height="700px"  align="center" border="0" >
	<tr>
		<td width="17%" bgcolor="#f5f5f5" align="center" >이름</td>
		<td><input type="text" name="MEMBER_NAME" size="20" value="${Dto.MEMBER_NAME }" /></td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center"  align="center">ID</td>
		<td>
		<font style="margin-left:20px; font-size:15px;">${Dto.MEMBER_ID}</font> 	
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">부서</td>
		<td>
		<input type="text" name="MEMBER_DEPTNAME" size="24" value="${Dto.MEMBER_DEPTNAME}" readonly/>
		<input type="hidden" name="MEMBER_DEPTCODE" size="24" value="${Dto.MEMBER_DEPTCODE}" />
		<a href="#" onclick="javascript:openDeptList()">부서선택</a>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">이메일 주소</td>
		<td>	
		<input type="text" name="MEMBER_EMAIL1" size="13" 
	value="<%=email[0].trim() %>" />  <font style="position:absolute; margin-left:5px; margin-top:5px;">@</font>
		<input type="text" name="MEMBER_EMAIL2" size="13" value="<%=email[1].trim() %>" style="margin-left:25px;"/>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center" align="center">비밀번호</td>
		<td>
		<input type="password" name="MEMBER_PW" size="15"/></td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">비밀번호 확인</td>
		<td><input type="password" name="MEMBER_PW2" size="15" /></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
		<input type="image" src="./image/memberimage/ok.png" value="submit" style= "width: 70px; height: 50px;"/>
		</td>
	</tr>
</table>
</form>
</div>
</div>
</body>
</html>