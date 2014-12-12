<%@ page language="java" import="java.util.*,com.drexel.remedy.bean.SearchDoctorBean" contentType="text/html; charset=ISO-8859-1"
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
 <div id="loginHeader"><h2>Remedy Doctor System - Doctor Search Results</h2></div>
 <input align="right" type=button onClick="parent.location='Login.jsp'" value='Sign Out'>
<img src="Doctor_Appoint.png" alt="Doctor Appointment" style="width:1350px;height:150px">

<input align="left"  type=button onClick="parent.location='RemedyDashboard.jsp'" value='Back'>

<br>
<table align="center">
  <tr>
    <th></th>
    <th>FNAME</th>
    <th>LNAME</th>
     <th>HOSPITAL</th>
    <th>SPECIALIZATION</th>
     <th>RATING</th>
    <th>EMAIL</th>
     <th>PHONE</th>
    <th>HOURS</th>
  </tr>
  
 <%
 ArrayList<SearchDoctorBean> beanList = (ArrayList<SearchDoctorBean>) request.getAttribute("list");
 
 for(int i=0; i < beanList.size(); i++){  
	 SearchDoctorBean doctorBean = new SearchDoctorBean();
	 doctorBean = beanList.get(i);
 %> 
  
    <tr>
    
    <td><input type="radio" name="selectedConference" value="<%= doctorBean.getFirstName()%>"></td>
    <td><%= doctorBean.getFirstName()%></td>
    <td><%= doctorBean.getLastName()%></td>
    <td><%= doctorBean.getAffiliation()%></td>
    <td><%= doctorBean.getSpecialization()%></td>
    <td><%= doctorBean.getRating()%></td>
    <td><%= doctorBean.getEmail()%></td>
    <td><%= doctorBean.getCellNum()%></td>
    <td><%= doctorBean.getOfficeHour()%></td>
  </tr>
  
 <% }  %> 

</table>
<br/>
<table align="center">
<tr>
<td><input  type=button onClick="parent.location='EditDoctorDetails.jsp'" value='Edit'></td>
<td><input  type=button onClick="parent.location='DeletedDoctorDetails.jsp'" value='Delete'></td>
</tr>
</table>


</body>
</html>