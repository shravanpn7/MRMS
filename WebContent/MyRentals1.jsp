<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import = "cmpe18032.*" %>
    <%@ page import="java.sql.*" %>
    <% Class.forName("sun.jdbc.odbc.JdbcOdbcDriver"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Rentals</title>
</head>
<body>

<h1>My Rentals</h1>

Hello, <%= session.getAttribute("uname") %>

<%



Connection con;
String userName = "root";
String password = "papanaidu";
String url = "jdbc:mysql://localhost:3306/mrms";
Class.forName ("com.mysql.jdbc.Driver").newInstance();
con = DriverManager.getConnection (url, userName, password);

Statement statement = con.createStatement() ;
ResultSet resultset = 
    statement.executeQuery("select transaction.MovieID, Title, T_iD, T_time, T_date, Due_date from movies, transaction where CustID = '"+ session.getAttribute("uname") +"' and transaction.MovieID = movies.MovieID ");
%>

<TABLE BORDER="1">
<TR>
	<TH>Movie ID</TH>
    <TH>Title</TH>
    <TH>Transaction ID</TH>
    <TH>Transaction Time</TH>
	<TH>Transaction Date</TH>
	<TH>Due Date</TH>
	

</TR>
<% while(resultset.next()){ %>
<TR>
    <TD> <%= resultset.getString(1) %></td>
    <TD> <%= resultset.getString(2) %></TD>
	<TD> <%= resultset.getString(3) %></TD>
	<TD> <%= resultset.getString(4) %></TD>
	<TD> <%= resultset.getString(5) %></TD>
	<TD> <%= resultset.getString(6) %></TD>
</TR>
<% } %>
</TABLE>
 <BR>
	<a href="getMovies.jsp"> New query </a>
	<br/>
	<a href="index.html">Back to Index</a>


</body>
</html>