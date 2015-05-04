<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

    <%@ page import="java.sql.*" %>
    
<% Class.forName("sun.jdbc.odbc.JdbcOdbcDriver"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List of Movies in Database</title>
</head>
<body>
 <H1>List of Movies in Database </H1>

        <% 
            Connection con;
 			String userName = "root";
	   		String password = "papanaidu";
        	String url = "jdbc:mysql://localhost:3306/mrms";
	        Class.forName ("com.mysql.jdbc.Driver").newInstance();
    		con = DriverManager.getConnection (url, userName, password);

            Statement statement = con.createStatement() ;
            ResultSet resultset = 
                statement.executeQuery("select MovieID, Title, Rate from movies"); 
        %>

        <TABLE BORDER="1">
            <TR>
                <TH>MovieID</TH>
                <TH>Title</TH>
                <TH>Rating</TH>
            </TR>
            <% while(resultset.next()){ %>
            <TR>
                <TD> <%= resultset.getString(1) %></td>
                <TD> <%= resultset.getString(2) %></TD>
                <TD> <%= resultset.getString(3) %></TD>

            </TR>
            <% } %>
        </TABLE>
        
        <BR>
	<a href="getMovies.jsp"> New query </a>
	<br/>
	<a href="index.html">Back to Index</a>
</body>
</html>