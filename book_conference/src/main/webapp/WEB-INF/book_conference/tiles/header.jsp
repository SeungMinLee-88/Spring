<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<%
	String user = (String)session.getAttribute("id");
	String admin =(String)session.getAttribute("admin");

%>
<style type="text/css">
#main_header {
	font-family: 'Times New Roman', 맑은고딕;		
	width: 100%; margin: 0 auto;
	height: 100px;
    position: relative;
    }

#main_header > #title {
	position: absolute;
	left: 100px; top: 40px;
	}

#main_header > #main_gnb {
	position: absolute;
	right: 0; top: 0;
	}
        
#main_header > #main_lnb {
	position: absolute;
	right: 10px; bottom: 10px;
	border:1px solid black;
	}
    

#main_gnb > ul { overflow: hidden;list-style:none; }
#main_gnb > ul > li { float: left; }
#main_gnb > ul > li > a {
	color:gray;
	display: block;
	padding: 2px 15px;
	margin-top:5px;
	}
        
	#main_gnb > ul > li > a:hover {
	color: black;
	}
    
#main_lnb > ul { overflow: hidden;list-style:none; }

#main_lnb > ul > li { float: left; }

#main_lnb > ul > li > a {
	text-align:left;
	font-size:15px;
	color:black;
	padding: 10px 20px;
	text-decoration:none;
        }

#main_lnb > ul > li > a:hover {
	background: black;
	color: white;
        }
	 </style>

</head>
<header id="main_header">
        <div id="title">

        </div>
        
<% 
		if (user != null && admin.equals("n")){
%>        

        <nav id="main_gnb">
            <ul>
                <li style="font-size:15px; margin-top:8px;"><%=user %> 님 환영합니다.</li>            
                <li><a href="#" onclick="javascript:location.href='./MemberLogout';">로그아웃</a></li>
                <li><a href="./MemberModify">회원정보수정</a></li>
            </ul>
        </nav>
        
        <div id ="topmenu"
		 style="position: absolute;top: 80px;background-color: #F6D8CE;border:1px solid black;
		 width: 100%;height:40px;vertical-align:middle;">
		<nav id="main_lnb">
			<ul>
				<li><a href="./MemberReserve">회의실예약</a></li>
				<li><a href="./NoticeList">공지사항</a></li>
				<li><a href="./DownloadList">자료실</a></li>
			</ul>
		</nav>
</div>
        
        
 <%
} else if(user != null && admin.equals("y")){
%>

        <nav id="main_gnb">
            <ul>
                <li style="font-size:15px; margin-top:8px;">관리자 <%=user %> 로그인 하셨습니다.</li>            
                <li><a href="#" onclick="javascript:location.href='./MemberLogout';">로그아웃</a></li>    
			</ul>
        </nav>
		<div id ="topmenu"
		 style="position: absolute;top: 80px;background-color: #F6D8CE;border:1px solid black;
		 width: 100%;height:40px;vertical-align:middle;">
				<nav id="main_lnb">
					<ul>
						<li><a href="./AdminReserve">관리자</a></li>
						<li><a href="./NoticeList">공지사항</a></li>
						<li><a href="./DownloadList">자료실</a></li>
					</ul>
				</nav>
		</div>
<%
}else{
%>
				<script>
				location.href="./MainLogin";
				alert("로그인 후 이용 해주세요.")
				</script> 
<%
}
%>

</header>

<body>

</body>
</html>