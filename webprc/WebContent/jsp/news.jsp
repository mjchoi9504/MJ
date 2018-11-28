<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/hanna.css);

body {
text-align: center;
font-family: 'Hanna', fantasy;
}
table {
border-radius : 30px;
border: 2px double rgb(0, 107, 160);
margin: auto;
padding: 20px;
box-shadow: 0px 0px 50px rgba(0, 107, 160, 0.4);
}
th  {
font-size : 30px;
border-top: 6px double rgb(0, 107, 160); 
border-bottom: 6px double rgb(0, 107, 160); 
padding: 10px;
}
td {
border-bottom: 4px dotted rgb(0, 107, 160); 
padding: 10px;
}
td a {
text-decoration: none;
}

input,textarea {
margin: 10px;
}
input:hover,textarea:hover {
background: rgba(0, 153, 153, 0.2);
}
#f {
border-radius : 25px;
border:5px dotted rgb(0, 153, 153);
width: 50%;
margin: auto;
}
</style>
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
<c:if test="${param.action == 'search'}">
<h1> ${param.key}을 포함하는 News 글 리스트 </h1>
</c:if>
<c:if test="${param.action != 'search'}">
<h1> 뉴스 게시판 </h1>
</c:if>

<div id = "box">

<c:if test="${!empty list}"> 
	<table style ="margin : 0 auto">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
<c:forEach var ="vo" items="${ list }">
		<tr>
			<td><a class = "a1" href = "/webprc/news?id=${vo.id}&action=read" >${vo.id}</a></td>
			<td class ="title"><a class = "a1" href = "/webprc/news?id=${vo.id}&action=read" >${vo.title}</a></td>
			<td><a class = "a1" href ="/webprc/news?writer=${vo.writer}&action=listwriter" >${vo.writer}</a></td>
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
		<form method="get" action="/webprc/news">
			<select name ="searchType">
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name ="key">
			<input type="submit" value="뉴스검색">
			<input type="hidden" name ="action" value ="search">
		</form>
	</div>
	<div style ="${style }"><a class= "a1" href = "/webprc/news"><button>뉴스 홈</button></a></div>

	<button id = "b1">뉴스 작성</button>
	
	<div id = "insertBox" style = "display:none">
		<form method ="post"  action="/webprc/news" id="i" >
			<input class="inputbox" type="text" placeholder="작성자명을 입력해주세요." name="writer"><br>
			<input class="inputbox"type="text" placeholder="제목을 입력해주세요." name="title"><br>
			<textarea class="inputbox" rows="5" cols="50" placeholder="내용을 입력해주세요." name="content"></textarea><br>
			<input type="submit" value ="저장">
			<input type="reset" value ="재작성">
			<input type="hidden" name="action" value="insert">
			<input id="b2" type="button" value ="취소">
		</form>
	</div>
	
<c:if test= "${param.action == 'read' }">
	<div id = "modifyBox">
		<form method = "post" action="/webprc/news" id="ud">
			<input class="inputbox" type="text" name="writer" value="${vo.writer}"><br>
			<input class="inputbox" type="text" name="title" value="${vo.title}"><br>
			<textarea class="inputbox" rows="5" cols="50" name="content"> ${vo.content} </textarea><br>
			<input id ="check" type="button" value ="확인">
			<input type="submit" value="수정">
			<a href ="/webprc/news?id=${param.id}&action=delete" > <input type="button" value="삭제"> </a>
			<input type="hidden" name="id" value="${param.id }">
			<input type="hidden" name="action" value="update">
		</form>
	</div>
</c:if>

</div>

<!-- form 태그 안에 버튼으로 바로 주면 submit으로 작용해버린다 조심해라 -->
</body>
</html>