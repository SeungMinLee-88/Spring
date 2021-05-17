<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String user = (String)session.getAttribute("id");
	String admin =(String)session.getAttribute("admin");
	
	out.println("user : "+user);
	out.println("admin : "+admin);

%>


    <header id="main_header">
        <div id="title">

        </div>
        
<% 
		if (user != null && admin.equals("n")){
%>        

        <nav id="main_gnb">
            <ul>
                <li style="font-size:15px; margin-top:8px;"><%=user %> 님 환영합니다.</li>            
                <li><a href="#" onclick="logout()">로그아웃</a></li>
                <li><a href="MemberModifyAction_1.me">회원정보수정</a></li>
            </ul>
        </nav>
        
 <%
} else if(user != null && admin.equals("y")){
%>

        <nav id="main_gnb">
            <ul>
                <li style="font-size:15px; margin-top:8px;">관리자 <%=user %> 로그인 하셨습니다.</li>            
                <li><a href="#" onclick="javascript: location.href:MemberLogout">로그아웃</a></li>
                <li><a href="MemberModifyAction_1.me">회원정보수정</a></li>      
			</ul>
        </nav>          
<%
}
%>
<div id ="topmenu"
 style="position: absolute;top: 80px;background-color: #F6D8CE;border:1px solid black;
 width: 100%;height:20px;vertical-align:middle;">
		<nav id="main_lnb">
			<ul>
				<li><a href="./MovieList.go">관리자</a></li>
				<li><a href="./Main.me">회의실예약</a></li>
				<li><a href="./Information.me#tab1">서비스</a></li>
				<li><a href="./Information.me#tab1">자료실</a></li>
			</ul>
		</nav>
</div>
</header>
		<div id="movie_gnb" align="center">
			<ul>
			<li>관리자예약
				<ul>
				<li>
				<a href="#tab1">A회의실
				</a>
				</li>
				</ul>
				</li>
			<li><a href="#tab2">
			B회의실</a>
			</li>
			<li><a href="#tab3">
			예약현황</a>
			</li>
			<li>
			<a href="#tab4">
			예약수정
			</a>
			</li>
			</ul>
		</div>
</body>
</html>