<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공중화장실</title>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<!-- <link rel="sylesheet" href="button.css"> -->
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejuhallasan.css);
@font-face {
 font-family: 'Jeju Hallasan', cursive;
 font-weight: normal;
font-style: normal;
}

html, body { width: 100%; height: 100%; margin: 0; padding: 0;}

body {
	margin: 0px;
}
/* ========input=========== */
input {
	margin: 12px;
	padding: 20px;
}

input[type=text], [type=tel], [type=password], [type=date], [type=email]
	{
	width: 40%;
	padding: 12px 20px;
	margin: 8px 0;
	box-sizing: border-box;
	border: none;
	border-bottom: 2px solid #004d4d;
}

input[type=date], input::placeholder, textarea::placeholder {
/* 	font-family: 'Jeju Hallasan', cursive; */
	font-size: 15px;
}

/* =====로그인창 - 버튼 ======= */
.modalbutton > input {
	margin: 10px;
	padding: 10px 15px;
	font-size: 12pt;
	cursor: pointer;
	text-align: center;
	color: #fff;
	background-color: #004d4d;
	border: none;
	border-radius: 15px;
	box-shadow: 0 4px rgb(0, 77, 77);
}

.modalbutton > input:hover {
	background-color: rgba(0, 77, 77,0.5);
}
/* ========nav== 1 ========= */
.navbar {
	overflow: hidden;
	background-color: Teal;/* ------- */
}

.navbar a {
	color: white;
	float: left;
	font-size: 20px;
	text-align: center;
	padding: 14px 16px;
/* 	padding-top: 25px;
	padding-bottom: 25px; */
	text-decoration: none;
}

.navbar a:hover {
	background-color: red;
}

nav {
	float: right;
}
.setDiv {
	text-align: center;
}

.mask {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 9999;
	background-color: #000;
	display: none;
}

.window {
	display: none;
	background-color: #ffffff;
	width: 350px;
	height: 220px;
	z-index: 99999;
	opacity: 0.85;
	padding-top: 10px;
}

#loginForm {
	font-family: 'Jeju Hallasan', cursive;
}

#loginForm input[type=text], input[type=password] {
	width: 50%;
}

/* ========nav== 2 ========= */
.buttonlist {
background: Teal;
text-align: center;
margin: 0;
}
.buttonlist > h1 {
margin: 0px;
font-family: 'Jeju Hallasan', cursive;
font-size: 40px;
}
.buttonlist input[type=button] {
font-family: 'Jeju Hallasan', cursive;
font-size: 20pt;
width: 130px;
background: Teal;
color:white;
border: 1px solid Teal;
margin: 0;
}
.buttonlist input[type=button]:hover{
font-family: 'Jeju Hallasan', cursive;
font-size: 20pt;
width: 130px;
background: red;
color:white;
border: 1px solid Teal;
margin: 0;
}

/* ========content=========== */
.content { 
    width: 100%; height: 1000px;
    padding : 30px;
    margin-left: -17px; /* 우측 스크롤바가 보여야 하므로 17px만큼 외쪽으로 땡겨주기 */
    padding-left: 17px; /* 좌측으로 들어간만큼 패딩값 지정 */
    }
/* ========suggestion======= */
#d3 {
	text-align : center;
	width : 80%;
	border: none;
	margin : auto; 
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
	background-color : Teal;
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
th:nth-of-type(6) {
	color : #e6ffe6;
}
tr:hover {
	background-color : #ccff99;
}
a {
	text-decoration : none;
}
.d3_button, #d3 button, #check {
	width:90px;
	height : 40px;
    background-color: #f8585b;
    border: none;
    color:#fff;
    padding: 10px 0;
    text-align: center;
    text-decoration: none; 
    margin: 4px;
    cursor: pointer;
	border-radius:10px 0 10px 0;
}


/* ========footer=========== */
.footer {
	text-align: center;
	font-size: 20px;
	background : black;
	color: white;
	position : relative;
	bottom :0em;
	width : 100%;
	height: 100px;
	margin-bottom:0px;
	padding: 20px;
}
.footer > ul {
    list-style: none;
}

</style>

</head>
<body>
<!-- 모달 --LOG IN------- -->
<div class="setDiv">
	<div class="mask"></div>
	<div class="window">
		<form id="loginForm" action="/webprc/join" method="post">
			아이디 <input name="userid" type="text"><br> 
			패스워드 <input name="userpassword" type="password"><br>
			<div class="modalbutton">
			<input type="hidden" name="action" value="check">
			 <input type="submit" id="sendLoginButton" name="sendLoginButton" value="로그인">
			 <input type="button" id="CancleButton" name="CancleButton" value="취소" onclick="cancel();">
			</div>
		</form>
	</div>
</div>
<!-- --------nav-- 1 -------- -->
<div class="navbar">
	<nav>
		<a href="/webprc/jsp/join.jsp" id="nav_signup" onclick="fnMove('1')">회원가입</a> 
		<a id="nav_login">로그인</a>
		<a id="nav_logout" style="display: none" onclick="logout();">로그아웃</a>
		<c:if test="${login!=null}">
		<script>	
		$('#nav_login').css("display","none");
		$('#nav_logout').css("display","inline");
		</script>
		</c:if>
		<c:if test="${login==null}">
		<script>	
		$('#nav_login').css("display","inline");
		$('#nav_logout').css("display","none");
		</script>
		</c:if>
		
		
	</nav>
</div>



<!-- -------nav-- 2 --------- -->
<div class="buttonlist">
	<h1>public restroom</h1>  
	<a href ="/webprc/main"><input type="button" id="b1" value="맵"></a>
	<a href ="/webprc/main?viewview=list"><input type="button" id="b2" value="리스트"></a>
	<a href ="/webprc/main?viewview=suggestion"><input type="button" id="b3" value="건의사항"></a>
</div>
<!-- -------content----------- -->
<div class="content">

<c:if test="${empty param.viewview }">
	<div id="d1"><jsp:include page="toiletView.jsp"/></div>
</c:if>
<c:if test="${param.viewview == 'list'}">
	<div id="d2"><jsp:include page="makeTable1.jsp"/></div>
</c:if>

<c:if test="${param.viewview == 'suggestion'}">
<c:if test="${!empty login }">

<div id ="d3">
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
				<td><a class = "a1" href = "/webprc/main?viewview=suggestion&id=${vo.id}&action=read" >${vo.id}</a></td>
				<td class ="type"><a class = "a1" href = "/webprc/main?viewview=suggestion&con_type=${vo.con_type}&action=listType" >${vo.con_type}</a></td>
				<td class ="title"><a class = "a1" href = "/webprc/main?viewview=suggestion&id=${vo.id}&action=read" >${vo.title}</a></td>
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
		<form method="get" action="/webprc/main">
			<select name ="searchType">
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name ="key">
			<input class = "d3_button" type="submit" value="검색">
			<input type="hidden" name ="action" value ="search">
			<input type="hidden" name ="viewview" value ="suggestion">
		</form>
	</div>
	
	<div style ="${style }">
	<a class= "a1" href = "/webprc/main?viewview=suggestion">
	<button>게시판</button></a>
	</div>
	
	<button id = "insertButton">게시물 작성</button>
		
	<div id = "insertBox" style = "display:none">
		<form method ="post"  action="/webprc/main?viewview=suggestion" id="i" >
			<input class="inputbox" type="text" placeholder="작성자명을 입력해주세요." name="writer" required><br>
			<select  class="inputbox" name = "con_type" required>
				<option value="건의사항">건의사항</option>
				<option value="소소한 이야기">소소한 이야기</option>
			</select>
			
			<input class="inputbox"type="text" placeholder="제목을 입력해주세요." name="title" required><br>
			<textarea class="inputbox" rows="5" cols="50" placeholder="내용을 입력해주세요." name="content"></textarea><br>
			<input class = "d3_button" type="submit" value ="저장">
			<input class = "d3_button" type="reset" value ="재작성">
			<input type="hidden" name="action" value="insert">
			<input class = "d3_button" id="cancelButton" type="button" value ="취소">
		</form>
	</div>
	
	<c:if test= "${param.action == 'read' }">
	<div id = "modifyBox">
		<form method = "post" action="/webprc/main?viewview=suggestion" id="ud">
			<input class="inputbox" type="text" name="writer" value="${vo.writer}"><br>
			<select class="inputbox" name="con_type"  required> 
				<option value="건의사항"<c:if test="${vo.con_type=='건의사항'}">selected="selected"</c:if>>건의사항</option>
				<option value="소소한 이야기"<c:if test="${vo.con_type=='소소한 이야기'}">selected="selected"</c:if>>소소한 이야기</option>
			</select>
			<input class="inputbox" type="text" name="title" value="${vo.title}"><br>
			<textarea class="inputbox" rows="5" cols="50" name="content"> ${vo.content} </textarea><br>
			<input id ="check" type="button" value ="확인">
			<input class = "d3_button" type="submit" value="수정">
			<a href ="/webprc/main?viewview=suggestion&id=${param.id}&action=delete" > <input type="button" value="삭제"> </a>
			<input type="hidden" name="id" value="${param.id }">
			<input type="hidden" name="action" value="update">
		</form>
	</div>
	</c:if>
</div>
</div>
</c:if>

<c:if test="${empty login }">
	<h3>${ sessionScope.refuse }</h3>
</c:if>
</c:if>









</div>



<!-- ------------------------- -->





















<!-- --------footer---------- -->
<div class="footer">
<ul>
<li style="cursor : pointer;"><img width="25px" height="30px" src="/webprc/images/전화기02.png"> (02)427-0123</li>
<li><img width="25px" height="28px" src="/webprc/images/이메일02.png"> abc@naver.com</li>
</ul>
</div>

<!-- --------게시판---------- -->

<script>
$(document).ready(function () {
	$('#check').click(function(){
		$('#modifyBox').hide();
	});
	$('#insertButton').click(function () {  
	    if($("#insertBox").css("display") == "none"){   
	        $('#insertBox').css("display","block");  
	    } else {  
	        $('#insertBox').css("display","none");  
	    } 
		$('#modifyBox').hide();
	});
	$('#cancelButton').click(function() {
		 $('#insertBox').css("display","none"); 
	})
});
</script>

<!-- ---------------------- -->

<script>
	//======== 로그인 취소 버튼 ========
	function cancel() {
		location.href="/webprc/jsp/main.jsp";
	}	
		
	//=====로그아웃기능===========
	function logout(){
		location.href="/webprc/join?action=logout";
	}
	
	// ======== 로그인 href 디폴트 해제 ========
	$(document).ready(function() {
		$('#nav_login').click(function(e) {
			// preventDefault는 href의 링크 기본 행동을 막는 기능입니다.
			e.preventDefault();
			wrapWindowByMask();
		});
	});
	
	//  ======== 모달 - 로그인 기능 ========
	function wrapWindowByMask() {
		// 화면의 높이와 너비 -> 변수로 만듬
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();

		// 마스크의 높이와 너비를 화면의 높이와 너비 변수로 설정
		$('.mask').css({
			'width' : maskWidth,
			'height' : maskHeight
		});
		// fade 애니메이션 : 천천히 80%의 불투명
		/* $('.mask').fadeIn(10); */
		$('.mask').fadeTo("slow", 0.8);

		// 레이어 팝업을 가운데로 띄우기 위해, 화면의 높이와 너비의 가운데 값과 스크롤 값을 더하여 변수로 만듬
		var left = ($(window).scrollLeft() + ($(window).width() - $(
				'.window').width()) / 2);
		var top = ($(window).scrollTop() + ($(window).height() - $(
				'.window').height()) / 2);

		// css 스타일을 변경
		$('.window').css({
			'left' : left,
			'top' : top,
			'position' : 'absolute'
		});

		// 레이어 팝업을 띄움
		$('.window').show();
	}// =================끝
	</script>
</body>
</html>