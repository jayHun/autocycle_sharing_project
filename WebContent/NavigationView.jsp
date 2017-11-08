<%@page import="temp.RideInfoBean"%>
<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>스쿠터쉐어링</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=010e366715aca0ac1bd32a2bd5e0193f"></script>
		<style>
			.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
			.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;color:black;font-weight:bold;padding:5px;background:#fff;}
			.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
			.number {font-weight:bold;color:#ee6152;}
			.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
			.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
			.distanceInfo .label {display:inline-block;width:50px;}
			.distanceInfo:after {content:none;}
			#button_id {visibility:hidden;left:50px;top:200px;}
		</style>
		<% 	
			 RideInfoBean rideinfo = (RideInfoBean) session.getAttribute("RIDE_INFO");
	 		 session.setAttribute("RIDE_INFO", rideinfo);
		%>
	</head>
	<body>

		<!-- 메뉴바 편집 -->
			<section id="sidebar">
				<div class="inner">
					<center>
					<%
						if(rideinfo.userId != null){
							out.println(rideinfo.userId+"님");
					%>
        			</center><br/>
        				<button onclick="location='Logout.jsp'">로그아웃</button><br/><br/>
        			<%} %>
					<nav>
						<ul>
						<%
							if(rideinfo.userId != null){
						%>
							<li><a href="#intro">주변 스쿠터 검색/이용</a></li>
						<%}%>
							<li><a href="#one">마이페이지</a></li>
						<%
							if(rideinfo.userId == null){
						%>
							<li><a href="#three">회원가입</a></li>
						<%}%>
						</ul>
					</nav>
				</div>
			</section>

		<!-- Wrapper -->
			
			<div id="wrapper">

				<!-- 지도 넣는곳!!!! -->
				<%
					if(rideinfo.userId != null){ 
				%>
				<section id="intro" class="wrapper style1 fullscreen fade-up">
					<div class="inner" style="margin:0;padding:10px;">
						<h2>Navigation View</h2>
    						<div id="map" style="width:80%; height:450px;left:100px;margin:0;padding:0;"></div><br>&nbsp;&nbsp;
    						<p><button id="button" style="left: 530px; margin:0;visibility:hidden;">주행 종료</button></p>
					
					 </div>
						 <form  id="navi_form" action="enddrive" method="post">
						 	<input type=hidden id="start_lat" value="${RIDE_INFO.startLocLat}">
						 	<input type=hidden id="start_lng" value="${RIDE_INFO.startLocLng}">
							<input type="hidden" name="LAT" id="end_lat_loc">
							<input type="hidden" name="LNG" id="end_lng_loc">
							<input type="hidden" name="DISTANCE" id="travel_distance">
						</form>
				</section>
				<%} %>
				<!--마이페이지 스킨-->
					<section id="one" class="wrapper style2 spotlights">
						<section>
							<a href="#" class="image"><img src="images/pic01.jpg" alt="" data-position="center center" /></a>
							<div class="content">
								<div class="inner">
									<h2>요금정산</h2>
									<p>사용했던 오토바이 요금을 확인하세요</p>
									<ul class="actions">
										<li><a href="#" class="button">보러가기</a></li>
									</ul>
								</div>
							</div>
						</section>

						<section>
							<a href="#" class="image"><img src="images/pic02.jpg" alt="" data-position="top center" /></a>
							<div class="content">
								<div class="inner">
									<h2>회원 탈퇴하기</h2>
									<p>※ 회원 탈퇴시 모든 정보가 삭제됩니다 </p>
									<form action="DeluserPRE.jsp" method="post" name="myform" onSubmit="return checkpassIt()">
										<div class="field half first">
											<label for="id">ID</label>
											<input type="text" name="ID" id="id" />
										</div>
										<div class="field half">
											<label for="passwd">PASSWD</label>
											<input type="password" name="PASSWD" id="passwd" />
										</div>
										<ul class="actions">
											<li><a href="" class="button submit">회원탈퇴</a></li>
										</ul>
									</form>
								</div>
							</div>
						</section>

					</section>
			</div>
		<!-- Footer -->
			<footer id="footer" class="wrapper style1-alt">
				<div class="inner">
					<ul class="menu">
						<li>&copy; The Catholic University of Korea</li><li>CSIE WebService Computing TEAM3</li>
					</ul>
				</div>
			</footer>

		<!-- Scripts -->

			<script>
					var curLat= document.getElementById("start_lat").value;
					var curLng= document.getElementById("start_lng").value;
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div
					mapOption = {
						center: new daum.maps.LatLng(curLat,curLng), // 지도의 중심좌표
							level: 3 // 지도의 확대 레벨
						};
						// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
					var map = new daum.maps.Map(mapContainer, mapOption);
					map.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC);
					
					var markerPosition = new daum.maps.LatLng(curLat, curLng);
		 			var marker = new daum.maps.Marker({
	 	 			position: markerPosition,
					draggable: true
	 				});

	 				// 마커가 지도 위에 표시되도록 설정합니다
	 				marker.setMap(map);
	 				
	 				var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
	 				var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
	 				var clickLine; // 마우스로 클릭한 좌표로 그려질 선 객체입니다
	 				var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
	 				var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
	 				
	 				
	 				daum.maps.event.addListener(marker, 'dragstart', function() {
	 				        // 상태를 true로, 선이 그리고있는 상태로 변경합니다
	 				        drawingFlag = true;
	 				        document.getElementById("button").style.visibility="visible";
	 				        // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
	 				        deleteClickLine();
	 				        
	 				        // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
	 				        deleteDistnce();

	 				        // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
	 				        deleteCircleDot();
	 				    
	 				        // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
	 				        clickLine = new daum.maps.Polyline({
	 				            map: map, // 선을 표시할 지도입니다 
	 				            path: [markerPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
	 				            strokeWeight: 3, // 선의 두께입니다 
	 				            strokeColor: '#db4040', // 선의 색깔입니다
	 				            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	 				            strokeStyle: 'solid' // 선의 스타일입니다
	 				        });
	 				        
	 				        // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
	 				        moveLine = new daum.maps.Polyline({
	 				            strokeWeight: 3, // 선의 두께입니다 
	 				            strokeColor: '#db4040', // 선의 색깔입니다
	 				            strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	 				            strokeStyle: 'solid' // 선의 스타일입니다    
	 				        });
	 				    
	 				        // 클릭한 지점에 대한 정보를 지도에 표시합니다
	 				        displayCircleDot(markerPosition, 0);
	 				       
	 				});
	 				
	 				
	 				
	 			// 지도에 마우스무브 이벤트를 등록합니다
	 			// 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
	 			daum.maps.event.addListener(map, 'mousemove', function (mouseEvent) {
	 			    // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
	 			    if (drawingFlag){
	 			        
	 			        // 마우스 커서의 현재 위치를 얻어옵니다 
	 			        var mousePosition = mouseEvent.latLng; 

	 			        // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
	 			        var path = clickLine.getPath();
	 			        
	 			        // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
	 			        var movepath = [path[path.length-1], mousePosition];
	 			        moveLine.setPath(movepath);    
	 			        moveLine.setMap(map);
	 			        
	 			        var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
	 			            content = '<div class="dotOverlay distanceInfo">거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
	 			        
	 			        // 거리정보를 지도에 표시합니다
	 			        showDistance(content, mousePosition);   
	 			    }             
	 			});                 
	 			
	 			daum.maps.event.addListener(marker, 'dragend', function () {
	 				   marker.setDraggable(false);
					   var movePath = moveLine.getPath();
					   
	 			        // 마우스무브로 그려진 선은 지도에서 제거합니다
	 			        moveLine.setMap(null);
	 			        moveLine = null;  
	 			       var path = clickLine.getPath();
	 			       var lastPath=[path[path.length-1],movePath[movePath.length-1]];
	 			       clickLine.setPath(lastPath);
					   clickLine.setMap(map);	 	
					   displayCircleDot(movePath[movePath.length-1],0);
	 			        // 선을 구성하는 좌표의 개수가 2개 이상이면
	 			        if (path.length > 1) {

	 			            // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
	 			           

	 			            var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
	 			                content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
	 			                
	 			            // 그려진 선의 거리정보를 지도에 표시합니다
	 			            showDistance(content, path[path.length-1]);  
	 			             
	 			        } 

	 			            // 선을 구성하는 좌표의 개수가 1개 이하이면 
	 			            // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
	 			        var distance = Math.round(clickLine.getLength());
	 			        var endLoc= movePath[movePath.length-1];
	 			        var lat = endLoc.getLat();
	 			        var lng= endLoc.getLng();
	 			        
	 			        document.getElementById("travel_distance").value = distance;
	 			        document.getElementById("end_lat_loc").value = lat;
	 			        document.getElementById("end_lng_loc").value = lng;
	 			        
	 			       
	 			        
	 			        // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
	 			        drawingFlag = false;          
	 			        
	 			        
	 			});    
	 			
	 		// 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
	 			function deleteClickLine() {
	 			    if (clickLine) {
	 			        clickLine.setMap(null);    
	 			        clickLine = null;        
	 			    }
	 			}
	 				
	 		// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
	 		// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
	 		function showDistance(content, position) {
	 		    
	 		    if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
	 		      
	 		        // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
	 		        distanceOverlay.setPosition(position);
	 		        distanceOverlay.setContent(content);
	 		        
	 		    } else { // 커스텀 오버레이가 생성되지 않은 상태이면
	 		        
	 		        // 커스텀 오버레이를 생성하고 지도에 표시합니다
	 		        distanceOverlay = new daum.maps.CustomOverlay({
	 		            map: map, // 커스텀오버레이를 표시할 지도입니다
	 		            content: content,  // 커스텀오버레이에 표시할 내용입니다
	 		            position: position, // 커스텀오버레이를 표시할 위치입니다.
	 		            xAnchor: 0,
	 		            yAnchor: 0,
	 		            zIndex: 3  
	 		        });      
	 		    }
	 		}
	 		
	 	// 그려지고 있는 선의 총거리 정보와 
	 	// 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
	 	function deleteDistnce () {
	 	    if (distanceOverlay) {
	 	        distanceOverlay.setMap(null);
	 	        distanceOverlay = null;
	 	    }
	 	}
	
	 	function displayCircleDot(position, distance) {

	 	    // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
	 	    var circleOverlay = new daum.maps.CustomOverlay({
	 	        content: '<span class="dot"></span>',
	 	        position: position,
	 	        zIndex: 1
	 	    });

	 	    // 지도에 표시합니다
	 	    circleOverlay.setMap(map);

	 	    if (distance > 0) {
	 	        // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
	 	        var distanceOverlay = new daum.maps.CustomOverlay({
	 	            content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
	 	            position: position,
	 	            yAnchor: 1,
	 	            zIndex: 2
	 	        });

	 	        // 지도에 표시합니다
	 	        distanceOverlay.setMap(map);
	 	    }

	 	    // 배열에 추가합니다
	 	    dots.push({circle:circleOverlay, distance: distanceOverlay});
	 	}
	 	
	 // 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
	 	function deleteCircleDot() {
	 	    var i;

	 	    for ( i = 0; i < dots.length; i++ ){
	 	        if (dots[i].circle) { 
	 	            dots[i].circle.setMap(null);
	 	        }

	 	        if (dots[i].distance) {
	 	            dots[i].distance.setMap(null);
	 	        }
	 	    }

	 	    dots = [];
	 	}
	 
	    var buttonAction= function(){
	    	document.getElementById("button").onclick=function(){
	    		var form= document.getElementById("navi_form");
 				form.submit();
	    	}
	    }
	 	
	    window.onload= buttonAction;
	 			

			</script>
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>