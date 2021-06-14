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
        <title>TempSet - Insert Room</title>
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Insert Room</h3></div>
                                    <div class="card-body">

                                        <form action="insertRoom_db.jsp" method="post">

                                            <div class="form-group">
                                                
                                            </div>
                                            <div class="form-row">
                                            
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="inputPassword">Building code</label>
                                                        <input class="form-control py-4" name=bid id="buildingcode" type="text" placeholder="Enter Building code in Alphabet..ex)E" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="inputConfirmPassword">Room name</label>
                                                        <input class="form-control py-4" name="rname" id="roomname" type="text" placeholder="Enter Room name in num..ex)102" />
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="form-row">
                                            
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="inputPassword">Cam code</label>
                                                        <input class="form-control py-4" name="rcamcode" id="camcode" type="text" placeholder="Enter cam code" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="inputConfirmPassword">Area Size(m2)</label>
                                                        <input class="form-control py-4" name="rsize" id="areasize" type="text" placeholder="Enter area size" />
                                                    </div>
                                                </div>

                                            </div>
                                            </div>

                                            <div class="form-group mt-4 mb-0"><input type="submit" value="Insert Room" class="btn btn-primary btn-block"></div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center">

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
