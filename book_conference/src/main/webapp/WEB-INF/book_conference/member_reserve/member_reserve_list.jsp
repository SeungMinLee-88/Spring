<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.StringTokenizer" %>
<%
String roomnum = "";
if(request.getParameter("roomnum")== null){
	roomnum = "ROOMA";
}else{
	roomnum = (String)request.getParameter("roomnum");
}
int nowpage=1;
if(request.getParameter("page")!=null){
	nowpage=Integer.parseInt(request.getParameter("page"));
}
Calendar cal = Calendar.getInstance();
String strYear = (String)request.getAttribute("year");
String strMonth = (String)request.getAttribute("month");
int year = Integer.parseInt(strYear);
int month = Integer.parseInt(strMonth);
int curmonth = cal.get(Calendar.MONTH);
curmonth = curmonth+1;
session.setAttribute("boardpage", nowpage);
int count=((Integer)(request.getAttribute("count"))).intValue();
int pageCount=((Integer)(
		request.getAttribute("pageCount"))).intValue();
int startPage=((Integer)(
		request.getAttribute("startPage"))).intValue();
int endPage=((Integer)(
		request.getAttribute("endPage"))).intValue();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/movie/CSS/StyleSheet.css" />
<link rel="stylesheet" href="/movie/board/board.css" />
<script language="JavaScript" src="/movie/board/board.js" charset="euc-kr"></script>
<script language="JavaScript" src="/movie/js/script.js" charset="euc-kr"></script>
<title>회의실 예약 확인</title>
</head>
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
.reservelist, .reservelist th, .reservelist td{
	font-size:13px;
	border-collapse:collapse;
}         
.reservelist  tr {
	border-bottom:1px solid CECDCD;
}
.reservelist  a {
	color:black;
	text-decoration:none;
}
.reservelist a:hover {
	color: red;
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
<table width="1000px" align="center" border="0" cellspacing="1" cellpadding="1" bgcolor="#BDBDBD" style="display:inline-block;">
<tr>
<td height="60px" align="center" >
       <table width="1000px" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td align="center" >
                    <%if(month > 0 && month > curmonth ){ %>
                    <a id="booktag" href="./MemberReserveList?year=<%=year%>&amp;month=<%=month-1%>&amp;roomnum=<%=roomnum%>">
                           <b>prev</b><!-- 이전달 -->
                    </a>
                    <%}%>
                   &nbsp;
                    <font color="black" style="font-weight:bold;">|
                    <%=year%>년
                    <%=month%>월
                     |&nbsp;</font>
                    <%if(month < 12 ){ %>
                    <a id="booktag" href="./MemberReserveList?year=<%=year%>&amp;month=<%=month+1%>&amp;roomnum=<%=roomnum%>">
                           <!-- 다음달 --><b>next</b>
                    </a>
                    <%}%>
             </td>
       </tr>
       </table>
</td>
</tr>
</table>
<table border="0" width="700px"  style="margin-left:20px;">
	<tr>
	<td height="50px">
	</td>
	</tr>
</table>
<table class="reservelist" align="center">
	<tr align="center" height="50px" width="900px" 
	style="font-weight: 900; font-size:15px; background:F6F0FC; color:190E44;border-bottom: 5px solid #aaa;">
		<td width="60px">번호</td>
		<td width="80px">예약자</td>
		<td>예약시간</td>
		<td width="120px">예약일자</td>
		<td>수정</td>
	</tr>
<c:set var="mapTest" value="<%=new java.util.HashMap()%>" />
<c:set target="${mapTest}" property="A" value="09:00~10:00" />
<c:set target="${mapTest}" property="B" value="10:00~11:00" />
<c:set target="${mapTest}" property="C" value="11:00~12:00" />
<c:set target="${mapTest}" property="D" value="13:00~14:00" />
<c:set target="${mapTest}" property="E" value="14:00~15:00" />
<c:set target="${mapTest}" property="F" value="15:00~16:00" />
<c:set target="${mapTest}" property="G" value="16:00~17:00" />
<c:set target="${mapTest}" property="H" value="17:00~18:00" />
		<c:choose> 
			<c:when test="${requestScope.itemList[0].BOOK_NUM==null}">
			<tr>
			<td width="700" height="300" align="center" colspan="5">등록된 예약이 없습니다.</td>
			</tr>
			</c:when>
		<c:otherwise> 	
		<c:forEach var="item" items="${requestScope.itemList}">
	<tr height="30px" style="border-bottom: 1px solid #aaa;">
		<td align="center">${item.RNUM}
		<input type="hidden" name="board_num" value="${item.BOOK_NUM}">
			</td>
		<td align="center"> 
	 	${item.BOOK_MEMBER}
		</td>
		<td width="560px">
	<c:set var="book_time" value="${item.BOOK_TIME }"/>
		<%
		List book_time_list = new ArrayList();
		String book_time = (String)pageContext.getAttribute("book_time");
		StringTokenizer st = new StringTokenizer(book_time, ",");
		while (st.hasMoreTokens()) {
			book_time_list.add(st.nextToken());
		}
		for(int i=0;i<book_time_list.size();i++){
		pageContext.setAttribute("book_time_val", book_time_list.get(i));
		if(i < book_time_list.size()-1){
		%>
		<font style="margin-top:10px;margin-bottom:10px;">
		${mapTest[book_time_val]},
		</font>
		<%
		}else{
		%>
		<font style="margin-top:10px;margin-bottom:10px;">
		${mapTest[book_time_val]}
		</font>
		<%
		}
		}
		%>
		</td>
		<td align="center">${fn:substring(item.BOOK_DATE,0,10)}</td>
		<td align="center">
		<a href="./MemberDeleteBook?book_num=${item.BOOK_NUM}&page=<%=nowpage%>&month=<%=month%>&amp;roomnum=<%=roomnum%>"
		style="text-decoration:none;">
		삭제</a>
		&nbsp;
		<a href="./MemberModifyBook?book_num=${item.BOOK_NUM}&page=<%=nowpage%>&month=<%=month%>&amp;roomnum=<%=roomnum%>"
		style="text-decoration:none;">
		수정
		</a>
		</td>
	</tr>
		</c:forEach>
        </c:otherwise>
		</c:choose>
</table>
<table align="center" width="900px" style="margin-top:15px;">
	<tr>
	<td align="center">
	<div id="paging">		
		<%
		if (count>0) {
			if (startPage>10) { %>
			<a href="MemberReserveList?year=<%=year%>&amp;month=<%=month%>&amp;roomnum=<%=roomnum%>&page=<%=startPage-1%>" style="text-decoration:none;">[이전]</a>
			<% }
			for (int i=startPage;i<=endPage ; i++) { 
				if (i==nowpage) {   %>
				<font size="4px" color="#FE2E2E" style="font-weight:bold;">[<%=i%>]</font>
				<% } else { 
				%>  
					<a href="MemberReserveList?month=<%=month%>&amp;roomnum=<%=roomnum%>&page=<%=i%>" style="text-decoration:none;">
					<font color="black">[<%=i%>]</font>
					</a>
					<%
				}
			}
			if (endPage<pageCount) { %>
			<a href="MemberReserveList?year=<%=year%>&amp;month=<%=month%>&amp;roomnum=<%=roomnum%>&page=<%=endPage+1%>" style="text-decoration:none;">[다음]</a>
			<%
			}
		}
		%>			
	</div>
		</td>
		</tr>
</table>
</div>
</body>
</html>