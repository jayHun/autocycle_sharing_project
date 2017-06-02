<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
	out.print("<script>");
	out.print("alert('로그인 실패. 아이디와 비밀번호를 확인하세요.');");
	out.print("history.back();");
	out.print("</script>");
%>