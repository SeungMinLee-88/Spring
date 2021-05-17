<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<%@ page import="com.book_conference.memberreserve.dto.RoomDto"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.StringTokenizer" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 예약 수정</title>
</head>
<%  
	RoomDto Dto=(RoomDto)request.getAttribute("Dto");
	String user = (String)session.getAttribute("id");
	String pagenum =request.getParameter("page");
	String booktime = Dto.getBOOK_TIME();
	String bookdate = Dto.getBOOK_DATE();
	List curbook_time_list = new ArrayList();
	StringTokenizer st = new StringTokenizer(booktime, ",");
	while (st.hasMoreTokens()) {
		curbook_time_list.add(st.nextToken());
	}
	String roomnum = "";
	if(request.getParameter("roomnum")== null){
		roomnum = "ROOMA";
	}else{
		roomnum = (String)request.getParameter("roomnum");
	}
	Calendar cal = Calendar.getInstance();
	String strMonth = (String)request.getAttribute("month");
	int month = Integer.parseInt(strMonth);
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
<iframe name="frame"  width="1200px" height="780px" src="./MemberBookModifyCalendar?roomnum=<%=roomnum %>&month=<%=month%>&bookdate=<%=bookdate%>"
 scrolling="auto" frameborder="0">
</iframe>
<form name="bookform" action="./MemberModifyBookProcess" method="post"  onsubmit="return reservecheck()">
<input type="hidden" id ="curbookdate" value="<%=Dto.getBOOK_DATE()%>">
<input type="hidden" id ="curbooktime" value="<%=Dto.getBOOK_TIME()%>">
<input type="hidden" name="page" value=<%=pagenum%>>
<input type="hidden" name="month" value=<%=month%>>
<input type="hidden" name="roomnum" value=<%=roomnum%>>
<input type="hidden" name ="BOOK_NUM" value="<%=Dto.getBOOK_NUM()%>">
<c:set var="mapkey" value="<%=new java.util.HashMap()%>" />
<c:set target="${mapkey}" property="A" value="09:00~10:00" />
<c:set target="${mapkey}" property="B" value="10:00~11:00" />
<c:set target="${mapkey}" property="C" value="11:00~12:00" />
<c:set target="${mapkey}" property="D" value="13:00~14:00" />
<c:set target="${mapkey}" property="E" value="14:00~15:00" />
<c:set target="${mapkey}" property="F" value="15:00~16:00" />
<c:set target="${mapkey}" property="G" value="16:00~17:00" />
<c:set target="${mapkey}" property="H" value="17:00~18:00" />

<table width="700px"  style="margin-left:20px;"  align="center" border="0">
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		현재예약정보
		</td>
		<td width="110px" valign="top">
		<font size="3px" style="font-weight: bold;color:#FE2E2E;">
		예약일자 :
		</font>
		<br>
		<font style="margin-left:10px;">
		<%=bookdate%>
		</font>
		</td>
		<td  valign="top">
		<font size="3px" style="font-weight: bold;color:#FE2E2E;">
		예약시간 :
		</font>
		<br>
		<%
		for(int i=0;i<curbook_time_list.size();i++){
		pageContext.setAttribute("book_time_val", curbook_time_list.get(i)) ;
		if(i < curbook_time_list.size()-1){
		%>
		<font style="margin-left:10px;">
		${mapkey[book_time_val]}<br>
		</font>
		<%
		}else{
		%>
		<font style="margin-left:10px;">
		${mapkey[book_time_val]}
		</font>
		<%	
		}
		}
		%>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		예약일자
		</td>
		<td colspan="2">
		<input type="text" name="BOOK_DATE" style="width:100%; border: 0;" value="" readonly>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		예약자
		</td>
		<td colspan="2">
		<input type="hidden" name="BOOK_MEMBER" value="<%=user%>">
		<b style="margin-left:20px;"><%=user%></b>
		</td>
	</tr>
	<tr>
		<td bgcolor="#f5f5f5" align="center">
		예약사유
		</td>
		<td colspan="2">
		<textarea name="BOOK_REASON" rows=5 style="width:100%; height:100%; border: 0;"><%=Dto.getBOOK_REASON()%></textarea>
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
</form>
</div>
</body>
</html>