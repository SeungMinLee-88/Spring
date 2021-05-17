<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이용신청리스트</title>
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

%>
<style type="text/css">
.noticelist, .noticelist th, .noticelist td{
	font-size:15px;
	border-collapse:collapse;

		}         

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
		

#admin_form{
margin-left:200px;margin-top: 40px;position:relative;display: inline-block;
clear:both;
}
</style>
<body>
<div id="admin_form">
<table border="0" width="700px"  style="margin-left:20px;margin-bottom:30px;">
	<tr>
	<td height="50px">
	<img id="topimage" src="./image/applylist.jpg" width="500px" >
	</td>
	</tr>
</table>

<table class="noticelist" align="center">
	<tr align="center" height="50px" width="900px" style="font-weight:900;background:#F6F0FC; font-size:15px;border-bottom: 2px solid black;">
	<td width="80px">번호</td>
	<td width="300px">부서</td>
	<td width="120px">신청자</td>
	<td width="120px">처리</td>
	</tr>
<c:forEach items="${itemList}" var="items">

	<tr style="background: #eef8ff;border-bottom: 1px solid #819FF7;">
	<td align="center">${items.RNUM}
	</td>
	<td align="center">${items.MEMBER_DEPTNAME}
	</td>
	<td align="center"> 
	${items.MEMBER_NAME}
	</td>
	<td align="center">
	<a href="ApplyProcess?APPLY_NUM=${items.APPLY_NUM}&status=a" style="text-decoration:none;">
	승인
	</a>&nbsp;&nbsp;|&nbsp;&nbsp;
	<a href="ApplyProcess?APPLY_NUM=${items.APPLY_NUM}&status=r" style="text-decoration:none;">
	반려
	</a>
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
			<a href="AdminMemberApplyList?page=<%=startPage-1%>">[이전]</a>
			<% }
			for (int i=startPage;i<=endPage ; i++) { 
				if (i==nowpage) {   %>
				<font size="4px" color="#FE2E2E" style="font-weight:bold;">[<%=i%>]</font>
				
				<% } else { 
				%>  
					<a href="AdminMemberApplyList?page=<%=i%>" style="text-decoration:none;">
					<font color="black">[<%=i%>]</font></a>
					<%
				}
			}
			if (endPage<pageCount) { %>
			<a href="AdminMemberApplyList?page=<%=endPage+1%>">[다음]</a>
			<%
			}
		}
		%>			
	</div>
		</td>
		</tr>
</table>

</div>
</div>
</body>
</html>