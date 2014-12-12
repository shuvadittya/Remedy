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


<table align="center">
  <tr>
    <th></th>
    <th>APPOINT DATE</th>
    <th>APPOINT TIME</th>
    <th>PATIENT NAME</th>
    <th>DOCTOR NAME</th>
     <th>DOCTOR SPECIALIZATION</th>
     <th>DOCTOR EMAIL</th>
    <th>DOCTOR CELL NUM</th>
     <th>APPOINTMENT TIME</th>
     <th>CHAMBER NAME</th>
     <th>CHAMBER ADDRESS1</th>
     <th>CHAMBER ADDRESS2</th>
  </tr>
  
 <%
 ArrayList<SearchAppointmentBean> beanList = (ArrayList<SearchAppointmentBean>) request.getAttribute("list");
 
 for(int i=0; i < beanList.size(); i++){  
	 SearchAppointmentBean appointmentBean = new SearchAppointmentBean();
	 appointmentBean = beanList.get(i);
 %> 
  
    <tr>
    
    <td><input type="radio" name="selectedConference" value="<%= appointmentBean.getChamberName()%>"></td>
    <td><%= appointmentBean.getAppointmentDate()%></td>
    <td><%= appointmentBean.getAppointmentTime()%></td>
    <td><%= appointmentBean.getPatientName()%></td>
    <td><%= appointmentBean.getDoctorName()%></td>
    <td><%= appointmentBean.getDoctor_specialization()%></td>
    <td><%= appointmentBean.getDoctor_email()%></td>
    <td><%= appointmentBean.getDoctor_cellNum()%></td>
     <td><%= appointmentBean.getChamberName()%></td>
       <td><%= appointmentBean.getChamberAddressLine1()%></td>
     <td><%= appointmentBean.getChamberAddressLine2()%></td>
  </tr>
  
 <% }  %> 

</table>
<br/>
<form action="EditAppointmentServlet" method="post" >
<table align="center">
<tr>
<td><input  type=button onClick="parent.location='EditAppointmentResults.jsp'" value='Edit'></td>
<td><input  type=button onClick="parent.location='DeletedAppointmentDetails.jsp'" value='Delete'></td>
</tr>
</table>
</form>

</body>
</html>