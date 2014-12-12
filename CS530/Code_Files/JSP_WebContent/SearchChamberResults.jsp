<%@ page language="java" import="java.util.*,com.drexel.remedy.bean.SearchChamberBean" contentType="text/html; charset=ISO-8859-1"
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
 <div id="loginHeader"><h2>Remedy Doctor System - Chamber Search Results</h2></div>
 <input align="right" type=button onClick="parent.location='Login.jsp'" value='Sign Out'>
<img src="Doctor_Appoint.png" alt="Doctor Appointment" style="width:1350px;height:150px">

<input align="left"  type=button onClick="parent.location='RemedyDashboard.jsp'" value='Back'>

<br>
<table align="center">
  <tr>
    <th></th>
    <th>CHAMBER NAME</th>
    <th>CHAMBER ADDRESS1</th>
     <th>CHAMBER ADDRESS2</th>
    <th>EMAIL</th>
     <th>PHONE NUM</th>
     <th>OFFICE HOURS</th>
  </tr>
  
 <%
 ArrayList<SearchChamberBean> beanList = (ArrayList<SearchChamberBean>) request.getAttribute("list");
 
 for(int i=0; i < beanList.size(); i++){  
	 SearchChamberBean chamberBean = new SearchChamberBean();
	 chamberBean = beanList.get(i);
 %> 
  
    <tr>
    
    <td><input type="radio" name="selectedConference" value="<%= chamberBean.getChamberName()%>"></td>
    <td><%= chamberBean.getChamberName()%></td>
    <td><%= chamberBean.getChamberAddrLine1()%></td>
    <td><%= chamberBean.getChamberAddrLine2()%></td>
    <td><%= chamberBean.getChamberEmail()%></td>
    <td><%= chamberBean.getChamberLandLineNum()%></td>
     <td><%= chamberBean.getChamberOfficeHour()%></td>
  </tr>
  
 <% }  %> 

</table>
<br/>
<table align="center">
<tr>
<input  type=button onClick="parent.location='DeletedChamberDetails.jsp'" value='Delete'>
</tr>
</table>


</body>
</html>