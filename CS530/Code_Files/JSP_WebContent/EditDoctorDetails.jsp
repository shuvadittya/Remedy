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
			<td>FIRST NAME:</td>
			<td><input type="text" name="fName" /></td>
		</tr>
		<tr>
			<td>LAST NAME:</td>
			<td><input type="text" name="lName"/></td>
		</tr>
		<tr>
			<td>HOSPITAL:</td>
			<td><input type="text" name="hospital" /></td>
		</tr>
		<tr>
			<td>SPECIALIZATION:</td>
			<td><input type="text" name="spec"/></td>
		</tr>
		<tr>
			<td>RATING</td>
			<td><input type="text" name="rating" /></td>
		</tr>
		<tr>
			<td>EMAIL</td>
			<td><input type="text" name="Email"/></td>
		</tr>
		<tr>
			<td>PHONE:</td>
			<td><input type="text" name="cellNum" /></td>
		</tr>
		<tr>
			<td>HOURS:</td>
			<td><input type="text" name="hours"/></td>
		</tr>

<tr align="center">
<td><input  type=button onClick="parent.location='DoctorUpdateSuccess.jsp'" value='Update'></td>
<td><input  type=button onClick="parent.location='SearchAppointment.jsp'" value='Cancel'></td>
</tr>
</table>
</form>

</body>
</html>