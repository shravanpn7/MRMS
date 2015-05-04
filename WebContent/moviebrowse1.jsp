
<%@ page language="java" import="cmpe226.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script LANGUAGE="javascript">
	function check_all_fields(form_obj) {
		//alert(form_obj.searchAttribute.value + "='" + form_obj.isbn.value + "'");
		if (form_obj.actors.value == "" || form_obj.directors.value == "" || form_obj.keywords.value == "") {
			alert("Fields should be nonempty");
			return false;
		}
		return true;
	}
</script>
</head>
<body>

	<%
		String isSet = request.getParameter("actors");
		if (isSet == null)
		{
	%>

	Movie Search
	<form name="user_add" method=get
		action="moviebrowse.jsp">
		<input type=hidden name="searchAttribute" value="degrees">
		Actors Name
		<input type=text name="actors" length=100><br />
		Movie Name 
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

	<BR>
	<a href="moviebrowse.jsp"> New query </a>
	<br/>
	<a href="index.html">Back to Index</a>

</body>