<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

    <%@ page import="java.sql.*" %>
    
<% Class.forName("sun.jdbc.odbc.JdbcOdbcDriver"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List Of Movies</title>
</head>
<body>
 <H1>List of Customers in MRMS </H1>

        <% 
            Connection con;
 			String userName = "root";
	   		String password = "papanaidu";
        	String url = "jdbc:mysql://localhost:3306/mrms";
	        Class.forName ("com.mysql.jdbc.Driver").newInstance ();
    		con = DriverManager.getConnection (url, userName, password);

            Statement statement = con.createStatement() ;
            ResultSet resultset = 
                statement.executeQuery("select Custid, email,phone,Fname,Lname,Mname,Hno,Street,City,Regdate,Memtype from customer") ; 
        %>

        <TABLE BORDER="1">
            <TR>
                <TH>Custid</TH>
                <TH>Email</TH>
                <TH>phone</TH>
                <TH>Fname</TH>
                <TH>Lname</TH>
                <TH>Mname</TH>
                <TH>Hno</TH>
                <TH>Street</TH>
                <TH>City</TH>
                <TH>Regdate</TH>
                <TH>Memtype</TH>
            </TR>
            <% while(resultset.next()){ %>
            <TR>
                <TD> <%= resultset.getString(1) %></td>
                <TD> <%= resultset.getString(2) %></TD>
                <TD> <%= resultset.getString(3) %></td>
                <TD> <%= resultset.getString(4) %></TD>
                <TD> <%= resultset.getString(5) %></td>
                <TD> <%= resultset.getString(6) %></TD>
                <TD> <%= resultset.getString(7) %></td>
                <TD> <%= resultset.getString(8) %></TD>
                <TD> <%= resultset.getString(9) %></td>
                <TD> <%= resultset.getString(10) %></TD>
                <TD> <%= resultset.getString(11) %></td>
                

            </TR>
            <% } %>
        </TABLE>
        
        <BR>
	<a href="user.jsp"> New query </a>
	<br/>
	<a href="index.html">Back to Index</a>
</body>
</html>