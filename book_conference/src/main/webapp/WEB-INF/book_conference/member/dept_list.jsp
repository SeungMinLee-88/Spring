<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script language="JavaScript" src="./js/main.js" charset="utf-8"></script>
<%
String close ="";
 close = request.getParameter("close");
	if(close.equals("y")){
%>
<script>
self.close();
</script>
<%
	}else{
		
	}
%>
<html>
<head>
<title>이용신청</title>
</head>
<style type="text/css">
.treebtn {
	border:0;
	background-color:white;
}
#tree > table {
	width: 80%;
	margin-left:20px;
}
#selecta {
	text-align:left;
	color:black;
	text-decoration:none;
}
#selecta:hover {
	background: black;
	color: white;
}
</style>
<body>
<img src="./image/folder/twinline.jpg" width="250px" style="margin-bottom:20px;"/>
<div id="outline" style="widht:380px;margin-left:30px;">
<div id="tree">
<table border=0 cellpadding=0 cellspacing=0>
<tr>
<td id="id0A">
	<button class="treebtn" type="button" id="id0AB" class="togglebtn" style="border:0;background-color:white;"
	onclick="javascript:ajaxfunction('${dept_list[0].DEPT_DEPTH}','${fn:replace(dept_list[0].DEPT_CODE,'0','')}')">
	<img src="./image/folder/plus.jpg" width="20px"></button>
	<img src="./image/folder/folder.jpg" width="20px">${dept_list[0].DEPT_NAME}
</td>
</tr>
</table>
</div>
</div>
<script>
function removeobj(depth,code){
	var tdval = "#id"+depth+code;
	var buttonval = tdval+"B";
	$(tdval).find("tr").remove();
	$(buttonval).attr("onclick", "javascript:ajaxfunction('"+depth+"','"+code+"');");
	$(buttonval).html('<img src="./image/folder/plus.jpg" width="20px">');
}
var paraMap = {"A":"1", "B":"2", 
"C":"3", "D":"4", "E":"5", "F":"6", "G":"7", "H":"8"};
function ajaxfunction(depth,code){
	var depth = depth;
	var code = code;
	var appendval = "#id"+depth+code;
	var buttonval= appendval+"B";
	var tree = $('.tree');
	$(buttonval).attr("onclick", "removeobj('"+depth+"','"+code+"');");
	$(buttonval).html('<img src="./image/folder/minus.jpg" width="20px">');
$(document).ready(function () {

	$.ajax({
        type : "POST",
        url : "./GetDeptList?depth="+depth+"&code="+code,
        dataType : "json",
        error : function(){
            alert("통신실패!!!!");
        },
        success : function(data){
        	var length= data.length;
        	if (length != 0){
        	$.each(data, function(idx){
        		var idval = "id"+this.DEPT_DEPTH+this.DEPT_CODE.replace(/0/g,'');
        		var test=""; 
				var replacecode = this.DEPT_CODE.replace(/0/g,'');
        		test += "<tr><td id="+idval+">";
        		for(var i=0;i<=this.DEPT_DEPTH;i++){
            			test += "&nbsp;";
            		}
        		if(this.DEPT_CHILD > 0){
        		test += '<button class="treebtn" type="button" id="'+idval+'B" onclick="javascript:ajaxfunction(\'';
            	test +=	this.DEPT_DEPTH + '\' , \'' + replacecode +'\')"><img src="./image/folder/plus.jpg" width="20px">';
            	}else{
            	test += '<img src="./image/folder/treeline.jpg" width="15px">';	
        		}
        		test +=	'</button>';
        		if(this.DEPT_DEPTH >1 ){
        		test +=	
                '<a href="#" id="selecta" onclick="javascript:inputdept(\''+this.DEPT_CODE+'\',\''+this.DEPT_NAME+'\')">';
                test +=	this.DEPT_NAME;
                test +=	'</a>';
        		}else{
        			test +=	this.DEPT_NAME;
        		}
        		test +=	"</td></tr>";
				$(appendval).append(test);
        	});
        	} else{
        	}
        }
    });
});
}
</script>
<br>
<form name="applyform" action="JoinApply" method="post" onsubmit="return check()">
<table class="membertable" width="400px"  height="500px" align="center"  border="0">
<tr>
	<td width="17%" bgcolor="#f5f5f5" align="center">이름</td>
		
	<td><input type="text" name="MEMBER_NAME" size="20"/></td>
</tr>
<tr>
	<td width="17%" bgcolor="#f5f5f5" align="center">부서</td>
		
	<td>
	<input type="text" name="MEMBER_DEPTNAME" size="20" readonly 
	placeholder="부서를 선택해주세요."/>
	<input type="hidden" name="MEMBER_DEPTCODE" size="20" readonly />
	</td>
</tr>
<tr>
	<td bgcolor="#f5f5f5" align="center">아이디</td>
	<td>
	<input type="text" name="MEMBER_ID" size="20" maxlength=15 />
	<input type="image" src="./image/formimage/findid.png" value="button" 
				onclick="openConfirmId(this.form); return false;" style="position:absolute;width:80px; margin-left:10px"/>
	</td>
</tr>
<tr>
	<td bgcolor="#f5f5f5" align="center">비밀번호</td>
	<td><input type="password" name="MEMBER_PW" size="15"/></td>
	</tr>
<tr>
	<td bgcolor="#f5f5f5" align="center">비밀번호 확인</td>
		
	<td><input type="password" name="MEMBER_PW2" size="15" /></td>
</tr>
<tr>
	<td bgcolor="#f5f5f5" align="center">이메일 주소</td>
	<td valign=middle>
	<input type="text" name="MEMBER_EMAIL1" size="13"/><font size=2px style="position:absolute; margin-left:5px; margin-top:5px;">@</font>
	<input type="text" name="MEMBER_EMAIL2" size="15" style="margin-left:20px;"/> 
	</td>
</tr>
</table>
<table width="400px" style="margin-bottom:20px;">
	<tr>
	<td align="center" >
	<br/><input type="image" src="./image/formimage/ok.png" value="submit" style= "width: 70px; height: 50px;"/>		
	</td>
	</tr>
</table>
</form>
</body>
</html>