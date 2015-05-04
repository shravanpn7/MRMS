<%@page import="cmpe18032.BCrypt"%>
<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    String hashed = "";
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mrms",
            "root", "papanaidu");
    Statement st = con.createStatement();
    ResultSet rs;
    
    session.setAttribute("uname", userid); 
    
    rs = st.executeQuery("select pwd from customer where custid= '" + userid + "'");
    if (rs.next()) {
    	
    	hashed = rs.getString(1);
    	if (BCrypt.checkpw(pwd,hashed))
	       response.sendRedirect("index.html");
        else
        	out.println("Invalid Password <a href='Login.jsp'>try again</a>");
    } else {
        out.println("Invalid password <a href='Login.jsp'>try again</a>");
    }
%>