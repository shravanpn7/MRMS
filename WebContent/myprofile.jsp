
<%@ page language="java" import="cmpe226.*"%>
   <%@ page import = "cmpe226.*" %>
    <%@ page import="java.sql.*" %>
    <% Class.forName("sun.jdbc.odbc.JdbcOdbcDriver"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

</head>
<body>

	<h1>My Profile</h1>
	
	<BR>
	<BR>

	<%
		
		HttpSession ses = request.getSession(true);	
		//String login = request.getParameter("uname");
		String login = (String)session.getAttribute("uname");

		 Connection con;
			String userName = "root";
	   		String password = "papanaidu";
     	String url = "jdbc:mysql://localhost:3306/mrms";
	        Class.forName ("com.mysql.jdbc.Driver").newInstance();
 		con = DriverManager.getConnection (url, userName, password);

         Statement stmt = con.createStatement() ;
         ResultSet rs = 
             stmt.executeQuery("select CustID,email,phone,Fname,Lname,Mname,Hno,Street,City,RegDate,MemType from customer where CustID = '" + login + "'"); 
         out.print("executing ");
 		try {
 			
 			while (rs.next()) {
 				String CustID = rs.getString("CustID");
 				String firstName = rs.getString("Fname");
 				String lastName = rs.getString("Lname");
 				String email = rs.getString("email");
 				String phone = rs.getString("phone");
 				String Hno = rs.getString("Hno");
 				String Street = rs.getString("Street");
 				String City = rs.getString("City");
 				String RegDate = rs.getString("RegDate");
 				String MemType = rs.getString("MemType");

 				out.println("Customer ID -" + CustID); %> <br> <%
 				out.println("First Name - " + firstName); %> <br> <% 
 				out.println("Last Name - " + lastName);%> <br> <%
 				out.println("email - " + email);%> <br> <%
 				out.println("phone - " + phone);%> <br> <%
 				out.println("House Number - " + Hno);%> <br> <%
 				out.println("Street - " + Street);%> <br> <%
 				out.println("City - " + City);%> <br> <%
 				out.println("RegDate - " + RegDate);%> <br> <%
 				out.println("MemType - " + MemType);%> <br> <%
 			}

 			rs.close();
 		} catch (Exception e) {
 			out.print("cannot execute the query: " + e.toString());

 		} finally {
 			try {
 				if (rs != null && !rs.isClosed())
 					rs.close();
 			} catch (Exception e) {
 				out.print("cannot close resultset");
 			}
 		}

  		
  %>
		
	
 <BR>
	<a href="myprofile.jsp"> New query </a>
	<br/>
	<a href="index.html">Back to Index</a>

</body>