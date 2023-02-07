<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>email send result</title>
</head>
<body>
결과:<c:out value="${result}" />
</body>
</html>