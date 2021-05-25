<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
if(session != null){
	session.invalidate();
%>
	<script type="text/javascript">
		alert("로그아웃 성공");
	 	document.location.href="./main.html";		
	</script>
<%
}
%> 