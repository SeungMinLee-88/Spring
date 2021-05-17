<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
Calendar cal = Calendar.getInstance();
String strYear = request.getParameter("year");
String strMonth = request.getParameter("month");
int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH);
String roomnum = "";
if(request.getParameter("roomnum")== null){
	roomnum = "ROOMA";
}else{
	roomnum = (String)request.getParameter("roomnum");
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
$(document).ready(function(){
    $("#aroom_div").mouseover(function(){
        $("#aroom_div").css("background-color", "#A9F5A9");
    });
    $("#aroom_div").mouseout(function(){
        $("#aroom_div").css("background-color", "gray");
    });
    
    $("#broom_div").mouseover(function(){
        $("#broom_div").css("background-color", "#A9F5A9");
    });
    $("#broom_div").mouseout(function(){
        $("#broom_div").css("background-color", "gray");
    });
});
</script>
<style type="text/css">
#reserve_gnb{
	height:100%;
	margin-top:40px;
	font-size:15px;
	width: 180px;
	border:1px solid black;
	background-color: #D8D8D8;
	padding: 0;
	display: inline-block;
	position:absolute;
	float: left; 
}
#reserve_gnb > ul{
	overflow: hidden;
	font-size:15px;
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
#reserve_aside{
	margin-top:40px;
	font-size:15px;
	width: 180px;
	height: 100%;
}
 </style>

<div id="imgbox">
<img src="./image/mettingroom/meetingroom.jpg" width="300px">
<div id="aroom_div" 
style="background-color:gray; opacity: 0.5; width:105px;height:50px;word-wrap:break-word; overflow-x:hidden;overflow-y:hidden;
position:absolute;top:10px;left:10px;" onclick="javascript:ajaxfunction(<%=month+1%>,1,'ROOMA');">
</div>

<div id="broom_div"
style="background-color:gray; opacity: 0.5; width:105px;height:50px;word-wrap:break-word; overflow-x:hidden;overflow-y:hidden;
position:absolute;top:60px;left:10px;" onclick="javascript:ajaxfunction(<%=month+1%>,1,'ROOMB');">
</div>

<div id="block_div" 
style="background-color:#FF0000; opacity: 0.5; width:105px;height:50px;word-wrap:break-word; overflow-x:hidden;overflow-y:hidden;
position:absolute;top:110px;left:10px;">
</div>

<div id="block_div" 
style="background-color:#FF0000; opacity: 0.5; width:105px;height:50px;word-wrap:break-word; overflow-x:hidden;overflow-y:hidden;
position:absolute;top:160px;left:10px;">
</div>

</div>

<div id="reserve_title">

</div>

<div id="reserve_status" style='text-align:center;position:absolute;'>

</div>
<input type="text" id ="monthval" value="<%=month+1 %>"/>
<c:set var="mapTest" value="<%=new java.util.HashMap()%>" />

<c:set target="${mapTest}" property="A" value="09:00~10:00" />
<c:set target="${mapTest}" property="B" value="10:00~11:00" />
<c:set target="${mapTest}" property="C" value="11:00~12:00" />
<c:set target="${mapTest}" property="D" value="13:00~14:00" />
<c:set target="${mapTest}" property="E" value="14:00~15:00" />
<c:set target="${mapTest}" property="F" value="15:00~16:00" />
<c:set target="${mapTest}" property="G" value="16:00~17:00" />
<c:set target="${mapTest}" property="H" value="17:00~18:00" />
<c:set var="test" value="123"/>
<script>
var paraMap = {"A":"09:00~10:00", "B":"10:00~11:00", 
"C":"11:00~12:00", "D":"13:00~14:00", "E":"14:00~15:00", "F":"15:00~16:00", "G":"16:00~17:00", "H":"17:00~18:00"};


function ajaxfunction(month,page,roomnum){
	
	var monthval = month;
	var page = page;
	var roomnum = roomnum;
	alert(page);

$(document).ready(function () {

	$.ajax({
        type : "POST",
        url : "./ReserveStatus?year=2018&month="+monthval+"&page="+page+"&roomnum="+roomnum,
        dataType : "json",
        error : function(){
            alert("통신실패!!!!");
        },
        success : function(data){
        $("#reserve_status").val("");
        var titleHTML ="";
        var innerHTML ="";
        if(monthval == <%=month+1%>){
    		innerHTML += "<div>&nbsp;&nbsp;"+monthval+" &nbsp;&nbsp";
    		innerHTML += '<b id=\'nextmonth\' onclick="javascript:ajaxfunction('+(monthval+1)+',1,\''+roomnum+'\');">&gt;</b></div>';
            }else if(monthval > <%=month+1%>){
            innerHTML += "<div>";
            innerHTML += 
           	innerHTML +=
           	'<b id=\'prevmonth\' onclick="javascript:ajaxfunction('+(monthval-1)+',1,\''+roomnum+'\');">&lt;</b>&nbsp;&nbsp;'+monthval;
            innerHTML += 
            ' &nbsp;&nbsp;<b id="nextmonth"onclick="javascript:ajaxfunction('+(monthval+1)+',1,\''+roomnum+'\');">&gt;</b></div>';
            }
		innerHTML += "<table class='noticelist' align='center'>";
        var i=1;
		innerHTML += "<tr><td width='100px'>번호</td>";
		innerHTML += "<td width='400px'>예약자</td>";
		innerHTML += "<td>예약시간</td>";
		innerHTML += "<td width='120px'>예약일자</td></tr>";
		var count = data;
		var length= data.length;
		var pagecountval;
		var pageval;
		$.each(data, function(idx){
			if(idx <length-2){
	    		innerHTML += "<tr align='center' height='30px' style='font-weight: 900; font-size:15px; background:F6F0FC; color:190E44'>";
	    		innerHTML += "<tr><td align='center'>"+ i +"</td>";
	    		innerHTML += "<td><div>"+this.BOOK_MEMBER+"</div></td>";
	    		innerHTML += "	<td>";
	    		book_time_array = this.BOOK_TIME.split(",");
	
	    		for (var j = 0; j < book_time_array.length; j++){
	    			if(j < book_time_array.length){
	    			innerHTML += paraMap[book_time_array[j]]+",";
	    			}else if(j == book_time_array.length){
	        			innerHTML += paraMap[book_time_array[j]];
	    			}
	    		}
	    		+ "</td>";
	    		innerHTML += "<td align='center'>"+this.BOOK_DATE+"</td></tr>";
				i++;
    		}else{
    			pagecountval = this.pageCount;
    			pageval = this.page;
    		}
		});
        innerHTML += "</tbody></table>";
        innerHTML += "<div id='paging' style='text-align:center;position:absolute;'>";
	
        for(var k = 1; k<=pagecountval; k++) {
			if (k == pageval){
				innerHTML += '<b onclick="javascript:ajaxfunction('+monthval+','+k+',\''+roomnum+'\');">['+k+']</b>';
			}else{
				innerHTML += '<h1 onclick="javascript:ajaxfunction('+monthval+','+k+',\''+roomnum+'\');">['+k+']</h2>';
			}
        }
        if(roomnum =="ROOMA"){
        titleHTML +="<b>A회의실 예약 현황</b><br>";
        }else if(roomnum =="ROOMB"){
        	titleHTML +="<b>B회의실 예약 현황</b><br>";
        }
        titleHTML += "<img src='./image/mettingroom/grayline.png' width='350px;'>";
        $("#reserve_title").html(titleHTML);
        
        $("#reserve_status").html(innerHTML);
        }
    });
});
}
</script>
<div id="Parse_Area">
</div>
</body>
</html>