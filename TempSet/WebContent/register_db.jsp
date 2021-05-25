<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
	String uid = request.getParameter("uid");
	String upw = request.getParameter("upw");
	String ucode = request.getParameter("ucode");
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try{
	    Class.forName("com.mysql.jdbc.Driver");
	    String jdbcurl = "jdbc:mysql://localhost:3306/tempset?serverTimezone=UTC";
		conn  = DriverManager.getConnection(jdbcurl, "root", "0000");
	    stmt = conn.createStatement();
	    rs = stmt.executeQuery("select uid from user where uid='" + uid + "'");
		if(rs.next()){	
			if(uid.equals(rs.getString("uid"))){
			%>
			<script type="text/javascript">
				alert("아이디가 이미 존재합니다.");
				history.go(-1);
			</script>
			<%
			}
		}else{	
			// code(int), name, birth, id, pw, email, marketing(int)
			stmt.executeUpdate("insert into user values('"+ uid +"','"+upw+"','"+ ucode+"')");
			response.sendRedirect("main.html");
		}
	}
	catch(Exception e){
		out.println("DB 연동 오류입니다 : " + e.getMessage());
	}
%>
</body>
</html>