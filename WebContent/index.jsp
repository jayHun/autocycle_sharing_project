<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>�����ͽ��</title>
		<% 	
			 String id = (String)session.getAttribute("ID");
	 		session.setAttribute("ID", id);
		%>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/main.css" />
	</head>
	<body>

		<!-- �޴��� ���� -->
			<section id="sidebar">
				<div class="inner">
					<center>
					<%
        				if(id!=null){
        					out.println(id+"��");
        			%>
        			</center><br/>
        				<button onclick="location='Logout.jsp'">�α׾ƿ�</button><br/><br/>
        			<%}%>
					<nav>
						<ul>
						<%  if(id==null){
								out.println("<!--");
						%>
							<li><a href="#intro">����������</a></li>
						<%	
							out.println("-->");
							}else{
								out.println("<li><a href="+"#intro"+">����������</a></li>");
							}
						%>
							<li><a href="#one">����������</a></li>
							<li><a href="#two">�ΰ�������</a></li>
						<%
							if(id==null){
						%>
							<li><a href="#three">ȸ������</a></li>
						<%
							}
						%>
						</ul>
					</nav>
				</div>
			</section>

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- ���� �ִ°�!!!! -->
					<section id="intro" class="wrapper style1 fullscreen fade-up">
						<div class="inner">
							<h1>����</h1>
							<p>�̰��� ������ ������ �ɰŰ����ϴ�</p>
							
						</div>
					</section>

				<!--���������� ��Ų-->
					<section id="one" class="wrapper style2 spotlights">
						<section>
							<a href="#" class="image"><img src="images/pic01.jpg" alt="" data-position="center center" /></a>
							<div class="content">
								<div class="inner">
									<h2>�������</h2>
									<p>����ߴ� ������� ����� Ȯ���ϼ���</p>
									<ul class="actions">
										<li><a href="#" class="button">��������</a></li>
									</ul>
								</div>
							</div>
						</section>

						<section>
							<a href="#" class="image"><img src="images/pic02.jpg" alt="" data-position="top center" /></a>
							<div class="content">
								<div class="inner">
									<h2>ȸ�� Ż���ϱ�</h2>
									<p>�� ȸ�� Ż��� ��� ������ �����˴ϴ� </p>
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
											<li><a href="" class="button submit">ȸ��Ż��</a></li>
										</ul>
									</form>
								</div>
							</div>
						</section>

						
					</section>
					
				<!-- �ΰ�������1 -->
					<section id="two" class="wrapper style3 fade-up">
						<div class="inner">
							<h2>�ΰ�������</h2>
							<p>�� �ʿ��ѱ���� ����� ���⿡ �߰��ϸ� �ɰŰ����ϴ�</p>
							<div class="features">
								<section>
									<span class="icon major fa-code"></span>
									<h3>�ΰ����1</h3>
									<p>�Է��ϼ���</p>
								</section>
								<section>
									<span class="icon major fa-lock"></span>
									<h3>�ΰ����2</h3>
									<p>�Է��ϼ���</p>
								</section>
								<section>
									<span class="icon major fa-cog"></span>
									<h3>�ΰ����3</h3>
									<p>�Է��ϼ���</p>
								</section>
								<section>
									<span class="icon major fa-desktop"></span>
									<h3>�ΰ����4</h3>
									<p>�Է��ϼ���</p>
								</section>
								
							</div>
							<ul class="actions">
								<li><a href="#" class="button">���⸦ ��������</a></li>
							</ul>
						</div>
					</section>
			
			
			<!-- ȸ������ ������ -->
			<%	
				if(id==null){
			%>
					<section id="three" class="wrapper style1 fade-up">
						<div class="inner">
							<h2>ȸ������</h2>
							<p>ȸ�������� �Է��ϼ���</p>
							<div class="split style1">
								<section>
									<form method="post" action="SignupPRE.jsp" name="userinput" onSubmit="return checkIt()">
										<div class="field half first">
											<label for="id">ID</label>
											<input type="text" name="ID" id="id" />
										</div>
										<div class="field half">
											<label for="check">&nbsp;</label>
											<input type="button" name="confirm_id" id="check" value="ID�ߺ�Ȯ��" onclick="openConfirmid(this.form)">
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
											<input type="text" name="HP" id="hp" placeholder="- ���� �Է�"/>
										</div>
										<div class="field half">
											<label for="birth">BIRTH</label>
											<input type="text" name="BIRTH" id="birth" placeholder="�ֹε�Ϲ�ȣ �� 6����"/>
										</div>
										<ul class="actions" align="right">
											<li><a href="" class="button submit">ȸ������</a></li>
											<li><input type="reset" value="�ʱ�ȭ"></li>
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
						<li>&copy; ��������ǻ�� 3�� ������ �̰��� �̽���</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
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
			
		<!--  ���̵� �ߺ� üũ ��ũ��Ʈ -->
			<script>
				function checkIt()
				{
					var userinput = eval("document.userinput");
		
					if(!userinput.ID.value) {
						alert("ID�� �Է��ϼ���!")
						return false;
					}
		
					if(!userinput.PASSWD.value) {
						alert("��й�ȣ�� �Է��ϼ���!");
						return false;
					}
		
					if(userinput.PASSWD.value != 
						document.userinput.PASSWD2.value){
						alert("��й�ȣ�� �����ϰ� �Է��ϼ���!");
						return false;
					}
				}
	
				function openConfirmid(userinput)
				{
					if(userinput.ID.value == ""){
						alert("�ߺ�Ȯ�ο���: ���̵� �Է��ϼ���");
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
						alert("��й�ȣ�� �Է��ϼ���!");
						document.myform.passwd.focus();
						return false;
					}
				}
			</script>
	</body>
</html>