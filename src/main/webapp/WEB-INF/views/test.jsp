<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>

<button id="btnSearch" style="color: white; background-color: #4e73df;">검색</button>
<label id="lbl"></label>
<script>
 function GetData(str)
 {
	 $("#lbl").text(str)
 }
$(document).ready(function(){
	$("#btnSearch").click(function(){
		window.open(
			    "/test2",
			    "DescriptiveWindowName",
			    "left=100,top=100,width=320,height=320"
			  );
	})
	//window.open("/test2");
});
 
</script>


</body>
</html>