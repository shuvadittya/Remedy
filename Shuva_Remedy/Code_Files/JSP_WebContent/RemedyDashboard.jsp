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

    <div id="loginHeader"><h2>Remedy Doctor System - Dashboard</h2></div>
    
    <table align="right">
    <tr>
    <input align="right" type=button onClick="parent.location='Login.jsp'" value='Sign Out'>
    </tr>
    </table>
    
	<img src="Doctor_Appoint.png" alt="Doctor Appointment" style="width:1350px;height:150px">
	
	<hr>
	
	<form action="redirectServlet" method="post"> 
		<table align="center">
			<tr>
			<td><input type="submit" name="GoAddDoctor" value="Add a Doctor"></td>
			<td><input type="submit" name="GoSearchDoctor" value="Search a Doctor"></td>
			</tr>
			<tr>
			<td><input type="submit" name="GoAddHospital" value="Add Hospital"></td>
			<td><input type="submit" name="GoSearchHospital" value="Search Hospital"></td>
			</tr>
			<tr>
			<td><input type="submit" name="GoAddChamber" value="Add Chamber"></td>
			<td><input type="submit" name="GoSearchChamber" value="Search Chamber"></td>
			</tr>
			<tr>
			<td><input type="submit" name="GoMakeAnAppointment" value="Make an Appointment"></td>
			<td><input type="submit" name="GoSearchAppointment" value="Search Appointment"></td>
			</tr>
		</table>
		</form>
	<hr>
</body>
</html>