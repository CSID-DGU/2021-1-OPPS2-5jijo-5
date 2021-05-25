<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head><meta charset="EUC-KR"><title></title></head>
<body>
<%   
	String cname = request.getParameter("cname");
	String cemail = request.getParameter("cemail");
	String cphone = request.getParameter("cphone");
	String caddress = request.getParameter("caddress");
	String ccode =""; 
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
   
   // ccode
   SimpleDateFormat format = new SimpleDateFormat ("yyMMdd");
   Date date = new Date();
   // Encryption time
   String time = format.format(date);
   String tcode = String.valueOf((1 + time.charAt(0)-'0') % 10) + String.valueOf((2 + time.charAt(1)-'0') % 10) + String.valueOf((3 + time.charAt(2)-'0') % 10) 
   				+ String.valueOf((4 + time.charAt(3)-'0') % 10) + String.valueOf((5 + time.charAt(4)-'0') % 10) + String.valueOf((6 + time.charAt(5)-'0') % 10);
   // Encryption phone-number
   String pcode =  cphone.substring(cphone.length()-4, cphone.length());
   pcode = String.valueOf((7 + pcode.charAt(0)-'0') % 10) + String.valueOf((8 + pcode.charAt(1)-'0') % 10) + String.valueOf((9 + pcode.charAt(2)-'0') % 10) + pcode.charAt(3);
   
   ccode = tcode + pcode + cname.substring(0, 3).toUpperCase();
   
	try{
	    Class.forName("com.mysql.jdbc.Driver");
	    String jdbcurl = "jdbc:mysql://localhost:3306/tempset?serverTimezone=UTC";
		conn  = DriverManager.getConnection(jdbcurl, "root", "0000");
	    stmt = conn.createStatement();
	    rs = stmt.executeQuery("select cname from company where cname='" + cname + "'");
		if(rs.next()){	
			if(cname.equals(rs.getString("cname"))){
			%>
			<script type="text/javascript">
				alert("해당 회사는 이미 존재합니다.");
				history.go(-1);
			</script>
			<%
			}
		} else{
			stmt.executeUpdate("insert into company values('"+ cname +"','"+ cemail+"','"+ cphone +"','"+ caddress +"','" + ccode +"')");
			session.setAttribute("CODE", ccode);
			response.sendRedirect("company_code.jsp");
		}
	}
	catch(Exception e){
		out.println("DB 연동 오류입니다 : " + e.getMessage());
	}
%>
</body>
</html>