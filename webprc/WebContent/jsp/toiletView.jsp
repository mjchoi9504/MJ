<%@page import="model.vo.EvaluationVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="javax.servlet.*"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=t76XFOO4KOQe79v0K_L0&submodules=geocoder"></script>
<style>
#map{
		width : 85%;
		height : 650px;
		margin : auto;
	}
</style>
</head>

<body>
<div id="map"></div>

<script>
	window.onload = function() {
		$(document).ready(function() {
			$.getJSON('/webprc/wgs1984.json', function(obj) {
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
								anchor : new naver.maps.Point(11, 35),
							},
							animation: naver.maps.Animation.BOUNCE
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
							
								naver.maps.Event.addListener(toilet_marker[i], 'click', function(e){
							    	console.log("위치가 어디인가?"+e.coord);
							    	searchCoordinateToAddress(e.coord);
			
							    });
							    
							    
							    
							    
							    
							}
							
						
							
						}
						
					
				
						function selectMarkers(markBounds) {
							var j = 0;
						
							for (var i = 0; i < obj.DATA.length; i++) {
							    var toilet_position = new naver.maps.LatLng(obj.DATA[i].lat, obj.DATA[i].lng);
							   // var tag_position = new naver.maps.LatLng(obj.DATA[i].lat, obj.DATA[i].lng);
							  
							    if (markBounds.hasLatLng(toilet_position)) {
							    	toilet_marker[j] = new naver.maps.Marker( { 
			 						    position: new naver.maps.LatLng(obj.DATA[i].lat, obj.DATA[i].lng),
										icon : { // marker icon
											url : '/webprc/images/d08.png', 
											size : new naver.maps.Size(38, 31),
											anchor : new naver.maps.Point(11, 35),
											title : j
											
										},
										animation: naver.maps.Animation.DROP
									});
							    	
							    	console.log("이거지"+toilet_marker[j].position);
							    
							    	 
							    	 
							    	 toilet_marker[j].setMap(map);
							    	
								    j++;
							    	
								}
							  
						
							    	
							    }
							
						
							}
						
						
	
						 
			
						
						function searchDistance(cPoint, mPoint) {
							var distance = map.getPrimitiveProjection().getDistance(cPoint,mPoint);
							return distance;
						}
							
						
						
						function searchCoordinateToAddress(latlng) {
							
							naver.maps.Service.reverseGeocode({
	   							location: latlng,
	
							}, function(status, response) {
								if (status === naver.maps.Service.Status.ERROR) {
							    	return alert('Something Wrong!');
							    }
								
						
								result= response.result.items[1].address; // 검색 결과의 컨테이너
								
								console.log(response);
								console.log(response.result.userquery);
								console.log("결과:::"+response.result.items[1]);
								distance = searchDistance(center_marker.getPosition(), latlng);
								console.log("거리:::"+distance);
								//alert(distance); *
								var round_distance=Math.round(distance)
								var infoWindow = new naver.maps.InfoWindow({
									maxWidth: 900,
									borderWidth: 3,
									borderColor: "purple",
				 					content: 
				 							'<div><a style="color: red; position:absolute;text-align:center;top:-16px;right:-16px;width:14px;height:16px;" href="#" class="btn_clear">&nbspX&nbsp</a>'+
				 							'<div style="width:450px; text-align:left; padding:10px;">주&nbsp&nbsp&nbsp소 : ' + result + '<br>'+
				 							'청결도 : 3.0/5.0 <br>' +'거&nbsp&nbsp&nbsp리 : ' + round_distance+'m</div>' +
				 							'&nbsp&nbsp&nbsp<button style="border-radius: 25px; border: 2px dotted purple;" onclick= goBoard();>청결도</button></div>'
									
								});
								
								
								
								infoWindow.open(map, latlng);
								
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
		var eval=window.open("/webprc/html/evaluation2.html","","width=330, height=100");
	}
	
</script>



</body>

</html>