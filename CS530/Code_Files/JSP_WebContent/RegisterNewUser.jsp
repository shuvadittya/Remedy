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
	<div id="loginHeader"><h2>Register in Remedy Doctor System</h2></div>
	<hr>
		<p id="regLink" onclick="registerNew()">Register</p> <a href="RemedyHomePage.jsp">Back</a>
		<!-- <p id="resetLink" onclick="resetPwd()">Forget/Reset</p> -->
	<hr>
	<div id="register">
		<h4>REGISTER</h4>
		<form name="register" method="post" action ="RegisterNewUser" onsubmit="return validateRegisterForm();">
		<p id="registerError" style="color: red;"></p>
		<table id="rrTable">
			<tr>
				<td>Name</td>
				<td><input type="text" name="name" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>UserName*</td>
				<td><input type="text" name="username" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Password*</td>
				<td><input type="password" name="password" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Confirm Password*</td>
				<td><input type="password" name="confirmPassword" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Email id*</td>
				<td><input type="text" name="email" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>Confirm Email id*</td>
				<td><input type="text" name="confirmEmail" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>What is your favorite Hero?*</td>
				<td><input type="text" name="quesOne" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td>What is your favorite car model?*</td>
				<td><input type="text" name="quesTwo" onfocus="clearRegisterRError()"/></td>
			</tr>
			<tr>
				<td />
				<td><input type="submit" value="Create Account"></td>
			</tr>
		</table>
		</form>
	</div>
	 <div id="reset">
		<h4>RESET</h4>
		<form name="reset" method="post" action ="Login.jsp" onsubmit="return validateResetForm();">
		<p id="resetError" style="color: red;"></p>
		<table id="rrTable">
			<tr>
				<td>Email id</td>
				<td><input type="text" name="resetEmail" onfocus="clearResetError()" /></td>
			</tr>
			<tr>
				<td />
				<td><input type="submit" name="reset" /></td>
			</tr>
		</table>
		</form>
	</div> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/static/js/global.js"></script>
</body>
</html>