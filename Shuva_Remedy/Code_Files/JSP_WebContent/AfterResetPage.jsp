<%@ page language="java" import="java.util.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/static/css/global.css" />
<title>Remedy Doctor System</title>
</head>
<body>
 <div id="loginHeader"><h2>Remedy Doctor System</h2></div>
<img src="Doctor_Appoint.png" alt="Doctor Appointment" style="width:1350px;height:150px">
		<% 
		String userName = (String) request.getAttribute("userName");
		String password = (String) request.getAttribute("password");
		if(userName != null && password != null){
		%>
				<p align="center">Your UserName: <%=userName%></p>
				<p align="center">Your Password: <%=password%></p>
				
						<%	}
	%>

<h3 style="font-family:Arial Helvetica sans-serif;" align='center'><a href="Login.jsp" >Click here to Login!</a> </h3>
 
</body>
</html>