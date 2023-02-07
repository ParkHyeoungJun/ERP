<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>email 연동 테스트 </title>

</head>
<body>
<form action="/email/send" method="post">
<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token}" />
<input type="text" name="from" value="phj830914@naver.com"><br>
<input type="text" name="to" value="phj830914@naver.com"><br>
<input type="text" name="subject" value="제목"><br>
<textarea name="content" rows="30" cols="50">email 발송 테스트 !!!</textarea>
<button type="submit"> 전송 </button>
</form>
</body>
</html>