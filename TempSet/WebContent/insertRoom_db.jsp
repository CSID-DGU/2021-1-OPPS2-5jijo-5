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
<%   // �Է¹��� ROOM ������ �������� ROOM table�� �� �Է��ϱ�
   String bid, rid, ucode;    // �� �̸�, user code
   int rsize = 0;      // �� ũ��
   int ractivity = 0; // Ȱ��ȭ :�ʱ� ������
  int rauto = 0;    // �ڵ����� :�ʱ� ������
  int rcamcode =0;   // ī�޶� �ڵ�

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
      out.println("DB ���� �����Դϴ�.: " + e.getMessage());
   }

   ucode = ucodeR;
   // �Էµ� ȸ������ request�� ��������
   bid = request.getParameter("bid");
   rid = request.getParameter("rname");
   rid = bid.concat(rid);
   rcamcode = Integer.parseInt(request.getParameter("rcamcode"));
   rsize = Integer.parseInt(request.getParameter("rsize"));

   // �Էµ��� ���� ȸ������ ���� �� ���â �߱�
   if (rid.equals("") || rsize == 0) {
      out.println("<script>alert('������ ��� �Է����ּ���.'); history.back();</script>");
   }
   else {
      // ȸ������ member table�� �Է��� string
      sql = "insert into ROOM values ('" + ucode + "','" + rid + "'," + rsize + "," + ractivity + "," + rcamcode + "," + rauto + ")";

      // �ߺ��� ���̵� ���� �� ���â �߱� or ������ ȸ������ �Ϸ�(string member table�� �Է�)
      try {
         stmt.executeUpdate(sql);
         out.println("<script>alert('���ο� ROOM�� �߰��Ǿ����ϴ�.'); location.href='tables.jsp';</script>");
      } catch(Exception e) {
    	 System.out.println(e);
         out.println("<script>alert('�ߺ��� �̸��� ROOM�Դϴ�.'); history.back();</script>");
      }
   }
%>
</body>
</html>