<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회의실 예약</title>
</head>
<%
String roomnum = "";
if(request.getParameter("roomnum")== null){
	roomnum = "ROOMA";
}else{
	roomnum = (String)request.getParameter("roomnum");
}
String user = (String)session.getAttribute("id");
%>
<script>
function reservecheck(){
	var bookdate=bookform.BOOK_DATE.value;
	var bookreason=bookform.BOOK_REASON.value;
	var booktime = document.getElementsByName("BOOK_TIME");
	var booktimeChk=false;
	if ((bookdate=="")){
		alert("예약 일자를 선택해주세요.");
         	return false;
	}
	if ((bookreason=="")){
		alert("예약 사유를 입력해주세요.");
         	return false;
	}
	for(var i=0;i<booktime.length;i++){
		if(booktime[i].checked == true) {
		booktimeChk = true;
			break;
		}
	}
	if(!booktimeChk){
		alert("예약시간을 선택해주세요.");
			return false;
	}
	return true;
}
</script>
<style type="text/css">
input[class="checkbar"] + label {
	display: inline-block;
	width: 100%;
	height: 100%;
	border:1px solid #D8D8D8;
	background-color: #FFFFFF;
	cursor: pointer;
}
input[class="checkbar"]:checked + label {
	background-color: #A4A4A4;
}
input[class="checkbar"] {
	display: none;
}
#member_form{
	margin-left:200px;
	margin-top: 40px;
	position:relative;
	display: inline-block;
}
</style>
<body>
<div id="member_form">
<iframe name="frame"  width="1200px" height="780px" src="./MemberRoomBookCalendar?roomnum=<%=roomnum %>" scrolling="auto" frameborder="0">
</iframe>
<form name="bookform" action="./MemberBookWrite" method="post" onsubmit="return reservecheck()">
<input type="hidden" name="roomnum" value="<%=roomnum%>">
<div id="book_content" align="center" style="width:850px;">
<table width="700px"  style="margin-left:20px;"  align="center" border="0">
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		예약일자 : 
		</td>
		<td>
		<input type="text" name="BOOK_DATE" style="width:100%; border: 0;">
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		예약자
		</td>
		<td>
		<input type="hidden" name="BOOK_MEMBER" value="<%=user%>">
		<b style="margin-left:20px;"><%=user%></b>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		예약사유
		</td>
		<td>
		<textarea name="BOOK_REASON" rows=5 style="width:100%; height:100%; border: 0;"></textarea>
		</td>
	</tr>
</table>
<table width="900px"  style="margin-left:20px;border-collapse: collapse;"  align="center" border="0">
	<tr>
		<td bgcolor="#f5f5f5" align="center" colspan="8">
		예약시간
		</td>
	</tr>
	<tr>
		<td height="30px">
		<input type="checkbox" class="checkbar" name="BOOK_TIME" id="A" value="A"/>
		    <label for="A" id="Alabel" style="text-align:center;vertical-align:middle;font-size:12px;">
		    09:00 ~ 10:00
		    </label>
			</td>
			<td height="30px">
			<input type="checkbox" class="checkbar" name="BOOK_TIME" id="B" value="B"/>
		    <label for="B" id="Blabel" style="text-align:center;vertical-align:middle;font-size:12px;">
		    10:00 ~ 11:00</label>
			</td>
			<td height="30px">
			<input type="checkbox" class="checkbar" name="BOOK_TIME" id="C" value="C"/>
		    <label for="C" id="Clabel" style="text-align:center;vertical-align:middle;font-size:12px;">
		    11:00 ~ 12:00</label>
			</td>
			<td height="30px">
			<input type="checkbox" class="checkbar" name="BOOK_TIME" id="D" value="D"/>
		    <label for="D" id="Dlabel" style="text-align:center;vertical-align:middle;font-size:12px;">
		    13:00 ~ 14:00</label>
			</td>
			<td height="30px">
			<input type="checkbox" class="checkbar" name="BOOK_TIME" id="E" value="E"/>
		    <label for="E" id="Elabel" style="text-align:center;vertical-align:middle;font-size:12px;">
		    14:00 ~ 15:00</label>
			</td>
			<td height="30px">
			<input type="checkbox" class="checkbar" name="BOOK_TIME" id="F" value="F"/>
		    <label for="F" id="Flabel" style="text-align:center;vertical-align:middle;font-size:12px;">
		    15:00 ~ 16:00</label>
			</td>
			<td height="30px">
			<input type="checkbox" class="checkbar" name="BOOK_TIME" id="G" value="G"/>
		    <label for="G" id="Glabel" style="text-align:center;vertical-align:middle;font-size:12px;">
		    16:00 ~ 17:00</label>
			</td>
			<td height="30px">
			<input type="checkbox" class="checkbar" name="BOOK_TIME" id="H" value="H"/>
		    <label for="H" id="Hlabel" style="text-align:center;vertical-align:middle;font-size:12px;">
		    17:00 ~ 18:00</label>
			</td>
	</tr>
 </table>
<table width="700px"  style="margin-left:20px;"  align="center" border="0">
	<tr>
		<td align="center" colspan="3">
		<input type="image" src="./image/formimage/ok.png" value="submit" width="50px" style="margin-top:20px;">
		</td>
	</tr>
</table>
</div>
</form>
</div>
</body>
</html>