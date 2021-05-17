<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
int nowpage=1;
if(request.getParameter("page")!=null){
	nowpage=Integer.parseInt(request.getParameter("page"));
}
session.setAttribute("noticepage", nowpage);
int count=((Integer)(request.getAttribute("count"))).intValue();
int pageCount=((Integer)(
		request.getAttribute("pageCount"))).intValue();
int startPage=((Integer)(
		request.getAttribute("startPage"))).intValue();
int endPage=((Integer)(
		request.getAttribute("endPage"))).intValue();
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
<html>
<head>
<script>
function admincheck() {
	var user = <%=user%>;
	var admin= <%=admin%>;
	if(user == null || admin != 'y') {
		alert("관리자만 작성 가능합니다.");
 		history.go(0);
	} else{
	}
}
function noticeserarch(){
	var searchtype = document.getElementById("searchtype").value;
	var searchkeyword = document.getElementById("searchkeyword").value;
	searchform.reset();
	searchform.searchtype.value=searchtype;
	searchform.searchkeyword.value=searchkeyword;
	searchform.submit();
}
</script>
<title>공지 사항</title>
</head>
<style type="text/css">
.noticelist  tr {
	border-bottom:1px solid CECDCD;
}
.noticelist  a {
	color:black;
	text-decoration:none;
}
.noticelist a:hover {
	color: red;
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
<table border="0" width="700px"  style="margin-left:20px;">
	<tr>
	<td height="50px">
	<img id="topimage" src="./image/noticeimage/noticelist.png" width="700px" >
	</td>
	</tr>
</table>
<%
if(user != null && admin.equals("y")){
%>	
	<table align="center" width="600px" border="0">
	<tr>
		<td align="right" height="50px">
		<a href="./NoticeWrite" onclick ="admincheck()"><img src="./image/noticeimage/write.png" width="70px"></a>
		</td>
	</tr>
	</table>
<%
}
%>
<form name="searchform" action="NoticeList" method="post">
<input type="hidden" name="searchtype" size="20" value="<%=searchtype %>"//>
<input type="hidden" name="searchkeyword" size="20" value="<%=searchkeyword %>"//>
<input type="hidden" name="page" size="20" value="<%=nowpage %>"/>
</form>
<table border="0" width="400px"  style="margin-left:350px;margin-bottom:50px;">
	<tr>
		<td width="90px">
		<input type="hidden" name="searchtype" size="20"/>
		<select id ="searchtype">
		<option value="" <%if(searchtype==null){%> selected<%}else{ %><%} %>></option>
		<option value="TITLE" <%if(searchtype.equals("TITLE")){%> selected<%}else{ %><%} %>>제목</option>
		<option value="WRITER" <%if(searchtype.equals("WRITER")){%> selected<%}else{ %><%} %>>작성자</option>
		</select>
		</td>
		<td>
		<input type="text" id="searchkeyword" size="30" value="<%=searchkeyword%>"/>
		<input type="button" onclick="javascript:noticeserarch();" value="검색">
		</td>
	</tr>
</table>
<table class="noticelist" align="center">
	<tr align="center" height="50px" width="900px" 
	style="font-weight: 900; font-size:15px; background:F6F0FC; color:190E44;border-bottom: 5px solid #aaa;">
		<td width="80px">번호</td>
		<td width="300px">제목</td>
		<td width="120px">작성자</td>
		<td width="120px">조회수</td>
		<td width="120px">작성일자</td>
	</tr>
<c:choose> 
	<c:when test="${requestScope.topitemList[0].NOTICE_NUM!=null}">	
	<c:forEach var="item2" items="${requestScope.topitemList}">
	<tr style="background: #eef8ff;">
		<td align="center">
		<img id="topimage" src="./image/noticeimage/notice.jpg" width="30px" >
		<input type="hidden" name="board_num" value="${item2.NOTICE_NUM}">
		</td>
		<td> 
		<div id="noticelist">
	 	<a href="./NoticeView?notice_number=${item2.NOTICE_NUM}&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>"> ${item2.NOTICE_TITLE}</a>
		</div>
		</td>
		<td align="center">${item2.NOTICE_WRITER}
		</td>
		<td align="center">${item2.NOTICE_HIT}
		</td>
		<td align="center">${fn:substring(item2.CREATE_DATE,0,10)}
		</td>
	</tr>
	</c:forEach>
	</c:when>
</c:choose>
<c:choose> 
	<c:when test="${requestScope.itemList[0].NOTICE_NUM==null}">
	<tr  height="50px">
		<td width="700" height="300" align="center" colspan="5">등록된 글이 없습니다.
		</td>
	</tr>
	</c:when>
	<c:otherwise> 	
	<c:forEach var="item" items="${requestScope.itemList}">
	<tr>
		<td align="center">${item.RNUM}
		<input type="hidden" name="board_num" value="${item.NOTICE_NUM}">
		</td>
		<td> 
		<div id="noticelist">
	 	<a href="./NoticeView?notice_number=${item.NOTICE_NUM}&page=<%=nowpage%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>"> ${item.NOTICE_TITLE}</a>
		</div>
		</td>
		<td align="center">${item.NOTICE_WRITER}
		</td>
		<td align="center">${item.NOTICE_HIT}
		</td>
		<td align="center">${fn:substring(item.CREATE_DATE,0,10)}
		</td>
	</tr>
	</c:forEach>
    </c:otherwise>
</c:choose>
</table>
<table align="center" width="600px" style="margin-top:15px;">
	<tr>
	<td align="center">
	<div id="paging">		
		<%
		if (count>0) {
			if (startPage>10) { %>
			<a href="NoticeList?page=<%=startPage-1%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>">[이전]</a>
			<% }
			for (int i=startPage;i<=endPage ; i++) { 
				if (i==nowpage) {   %>
				<font size="4px" color="#FE2E2E" style="font-weight:bold;">[<%=i%>]</font>
				<% } else { 
				%>  
					<a href="NoticeList?page=<%=i%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>" style="text-decoration:none;">
					<font color="black">[<%=i%>]</font></a>
					<%
				}
			}
			if (endPage<pageCount) { %>
			<a href="NoticeList?page=<%=endPage+1%>&searchtype=<%=searchtype%>&searchkeyword=<%=searchkeyword%>">[다음]</a>
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