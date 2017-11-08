
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*" %>
<%@ page import="temp.BikeBean, temp.LogBean" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>스쿠터쉐어링</title>
		<% 	
			 String id = (String)session.getAttribute("LOGIN_USER");
	 		 session.setAttribute("LOGIN_USER", id);
	 		 
	 		 LogBean logbean =  (LogBean) session.getAttribute("USER_LOG");
	 		 session.setAttribute("USER_LOG", logbean);
		%>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<link rel="stylesheet" href="assets/css/overlay.css" />
	</head>
	<body>

		<!-- 메뉴바 편집 -->
			<section id="sidebar">
				<div class="inner">
					<center>
				<%
					if(id!=null){out.println(id+"님");
				%>
        			</center><br/>
        				<button onclick="location='Logout.jsp'">로그아웃</button><br/><br/>
        			<%} %>
					<nav>
						<ul>
						<%
							if(id==null){
						%>
							<li><a href="index.html">로그인</a></li>
						<%}%>
						<%
							if(id!=null){
						%>
							<li><a href="#intro">주변 스쿠터 검색/이용</a></li>
						<%}%>
							<li><a href="#one">마이페이지</a></li>
							<li><a href="#two">누적 기록 조회</a></li>
						<%
							if(id==null){
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
						if(id!=null){
					%>
						<section id="intro" class="wrapper style1 fullscreen fade-up">
						<div class="inner">
							<h3>available bikes arround your location</h3>
    							<div id="map" style="width:80%; height:600px;"></div><br>&nbsp;&nbsp;
    							<p><button onclick="showMarkers()">주변 스쿠터 보기</button></p>
							<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=010e366715aca0ac1bd32a2bd5e0193f"></script>
							<script>
								var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    							mapOption = {
    	    						center: new daum.maps.LatLng(37.486653, 126.801815), // 지도의 중심좌표
	        						level: 2 // 지도의 확대 레벨
    							};

								var marker = new daum.maps.Marker({
									title: '현재 위치',
									position: new daum.maps.LatLng(37.486653, 126.801815)
								});

	    						var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	    						map.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC);
	    						marker.setMap(map);
	    						// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
	    						
	    						// bean에 저장된 스쿠터 정보 가져와서 리스트로 뿌리기 (배열리스트로 저장되었기 때문에 출력은 인덱스 역순으로)
	    						var list1= [];
	    						var list2= [];
	    						var list3= [];
	    						
	    						<c:forEach items="${BIKE_INFO.bikeId}" var="item1">
	    							list1.push("${item1}");
	    						</c:forEach>
	    						<c:forEach items="${BIKE_INFO.latitude}" var="item2">
	    							list2.push("${item2}");
	    						</c:forEach>
	    						<c:forEach items="${BIKE_INFO.longitude}" var="item3">
	    							list3.push("${item3}");
	    						</c:forEach>
	    						
	    						var positions = [{
	        						content: '<div class="wrap">' +
	            						'    <div class="info">' +
	            						'        <div class="title"><font color="black" size="2.75em">' +
	            						'            스쿠터1</font>' +
	            						'            <div class="close" title="닫기"></div>' +
	            						'        </div>' +
	            						'        <div class="body">' +
	            						'            <div class="img">' +
	            						'                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
	            						'           </div>' +
	            						'            <div style="position: relative; margin: 5px 0 0 90px; height: 85px;" class="desc">' +
	            						'                <div class="ellipsis"><font color="black">잔여 기름 : 1L</font></div>' +
	            						'                <div class="jibun ellipsis">이동 가능 거리 : 1.4km</div>' +
	            						'                <div><form action="start" method="post"><input type="hidden" name="BIKEID" value="'+ list1[3] +'"/><input type="hidden" name="LATITUDE" value="'+ list2[3] +'"/><input type="hidden" name="LONGITUDE" value="'+ list3[3] +'"><input style="margin-top: 0.25em; background-color: #cccccc; width: 6.0em; height: 35px; line-height: 2.5em; border: solid 1px; border-color: #ffffff ; border-radius: 3em; color: #ffffff; cursor: pointer; font-size: 1.1em; font-weight: bold; letter-spacing: 0.35em; outline: 0; padding: 0em 0.3em 0.2em 0.5em; position: relative; text-align: center; text-decoration: none; white-space: nowrap" type="submit" value="출발"></form></div>' + //StartRidingServlet으로 좌표값 넘겨야함 (form태그사용)
	            						'            </div>' +
	            						'        </div>' +
	            						'    </div>' +
	        						    '</div>',
	        						latlng: new daum.maps.LatLng(parseFloat(list2[3]), parseFloat(list3[3]))
	    						}, {
	        						content: '<div class="wrap">' +
	            						'    <div class="info">' +
	            						'        <div class="title"><font color="black" size="2.75em">' +
	            						'            스쿠터2</font>' +
	            						'            <div class="close" title="닫기"></div>' +
	            						'        </div>' +
	            						'        <div class="body">' +
	            						'            <div class="img">' +
	            						'                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
	            						'           </div>' +
	            						'            <div style="position: relative; margin: 5px 0 0 90px; height: 85px;" class="desc">' +
	            						'                <div class="ellipsis"><font color="black">잔여 기름 : 1.5L</font></div>' +
	            						'                <div class="jibun ellipsis">이동 가능 거리 : 1.0km</div>' +
	            						'                <div><form action="start" method="post"><input type="hidden" name="BIKEID" value="'+ list1[2] +'"><input type="hidden" name="LATITUDE" value="'+ list2[2] +'"><input type="hidden" name="LONGITUDE" value="'+ list3[2] +'"><input style="margin-top: 0.25em; background-color: #cccccc; width: 6.0em; height: 35px; line-height: 2.5em; border: solid 1px; border-color: #ffffff ; border-radius: 3em; color: #ffffff; cursor: pointer; font-size: 1.1em; font-weight: bold; letter-spacing: 0.35em; outline: 0; padding: 0em 0.3em 0.2em 0.5em; position: relative; text-align: center; text-decoration: none; white-space: nowrap" type="submit" value="출발"></form></div>' +
	            						'            </div>' +
	            						'        </div>' +
	            						'    </div>' +
	            						'</div>',
	        						latlng: new daum.maps.LatLng(parseFloat(list2[2]), parseFloat(list3[2]))
	    						}, {
	        						content: '<div class="wrap">' +
	            						'    <div class="info">' +
	            						'        <div class="title"><font color="black" size="2.75em">' +
	            						'            스쿠터3</font>' +
	            						'            <div class="close" title="닫기"></div>' +
	            						'        </div>' +
	            						'        <div class="body">' +
	            						'            <div class="img">' +
	            						'                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
	            						'           </div>' +
	            						'            <div style="position: relative; margin: 5px 0 0 90px; height: 85px;" class="desc">' +
	            						'                <div class="ellipsis"><font color="black">잔여 기름 : 2L</font></div>' +
	            						'                <div class="jibun ellipsis">이동 가능 거리 : 1.4km</div>' +
	            						'                <div><form action="start" method="post"><input type="hidden" name="BIKEID" value="'+ list1[1] +'"><input type="hidden" name="LATITUDE" value="'+ list2[1] +'"><input type="hidden" name="LONGITUDE" value="'+ list3[1] +'"><input style="margin-top: 0.25em; background-color: #cccccc; width: 6.0em; height: 35px; line-height: 2.5em; border: solid 1px; border-color: #ffffff ; border-radius: 3em; color: #ffffff; cursor: pointer; font-size: 1.1em; font-weight: bold; letter-spacing: 0.35em; outline: 0; padding: 0em 0.3em 0.2em 0.5em; position: relative; text-align: center; text-decoration: none; white-space: nowrap" type="submit" value="출발"></form></div>' +
	            						'            </div>' +
	            						'        </div>' +
	            						'    </div>' +
	            						'</div>',
	        						latlng: new daum.maps.LatLng(parseFloat(list2[1]), parseFloat(list3[1]))
	    						}, {
	        						content: '<div class="wrap">' +
	            						'    <div class="info">' +
	            						'        <div class="title"><font color="black" size="2.75em">' +
	            						'            스쿠터4</font>' +
	            						'            <div class="close" title="닫기"></div>' +
	            						'        </div>' +
	            						'        <div class="body">' +
	            						'            <div class="img">' +
	            						'                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
	            						'           </div>' +
	            						'            <div style="position: relative; margin: 5px 0 0 90px; height: 85px;" class="desc">' +
	            						'                <div class="ellipsis"><font color="black">잔여 기름 : 3L</font></div>' +
	            						'                <div class="jibun ellipsis">이동 가능 거리 : 3km</div>' +
	            						'                <div><form action="start" method="post"><input type="hidden" name="BIKEID" value="'+ list1[0] +'"><input type="hidden" name="LATITUDE" value="'+ list2[0] +'"><input type="hidden" name="LONGITUDE" value="'+ list3[0] +'"><input style="margin-top: 0.25em; background-color: #cccccc; width: 6.0em; height: 35px; line-height: 2.5em; border: solid 1px; border-color: #ffffff ; border-radius: 3em; color: #ffffff; cursor: pointer; font-size: 1.1em; font-weight: bold; letter-spacing: 0.35em; outline: 0; padding: 0em 0.3em 0.2em 0.5em; position: relative; text-align: center; text-decoration: none; white-space: nowrap" type="submit" value="출발"></form></div>' +
	            						'            </div>' +
	            						'        </div>' +
	            						'    </div>' +
	            						'</div>',	
	        						latlng: new daum.maps.LatLng(parseFloat(list2[0]), parseFloat(list3[0]))
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
	            						image : markerImage
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
							
							
						</div>
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
					
				<!-- 부가페이지1 -->
					<section id="two" class="wrapper style3 fade-up">
						<div class="inner">
							<h2>부가페이지</h2>
							<p>이용 로그</p>
							<div class="features">
								<section>
									<span class="icon major fa-code"></span>
									<h3>누적 사용 횟수</h3>
									<p>${USER_LOG.getCounter()} 번</p>
								</section>
								<section>
									<span class="icon major fa-lock"></span>
									<h3>누적 이용 시간</h3>
									<p>${USER_LOG.getSum()} 초</p>
								</section>
								<section>
									<span class="icon major fa-cog"></span>
									<h3>공유하기</h3>
									<ul class="icons">
										<li><a href="#" class="fa-twitter"><span class="label">Twitter</span></a></li>
										<li><a href="#" class="fa-facebook"><span class="label">Facebook</span></a></li>
										<li><a href="#" class="fa-github"><span class="label">GitHub</span></a></li>
										<li><a href="#" class="fa-instagram"><span class="label">Instagram</span></a></li>
										<li><a href="#" class="fa-linkedin"><span class="label">LinkedIn</span></a></li>
									</ul>
								</section>
								<section>
									<span class="icon major fa-desktop"></span>
									<h3>도움말</h3>
									<p>...</p>
								</section>
								
							</div>
							<ul class="actions">
								<li><a href="#" class="button">확인하기</a></li>
							</ul>
						</div>
					</section>
			
			
			<!-- 회원가입 페이지 -->
			<%	
				if(id==null){
			%>
					<section id="three" class="wrapper style1 fade-up">
						<div class="inner">
							<h2>회원가입</h2>
							<p>회원정보를 입력하세요</p>
							<div class="split style1">
								<section>
									<form method="post" action="SignupPRE.jsp" name="userinput" onSubmit="return checkIt()">
										<div class="field half first">
											<label for="id">ID</label>
											<input type="text" name="ID" id="id" />
										</div>
										<div class="field half">
											<label for="check">&nbsp;</label>
											<input type="button" name="confirm_id" id="check" value="ID중복확인" onclick="openConfirmid(this.form)">
										</div>
										<div class="field half first">
											<label for="passwd">PASSWD</label>
											<input type="password" name="PASSWD" id="passwd" />
										</div>
										<div class="field half">
											<label for="passwd2">PASSWD Check</label>
											<input type="password" name="PASSWD2" id="passwd2" />
										</div>
										<div class="field">
											<label for="name">NAME</label>
											<input type="text" name="NAME" id="name" />
										</div>
										<div class="field half first">
											<label for="hp">HP</label>
											<input type="text" name="HP" id="hp" placeholder="- 빼고 입력"/>
										</div>
										<div class="field half">
											<label for="birth">BIRTH</label>
											<input type="text" name="BIRTH" id="birth" placeholder="주민등록번호 앞 6글자"/>
										</div>
										<ul class="actions" align="right">
											<li><a href="" class="button submit">회원가입</a></li>
											<li><input type="reset" value="초기화"></li>
										</ul>
									</form>
								</section>
								<section>
									<ul class="contact">
									<h3>Social</h3>
									<ul class="icons">
										<li><a href="#" class="fa-twitter"><span class="label">Twitter</span></a></li>
										<li><a href="#" class="fa-facebook"><span class="label">Facebook</span></a></li>
										<li><a href="#" class="fa-github"><span class="label">GitHub</span></a></li>
										<li><a href="#" class="fa-instagram"><span class="label">Instagram</span></a></li>
										<li><a href="#" class="fa-linkedin"><span class="label">LinkedIn</span></a></li>
									</ul>
									</ul>
								</section>
							</div>
						</div>
					</section><%} %>
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
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>
			
		<!--  아이디 중복 체크 스크립트 -->
			<script>
				function checkIt()
				{
					var userinput = eval("document.userinput");
		
					if(!userinput.ID.value) {
						alert("ID를 입력하세요!")
						return false;
					}
		
					if(!userinput.PASSWD.value) {
						alert("비밀번호를 입력하세요!");
						return false;
					}
		
					if(userinput.PASSWD.value != 
						document.userinput.PASSWD2.value){
						alert("비밀번호를 동일하게 입력하세요!");
						return false;
					}
				}
	
				function openConfirmid(userinput)
				{
					if(userinput.ID.value == ""){
						alert("중복확인에러: 아이디를 입력하세요");
						return;
					}
					url="confirmId.jsp?id=" + userinput.ID.value;
					open(url, "confirm", "toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=300, height=200");
				}
			</script>
			<script language="javascript">
				function begin(){
					document.myform.passwd.focus();
				}
	
				function checkpassIt(){
					if(!document.myform.passwd.value){
						alert("비밀번호를 입력하세요!");
						document.myform.passwd.focus();
						return false;
					}
				}
			</script>
	</body>
</html>