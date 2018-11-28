<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
body {
text-align: center;
}
table {
border-bottom-right-radius : 25px;
border: 2px solid grey;
margin : auto;
padding: 50px;
}
table td {
text-align: left;
font-size: 20px;
margin: 10px;
padding: 5px;
}
.login > input {
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

.login > input:hover {
	background-color: rgba(0, 77, 77,0.5);
}
</style>

<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script>

$(document).ready(function() {
	$('a').click(function() {
		$(this).attr('href','/edu/project/main.html');
	/* 	location.href('http://www.naver.com'); */
	});
});
</script>

<body>
<h1>login</h1>
<form action="">
  <table>
	<tr>
	<td><label class="legend">아이디</label></td>
	<td><input name="userid" type="text" placeholder="아이디를 입력하세요"></td>
	</tr>
	<tr>
	<td><label class="legend">비밀번호</label></td>
	<td><input name="passwprd" type="password" placeholder="비밀번호를 입력하세요"></td>
	</tr>
  </table>
  <br><br>
  <div class="login">
    <input style="font-size: 30px" type="submit" id="login" value="login"/>
  </div> 
</form>
</body>
</html>