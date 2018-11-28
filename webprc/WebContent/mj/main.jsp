<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공중화장실</title>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejuhallasan.css);
@font-face {
 font-family: 'Jeju Hallasan', cursive;
 font-weight: normal;
font-style: normal;
}
html {  overflow: hidden;  }
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
.buttonlist > input[type=button] {
font-family: 'Jeju Hallasan', cursive;
font-size: 20pt;
width: 130px;
background: Teal;
color:white;
border: 1px solid Teal;
margin: 0;
}
.buttonlist > input[type=button]:hover{
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
    margin-left: -17px; /* 우측 스크롤바가 보여야 하므로 17px만큼 외쪽으로 땡겨주기 */
    padding-left: 17px; /* 좌측으로 들어간만큼 패딩값 지정 */
    }

/* ========footer=========== */
.footer {
	text-align: center;
	font-size: 20px;
	background : black;
	color: white;
	position : absolute;
	bottom :0em;
	width : 100%;
	 margin-left:0px; margin-bottom:-1px;
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
		<form id="loginForm">
			아이디 <input name="userid" type="text"><br> 
			패스워드 <input name="passwprd" type="password"><br>
			<div class="modalbutton">
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
		<a id="nav_login">로그 인</a>
	</nav>
</div>
<!-- -------nav-- 2 --------- -->
<div class="buttonlist">
	<h1>public restroom</h1> 
	<input type="button" name="map" value="맵">
	<input type="button" name="list" value="리스트">
	<input type="button" name="report" value="건의사항">
</div>
<!-- -------content----------- -->
<div class="content">
본문내용... 
</div>
<!-- --------footer---------- -->
<div class="footer">
<ul>
<li style="cursor : pointer;"><img width="25px" height="30px" src="/webprc/images/전화기02.png"> (02)427-0123</li>
<li><img width="25px" height="28px" src="/webprc/images/이메일02.png"> abc@naver.com</li>
</ul>
</div>
<script>
	//======== 로그인 취소 버튼 ========
	function cancel() {
		location.href="main.jsp";
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