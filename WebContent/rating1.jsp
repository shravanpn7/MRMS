
<%@ page language="java" import="cmpe226.*"%>
   <%@ page import = "cmpe226.*" %>
    <%@ page import="java.sql.*" %>
    <%
    	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
</head>
<body>

	Enter a rating for a Movie
	<form name="user_add" method=get
		onsubmit="return check_all_fields(this)" action="rating.jsp">
		<input type=hidden name="searchAttribute" value="ratemovie">
		
		Movie id: 
		<input type=text name=movieid length=10><br /> 
		
		Rating:
		<input type=text name=rating length=10><br />
		 
		<input type=submit>
	</form>
	<BR>
	<BR>

	<%
		String isSet = request.getParameter("movieid");
		if(isSet != null) {
			HttpSession ses = request.getSession(true);	
			//String login = request.getParameter("uname");
			String login = (String)session.getAttribute("uname");
			String movieid = request.getParameter("movieid");
			String rating = request.getParameter("rating");
			cmpe226.Connector connector = new Connector();
			
			cmpe226.Queries query = new Queries();

	  		out.println("adding a new rating");
	  		out.println(query.rateMovie(connector.stmt, login, movieid,rating));
	%>
	%>

	<b>Movie is Rated!</b>
	<
	<%
	} else {
		out.println("Enter all fields");// We are ending the braces for else here
	}
	%>

	<BR>
	<a href="rating.jsp"> New query </a>
	<br/>
<a href="index.html">Back to Index</a>


</body>