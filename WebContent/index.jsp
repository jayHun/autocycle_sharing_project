<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>스쿠터쉐어링</title>
		<% 	
			 String id = (String)session.getAttribute("ID");
	 		session.setAttribute("ID", id);
		%>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/main.css" />
	</head>
	<body>

		<!-- 메뉴바 편집 -->
			<section id="sidebar">
				<div class="inner">
					<center>
					<%
        				if(id!=null){
        					out.println(id+"님");
        			%>
        			</center><br/>
        				<button onclick="location='Logout.jsp'">로그아웃</button><br/><br/>
        			<%}%>
					<nav>
						<ul>
						<%  if(id==null){
								out.println("<!--");
						%>
							<li><a href="#intro">메인페이지</a></li>
						<%	
							out.println("-->");
							}else{
								out.println("<li><a href="+"#intro"+">메인페이지</a></li>");
							}
						%>
							<li><a href="#one">마이페이지</a></li>
							<li><a href="#two">부가페이지</a></li>
						<%
							if(id==null){
						%>
							<li><a href="#three">회원가입</a></li>
						<%
							}
						%>
						</ul>
					</nav>
				</div>
			</section>

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- 지도 넣는곳!!!! -->
					<section id="intro" class="wrapper style1 fullscreen fade-up">
						<div class="inner">
							<h1>지도</h1>
							<p>이곳에 지도를 넣으면 될거같습니다</p>
							
						</div>
					</section>

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
							<p>더 필요한기능이 생기면 여기에 추가하면 될거같습니다</p>
							<div class="features">
								<section>
									<span class="icon major fa-code"></span>
									<h3>부가기능1</h3>
									<p>입력하세요</p>
								</section>
								<section>
									<span class="icon major fa-lock"></span>
									<h3>부가기능2</h3>
									<p>입력하세요</p>
								</section>
								<section>
									<span class="icon major fa-cog"></span>
									<h3>부가기능3</h3>
									<p>입력하세요</p>
								</section>
								<section>
									<span class="icon major fa-desktop"></span>
									<h3>부가기능4</h3>
									<p>입력하세요</p>
								</section>
								
							</div>
							<ul class="actions">
								<li><a href="#" class="button">여기를 누르세요</a></li>
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
										<li>
											<h3>Address</h3>
											<span>12345 Somewhere Road #654<br />
											Nashville, TN 00000-0000<br />
											USA</span>
										</li>
										<li>
											<h3>Email</h3>
											<a href="#">user@untitled.tld</a>
										</li>
										<li>
											<h3>Phone</h3>
											<span>(000) 000-0000</span>
										</li>
										<li>
											<h3>Social</h3>
											<ul class="icons">
												<li><a href="#" class="fa-twitter"><span class="label">Twitter</span></a></li>
												<li><a href="#" class="fa-facebook"><span class="label">Facebook</span></a></li>
												<li><a href="#" class="fa-github"><span class="label">GitHub</span></a></li>
												<li><a href="#" class="fa-instagram"><span class="label">Instagram</span></a></li>
												<li><a href="#" class="fa-linkedin"><span class="label">LinkedIn</span></a></li>
											</ul>
										</li>
									</ul>
								</section>
							</div>
						</div>
					</section>
			<%} %>
			</div>
		
		<!-- Footer -->
			<footer id="footer" class="wrapper style1-alt">
				<div class="inner">
					<ul class="menu">
						<li>&copy; 웹서비스컴퓨팅 3조 한정훈 이강렬 이승현</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
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