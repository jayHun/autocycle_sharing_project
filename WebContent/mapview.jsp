<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <style>
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style>
  </head>
  <body>
    <h3>available bikes arround your location</h3>
    <div id="map" style="width:100%;height:600px;"></div><br>&nbsp;&nbsp;
    <p>
    	<button onclick="showMarkers()">마커 보이기</button>
    </p>
	
	<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=010e366715aca0ac1bd32a2bd5e0193f"></script>
	<script>
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    		mapOption = {
    	    	center: new daum.maps.LatLng(37.486653, 126.801815), // 지도의 중심좌표
	        	level: 2, // 지도의 확대 레벨
        		mapTypeId : daum.maps.MapTypeId.ROADMAP // 지도종류
    		}; 

			var marker = new daum.maps.Marker({
				title: '현재 위치',
				position: new daum.maps.LatLng(37.486653, 126.801815)
			});

	    var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	    marker.setMap(map);
	    // 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
	    var positions = [{
	        content: '<div class="wrap">' +
	            '    <div class="info">' +
	            '        <div class="title">' +
	            '            스쿠터1' +
	            '            <div class="close" title="닫기"></div>' +
	            '        </div>' +
	            '        <div class="body">' +
	            '            <div class="img">' +
	            '                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
	            '           </div>' +
	            '            <div class="desc">' +
	            '                <div class="ellipsis">잔여 기름 : 1L</div>' +
	            '                <div class="jibun ellipsis">이동 가능 거리 : 0.7km</div>' +
	            '                <div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">출발</a></div>' + //StartRidingServlet으로 좌표값 넘겨야함 (form태그사용)
	            '            </div>' +
	            '        </div>' +
	            '    </div>' +
	            '</div>',
	        latlng: new daum.maps.LatLng(37.486320, 126.803597)
	    }, {
	        content: '<div class="wrap">' +
	            '    <div class="info">' +
	            '        <div class="title">' +
	            '            스쿠터2' +
	            '            <div class="close" title="닫기"></div>' +
	            '        </div>' +
	            '        <div class="body">' +
	            '            <div class="img">' +
	            '                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
	            '           </div>' +
	            '            <div class="desc">' +
	            '                <div class="ellipsis">잔여 기름 : 1.5L</div>' +
	            '                <div class="jibun ellipsis">이동 가능 거리 : 1.0km</div>' +
	            '                <div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">출발</a></div>' +
	            '            </div>' +
	            '        </div>' +
	            '    </div>' +
	            '</div>',
	        latlng: new daum.maps.LatLng(37.485822, 126.803060)
	    }, {
	        content: '<div class="wrap">' +
	            '    <div class="info">' +
	            '        <div class="title">' +
	            '            스쿠터3' +
	            '            <div class="close" title="닫기"></div>' +
	            '        </div>' +
	            '        <div class="body">' +
	            '            <div class="img">' +
	            '                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
	            '           </div>' +
	            '            <div class="desc">' +
	            '                <div class="ellipsis">잔여 기름 : 2L</div>' +
	            '                <div class="jibun ellipsis">이동 가능 거리 : 1.4km</div>' +
	            '                <div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">출발</a></div>' +
	            '            </div>' +
	            '        </div>' +
	            '    </div>' +
	            '</div>',
	        latlng: new daum.maps.LatLng(37.486899, 126.801350)
	    }, {
	        content: '<div class="wrap">' +
	            '    <div class="info">' +
	            '        <div class="title">' +
	            '            스쿠터4' +
	            '            <div class="close" title="닫기"></div>' +
	            '        </div>' +
	            '        <div class="body">' +
	            '            <div class="img">' +
	            '                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
	            '           </div>' +
	            '            <div class="desc">' +
	            '                <div class="ellipsis">잔여 기름 : 3L</div>' +
	            '                <div class="jibun ellipsis">이동 가능 거리 : 3km</div>' +
	            '                <div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">출발</a></div>' +
	            '            </div>' +
	            '        </div>' +
	            '    </div>' +
	            '</div>',
	        latlng: new daum.maps.LatLng(37.487050, 126.800037)
	    }];

	    // 스쿠터 표시 마커이미지
	    var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	    
	    // 오버레이를 담는 배열
	    var overlays = [];
		var markers = [];

	    // 맵의 확대수준이 변경되거나 위치이동 되었을때 커스텀 오버레이 삭제
	    daum.maps.event.addListener(map, 'idle', function() {
	        closeOverlays();
	    });

	    // 오버레이를 모두 닫는 함수
	    function closeOverlays() {
	    	for (var i = 0; i < overlays.length; i++) {
	    		overlays[i].setMap(null);
	    	}
	    }
	
	    // 마커 생성
	    for (var i = 0; i < positions.length; i++) {
	    	createMarkers(positions[i]);
	    }
	    
		// 마커 생성 함수
	    function createMarkers(info){
	    	var imageSize = new daum.maps.Size(24, 35);
	    	var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);
	    	
	    	// 마커를 생성
	        var marker = new daum.maps.Marker({
	            map: map, // 마커를 표시할 지도
	            position: info.latlng, // 마커의 위치
	            image : markerImage // 마커 이미지  >> 오토바이 이미지로 바꾸던지 생각중
	        });
	    	
	    	markers.push(marker);
	    	marker.setVisible(false);
	    }
	    
	    // 오버레이 생성
	    for (var i = 0; i < positions.length; i++) {
	    	createOverlay(positions[i], markers[i]);
	    }
	    
	    // 마커와 오버레이를 생성하는 함수
	    function createOverlay(info, markinfo) {

	        var overlayDiv = document.createElement('div');
	        overlayDiv.innerHTML = info.content;

	        // 마커 위에 커스텀오버레이를 표시합니다
	        var overlay = new daum.maps.CustomOverlay({
	            content: overlayDiv, // 커스텀오버레이에 표시할 내용
	            position: markinfo.getPosition(),
	            zIndex: 3
	        });
	        
	        // 마커를 클릭했을 때 커스텀 오버레이 표시
	        daum.maps.event.addListener(markinfo, 'click', function() {
	            overlay.setMap(map);
	        });

	        // 오버레이 element에서 close버튼을 클릭하면 닫히게 되는 이벤트를 등록
	        var close = overlayDiv.getElementsByClassName('close')[0];
	        close.onclick= function() {
	        	overlay.setMap(null);	
	        };

	        overlays.push(overlay);
	    }
	    
	    // 주변 스쿠터 찾기 버튼 클릭시 보이게 하는 이벤트함수
	    function showMarkers(){
	    	for(var i=0; i<markers.length; i++){
	    		markers[i].setVisible(true);
	    		markers[i].getVisible();
	    	}
	    }
	    
    </script>
  </body>
</html>