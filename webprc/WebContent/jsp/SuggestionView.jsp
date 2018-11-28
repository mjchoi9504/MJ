<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	* {
		text-align :center;
	}

	#box {
		width : 1100px;
		border : 1px inset red;
		border-radius : 15px;
		margin : auto;
		padding : 20px;
		background-color : #ffe6e6;
		box-shadow:-5px -5px 70px red;
		opacity : 0.9;
	}
	
	.inputbox {
		width : 300px;
		font-size : 15px;
       	font-family: 'Jeju Hallasan', serif;
	}
	#searchBox{
		margin : 10px;
	}
	#insertBox{
		border : 2px dotted black;
		border-radius :15px;
		width : 400px;
		margin : 15px auto;
		padding : 10px;
	}
	#modifyBox{
		border : 2px solid green;
		border-radius :15px;
		width : 400px;
		margin : 15px auto;
		padding : 10px;
		box-shadow : 0 0 10px red;
	}

	td {
		width : 70px;
		border-bottom : 1px dotted black;
	}
	
	td.type{
		width:125px;
	}
	
	td.title {
		width: 400px;
	}
	
	td.date{
		width:200px;
	}
	th {
		border-right : 2px inset green;
		border-bottom : 2px inset green;
		background-color : #b35900;
	}
	
	th:nth-of-type(1) {
		color : #ffcccc;
	}
	th:nth-of-type(2) {
		color : #ffedcc;
	}
	th:nth-of-type(3) {
		color : #ffffcc;
	}
	th:nth-of-type(4) {
		color : #ccffcc;
	}
	th:nth-of-type(5) {
		color : #ccccff;
	}

	tr:hover {
		background-color : #ccff99;
	}
	
	a {
		text-decoration : none;
	}
</style>


<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script>

$(document).ready(function () {
	$('#check').click(function(){
		$('#modifyBox').hide();
	});
	$('#b1').click(function () {  
	    if($("#insertBox").css("display") == "none"){   
	        $('#insertBox').css("display","block");  
	    } else {  
	        $('#insertBox').css("display","none");  
	    }  
		$('#modifyBox').hide();
	});
	$('#b2').click(function() {
		 $('#insertBox').css("display","none"); 
	})
});

</script>


</head>

<body>

<div>
<c:if test="${param.action == 'search'}">
<h1> ${param.key}을 포함하는 글 리스트 </h1>
</c:if>
<c:if test="${param.action != 'search'}">
<h1> 해우소 </h1>
</c:if>

<div id = "box">

<c:if test="${!empty list}"> 
	<table style ="margin : 0 auto">
		<tr>
			<th>번호</th>
			<th>분류</th> 
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
<c:forEach var ="vo" items="${ list }">
		<tr>
			<td><a class = "a1" href = "/webprc/suggestion?id=${vo.id}&action=read" >${vo.id}</a></td>
			<td class ="type"><a class = "a1" href = "/webprc/suggestion?con_type=${vo.con_type}&action=listType" >${vo.con_type}</a></td>
			<td class ="title"><a class = "a1" href = "/webprc/suggestion?id=${vo.id}&action=read" >${vo.title}</a></td>
			<td>${vo.writer}</td>
			<td class ="date">${vo.writeDate}</td>
			<td>${vo.cnt}</td>
		</tr>	
</c:forEach>
	</table>
</c:if>

<c:if test="${empty list}"> 
	<h3>${ msg }</h3>
</c:if>
	<div id = "searchBox">
		<form method="get" action="/webprc/suggestion">
			<select name ="searchType">
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name ="key">
			<input type="submit" value="검색">
			<input type="hidden" name ="action" value ="search">
		</form>
	</div>
	<div style ="${style }"><a class= "a1" href = "/webprc/join"><button>게시판</button></a></div>

	<button id = "b1">게시물 작성</button>
	
	<div id = "insertBox" style = "display:none">
		<form method ="post"  action="/webprc/suggestion" id="i" >
			<input class="inputbox" type="text" placeholder="작성자명을 입력해주세요." name="writer" required><br>
			<select  class="inputbox" name = "con_type" required>
				<option value="건의사항">건의사항</option>
				<option value="소소한 이야기">소소한 이야기</option>
			</select>
			<input class="inputbox"type="text" placeholder="제목을 입력해주세요." name="title" required><br>
			<textarea class="inputbox" rows="5" cols="50" placeholder="내용을 입력해주세요." name="content"></textarea><br>
			<input type="submit" value ="저장">
			<input type="reset" value ="재작성">
			<input type="hidden" name="action" value="insert">
			<input id="b2" type="button" value ="취소">
		</form>
	</div>
	<c:if test= "${param.action == 'read' }">
	<div id = "modifyBox">
		<form method = "post" action="/webprc/suggestion" id="ud">
			<input class="inputbox" type="text" name="writer" value="${vo.writer}"><br>
			<select class="inputbox" name="con_type"  required> 
				<option value="건의사항"<c:if test="${vo.con_type=='건의사항'}">selected="selected"</c:if>>건의사항</option>
				<option value="소소한 이야기"<c:if test="${vo.con_type=='소소한 이야기'}">selected="selected"</c:if>>소소한 이야기</option>
			</select>
			<input class="inputbox" type="text" name="title" value="${vo.title}"><br>
			<textarea class="inputbox" rows="5" cols="50" name="content"> ${vo.content} </textarea><br>
			<input id ="check" type="button" value ="확인">
			<input type="submit" value="수정">
			<a href ="/webprc/suggestion?id=${param.id}&action=delete" > <input type="button" value="삭제"> </a>
			<input type="hidden" name="id" value="${param.id }">
			<input type="hidden" name="action" value="update">
		</form>
	</div>
</c:if>
</div>
</body>
</html>