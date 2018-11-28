<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=t76XFOO4KOQe79v0K_L0&submodules=geocoder"></script>


 <script>
      // XMLHttpRequest 객체의 생성
      var xhr = new XMLHttpRequest();
      // 비동기 방식으로 Request를 오픈한다
      xhr.open('GET', '/webprc/sample.json');
      // Request를 전송한다
      xhr.send();

      // Event Handler
      xhr.onreadystatechange = function () {
        // 서버 응답 완료 && 정상 응답
        if (xhr.readyState === XMLHttpRequest.DONE) {
          if (xhr.status === 200) {
            console.log(xhr.responseText.get("DATA"));
			
            
           document.getElementById('content').innerHTML = xhr.responseText;

            // document.getElementById('content').insertAdjacentHTML('beforeend', xhr.responseText);
          } else {
            console.log('[' + xhr.status + ']: ' + xhr.statusText);
          }
        }
      };
    </script> 


</head>
<div>
<table>
<tr>
<th>번호</th>
<th>주소</th>
</tr>
<tr>
<td id="content"></td>
</tr>
</table>

</div>
<body>

</body>
</html>