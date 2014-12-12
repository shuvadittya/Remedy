<%@ page language="java" import="java.util.*" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remedy Doctor System</title>
</head>
<body>
	<div id="loginHeader"><h2>Remedy Doctor System - Hospital Details</h2></div>
	<input align="right" type=button onClick="parent.location='Login.jsp'" value='Sign Out'>
	<img src="Doctor_Appoint.png" alt="Doctor Appointment" style="width:1350px;height:150px">
		<h4>Add a New Hospital</h4>
		
		<input align="left"  type=button onClick="parent.location='RemedyDashboard.jsp'" value='Back'>
		<br/>
		<form name="newHospital" method="post" action ="AddNewHospital" onsubmit="return validateAddHospitalForm();">
		<p id="registerError" style="color: red;"></p>
		<table align="center">
			<tr>
				<td>Hospital Name :</td>
				<td><input type="text" name="hospitalName" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Address Line1 :</td>
				<td><input type="text" name="addrLine1" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Address Line2 :</td>
				<td><input type="text" name="addrLine2" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Email :</td>
				<td><input type="text" name="email" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Phone Number :</td>
				<td><input type="text" name="landLineNum" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td><input type="submit" value="Add"></td>
				<td><input type=button onClick="parent.location='RemedyDashboard.jsp'" value='Cancel'></td>
			</tr>
		</table>
		</form>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/global.js"></script>
</body>
</html>