<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
String rname = request.getParameter("rid");
%>
<%
String ucodeR = session.getAttribute("ucode").toString();
if(ucodeR == null){
  response.sendRedirect("main.html");
}
%>
<%
   String ucode = null;
   int rsize, rdensity, ractivity, rauto, rcamcode;
   Connection conn = null;
   Statement stmt1 = null;
   ResultSet rs = null;
   String sql;
   try {
      Class.forName("com.mysql.jdbc.Driver");
      String url = "jdbc:mysql://localhost:3306/tempset?serverTimezone=UTC";
      conn = DriverManager.getConnection(url, "root", "0000");
      stmt1 = conn.createStatement();
      sql = "select * from ROOM where ucode='" + ucodeR +"' and rid='" + rname + "'";
      rs = stmt1.executeQuery(sql);
   }
   catch(Exception e) {
      out.println("DB 연동 오류입니다.: " + e.getMessage());
   }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>TEMPSET Building Automation System - Chart</title>
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand">TempSet</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
                <div class="input-group">

                    <div class="input-group-append">

                    </div>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ml-auto ml-md-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">

                        <a class="dropdown-item" href="./logout.jsp">Logout</a>
                    </div>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">


                            <div class="sb-sidenav-menu-heading">Core</div>

                            <a class="nav-link" href="roomList.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                RoomLists
                            </a>
                        </div>
                    </div>

                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">Room Details</h1>
                        <ol class="breadcrumb mb-4">

                            <li class="breadcrumb-item active"><b><%=rname %></b></li>
                        </ol>
                        <div class="row">
                        	<div class="col-lg-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-pie mr-1"></i>
                                        Room Information
                                    </div>
                                    <% try {
                                    if(rs.next()) { %>
                                    <div class="card-body">
                                    <table class="table table-bordered" id="dataTable">
										<tr>
											<td>Room Name</td> <td><b><%=rname %></b></td>
										</tr>
										<tr>
											<td>Room Size(m2)</td> <td><b><%=rs.getInt("rsize") %></b></td>
										</tr>
										<tr>
											<td>Auto (on/off)</td> <td><b><% if(rs.getInt("rauto")==1){%>on<%}else%>off</b></td>
										</tr>
										<tr>
											<td>Camera Code</td> <td><b><%=rs.getInt("rcamcode") %></b></td>
										</tr>
									</table>
									</div>
                                    <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
                                </div>
                            </div>
                            				<% } 
                           			} catch (Exception e) {
                              			System.out.println(e.getMessage());
                           			}%>
							
							<%

									ArrayList<ArrayList<String>> Pdatas = new ArrayList<ArrayList<String>>();
									ArrayList<ArrayList<String>> Tdatas = new ArrayList<ArrayList<String>>();

									
									try {
										Statement stmt2 = conn.createStatement();
								
										String sql2 = "select * from DETAIL where ucode='" + ucodeR + "' and rid='" + rname + "'";
										ResultSet rs2 = stmt2.executeQuery(sql2);
										
										ArrayList<String> title = new ArrayList<>();
										title.add("'Time'");
										title.add("' '");
										Pdatas.add(title);
										
										ArrayList<String> Ttitle = new ArrayList<>();
										Tdatas.add(title);
								        
										while (rs2.next()) {
									      	String dtime = rs2.getString("dtime"); 
											String dpeople = String.valueOf(rs2.getInt("dpeople")); 
											String dtemp = String.valueOf(rs2.getFloat("dtemp")); 
											
											ArrayList<String> Pdata = new ArrayList<>();
											Pdata.add("'"+dtime+"'");
											Pdata.add(dpeople);
											Pdatas.add(Pdata);
											
											ArrayList<String> Tdata = new ArrayList<>();
											Tdata.add("'"+dtime+"'");
											Tdata.add(dtemp);
									        Tdatas.add(Tdata);
										}
										System.out.println(Pdatas);
										System.out.println(Tdatas);
								
										conn.close();
									} catch (Exception e) {
										System.out.println(e.getMessage());
									}
									%>
								<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
								<script type="text/javascript">
									google.charts.load('current', {'packages':['corechart','bar']});
									google.charts.setOnLoadCallback(drawPChart);	
									function drawPChart() {
									  var Pdata = google.visualization.arrayToDataTable(<%=Pdatas%>);
									  var Poptions = {
									  };
									
									  var Pchart = new google.charts.Bar(document.getElementById('PChart'));
									  Pchart.draw(Pdata, google.charts.Bar.convertOptions(Poptions));
									}
									
									google.charts.setOnLoadCallback(drawTChart);								
									function drawTChart() {
									  var Tdata = google.visualization.arrayToDataTable(<%=Tdatas%>);								
									  var Toptions = {
									  		
									  };								        
									  var Tchart = new google.visualization.LineChart(document.getElementById('TChart'));								
									  Tchart.draw(Tdata, Toptions);
									}
								      
							</script>
									
                            <div class="col-lg-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar mr-1"></i>
                                        Number Of People
                                    </div>
                            		<div id="PChart" style="width: 100%; height: 90%;"></div>
                                    <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
                                </div>
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-chart-area mr-1"></i>
                                Temperature
                            </div>
                            <div>
                            <div id="TChart" style="width: 100%; height: 90%;"></div>    
							</div>                            
                            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
                        </div>
                    </div>
                </main>

            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
  
    </body>
</html>
