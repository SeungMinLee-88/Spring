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
<title>예약 현황</title>
</head>
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
#booktag {
	margin-left:10px;
	margin-top:30px;
	text-decoration:none;
}
#booktag >font:hover {
	color: blue;
}
#booktag >b:hover {
	color: blue;
}
.reservestatus, .reservestatus th, .reservestatus td{
	font-size:13px;
	border-collapse:collapse;
}         
.reservestatus  tr {
	border-bottom:1px solid CECDCD;
}

</style>
<body>
<div id="imgbox" style="width:600px;height:400px;margin-left:200px;margin-top: 40px;position:relative;display: inline-block;">
<img src="./image/mettingroom/resrve_status_title.jpg" style="width:500px;margin-left:50px;">
<img src="./image/mettingroom/meetingroom.jpg" style="width:400px;margin-left:80px;margin-top: 20px;">
<div id="aroom_div" 
style="background-color:gray; opacity: 0.5; width:126px;height:60px;word-wrap:break-word; overflow-x:hidden;overflow-y:hidden;
position:absolute;top:96px;left:100px;" onclick="javascript:ajaxfunction(<%=month+1%>,1,'ROOMA');">
</div>
<div id="broom_div"
style="background-color:gray; opacity: 0.5; width:126px;height:60px;word-wrap:break-word; overflow-x:hidden;overflow-y:hidden;
position:absolute;top:156px;left:100px;" onclick="javascript:ajaxfunction(<%=month+1%>,1,'ROOMB');">
</div>
<div id="block_div" 
style="background-color:#FF0000; opacity: 0.5; width:126px;height:60px;word-wrap:break-word; overflow-x:hidden;overflow-y:hidden;
position:absolute;top:218px;left:100px;">
</div>
<div id="block_div" 
style="background-color:#FF0000; opacity: 0.5; width:126px;height:60px;word-wrap:break-word; overflow-x:hidden;overflow-y:hidden;
position:absolute;top:279px;left:100px;">
</div>
</div>
<br>
<div id="status_content" style="height:450px;margin-left:200px;position:relative;display: inline-block;">
<div id="reserve_title" style='margin-left:20px;width:350px;height:60px;position:relative;display: inline-block;'>
</div>
<div id="reserve_status" style='margin-left:20px;width:1000px;text-align:center;position:relative;display: inline-block;'>
</div>
</div>
<input type="hidden" id ="monthval" value="<%=month+1 %>"/>
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
$(document).ready(function () {
	$.ajax({
        type : "POST",
        url : "./MemberReserveStatus?year=2018&month="+monthval+"&page="+page+"&roomnum="+roomnum,//호출 URL을 설정한다. GET방식일경우 뒤에 파라티터를 붙여서 사용해도된다.
        dataType : "json",
        error : function(){
            alert("통신실패!!!!");
        },
        success : function(data){
        $("#reserve_status").val("");
        var titleHTML ="";
        var innerHTML ="";
        if(monthval == <%=month+1%>){
        	innerHTML += '<div style="height:60px;>';
    		innerHTML += '<font color="black" style="font-weight:bold;">|&nbsp;&nbsp;'+monthval+'월&nbsp;&nbsp;|</font>';	
    			if(monthval <12){
    			innerHTML += 
    		'<a href="#" id="booktag"><b id=\'nextmonth\' onclick="javascript:ajaxfunction('+(monthval+1)+',1,\''+roomnum+'\');">next</b></a></div>';
    			}
    		}else if(monthval > <%=month+1%>){
            innerHTML += "<div>";
            innerHTML += 
           	innerHTML +=
           	'<a href="#" id="booktag"><b id=\'prevmonth\' onclick="javascript:ajaxfunction('+(monthval-1)+',1,\''+roomnum+'\');">prev</b></a>';
        	innerHTML += '<font color="black" style="font-weight:bold;">|&nbsp;&nbsp;'+monthval+'월&nbsp;&nbsp;|</font>';
       			if(monthval <12){
        	innerHTML += 
            '<a href="#" id="booktag"><b id="nextmonth"onclick="javascript:ajaxfunction('+(monthval+1)+',1,\''+roomnum+'\');">next</b></a></div>';
       			}
       		}
        innerHTML += '</div>';
		innerHTML += '<table class="reservestatus" width="900px" align="center">';
        var i=1;
		innerHTML += '<tr style="border-bottom: 5px solid #aaa;"><td width="100px" align="center">번호</td>';
		innerHTML += '<td width="100px" align="center">예약자</td>';
		innerHTML += '<td align="center" width="560px">예약시간</td>';
		innerHTML += '<td width="120px" align="center">예약일자</td></tr>';
		var count = data;
		var length= data.length;
		var pagecountval;
		var pageval;
		if(length ==2 ){
			innerHTML += '<tr><td width="700px" colspan="4" height="300" align="center" STYLE="table-layout: fixed;">등록된 예약이 없습니다.</td></tr>';
		}
		$.each(data, function(idx){
		if(length ==2 ){
		}else{
			if(idx <length-2){
	    		innerHTML += '<tr align="center" height="30px" height="30px" style="border-bottom: 1px solid #aaa;">';
	    		innerHTML += '<tr style="border-bottom: 1px solid #aaa;"><td align="center">'+ this.RNUM +'</td>';
	    		innerHTML += "<td align='center'>"+this.BOOK_MEMBER+"</td>";
	    		innerHTML += '<td width="560px">';
	    		book_time_array = this.BOOK_TIME.split(",");
	    		for (var j = 0; j < book_time_array.length; j++){
	    			if(j < (book_time_array.length)-1){
	    			innerHTML += 
	    			'<font style="margin-top:10px;margin-bottom:10px;">'+paraMap[book_time_array[j]]+",</font>";
	    			}else{
	        		innerHTML += 
	        		'<font style="margin-top:10px;margin-bottom:10px;">'+paraMap[book_time_array[j]]+'</font>';
	    			}
	    		}
	    		+ "</td>";
	    		innerHTML += "<td align='center'>"+this.BOOK_DATE+"</td></tr>";
				i++;
    		}else{
    			pagecountval = this.pageCount;
    			pageval = this.page;
    		}
	}
});
        innerHTML += "</tbody></table>";
        innerHTML += '<table align="center" width="900px" style="margin-top:15px;">';
        innerHTML += '<tr><td align="center">';
        for(var k = 1; k<=pagecountval; k++) {
        	//alert("k :"+k);
			if (k == pageval){
		innerHTML +=
		'<font size="4px" color="#FE2E2E" style="font-weight:bold;">['+k+']</font>';
			}else{
		innerHTML += 
		'<a href="#" onclick="javascript:ajaxfunction('+monthval+','+k+',\''+roomnum+'\');">';
		innerHTML += '<font color="black">['+k+']</font></a>';
			}
        }
        if(roomnum =="ROOMA"){
        titleHTML +='<font size="3px" style="font-weight: bold;color:#FE2E2E;">▶&nbsp;A회의실 예약 현황</b></font>';
        }else if(roomnum =="ROOMB"){
        titleHTML +='<font size="3px" style="font-weight: bold;color:#FE2E2E;">▶&nbsp;B회의실 예약 현황</b></font>';
        }
        titleHTML += '<img src="./image/mettingroom/grayline.png" width="350px;" style="margin-bottom:10px;">';
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