<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
String ucodeR = session.getAttribute("ucode").toString();
if(ucodeR == null){
  response.sendRedirect("main.html");
}
%>

<!DOCTYPE html>
<html>
<head><meta charset="EUC-KR"><title>Insert title here</title></head>
<body>
<%   // 입력받은 ROOM 정보를 바탕으로 ROOM table에 방 입력하기
   String bid, rid, ucode;    // 방 이름, user code
   int rsize = 0;      // 방 크기
   int ractivity = 0; // 활성화 :초기 고정값
  int rauto = 0;    // 자동수동 :초기 고정값
  int rcamcode =0;   // 카메라 코드

   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null, rs2 = null;
   String sql, sql2;

   try {
      Class.forName("com.mysql.jdbc.Driver");
      String url = "jdbc:mysql://localhost:3306/tempset?serverTimezone=UTC";
      conn = DriverManager.getConnection(url, "root", "0000");
      stmt = conn.createStatement();
      //sql = "select * from ROOM";
      //sql2 = "select UCODE from USER where uid=" + uid;
      //rs = stmt.executeQuery(sql);
      //rs2 = stmt.executeQuery(sql2);
   }
   catch(Exception e) {
      out.println("DB 연동 오류입니다.: " + e.getMessage());
   }

   ucode = ucodeR;
   // 입력된 회원정보 request로 가져오기
   bid = request.getParameter("bid");
   rid = request.getParameter("rname");
   rid = bid.concat(rid);
   rcamcode = Integer.parseInt(request.getParameter("rcamcode"));
   rsize = Integer.parseInt(request.getParameter("rsize"));

   // 입력되지 않은 회원정보 있을 시 경고창 뜨기
   if (rid.equals("") || rsize == 0) {
      out.println("<script>alert('정보를 모두 입력해주세요.'); history.back();</script>");
   }
   else {
      // 회원정보 member table에 입력할 string
      sql = "insert into ROOM values ('" + ucode + "','" + rid + "'," + rsize + "," + ractivity + "," + rcamcode + "," + rauto + ")";

      // 중복된 아이디 있을 시 경고창 뜨기 or 없으면 회원가입 완료(string member table에 입력)
      try {
         stmt.executeUpdate(sql);
         out.println("<script>alert('새로운 ROOM이 추가되었습니다.'); location.href='tables.jsp';</script>");
      } catch(Exception e) {
    	 System.out.println(e);
         out.println("<script>alert('중복된 이름의 ROOM입니다.'); history.back();</script>");
      }
   }
%>
</body>
</html>