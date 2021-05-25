<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<%
	
	String ucodeR = request.getParameter("ucodeR");
	String rname = request.getParameter("rname");

	ArrayList<ArrayList<String>> datas = new ArrayList<ArrayList<String>>();
	
	try {
		Connection conn = null;
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/tempset?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		Statement stmt2 = conn.createStatement();

		String sql2 = "select * from DETAIL where ucode='" + ucodeR + "' and rid='" + rname + "'";
		ResultSet rs2 = stmt2.executeQuery(sql2);

		ArrayList<String> title = new ArrayList<>();
		title.add("''");
		title.add("''");
        datas.add(title);

		while (rs2.next()) {
	      	String dtime = rs2.getString("dtime"); 
			String dpeople = String.valueOf(rs2.getInt("dpeople")); 
			
			ArrayList<String> data = new ArrayList<>();
	        data.add("'"+dtime+"'");
	        data.add("'"+dpeople+"'");

	        datas.add(data);
		}
		System.out.println(datas);
		conn.close();
	} catch (Exception e) {
		System.out.println(e.getMessage());
	}
	%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable(<%=datas%>);

        var options = {
          chart: {
          }
        };

        var chart = new google.charts.Bar(document.getElementById('PChart'));
        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>
  </head>
  <body>
    <div id="PChart" style="width: 600px; height: 400px;"></div>
  </body>
</html>