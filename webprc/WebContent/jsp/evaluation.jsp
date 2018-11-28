
<%@page import="model.vo.EvaluationVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% EvaluationVO vo=(EvaluationVO)session.getAttribute("result"); %>
평점: <%= vo.getTotal() %> 점
</body>

</html>