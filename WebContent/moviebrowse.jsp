<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import = "cmpe226.*" %>
    <%@ page import="java.sql.*" %>
    <%
    	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    %>
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
<title>Movie Rental Management System | Search a Movie</title>
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
            <li><a href="order.jsp">Order Movies</a></li>
            <li><a href="MyRentals.jsp">My Rentals</a></li>
            <li><a href="moviebrowse.jsp" class="active">Search</a></li>
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
	<%
		String isSet = request.getParameter("actors");
		if (isSet == null)
		{
	%>

	<h3>Search <span>Movies / Actors</span></h3>
	<form name="user_add" method=get
		action="moviebrowse.jsp">
		<input type=hidden name="searchAttribute" value="degrees">
		<font color="white">Actor Name</font>
		<input type=text name="actors" length=100><br />
		<font color="white">Movie Name</font>
		<input type=text name="directors" length=100><br /> 
		
		<input type=submit value="Search">
	</form>
	<BR>
	<BR>

	<%
		} else
		{

			String actors = request.getParameter("actors");
			String directors = request.getParameter("directors");
			String keywords = request.getParameter("keywords");
			
			String[] actorsArray = actors.split(",(?=([^\"]*\"[^\"]*\")*[^\"]*$)");
			java.util.ArrayList<String> actorsAL = new java.util.ArrayList<String>();
			for(String s: actorsArray)
			{
		s = s.trim();
		actorsAL.add(s);
			}
			String[] directorsArray = directors.split(",(?=([^\"]*\"[^\"]*\")*[^\"]*$)");
			java.util.ArrayList<String> directorsAL = new java.util.ArrayList<String>();
			for(String s: directorsArray)
			{
		s = s.trim();
		directorsAL.add(s);
			}
			
			cmpe226.Connector connector = new Connector();

			cmpe226.Queries query = new Queries();
	%>

	<b>Search results</b>
	<BR>
	<BR>
	<%
		

			out.println("Search for Actors:<br>");
			out.println("<ul>");
			for(String s: actorsAL)
			{
				out.println("<li>" + s + "</li>");
			}
			out.println("</ul>");
			
			out.println("Search for Movies:<br>");
			out.println("<ul>");
			for(String s: directorsAL)
			{
				out.println("<li>" + s + "</li>");
			}
			out.println("</ul>");
			
			
			
			java.util.ArrayList<String> results = query.getSearchResults(connector.stmt, actorsAL, directorsAL);
			out.println("<p><strong>Query Results</strong></p>");
			for(String s: results)
			{
				out.println("<p>" + s + "</p>");
			}
	%>

	<%
		connector.closeStatement();
			connector.closeConnection();
		} // We are ending the braces for else here
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