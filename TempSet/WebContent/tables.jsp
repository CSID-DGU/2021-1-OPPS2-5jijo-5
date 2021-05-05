<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%	// Cookie 있으면 id에 저장. 없으면 id는 null
	String header = request.getHeader("Cookie");
	String uid = null;

	if (header != null) {
		Cookie[] cookies = request.getCookies();

		for(Cookie cookie : cookies) {
			if (cookie.getName().equals("uid")) {
				uid = (String) cookie.getValue();
			}
		}
	}
%>
<%
	String bid=null, rid=null, rname=null;
	int rnum, rsize, rdensity;
	boolean ractivity;

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql, sql1;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/tempset?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		stmt = conn.createStatement();
		sql = "select * from ROOM";
		rs = stmt.executeQuery(sql);
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
        <title>Tables - SB Admin</title>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand">TempSet</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
                <div class="input-group">

                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ml-auto ml-md-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">

                        <a class="dropdown-item" href="login.jsp">Logout</a>
                    </div>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">


                            <div class="sb-sidenav-menu-heading">Help</div>
                            <a class="nav-link" href="charts.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                Charts
                            </a>
                            <a class="nav-link" href="tables.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Tables
                            </a>
                        </div>
                    </div>

                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">Tables</h1>
                        <ol class="breadcrumb mb-4">

                            <li class="breadcrumb-item active">Tables</li>
                        </ol>

                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                                DataTable Example
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Position</th>
                                                <th>Office</th>
                                                <th>Age</th>
                                                <th>Start date</th>
                                                <th>Salary</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>Name</th>
                                                <th>Position</th>
                                                <th>Office</th>
                                                <th>Age</th>
                                                <th>Start date</th>
                                                <th>Salary</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <tr>
                                              <%
                                              while(rs.next()) {
                                                bid = rs.getString("bid");				// user id
                                                rid = rs.getString("rid");				// 공간 id
                                                rname = rs.getString("rname");			// 공간 이름
                                                rnum = rs.getInt("rnum");				// 사람수
                                                rsize = rs.getInt("rsize");				// 면적
                                                rdensity = rs.getInt("rdensity");		// 밀집도
                                                ractivity = rs.getBoolean("ractivity");	// on/off

                                                if(bid.equals(uid)) {
                                                  %>

                                                  <td><%=bid %>, <%=rid %>, <%=rname %>, <%=rnum %></td>


                                                  <%
                                                } else {
                                                  //rs.previous();
                                                  break;
                                                }
                                              }

                                              %>
                                            </tr>

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
		<button class = "insert"><a href = "insertTable.jsp">Insert Table&nbsp&nbsp&nbsp</a></button>
                    </div>
                </main>

            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/datatables-demo.js"></script>
    </body>
</html>
