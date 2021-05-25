<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>TEMPSET - code</title>
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
        <script type = "text/javascript">
        function copy_to_clipboard() {    
        	  var copyText = document.getElementById('codeInput');
        	  copyText.select();
        	  copyText.setSelectionRange(0, 99999);
        	  document.execCommand("Copy");
        }
        </script>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Service Application</h3></div>
                                    <div class="card-body">
                                       <center> Your COMPANY CODE is <big><b><%=session.getAttribute("CODE") %></b></big> ! </center>
                                       <center>
                                       		<input type="text" id="codeInput" value=<%=session.getAttribute("CODE") %> readonly>
                                       		<button onClick="copy_to_clipboard()">copy</button>
                                       </center>
                                       </br>
                                       <div class="small"><input class="btn btn-primary btn-block" type='button' onclick="location.href='main.html'" value='go to main'></div>
                                    </div>
                                    <div class="card-footer text-center">
                                        <div class="small"><a href="login.jsp">Already apply? Go to login</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>