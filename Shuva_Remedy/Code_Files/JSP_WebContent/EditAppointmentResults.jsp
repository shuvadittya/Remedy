<%@ page language="java" import="java.util.*,com.drexel.remedy.bean.SearchAppointmentBean" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remedy Doctor System</title>
<style>
table, th, td {
    border: 1px solid black;
}
</style>
</head>
<body>
 <div id="loginHeader"><h2>Remedy Doctor System - Appointment Search Results</h2></div>
 <input align="right" type=button onClick="parent.location='Login.jsp'" value='Sign Out'>
<img src="Doctor_Appoint.png" alt="Doctor Appointment" style="width:1350px;height:150px">

<input align="left"  type=button onClick="parent.location='RemedyDashboard.jsp'" value='Back'>

<br>
<form action="EditAppointmentServlet" method="post" >

<table align="center">
 
<tr>
			<td>APPOINT DATE:</td>
			<td><input type="text" name="aptDate" /></td>
		</tr>
		<tr>
			<td>APPOINT TIME:</td>
			<td><input type="test" name="aptTime"/></td>
		</tr>
		<tr>
			<td>PATIENT NAME:</td>
			<td><input type="text" name="patName" /></td>
		</tr>
		<tr>
			<td>DOCTOR NAME:</td>
			<td><input type="text" name="doctorName"/></td>
		</tr>
		<tr>
			<td>DOCTOR SPECIALIZATION</td>
			<td><input type="text" name="doctorSpec" /></td>
		</tr>
		<tr>
			<td>DOCTOR EMAIL</td>
			<td><input type="text" name="doctorEmail"/></td>
		</tr>
		<tr>
			<td>DOCTOR CELL NUM:</td>
			<td><input type="text" name="cellNum" /></td>
		</tr>
		<tr>
			<td>CHAMBER NAME:</td>
			<td><input type="text" name="chamberName"/></td>
		</tr>
		<tr>
			<td>CHAMBER ADDRESS1:</td>
			<td><input type="text" name="addr1" /></td>
		</tr>
		<tr>
			<td>CHAMBER ADDRESS2:</td>
			<td><input type="text" name="addr2"/></td>
		</tr>

<tr align="center">
<td><input  type=button onClick="parent.location='AppointmentUpdateSuccess.jsp'" value='Update'></td>
<td><input  type=button onClick="parent.location='SearchAppointment.jsp'" value='Cancel'></td>
</tr>
</table>
</form>

</body>
</html>