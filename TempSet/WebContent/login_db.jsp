<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>
<%
   request.setCharacterEncoding("utf-8");
%>
<html>
<body>
   <%
   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null;

   String uid = request.getParameter("uid");
   String upw = request.getParameter("upw");

   String save = request.getParameter("save");

   try {
      Class.forName("com.mysql.jdbc.Driver");
      String url = "jdbc:mysql://localhost:3306/tempset?serverTimezone=UTC";
      conn = DriverManager.getConnection(url, "root", "0000");
      stmt = conn.createStatement();
      String sql = "select * from user where uid = '" + uid + "'";

      rs = stmt.executeQuery(sql);
      if (rs != null) {
         while (rs.next()) {
      		if (upw.equals(rs.getString("upw"))) {
          		session.setAttribute("ucode", rs.getString("ucode"));
          		session.setMaxInactiveInterval(60*60);	// 세션 유지시간 1시간;

    	  		if(save != null){
         			response.addCookie(new Cookie("ID", uid));
         			response.addCookie(new Cookie("PW", upw));
         		}
    	  %>
     	<script>
	 		alert("로그인 성공");
	 		document.location.href='./tables.jsp'
	 	</script>
    	  <%
         		break;
    	  } else{
   %>
   <div style="text-align: center;">
      <script type="text/javascript">
         alert("로그인 실패");
         document.location.href='./login.jsp'
      </script>
   </div>
   <%
      		}
  		} // end of While
    }
      else{
    	  %>
    	  <div style="text-align: center;">
      		<script type="text/javascript">
            alert("로그인 실패");
            document.location.href='./login.jsp'
      		</script>
   		</div>
   <%
      }
   } catch (Exception e) {
   out.println("DB연동오류입니다.:" + e.getMessage());
   } // end of try-catch
   %>
</body>
</html>
