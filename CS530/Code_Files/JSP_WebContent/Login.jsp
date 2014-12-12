<%@ page language="java" import="java.util.*" contentType="text/html; charset=ISO-8859-1"
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
	<div id="loginHeader"><h2>Remedy Doctor System</h2></div>
	<img src="Doctor_Appoint.png" alt="Doctor Appointment" style="width:1350px;height:150px">
	<hr>
	<form action="LoginServlet" method="post" >
	<p id="error" style="color: red;"></p>
	<table>
				<%
		Enumeration paramName = request.getParameterNames();
			
			if (paramName.hasMoreElements()) {	
				String name = (String) request.getAttribute("validity");
				
				if (name != null && name.equals("info")) {%>
		
			<h4 style="color:red">Invalid Username or Password!!!</h4>
			<%		}else if(name != null && name.equals("duplicate")){ %>
				<h4 style="color:red">UserName Already Exist!!!</h4>
		<%		}
				}
	%>
	
		<tr>
			<td>UserName</td>
			<td><input type="text" name="username" /></td>
		</tr>
		<tr>
			<td>Password</td>
			<td><input type="password" name="password"/></td>
		</tr>
		<tr>
			<td></td>
			<td><a href="ForgotIdPass.jsp">Forgot Password!</a></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" value="Sign In" name="loginSubmit"/></td>
		</tr>
	</table>
	</form>
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/global.js"></script>
</body>
</html>