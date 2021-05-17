<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.book_conference.memberreserve.controller.MemberReserveController" %>
<%@ page import="com.book_conference.memberreserve.controller.RoomBookList" %>
<%@ page import="com.book_conference.memberreserve.controller.RoomBookStatus" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="com.book_conference.memberreserve.dao.*" %>
<%@ page import="com.book_conference.memberreserve.dto.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.StringTokenizer" %>
<html>
<head>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<%
String roomnum ="";
String bookdate ="";
roomnum = request.getParameter("roomnum");
bookdate = request.getParameter("bookdate");
Calendar cal = Calendar.getInstance();
String strYear = request.getParameter("year");
String strMonth = (String)request.getAttribute("month");
int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH);
int date = cal.get(Calendar.DATE);
int curyear = cal.get(Calendar.YEAR);
int curmonth = cal.get(Calendar.MONTH);
curmonth = curmonth+1;
int curdate = cal.get(Calendar.DATE);
if(strYear != null){
  year = Integer.parseInt(strYear);
  month = Integer.parseInt(strMonth);
}else{
}
cal.set(year, month, 1);
int startDay = cal.getMinimum(java.util.Calendar.DATE);
int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
int newLine = 0;
Calendar todayCal = Calendar.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
%>
<script type="text/javaScript" language="javascript">
function bookdateinput(date,book_time_stirng){
	window.parent.bookform.reset();
	var chk = parent.document.getElementsByName("BOOK_TIME");
	var disablearr = [ "A", "B", "C", "D", "E", "F", "G","H" ];
	for(j=0;j<chk.length;j++){
		chk[j].disabled=false;
		chk[j].checked=false;
	}
	for (var k = 0; k < disablearr.length; k++){
		parent.document.getElementById(disablearr[k]+"label").style.backgroundColor="";
	}
	var book_time_list  = book_time_stirng;
	var curbook_time_list  = parent.document.getElementById("curbooktime").value;
	var book_time_array = new Array();
	var curbook_time_array = new Array();
	var date = date;
	var curdate = parent.document.getElementById("curbookdate").value;
	window.parent.bookform.BOOK_DATE.value=date;
	curbook_time_array = curbook_time_list.split(",")
	book_time_array = book_time_list.split(",")
	if(date == curdate) {
		alert('현재 예약한 일자입니다.');
		for (var i = 0; i < book_time_array.length; i++){
		parent.document.getElementById(book_time_array[i]).disabled=true;
		parent.document.getElementById(book_time_array[i]+"label").style.backgroundColor="#FA5858";
		}
		for (var j = 0; j < curbook_time_array.length; j++){
		parent.document.getElementById(curbook_time_array[j]).disabled=false;
		parent.document.getElementById(curbook_time_array[j]+"label").style.backgroundColor="";
		parent.document.getElementById(curbook_time_array[j]).checked=true;
		}
	}else{
		if(book_time_stirng != 'null') {
			for (var i = 0; i < book_time_array.length; i++){
			parent.document.getElementById(book_time_array[i]).disabled=true;
			parent.document.getElementById(book_time_array[i]+"label").style.backgroundColor="#FA5858";
			}
		}
		
	}
}
</script>
<style type="text/css">
#booktag {
	margin-left:10px;
	margin-top:30px;
	text-decoration:none;
}
#booktag >font:hover {
	color: blue;
}
#booktag >b:hover {
	font-size:20px;
	color: blue;
}
#calendar_content{
	width:850px;
	border:2px double #424242;
}
</style>
<body>
<div id="calendar_content" align="center">
<form name="calendarFrm" id="calendarFrm" action="" method="post">
<table width="800px" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td align ="right">
		<a href="#" onclick="javascript:location.href='./MemberRoomBookCalendar?roomnum=<%=roomnum%>'"
      style="background: #58FAAC;boder:1px solid black;text-decoration:none;">
		TODAY
		</a>
       </td>
	</tr>
</table>
<table width="800px" border="0" cellspacing="1" cellpadding="1" bgcolor="#BDBDBD">
<tr>
<td height="60">
       <table width="800px" border="0" cellspacing="0" cellpadding="0">
       <tr>
		<td align="center" >
                    <%if(month > 0 && month+1 > curmonth ){ %>
                    <a id="booktag" href="./MemberBookModifyCalendar?year=<%=year%>&amp;month=<%=month-1%>&amp;roomnum=<%=roomnum%>&amp;bookdate=<%=bookdate%>">
                           <b>prev</b><!-- 이전달 -->
                    </a>
                    <%} else {%>
                    <%} %>
                     &nbsp;
                    <font color="black" style="font-weight:bold;">|
                    <%=year%>년
                    <%=month+1%>월
                    |&nbsp;</font>
                    <%if(month < 12 ){ %>
                    <a id="booktag" href="./MemberBookModifyCalendar?year=<%=year%>&amp;month=<%=month+1%>&amp;roomnum=<%=roomnum%>&amp;bookdate=<%=bookdate%>">
                           <!-- 다음달 --><b>next</b>
                    </a>
                    <%}%>
             </td>
       </tr>
       </table>
			</td>
</tr>
</table>
<br>
<table border="1" cellspacing="1" cellpadding="1" bgcolor="#FFFFFF" style="border-collapse:collapse; border:1px gray solid;">
<thead>
<TR bgcolor="#CECECE">
       <td width='100px'>
       <div align="center"><font color="red">일</font></div>
       </td>
       <td width='100px'>
       <div align="center">월</div>
       </td>
       <td width='100px'>
       <div align="center">화</div>
       </td>
       <td width='100px'>
       <div align="center">수</div>
       </td>
       <td width='100px'>
       <div align="center">목</div>
       </td>
       <td width='100px'>
       <div align="center">금</div>
       </td>
       <td width='100px'>
       <div align="center"><font color="blue">토</font></div>
       </td>
</tr>
</thead>
<tbody>
<tr>
<%
for(int index = 1; index < start ; index++ )
{
  out.println("<td >&nbsp;</td>");
  newLine++;
}
for(int index = 1; index <= endDay; index++)
{
		String sUseDate = Integer.toString(year)
				+(Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1))
				+(Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index));
		int curDate = Integer.parseInt(sUseDate);
		String inputDate = Integer.toString(year)+"-"
				+(Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1))+"-"
				+(Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index));   
       int iUseDate = Integer.parseInt(sUseDate);
       String backColor = "";
       String color="balck";
       if(newLine == 0){
    	   backColor = "#F6CECE";
       }else if(newLine == 6){
    	   backColor = "#529dbc";
       }else{ 
    	   backColor = "white"; 
    	}
       if(iUseDate == intToday ) {
             backColor = "#c9c9c9";
       }
       %>
        <td valign='top' align='right' height='92px' bgcolor='<%=backColor %>' nowrap>
       <font color='<%=color%>'>
             <%=index %>
       </font>
       <br>
		<%
		if(newLine != 0 && newLine != 6) {
		List itemList=new ArrayList();
		List itemList2=new ArrayList();
		int TotalNum=0;
		int RestrictStatus=0;
		itemList = RoomBookList.RoomBookListGet(roomnum, inputDate);
		itemList2 = RoomBookStatus.RoomBookStatusGet(roomnum, inputDate);
		List<Map<String, Object>> listMap = itemList2; 
		TotalNum = Integer.parseInt(listMap.get(0).get("TotalNum").toString());
		RestrictStatus = Integer.parseInt(listMap.get(0).get("RestrictStatus").toString());
		request.setAttribute("itemList", itemList);
		List book_time_list = new ArrayList();
		%>
<c:forEach var="item" items="${requestScope.itemList}">
<c:set var="book_time" value="${item.BOOK_TIME }"/>
<c:set var="BOOK_MEMBER" value="${item.BOOK_MEMBER }"/>
<%
String book_time = (String)pageContext.getAttribute("book_time");
String book_member = (String)pageContext.getAttribute("BOOK_MEMBER");
StringTokenizer st = new StringTokenizer(book_time, ",");
while (st.hasMoreTokens()) {
	book_time_list.add(st.nextToken());
}
%>
</c:forEach>
<%
String book_time_string ="";
String replace_string;
if(book_time_list.size() != 0){
	replace_string = book_time_list.toString().replace("[", "");
	replace_string = replace_string.replace("]", "");
	replace_string = replace_string.replace(" ", "");
	book_time_string =replace_string;
}else{
	book_time_string = null;
}
%>
		<%
		if(TotalNum <8 && curDate >= intToday){
		%>
			<br>
			<a id="booktag" href="#" class="input"
			onclick="javascript:bookdateinput('<%=inputDate%>','<%=book_time_string%>');">
			<font color="black" style="font-weight:bold;">예약</font>
			</a>
			<br>
		<% 
		}else{
			if(TotalNum >=8 && curDate >= intToday && inputDate.equals(bookdate)){
		%>
			<a id="booktag" href="#" class="input"
			onclick="javascript:bookdateinput('<%=inputDate%>','<%=book_time_string%>');">
			<font color="black" style="font-weight:bold;">수정</font>
			</a>
			<%
				}else{
			%>
		<br>
		<br>
		<font color="red" style="font-weight: bold">예약불가</font>
		<%
		}
		}
		%>
		</td>
		<%}else{ %>
		</td>
       <%
		}
       newLine++;
       if(newLine == 7)
       {
         out.println("</tr>");
         if(index <= endDay)
         {
           out.println("<tr>");
         }
         newLine=0;
       }
}
while(newLine > 0 && newLine < 7)
{
  out.println("<td>&nbsp;</td>");
  newLine++;
}
%>
</tr>
</tbody>
</table>
</div>
</form>
</body>
</html>