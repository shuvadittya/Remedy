<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
 <div id="loginHeader"><h2>Remedy Doctor System - Appointment Details</h2></div>
 <input align="right" type=button onClick="parent.location='Login.jsp'" value='Sign Out'>
<img src="Doctor_Appoint.png" alt="Doctor Appointment" style="width:1350px;height:150px">

<h3 align='center'>Appointment Details is Successfully Updated!</h3>
 
<table align="center">
			<tr>
			<td><input type=button onClick="parent.location='MakeAnAppointment.jsp'" value='Add Appointment'></td>
			</tr>
			<tr>
			<td><input type=button onClick="parent.location='SearchAppointment.jsp'" value='Search Appointment'></td>
			</tr>
			<tr>
			<td><input type=button onClick="parent.location='RemedyDashboard.jsp'" value='Remedy Dashboard'></td>
			</tr>
		</table>
		
</body>
</html>