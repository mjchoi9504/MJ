<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=t76XFOO4KOQe79v0K_L0&submodules=geocoder"></script>

<script>


var toilet_position = new Array();
// var address = new Array();
// var query = new Array();
// var data = new Array();

$(document).ready(function() {
	$.getJSON('/webprc/wgs1984.json', function(obj) {
		/* console.log(obj.DATA.length); */
		
		 var obj_s=new Array();
		 var k=0;
		for(var i =0; i<1000; i++) {
			toilet_position[i]= new naver.maps.LatLng(obj.DATA[i].lat, obj.DATA[i].lng);
// 			console.log(toilet_position[i]);
			naver.maps.Service.reverseGeocode({
				location: toilet_position[i]
			}, function(status, response) {
				if (status == naver.maps.Service.Status.ERROR) {
					return console.log('Something Wrong!');
			    }
// 				    console.log(obj.DATA[i].lat + ",  " +obj.DATA[i].lng);
				address= response.result.items[1].address;
				query= response.result.userquery;
				data= response.result.items[1].address + ", " + response.result.userquery;// 검색 결과의 컨테이너
				/* console.log(data);	 */	
				
				var personArray = new Array();   
	     		var obj = new Object(); 
	     		
                obj.address = address;
                obj.query = query;
            /*      personArray.push(obj);
                
                
                
                 var totalObj = new Object();
                totalObj = personArray;  */
                
                obj_s[k] = JSON.stringify(obj);
                
           /* 
                console.log(obj_s); */
                var dataUri = "data:application/json;charset=utf-8,"+ encodeURIComponent(obj_s);
                var link = $("#link").attr("href", dataUri);
                k++;
			});
		} 
	});
}); 

// 	console.log(toilet_position[1]);
// for(var i =0; i<10; i++){

	
// }
		
</script>


</head>
<body>
 <a href="#" id="link" download="sample.json">download</a></html>