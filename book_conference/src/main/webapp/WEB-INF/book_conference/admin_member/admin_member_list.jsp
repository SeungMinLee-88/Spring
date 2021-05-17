<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.StringTokenizer" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약리스트</title>
</head>
<%
int nowpage=1;
if(request.getParameter("page")!=null){
	nowpage=Integer.parseInt(request.getParameter("page"));
}
int count=((Integer)(request.getAttribute("count"))).intValue();
int pageCount=((Integer)(
		request.getAttribute("pageCount"))).intValue();
int startPage=((Integer)(
		request.getAttribute("startPage"))).intValue();
int endPage=((Integer)(
		request.getAttribute("endPage"))).intValue();
String memdept = "";
if(request.getParameter("memdept")!=null){
	memdept = (String)request.getParameter("memdept");
}
String memdeptcode = "";
if(request.getParameter("memdeptcode")!=null){
	memdeptcode = (String)request.getParameter("memdeptcode");
}
String memname ="";
if(request.getParameter("memname")!=null){
	memname = (String)request.getParameter("memname");
}
String memid = "";
if(request.getParameter("memid")!=null){
	memid = (String)request.getParameter("memid");
}

%>


<body>
<script>
function memberserarch(){
	var serarchdept = document.getElementById("searchdept").value;
	var searchdeptcode = document.getElementById("searchdeptcode").value;
	var searchmem = document.getElementById("searchmem").value;
	var searchtext = document.getElementById("searchtext").value;
	searchform.reset();
	searchform.memdept.value=serarchdept;
	searchform.memdeptcode.value=searchdeptcode;
	if(searchmem =="memname"){
	searchform.memname.value=searchtext
	}else if(searchmem =="memid"){
	searchform.memid.value=searchtext
	}else{
	}
	searchform.submit();
}
function openDeptList(){
	var url="./AdminDeptList?close=n"
	open(url, "confirm", "toolbar=no,location=no,"
						+"status=no,menubar=no,"
						+"scrollbars=yes,resizable=no,"
						+"width=410,height=800");
}
</script>

<style type="text/css">
.listtable, .listtable th, .listtable td{
	font-size:15px;
	border-collapse:collapse;
}         
.listtable  tr {
	border-bottom:1px solid CECDCD;
}
.listtable  a {
	color:black;
	text-decoration:none;
}
.listtable a:hover {
	color: red;
}
#admin_form{
margin-left:200px;margin-top: 40px;position:relative;display: inline-block;
clear:both;
}
</style>
<body>
<div id="admin_form">

<table border="0" width="700px"  style="margin-left:10px;margin-bottom:30px;">
	<tr>
	<td height="50px">
	<img id="topimage" src="./image/userlist.jpg" width="500px" >
	</td>
	</tr>
</table>
<form name="searchform" action="AdminMemberList" method="post">
<input type="hidden" name="memdept" value=""/>
<input type="hidden" name="memdeptcode" value="" />
<input type="hidden" name="memname" value=""/>
<input type="hidden" name="memid" value=""/>
<input type="hidden" name="page" value="<%=nowpage %>"/>
</form>
<table border="0" width="600px"  style="margin-left:50px;margin-bottom:30px;">
	<tr>
	<td width="110px" align="left">
	<input type="text" id="searchdept" size="20" value="<%=memdept %>"/>
	<input type="hidden" id="searchdeptcode" size="20" value="<%=memdeptcode %>"/>
	</td>
	<td width="90px" align="right">
	<input type="button" onclick="javascript:openDeptList();" value="부서선택">
	</td>
	<td width="110px" align="right">
		<input type="hidden" name="searchtype" size="20"/>
	<select id ="searchmem">
		<option value="" <%if(memid=="" && memname==""){%> selected<%}else{ %><%} %>></option>
		<option value="memname" <%if(memname!="" && memname!=null){%> selected<%}else{ %><%} %>>이름</option>
		<option value="memid" <%if(memid!="" && memid!=null){%> selected<%}else{ %><%} %>>아이디</option>
	</select>
	</td>
	
	<td width="150px" align="center">
	<input type="text" id="searchtext" width="10px"
	value="<%if(memname!="" && memname!=null){%><%=memname%><%}else{%><%} %><%if(memid!="" && memid!=null){%><%=memid%><%}else{%><%}%>"/>
	</td>
	<td width="90px" align="left">
	<input type="button" onclick="javascript:memberserarch();" value="검색">
	</td>
	<td width="90px" align="left">
	<input type="button" onclick="location.href='./AdminMemberList';" value="초기화">
	</td>
	</tr>
</table>

<table class="listtable" align="center">
	<tr align="center" height="50px" width="800px" style="font-weight:900; font-size:15px;background:#F6F0FC; font-size:15px;border-bottom: 2px solid black">
	<td width="80px">번호</td>
	<td width="200px">회원이름(아이디)</td>
	<td width="200">부서</td>
	<td width="150px">처리</td>
	</tr>
<c:forEach var="item" items="${requestScope.itemList}">
	<c:if test="${requestScope.itemList[0].MEMBER_NUM==null}">
	등록된 데이터가 없습니다.
	</c:if>
	<tr style="background: #eef8ff;border-bottom: 1px solid #819FF7;">
	<td align="center">${item.RNUM}
	</td>

	<td align="center">
	${item.MEMBER_NAME}(${item.MEMBER_ID})
	</td>
	<td align="center">
	${item.MEMBER_DEPTNAME}
	</td>
	<td align="center">
	<a href=
"./AdminDeleteMember?member_number=${item.MEMBER_NUM}&memdept=<%=memdept%>&memdeptcode=<%=memdeptcode%>&memname=<%=memname%>&memid=<%=memid%>&page=<%=nowpage%>">
	삭제
	</a>
	</td>
	</tr>
		</c:forEach>
</table>

<table align="center" width="600px" style="margin-top:15px;">
	<tr>
	<td align="center">
	<div id="paging">		

		<%
		if (count>0) {
			if (startPage>10) { %>
			<a href="AdminMemberList?memdept=<%=memdept%>&memdeptcode=<%=memdeptcode%>&memname=<%=memname%>&memid=<%=memid%>&page=<%=startPage-1%>">[이전]</a>
			<% }
			for (int i=startPage;i<=endPage ; i++) { 
				if (i==nowpage) {   %>
				<font size="4px" color="#FE2E2E" style="font-weight:bold;">[<%=i%>]</font>
				
				<% } else { 
				%>  
					<a href="AdminMemberList?memdept=<%=memdept%>&memdeptcode=<%=memdeptcode%>&memname=<%=memname%>&memid=<%=memid%>&page=<%=i%>" style="text-decoration:none;">
					<font color="black">[<%=i%>]</font></a>
					<%
				}
			}
			if (endPage<pageCount) { %>
			<a href="AdminMemberList?memdept=<%=memdept%>&memdeptcode=<%=memdeptcode%>&memname=<%=memname%>&memid=<%=memid%>&page=<%=endPage+1%>">[다음]</a>
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