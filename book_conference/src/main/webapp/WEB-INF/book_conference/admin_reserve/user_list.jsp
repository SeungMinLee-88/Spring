<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<html>
<head>
 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사용자리스트</title>
</head>
<style type="text/css">
.treebtn {
	border:0;background-color:white;
}
#tree > table {
	width: 80%;
	margin-left:20px;
}
#selectb {
	text-align:left;
	color:black;
	text-decoration:none;
	margin-bottom:10px;
}

#selectb:hover {
	background: black;
	color: white;
}
</style>
<body>
<img src="./image/folder/twinlineuser.jpg" width="350px" style="margin-bottom:20px;"/>
<div id="outline" style="border: 1px solid black;widht:380px;min-height:700px;height:100%;margin-left:30px;">
<div id="tree">
<table border=0 cellpadding=0 cellspacing=0>
<tr>
<td id="id0A">
	<button class="treebtn" type="button" id="id0AB"
	onclick="javascript:ajaxfunction('${dept_list[0].DEPT_DEPTH}','${fn:replace(dept_list[0].DEPT_CODE,'0','')}','0')">
	<img src="./image/folder/plus.jpg" width="20px"></button>
	<img src="./image/folder/folder.jpg" width="20px">${dept_list[0].DEPT_NAME}
</td>
</tr>
</table>
</div>
<script>
function inputuser(userid){
	var userid = userid;
	opener.document.bookform.BOOK_MEMBER.value=userid;
	self.close();
}
function removeobj(depth,code){
	var tdval = "#id"+depth+code;
	var buttonval = tdval+"B";
	$(tdval).find("tr").remove();
	$(buttonval).attr("onclick", "javascript:ajaxfunction('"+depth+"','"+code+"');");
	$(buttonval).html('<img src="./image/folder/plus.jpg" width="20px">');
}
function removeobj2(depth,idval,depcode,child){
	var tdval = "#"+idval;
	var buttonval = "#"+idval+"B";
	var child = child;
	var replacecode = depcode.replace(/0/g,'');	
	$(tdval).find("tr").remove();
	if (child =="1" ){
	$(buttonval).attr("onclick", "javascript:ajaxfunction('"+depth+"','"+replacecode+"');ajaxfunction2('"+depth+"','"+idval+"','"+depcode+"','"+child+"');");
	$(buttonval).html('<img src="./image/folder/plus.jpg" width="20px">');
	}else if(child == "2"){
	$(buttonval).attr("onclick", "javascript:ajaxfunction('"+depth+"','"+replacecode+"');ajaxfunction2('"+depth+"','"+idval+"','"+depcode+"','"+child+"');");
	$(buttonval).html('+<img src="./image/folder/plus.jpg" width="20px">');
	}
}
var paraMap = {"A":"1", "B":"2", 
"C":"3", "D":"4", "E":"5", "F":"6", "G":"7", "H":"8"};

function ajaxfunction(depth,code,child){

	var depth = depth;
	var code = code;
	var appendval = "#id"+depth+code;
	var buttonval= appendval+"B";
	var child = child;
	if(child =="0"){
		$(buttonval).attr("onclick", "removeobj('"+depth+"','"+code+"');");
		$(buttonval).html('<img src="./image/folder/minus.jpg" width="20px">');
	}
	
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
				var child = "";
        		test += "<tr><td id="+idval+">";
        		for(var i=0;i<=this.DEPT_DEPTH;i++){
            			test += "&nbsp;";
            		}
        		if(this.DEPT_CHILD > 0 && this.USER_CHILD == 0){
        		child =0;
        		test += '<button class="treebtn" type="button" id="'+idval+'B" onclick="javascript:ajaxfunction(\'';
        		test +=	this.DEPT_DEPTH + '\' , \'' + replacecode +'\',\''+child+'\')"><img src="./image/folder/plus.jpg" width="20px">';
        		}else if(this.DEPT_CHILD == 0 && this.USER_CHILD > 0){
        		child =1;
            	test += '<button class="treebtn" type="button" id="'+idval+'B" onclick="javascript:ajaxfunction2(\'';
                test +=	this.DEPT_DEPTH + '\', \'' + idval + '\' , \'' + this.DEPT_CODE +'\',\''+ child+'\')"><img src="./image/folder/plus.jpg" width="20px">';
        		}else if(this.DEPT_CHILD > 0 && this.USER_CHILD > 0){
        		child =2;
            	test += '<button class="treebtn" type="button" id="'+idval+'B" onclick="javascript:ajaxfunction(\'';
            	test +=	this.DEPT_DEPTH + '\' , \'' + replacecode +'\');ajaxfunction2(\'';
                test +=	this.DEPT_DEPTH + '\', \'' +idval + '\' , \'' + this.DEPT_CODE +'\',\''+child+'\')"><img src="./image/folder/plus.jpg" width="20px">';	
            	}else{
            	test += '<img src="./image/folder/treeline.jpg" width="15px">';
        		}
        		test +=	'</button>';
        		test +=	this.DEPT_NAME;
        		test +=	"</td></tr>";
				$(appendval).append(test);
        	});
        	} else{
        	}
        }
    });
});
}

function ajaxfunction2(depth,idval,depcode,child){
	var child = child;
	var depth = depth;
	var nbspdepth = parseInt(depth)+4;
	var appendval = "#"+idval;
	var depcode = depcode;
	var replacecode = depcode.replace(/0/g,'');
	var buttonval= "#id"+depth+depcode.replace(/0/g,'')+"B";
	if(child =="1" || child == "2"){
	$(buttonval).attr("onclick", "removeobj2('"+depth+"','"+idval+"','"+depcode+"','"+child+"');");
	$(buttonval).html('<img src="./image/folder/minus.jpg" width="20px">');
	}
$(document).ready(function () {
	$.ajax({
        type : "POST",
        url : "./SelectUserList?depcode="+depcode,
        dataType : "json",
        error : function(){
            alert("통신실패!!!!");
        },
        success : function(data){
        	var length= data.length;
        	$.each(data, function(idx){
        		var test=""; 
        		test += "<tr><td>";
        		for(var i=0;i<=nbspdepth;i++){
            			test += "&nbsp;";
            		}
        		test += '<img src="./image/folder/treeline.jpg" width="15px">';
        		test += '<img src="./image/folder/user.jpg" width="15px" style="margin-left:10px;margin-right:10px;">';
	       		test +=	'<b id="selectb" onclick="javascript:inputuser(\''+this.MEMBER_ID+'\')">';
	       		test +=	this.MEMBER_NAME +"</b>";
	       		test +=	"</td></tr>";
				$(appendval).append(test);	
        	});
        }
    });
});
}
</script>
</body>
</html>