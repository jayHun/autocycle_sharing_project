<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" %>
<%@ page import="signup.SignupDTO" %>
<%@ page import="signup.SignupDAO" %>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="signupdto" class="signup.SignupDTO">
	<jsp:setProperty name="signupdto" property="name" param="NAME" />
	<jsp:setProperty name="signupdto" property="hp" param="HP" />
	<jsp:setProperty name="signupdto" property="birth" param="BIRTH" />
	<jsp:setProperty name="signupdto" property="passwd" param="PASSWD" />
	<jsp:setProperty name="signupdto" property="id" param="ID" />
</jsp:useBean>
<jsp:useBean id="signupdao" class="signup.SignupDAO" />

<%
	if(signupdao.insertMember(signupdto)>0){
		out.print("<script>");
		out.print("alert('������ ���ϵ帳�ϴ�.');");
		out.print("location.href='index.html';");
		out.print("</script>");
	}else{
		out.print("<script>");
		out.print("alert('ȸ�������� ���������� �Ϸ���� �ʾҽ��ϴ�.');");
		out.print("history.back();");
		out.print("</script>");
	}
%>