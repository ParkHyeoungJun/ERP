<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>CSS Template</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
<table id="tab">
	<tr>
		<td class="td">클릭시 행 추가</td>
	</tr>
</table>
<script>
$(document).ready(function(){
	$(document).on("dblclick",".td",function(){
		$("#tab").append("<tr><td class='td'>클릭시 행 추가</td></tr>")
	});
});
</script>
</body>
</html>