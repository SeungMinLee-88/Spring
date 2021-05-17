<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>

<style type="text/css">
	  
#reserve_gnb{
	height:70%;
	margin-top:40px;
	font-size:15px;
	width: 180px;
	background-color: #A9F5A9;
	padding: 0;
	display: inline-block;
	position:absolute;
	float: left; 
}
#reserve_gnb > ul{
	overflow: hidden;
	font-size:18px;
	 font-weight: bold;
	color:black;
	list-style:none;
	text-align:left;
	margin:5; padding:0;
}

#reserve_gnb > ul > li { 
	float: left; 
	font-size:10pt;
	color:black;
	margin-left: 0px; 
	white-space:nowrap;

        }

#reserve_gnb > ul > li > a {
	color:gray;
	display: block;
	padding: 10px 20px;
	text-decoration:none;
        }

#reserve_gnb > ul > li > a:hover {
    color: F50F72;
        }
        

#reserve_gnb > ul > li > a {
    color:gray;
    display: block;
    padding: 10px 20px;
         
        }
#booktag {
	margin-left:10px;margin-top:30px;text-decoration:none;
}

#booktag >font:hover {

	color: blue;
}
#booktag >b:hover {
	font-size:20px;
	color: blue;
}
#content {
height:1300px;
}

 </style>
<div id="content">
		<div id="reserve_gnb">
				<ul>- 관리자예약</ul>
				<ul>
				<li>
				<a href="./AdminReserve?roomnum=ROOMA">A회의실
				</a>
				</li>
				<li>
				<a href="./AdminReserve?roomnum=ROOMB">B회의실
				</a>
				</li>
				
				</ul>

				<ul>- 예약리스트</ul>
				<ul>
				<li>
				<a href="./AdminReserve_list?roomnum=ROOMA">A회의실예약현황
				</a>
				</li>
				<li>
				<a href="./AdminReserve_list?roomnum=ROOMB">B회의실예약현황
				</a>
				</li>
				</ul>

				<ul>- 회원관리</ul>
				<ul>
				<li>
				<a href="./AdminMemberApplyList">이용신청관리
				</a>
				</li>
				<li>
				<a href="./AdminMemberList">사용자관리
				</a>
				</li>
				</ul>

		</div>
</body>
</html>