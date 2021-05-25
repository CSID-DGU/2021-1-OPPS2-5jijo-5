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
        <title>TEMPSET - Apply for Service</title>
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
        <script type = "text/javascript">
        function check(){
        	var cname = get.ElementByID("cname");
        	var cemail = get.ElementByID("cemail");
        	var cphone = get.ElementByID("cphone");
        	var caddress = get.ElementByID("caddress");
        	
        	if(cname.value == ""){
        		alert("회사명을 입력하세요");
        		cname.focus();
        		return false;
        	}
        	if(cemail.value == ""){
        		alert("이메일을 입력하세요");
        		cname.focus();
        		return false;
        	}
        	if(cphone.value == ""){
        		alert("회사 전화번호를 입력하세요");
        		cname.focus();
        		return false;
        	}
        	if(caddress.value == ""){
        		alert("회사 주소를 입력하세요");
        		cname.focus();
        		return false;
        	}
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
                                        <form method='post' action='service_db.jsp'>
                                           
                                            <div class="form-group">
                                                <label class="small mb-1" for="inputEmailAddress">Company</label>
                                                <input class="form-control py-4" id="cname" name='cname' type="text" aria-describedby="emailHelp" placeholder="Enter company name" /><br>
			           <label class="small mb-1" for="inputEmailAddress">Email</label>
                                                <input class="form-control py-4" id="cemail" name='cemail' type="email"  aria-describedby="emailHelp" placeholder="Enter email address" /><br>
			          <label class="small mb-1" for="inputEmailAddress">Phone number</label>
                                                <input class="form-control py-4" id="cphone" name='cphone' type="text" aria-describedby="emailHelp" placeholder="Enter phone number" /><br>
			          <label class="small mb-1" for="inputEmailAddress">Company address</label>
                                                <input class="form-control py-4" id="caddress" name='caddress' type="text" aria-describedby="emailHelp" placeholder="Enter company address" />
                                            </div>
                                            
			      
                                            <div class="form-group mt-4 mb-0"><input class="btn btn-primary btn-block" type='submit' value='Apply'></div>
                                        </form>
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
