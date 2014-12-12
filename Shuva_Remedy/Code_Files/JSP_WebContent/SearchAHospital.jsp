<%@ page language="java" import="java.util.*" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/static/css/global.css" />
<title>Remedy Doctor System - Hospital Details</title>
</head>
<body>
    <div id="loginHeader"><h2>Remedy Doctor System - Hospital Search</h2></div>
    <input align="right" type=button onClick="parent.location='Login.jsp'" value='Sign Out'>
	<img src="Doctor_Appoint.png" alt="Doctor Appointment" style="width:1350px;height:150px">
	<h4>Search for a Hospital</h4>
	<br>
	
	<form action="SearchHospitalServlet" method="post"> 
		<table align="center">
				<%
		Enumeration paramName = request.getParameterNames();
			
			if (paramName.hasMoreElements()) {	
				String name = (String) request.getAttribute("validity");
				
				if (name != null && name.equals("info")) {%>
		
			<h4 style="color:red">No Match Found!!!</h4>
			<%		}
				}
	%>
	
			<tr>
			<td>Hospital Name :</td>
			<td><input type="text" name="hospitalName" /></td>
			</tr>
			
			<tr>
			<td></td>
			<td><input type="submit" value="Search" name="Search"/></td>
		</tr>
		
		</table>
		</form>
	<hr>
</body>
</html>