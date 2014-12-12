<%@ page language="java" import="java.util.*" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remedy Doctor System</title>
</head>
<body>
	<div id="loginHeader"><h2>Remedy Doctor System - Appointment Details</h2></div>
	<input align="right" type=button onClick="parent.location='Login.jsp'" value='Sign Out'>
	<img src="Doctor_Appoint.png" alt="Doctor Appointment" style="width:1350px;height:150px">
		<h4 align="center">Make an Appointment</h4>
		<form name="makeAppointment" method="post" action ="MakeAnAppointment" onsubmit="return validateMakeAnAppointment();">
		<p id="registerError" style="color: red;"></p>
		<table align="center">
			<tr>
				<td>Patient Name :</td>
				<td><input type="text" name="patientName" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Doctor Last Name :</td>
				<td><input type="text" name="doctorName" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Chamber Address :</td>
				<td><input type="text" name="chamberAddress" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Appointment Date :</td>
				<td><input type="text" name="appointmentDate" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Appointment Time :</td>
				<td><input type="text" name="appointmentTime" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td><input type="submit" value="Save"></td>
				<td><input type=button onClick="parent.location='RemedyDashboard.jsp'" value='Cancel'></td>
			</tr>
		</table>
		</form>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/global.js"></script>
</body>
</html>