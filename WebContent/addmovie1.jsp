
<%@ page language="java" import="cmpe18032.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script LANGUAGE="javascript">

function check_all_fields(form_obj){
	alert(form_obj.searchAttribute.value+"='"+form_obj.login.value+"'");
	if( form_obj.MovieID.value == "" || form_obj.Title.value == "" || form_obj.Year.value == ""){
		alert("Fields should be nonempty");
		return false;
	}
	return true;
}

</script> 
</head>
<body>

<%
String isSet = request.getParameter("MovieID");
if( isSet == null ){
%>

	Add a new Movie:
	<form name="user_add" method=get onsubmit="return check_all_fields(this)" action="addmovie.jsp">
		<input type=hidden name="searchAttribute" value="newuser">
		MovieID:
		<input type=text name="MovieID" length=10><br/>
		Title:
		<input type=text name="Title" length=10><br/>
		Year:
		<input type=text name="Year" length=20><br/>
		Genre:
		<input type=text name="Genre" length=10><br/>
		Copies:
		<input type=text name="Copies" length=10><br/>
	
		
		<input type=submit>
	</form>
	<BR><BR>

<%

} else {

	 String MovieID = request.getParameter("MovieID");
     String Title = request.getParameter("Title");
     String Year = request.getParameter("Year");
     String Copies = request.getParameter("Copies");
     String Genre = request.getParameter("Genre");
    
	
	cmpe18032.Connector connector = new Connector();
	
	cmpe18032.Queries query = new Queries();
	
%>  
  
  <b>New Movie Added</b> <BR><BR>
  <%
  
  out.println("Movie Added -  <b> "+MovieID+
			" </b>");
  query.addMovie(connector.stmt, MovieID, Title, Year, Genre,Copies);

  		
  %>

<%
 connector.closeStatement();
 connector.closeConnection();
}  // We are ending the braces for else here
%>

<BR><a href="addmovie.jsp"> New query </a><br/>
<a href="manage.html">Back to Index</a>

</body>