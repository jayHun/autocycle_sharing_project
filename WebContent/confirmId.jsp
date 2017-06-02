<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" %>
<%@ page import="signup.SignupDAO" %>

<html>
<head>
	<title>ID 중복확인</title>
	<meta charset="utf-8" />
	<meta http-equiv="Content-Type" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="assets/css/main.css" />
</head>

<% request.setCharacterEncoding("utf-8"); %>
<%
	String id = request.getParameter("id");
	SignupDAO signupdao = SignupDAO.getInstance();
	
	int check = signupdao.confirmId(id);
%>
<body>
<%
	if(check == 1){%>
	<b><font color="red"><%= id %></font>는 이미 사용중인 아이디입니다.</b>
	<form name="checkForm" method="post" action="confirmId.jsp">
	<b>다른 아이디를 선택하세요.</b><br /><br />
		<input type="text" name="id" />
		<input type="submit" value="ID중복확인" />
	</form>
	<%
	}else{
	%>
	<b>입력한 <font color="red"><%= id %></font>는<br />
				사용 가능합니다. </b><br /><br />
	<input type="button" value="닫기" onclick="setid()">
	<%}%>
</body>
</html>
<script>
	function setid(){
		opener.document.userinput.ID.value="<%= id %>";
		self.close();
	}
</script>