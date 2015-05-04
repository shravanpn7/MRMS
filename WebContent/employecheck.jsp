<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mrms",
            "root", "papanaidu");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from employee where EmpID='" + userid + "' and Name='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("Empid", userid);
        //out.println("welcome " + userid);
        //out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("manage.html");
    } else {
        out.println("Invalid password <a href='Employer.jsp'>try again</a>");
    }
%>