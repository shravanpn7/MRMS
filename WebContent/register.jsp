
<%@ page language="java" import="cmpe18032.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Customer Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/cufon-yui.js" type="text/javascript"></script>
<script src="js/cufon-replace.js" type="text/javascript"></script>
<script src="js/Gill_Sans_400.font.js" type="text/javascript"></script>
<script src="js/script.js" type="text/javascript"></script>
<!--[if lt IE 7]>
<script type="text/javascript" src="js/ie_png.js"></script>
<script type="text/javascript">ie_png.fix('.png, .link1 span, .link1');</script>
<link href="css/ie6.css" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body id="page3">
<!-- START PAGE SOURCE -->
<div class="tail-top">
  <div class="tail-bottom">
    <div id="main">
      <div id="header">
        <div class="row-1">
          <div class="fleft"><a href="#">Customer <span>Registration</span></a></div>
          <ul>
            <li><a href="#"><img src="images/icon1.gif" alt="" /></a></li>
            <li><a href="#"><img src="images/icon2.gif" alt="" /></a></li>
            <li><a href="#"><img src="images/icon3.gif" alt="" /></a></li>
          </ul>
        </div>
<html>
<head>
<script LANGUAGE="javascript">

function check_all_fields(form_obj){
	alert(form_obj.searchAttribute.value+"='"+form_obj.login.value+"'");
	if( form_obj.login.value == "" || form_obj.firstname.value == "" || form_obj.lastname.value == ""){
		alert("Fields should be nonempty");
		return false;
	}
	return true;
}

</script> 
</head>
<body>

<%
String isSet = request.getParameter("login");
if( isSet == null ){
%>

	Add a new user:
	<form name="user_add" method=get onsubmit="return check_all_fields(this)" action="register.jsp">
		<input type=hidden name="searchAttribute" value="newuser">
		Login:
		<input type=text name="login" length=10><br/>
		Password:
		<input type=password name="password" length=10><br/>
		Email ID:
		<input type=text name="email" length=20><br/>
		First Name:
		<input type=text name="firstname" length=10><br/>
		Last Name:
		<input type=text name="lastname" length=10><br/>
		Middle Name:
		<input type=text name="middlename" length=10><br/>
		Phone:
		<input type=text name="phone" length=10><br/>
		House Number:
		<input type=text name="housenumber" length=10><br/>
		Street:
		<input type=text name="street" length=10><br/>
		City:
		<input type=text name="city" length=10><br/>
		Credit Card Number:
		<input type=text name="ccnum" length=10><br/>
		Membership Type
		<input type=text name="memtype" length=10><br/>
		<input type=submit>
	</form>
	<BR><BR>

<%

} else {

	String custID = request.getParameter("login");
	String password = request.getParameter("password");
	String firstname = request.getParameter("firstname");
	String middleName = request.getParameter("middlename");
	String lastname = request.getParameter("lastname");
	String houseNo = request.getParameter("housenumber");
	String city = request.getParameter("city");
	String street = request.getParameter("street");
	String email = request.getParameter("email");
	String memType = request.getParameter("memtype");
	String phone = request.getParameter("phone");
	String ccNumber = request.getParameter("ccnum");
	String regDate = "2014-05-05";
	
	cmpe18032.Connector connector = new Connector();
	
	cmpe18032.Queries query = new Queries();
	
%>  
  
  <b>New User Added</b> <BR><BR>
  <%
  		

  		out.println("adding a new user under username under: <b> "+custID+
					" </b>");
  		out.println(query.addNewCustomer(connector.stmt, custID, password, firstname, lastname, 
  				middleName, houseNo, street, city, phone, ccNumber, email, regDate, memType));
  %>

<%
 connector.closeStatement();
 connector.closeConnection();
}  // We are ending the braces for else here
%>

<BR><a href="register.jsp"> New query </a><br/>
<a href="Login.jsp">Back to Index</a>

</body>