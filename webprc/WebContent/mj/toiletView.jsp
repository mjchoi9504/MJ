<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=t76XFOO4KOQe79v0K_L0&submodules=geocoder"></script>
<style>
	body {
		margin : 0px;
		background-image : url('/webprc/images/5.jpg');
		image-size : 100%;
	}
	h1 {
		margin :0px;
	}
	#head {
		width : 100%;
		height : 250px;
		background : #e6e6ff;
		margin-bottom :20px;
	}
	#map {
		width : 85%;
		height : 650px;
		margin : auto;
	}
</style>
</head>

<body>

	<div id="head">
		<h1> 화장실 </h1>
		<ul>
			<li> 지도로 보기 </li>
			<li> 목록으로 보기 </li>
			<li> 건의사항 </li>
		</ul>
	</div>

	<div id="map">
	</div>



<script>
	window.onload = function() {
		$(document).ready(function() {
			$.getJSON('/edu/webproject/wgs1984.json', function(obj) {
				var map;
				if (navigator.geolocation) {
					navigator.geolocation.getCurrentPosition(function(position) {
						var lat_p = position.coords.latitude;
						var long_p = position.coords.longitude;
						var oPoint = new naver.maps.LatLng(lat_p, long_p);
						console.log("현재위치 :" + oPoint);
						map = new naver.maps.Map('map', {
							center : oPoint,
							zoom : 11,
							padding : {
								top : 20
							},
							mapTypeControl : true
						});
						
						var circle = new naver.maps.Circle({
							center : oPoint,
							radius : 500,
							strokeColor : "#00ff00",
							strokeWeight : 10,
							strokeOpacity : 0.5,
							fillColor : "#00ff00",
							fillOpacity : 0.2
						});
						circle.setMap(map);
						
						//마커표현 -> 중점 잡아주기. 현 위치를 기반.
					 	var markerOptions = {
							position : oPoint,
							icon : {
								url : 'http://static.naver.net/maps/v3/pin_default.png',
								size : new naver.maps.Size(22, 35),
								anchor : new naver.maps.Point(11, 35)
							}
						};
						
						
						
						//마커 환경 설정 후 -> map에 set 
						var center_marker = new naver.maps.Marker(markerOptions);
						center_marker.setMap(map);
						
						//우리가 가져올 데이터는 여러개므로 -> 마커로 배열을 만들어줌.
						//겹쳐지는 것 아님.
						var toilet_marker = new Array();
						var result =[];
						updateMarkers(map, toilet_marker);
						
						function updateMarkers(map, toilet_marker) {
							var markBounds = circle.getBounds();					
							selectMarkers(markBounds);
							for (var i=0; i<toilet_marker.length; i++) {
								console.log("click event: "+toilet_marker[i]);
							    naver.maps.Event.addListener(toilet_marker[i], 'click', function(e){
							    	searchCoordinateToAddress(e.coord);
							    });
							}
						}
						
						function selectMarkers(markBounds) {
							var j = 0;
							for (var i = 0; i < obj.DATA.length; i++) {
							    var toilet_position = new naver.maps.LatLng(obj.DATA[i].lat, obj.DATA[i].lng);
							    if (markBounds.hasLatLng(toilet_position)) {
							    	toilet_marker[j] = new naver.maps.Marker( { 
			 						    position: new naver.maps.LatLng(obj.DATA[i].lat, obj.DATA[i].lng),
										icon : { // marker icon
											url : '/edu/webproject/image/d08.PNG', 
											size : new naver.maps.Size(30, 35),
											anchor : new naver.maps.Point(11, 35),
											title : j
										}
									});
								    toilet_marker[j].setMap(map);
							    	j++;
							    console.log(center_marker.getPosition());
							    	
								}
							}
						}
						
						
						
						
						function searchDistance(cPoint, mPoint) {
							var distance = map.getPrimitiveProjection().getDistance(cPoint,mPoint);
							return distance;
						}
							
						
						
						function searchCoordinateToAddress(coord) {
							var tm128 = naver.maps.TransCoord.fromLatLngToTM128(coord);
						
							naver.maps.Service.reverseGeocode({
	   							location: tm128,
							    coordType: naver.maps.Service.CoordType.TM128
							}, function(status, response) {
								if (status === naver.maps.Service.Status.ERROR) {
							    	return alert('Something Wrong!');
							    }
								//alert("뭐지?");
								result= response.result.items[1].address; // 검색 결과의 컨테이너
								//alert(result);
								distance = searchDistance(center_marker.getPosition(), coord);
								//alert(distance);
								var round_distance=Math.round(distance)
								var infoWindow = new naver.maps.InfoWindow({
				 					content: 
				 							'<div><a style="position:absolute;text-align:center;top:-16px;right:-16px;width:14px;height:16px;" href="#" class="btn_clear">&nbspX&nbsp</a>'+
				 							'<div style="width:450px; text-align:left; padding:10px;">주&nbsp&nbsp&nbsp소 : ' + result + '<br>'+
				 							'청결도 : 3.0/5.0 <br>' +'거&nbsp&nbsp&nbsp리 : ' + round_distance+'m</div>' +
				 							'<button onclick= goBoard();>건의사항</button></div>'
								});
							
								infoWindow.open(map, coord);
								
							 	$(infoWindow.getWrapElement()).find('.btn_clear').on('click', function(e) {
								    infoWindow.close();
								}); 
							});
						}
			
						
					 
						//원이 움직일 때 -> update시키는 기능 추가하기!
						naver.maps.Event.addListener(map, 'mouseup', function(e) {
							console.log(e);
							lat_p = e.coord._lat;
							long_p = e.coord._lng;
							oPoint = new naver.maps.LatLng(lat_p,long_p);
							console.log("::::"+map.center);
							circle.setOptions({center: oPoint});
							center_marker.setPosition(oPoint);
							
							//**이 코드는 위치 이동시 기존의 마커를 안보이게 하는 기능임.
						 	 for(var i=0; i<toilet_marker.length; i++) {
								toilet_marker[i].setMap(null);
							} 
							updateMarkers(map, toilet_marker);
						}); 
					});
		 		} 
			});
		});
	}
	
	function goBoard() {
		window.open("http://www.naver.com/");
		console.log("이벤트");
	}
</script>

	


</body>

</html>