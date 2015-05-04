<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" import="cmpe226.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script LANGUAGE="javascript">
	function check_all_fields(form_obj) {
		alert(form_obj.searchAttribute.value + "='" + form_obj.isbn.value + "'");
		if (form_obj.movieid.value == "" || form_obj.login.value == ""
				|| form_obj.count.value == "") {
			alert("Fields should be nonempty");
			return false;
		}
		return true;
	}
</script>
<title>Movie Rental Management System | Order a Movie</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/cufon-yui.js" type="text/javascript"></script>
<script src="js/cufon-replace.js" type="text/javascript"></script>
<script src="js/Gill_Sans_400.font.js" type="text/javascript"></script>
<script src="js/script.js" type="text/javascript"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<!--[if lt IE 7]>
<script type="text/javascript" src="js/ie_png.js"></script>
<script type="text/javascript">ie_png.fix('.png, .link1 span, .link1');</script>
<link href="css/ie6.css" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body id="page4">
<!-- START PAGE SOURCE -->
<div class="tail-top">
  <div class="tail-bottom">
    <div id="main">
      <div id="header">
        <div class="row-1">
          <div class="fleft"><a href="#">Movie <span>Rental </span> Management<span> System</span></a></div>
          <ul>
            <li><a href="#"><img src="images/icon1.gif" alt="" /></a></li>
            <li><a href="#"><img src="images/icon2.gif" alt="" /></a></li>
            <li><a href="#"><img src="images/icon3.gif" alt="" /></a></li>
          </ul>
        </div>
        <div class="row-2">
          <ul>
            <li><a href="index.html">Home</a></li>
            <li><a href="order.jsp" class="active">Order Movies</a></li>
            <li><a href="MyRentals.jsp">My Rentals</a></li>
            <li><a href="moviebrowse.jsp">Search</a></li>
			<li><a href="getMovies.jsp"">List all Movies</a></li>
            <li class="last"><a href="rating.jsp">Rate Movies</a></li>
          </ul>
        </div>
      </div>
      <div id="content">
        <div class="line-hor"></div>
        <div class="box">
          <div class="border-right">
            <div class="border-left">
              <div class="inner">
                <h3>New <span>Order</span></h3>
				<div>
					<form name="user_add" method=get
						onsubmit="return check_all_fields(this)" action="order.jsp">
						<input type=hidden name="searchAttribute" value="ordermovie">
						
						<label color=white>Movie id: </label> 
						<input type=text name=movieid length=10><br /> 
						 
						<input type=submit>
					</form>
				</div>
	<BR>
	<BR>

	<%
		String isSet = request.getParameter("movieid");
		if(isSet != null) {
			HttpSession ses = request.getSession(true);	
			//String login = request.getParameter("uname");
			String login = (String)session.getAttribute("uname");
			String movieid = request.getParameter("movieid");
			
			
		

			cmpe226.Connector connector = new Connector();

			cmpe226.Queries query = new Queries();
	%>

	<b>New Order Created</b>
	<BR>
	<BR>
	<%
		out.print(query.createOrder(connector.stmt, login,movieid));

			out.println("Creating order for: <b> "
					+ login + " </b>");
			out.println(query.getHtmlString());
	%>

	<%
		connector.closeStatement();
			connector.closeConnection();
	} else {
		out.println("Enter all fields");// We are ending the braces for else here
	}
	%>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="footer">
        <div class="left">
          <div class="right">
            <div class="footerlink">
              <p class="lf">Copyright &copy; 2010 <a href="#">SiteName</a> - All Rights Reserved</p>
              <p class="rf">Design by <a href="http://www.templatemonster.com/">TemplateMonster</a></p>
              <div style="clear:both;"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"> Cufon.now(); </script>
<!-- END PAGE SOURCE -->
</body>
</html>