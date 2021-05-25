<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
String ucodeR = session.getAttribute("ucode").toString();
if(ucodeR == null){
  response.sendRedirect("main.html");
}
%>
<%
String ucode = null;
String rid = null;
int rsize, rdensity, ractivity, rauto, rcamcode;
int dpeople=0;
double dtemp=0;
Connection conn = null;
Statement stmt = null, stmt1 = null;
ResultSet rs = null, rs1 = null;
String sql, sql1;
try {
  Class.forName("com.mysql.jdbc.Driver");
  String url = "jdbc:mysql://localhost:3306/tempset?serverTimezone=UTC";
  conn = DriverManager.getConnection(url, "root", "0000");
  stmt = conn.createStatement();
  stmt1 = conn.createStatement();
  sql = "select * from ROOM where ucode='"+ucodeR+"'";
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
        <title>TEMPSET Building Automation System - RoomLists</title>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
        <style>
/* CSS */
/* The switch - the box around the slider */
.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
  vertical-align:middle;
}

/* Hide default HTML checkbox */
.switch input {display:none;}

/* The slider */
.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}

p {
   margin:0px;
   display:inline-block;
   font-size:15px;
   font-weight:bold;
}
        </style>
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
                        <h1 class="mt-4">Room Lists</h1>
                        <ol class="breadcrumb mb-4">

                            <li class="breadcrumb-item active">Manage your spaces</li>
                        </ol>

                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                                Room Information
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>ROOM</th>
                                                <th>SIZE</th>
                                                <th>NUM OF PEOPLE</th>
                                                <th>DENSITY(%)</th>
                                                <th>TEMPERATURE</th>
                                                <th>AUTO</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                              <%
                                              while(rs.next()) {
                                                ucode = rs.getString("ucode");        // user code
                                                rid = rs.getString("rid");            // room id
                                                rsize = rs.getInt("rsize");           // room size
                                                rauto = rs.getInt("rauto");           // on/off
                                                rcamcode = rs.getInt("rcamcode");     // cam code
                                                
                                               // detail mysql
                                               dpeople = 0;
                                               dtemp = 23.5;
                                               SimpleDateFormat format1 = new SimpleDateFormat("HH:mm:ss");
                                               Date time = new Date();
                                               String n_time = format1.format(time);
                                               sql1 = "select * from DETAIL where dtime<=DATE_FORMAT(dtime, '%H:%i:%s') AND ucode='"+ucode+"' AND rid='"+rid+"' order by dtime desc limit 1";
                                               rs1 = stmt1.executeQuery(sql1);
                                               if(rs1.next()){
                                                  dpeople = rs1.getInt("dpeople");  // people count
                                                  dtemp = rs1.getDouble("dtemp");   // temperature
                                               }
                                            %>
                                            <tr>
                                                <td><a href="roomDetail.jsp?rid=<%=rid %>"><%=rid %></td>
                                                <td><%=rsize %></td>
                                                <td><%=dpeople %></td>
                                                <td><%=Math.round(((double)(dpeople)/(double)rsize)*100) %></td>
                                                <td><%=dtemp %></td>
                                                <td>
                                                   <label class="switch">
                                            <input type="checkbox" id="t<%=rid %>" onclick="click(t<%=rid%>)" checked="on">
                                            <span class="slider round"></span>
                                       </label>
                                       <p class="t<%=rid %>" style="display:none;"></p>
                                                </td>
                                            </tr>
                                            <%
                                               
                                              }
                                            %>

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
      <button class = "insert"><a href = "insertRoom.jsp">Insert New Room</a></button>
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
        
    
<!-- switch toggle -->
    <script type="text/javascript">
       var check = $("input[type='checkbox']");
       check.click(function(){
          //if(check.is("checked") == true) {
          if($("input:checkbox").prop("checked")== false) {
             var mvalue = prompt("Enter temperature value to set.", "");
             // prompt 창으로 받은 
             if(mvalue == null){
            	 $("input:checkbox").prop("checked") = false;
             }
             writeFile(rid, mvalue);
          }
       });
       
       function writeFile(name, msg){ // name : 파일명, msg : 기록
          if(name="") return false;
          var defaultpath = "C:"; // 기록하고자 하는 경로
          var fileObject = new ActiveXObject("Scripting.FileSystemObject");
          var fullpath = defaultpath + "\\" + name;
          // 파일이 생성되어 있지 않으면 새로 만들고 기록
          if(!fileObject.FileExists(fullpath)) {
             var fWrite = fileObject.CreateTextFile(fullpath, false);
             fWrite.write(msg);
             fWrite.close();
          } else {
             // 파일이 생성되어 있으면 appending 모드로 파일 열고 기록
             var fWrite = fileObject.OpenTextFile(fullpath, 8);
             fWrite.write(msg);
             fWrite.close();
          }
       }
    </script>
    
    </body>
</html>