<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="signup.SignupDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--
	Hyperspace by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>스쿠터쉐어링-회원탈퇴</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
	
	<%
		String id = (String)session.getAttribute("ID");
		String passwd = request.getParameter("PASSWD");
		SignupDAO manager = SignupDAO.getInstance();
	
		int check = manager.deleteMember(id, passwd);
	
		if(check == 1)
		{
			session.invalidate();
	%>
	
	<body>

		<!-- Header -->
			<header id="header">
				<a href="index.jsp" class="title">스쿠터 쉐어링</a>
				<nav>
					<ul>
						<li><a href="index.jsp">Home</a></li>
						<li><a href="generic.html" class="active">Generic</a></li>
						<li><a href="elements.html">Elements</a></li>
					</ul>
				</nav>
			</header>

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<section id="main" class="wrapper">
						<div class="inner">
							<h1 class="major">결과</h1>
							<form action="generic.html" method="post" name="userinput">
								<p>회원 정보가 삭제되었습니다.</p>
								<meta http-equiv="Refresh" content="5;url=generic.html">
							</form>
						</div>
					</section>

			</div>
	<%
		}
		else
		{
	%>
		<script>
			alert("비밀번호가 틀립니다.");
			history.go(-1);
		</script>
	<%
		} 
	%>
		<!-- Footer -->
			<footer id="footer" class="wrapper alt">
				<div class="inner">
					<ul class="menu">
						<li>&copy; Untitled. All rights reserved.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
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

	</body>
</html>