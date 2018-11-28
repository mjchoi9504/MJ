<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

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
.join > input {
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

.join > input:hover {
	background-color: rgba(0, 77, 77,0.5);
}
</style>
</head>

<body>	
<h1>Join</h1>
<form id="f" method="post" action="/webprc/join">
<table>
		<tr>
			<td>이름</td>
			<td><input type="text" id="name" name="name" size="30" placeholder="이름을 입력하세요" required="required"></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" id="id" name="id" size="30" placeholder="아이디를 입력하세요" required="required"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" id="password" size="30" name="password" placeholder="비밀번호를 입력하세요" required="required"></td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
			<input type="radio" value="m" name="gender" size="30" class="gender" required="required">남
			<input type="radio" value="f" name="gender" size="30" class="gender" required="required">여
			</td>
		</tr>
		<tr>
			<td>연령대</td>
 			<td><select name="ages">
					<option value="10" required="required">10대</option>
					<option value="20" required="required">20대</option>
					<option value="30" required="required">30대</option>
					<option value="40" required="required">40대</option>
					<option value="50" required="required">50대</option>
					<option value="60" required="required">60대</option>
			</select></td>
		</tr>
		<tr>
			<td>연락처</td>
			<td><input type="text" id="phonenum" name="phonenum" size="30" placeholder="010-0000-0000" required="required"></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="email" id="email" name="email" size="30" placeholder="이메일 주소를 입력하세요" required="required"></td>
		</tr>
</table>	
<br>
<br>
<br>	
<div class="join">
<input style="font-size: 30px" type="submit" id="join" value="join"/> 
<input style="font-size: 30px" type="reset" id="reset" value="reset">
<input type="hidden" name="action" value="insert">
</div>
</form>
</body>
</html>