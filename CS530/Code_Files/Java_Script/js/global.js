function registerNew() {
	var resetObject = document.getElementById("reset");
	resetObject.style.visibility = "hidden";
	var regObject = document.getElementById("register");
	regObject.style.visibility = "visible";
	var paraObject = document.getElementById("regLink");
	paraObject.style.color = "maroon";
}
function resetPwd() {
	var regObject = document.getElementById("register");
	regObject.style.visibility = "hidden";
	var resetObject = document.getElementById("reset");
	resetObject.style.visibility = "visible";
	var paraObject = document.getElementById("resetLink");
	paraObject.style.color = "maroon";
}
function validateLoginForm() {
	var username = document.forms["login"]["username"].value;
	var password = document.forms["login"]["password"].value;
	if (username == "" | password == "") {
		return true;
	} else {
		document.forms["login"]["username"].value = "";
		document.forms["login"]["password"].value = "";
		document.getElementById("error").innerHTML = "Invalid username/password!";
		return false;
	}
}
function validateResetForm() {
	if (!verifyEmail(document.forms["reset"]["resetEmail"].value)) {
		document.forms["reset"]["resetEmail"].value = "";
		document.getElementById("resetError").innerHTML = "Not a valid e-mail address";
		return false;
	}
	//alert("Reset password is being sent to your email id!");
	return true;
}
function validateRegisterForm() {
	var username = document.forms["register"]["username"].value;
	var pwd = document.forms["register"]["password"].value;
	var cpwd = document.forms["register"]["confirmPassword"].value;
	var email = document.forms["register"]["email"].value;
	var cemail = document.forms["register"]["confirmEmail"].value;
	var quesOne = document.forms["register"]["quesOne"].value;
	var quesTwo = document.forms["register"]["quesTwo"].value;
	var errorMsg = "";
	if (username == "" | pwd == "" | cpwd == "" | email == "" | cemail == "" |quesOne == "" | quesTwo == "") {
		errorMsg = errorMsg + "Required fields (*) cannot be blank; ";
	} else {
		if (pwd != cpwd) {
			errorMsg = errorMsg + "Entered passwords does not match; ";
			document.forms["register"]["password"].value = "";
			document.forms["register"]["confirmPassword"].value = "";
		}
		if (!verifyEmail(email)) {
			errorMsg = errorMsg + "Invalid email address; ";
			document.forms["register"]["email"].value = "";
		}
		if (!verifyEmail(cemail)) {
			errorMsg = errorMsg + "Invalid confirm-email address; ";
			document.forms["register"]["confirmEmail"].value = "";
		}
		if (email != cemail) {
			errorMsg = errorMsg + "Entered email ids does not match";
			document.forms["register"]["email"].value = "";
			document.forms["register"]["confirmEmail"].value = "";
		}
	}
	document.getElementById("registerError").innerHTML = errorMsg;
	if (!errorMsg == "") {
		return false;
	} else {
		//alert("Successfully registered! Check your email for validating the account.");
		return true;
	}
}


function clearLoginError() {
	document.getElementById("error").innerHTML = "";
}

function clearResetError() {
	document.getElementById("resetError").innerHTML = "";
}

function validateAddDoctorForm() {
	var firstName = document.forms["register"]["firstName"].value;
	var lastName = document.forms["register"]["lastName"].value;
	var affiliation = document.forms["register"]["affiliation"].value;
	var specialization = document.forms["register"]["specialization"].value;
	var rating = document.forms["register"]["rating"].value;
	var email = document.forms["register"]["email"].value;
	var cellNum = document.forms["register"]["cellNum"].value;
	var landLineNum = document.forms["register"]["landLineNum"].value;
	var officeHour = document.forms["register"]["officeHour"].value;
	var errorMsg = "";
	if (firstName == "" | lastName == "" | affiliation == "" | specialization == "" |
			rating == "" |email == "" | cellNum == "" |
			landLineNum == "" |officeHour == "") {
		errorMsg = errorMsg + "Required fields (*) cannot be blank; ";
	} else {
		if (!verifyEmail(email)) {
			errorMsg = errorMsg + "Invalid email address; ";
			document.forms["register"]["email"].value = "";
		}
		if (!verifyCellNum(cellNum)) {
			errorMsg = errorMsg + "Invalid cell Number; ";
			document.forms["register"]["cellNum"].value = "";
		}if (!verifyPhoneNum(landLineNum)) {
			errorMsg = errorMsg + "Invalid land line Number; ";
			document.forms["register"]["landLineNum"].value = "";
		}
	}
	document.getElementById("registerError").innerHTML = errorMsg;
	if (!errorMsg == "") {
		return false;
	} else {
		//alert("Successfully registered! Check your email for validating the account.");
		return true;
	}
}

function validateAddNewChamber() {
	var hospitalName = document.forms["newChamber"]["hospitalName"].value;
	var addrLine1 = document.forms["newChamber"]["addrLine1"].value;
	var addrLine2 = document.forms["newChamber"]["addrLine2"].value;
	var email = document.forms["newChamber"]["email"].value;
	var landLineNum = document.forms["newChamber"]["landLineNum"].value;
	var officeHour = document.forms["newChamber"]["officeHour"].value;
	var errorMsg = "";
	if (hospitalName == "" | addrLine1 == "" | addrLine2 == "" | email == "" |
			landLineNum == "" |officeHour == "") {
		errorMsg = errorMsg + "Required fields (*) cannot be blank; ";
	} else {
		if (!verifyEmail(email)) {
			errorMsg = errorMsg + "Invalid email address; ";
			document.forms["register"]["email"].value = "";
		}if (!verifyPhoneNum(landLineNum)) {
			errorMsg = errorMsg + "Invalid land line Number; ";
			document.forms["register"]["landLineNum"].value = "";
		}
	}
	document.getElementById("registerError").innerHTML = errorMsg;
	if (!errorMsg == "") {
		return false;
	} else {
		//alert("Successfully registered! Check your email for validating the account.");
		return true;
	}
}

function validateAddHospitalForm() {
	var hospitalName = document.forms["register"]["hospitalName"].value;
	var addrLine1 = document.forms["register"]["addrLine1"].value;
	var addrLine2 = document.forms["register"]["addrLine2"].value;
	var email = document.forms["register"]["email"].value;
	var landLineNum = document.forms["register"]["landLineNum"].value;
	var errorMsg = "";
	if (hospitalName == "" | addrLine1 == "" | addrLine2 == "" | email == "" |
			landLineNum == "") {
		errorMsg = errorMsg + "Required fields (*) cannot be blank; ";
	} else {
		if (!verifyEmail(email)) {
			errorMsg = errorMsg + "Invalid email address; ";
			document.forms["register"]["email"].value = "";
		}	if (!verifyPhoneNum(landLineNum)) {
			errorMsg = errorMsg + "Invalid land line Number; ";
			document.forms["register"]["landLineNum"].value = "";
		}
	}
	document.getElementById("registerError").innerHTML = errorMsg;
	if (!errorMsg == "") {
		return false;
	} else {
		//alert("Successfully registered! Check your email for validating the account.");
		return true;
	}
}


function validateMakeAnAppointment() {
	var appointmentDate = document.forms["makeAppointment"]["appointmentDate"].value;
	var appointmentTime = document.forms["makeAppointment"]["appointmentTime"].value;
	var doctorName = document.forms["makeAppointment"]["doctorName"].value;
	var patientTime = document.forms["makeAppointment"]["patientTime"].value;
	var chamberAddress = document.forms["makeAppointment"]["chamberAddress"].value;
	var errorMsg = "";
	if (appointmentDate =="" | appointmentTime == "" | doctorName == "" | patientTime == "" | chamberAddress == "") {
		errorMsg = errorMsg + "Required fields (*) cannot be blank; ";
	} 
	document.getElementById("registerError").innerHTML = errorMsg;
	if (!errorMsg == "") {
		return false;
	} else {
		//alert("Successfully registered! Check your email for validating the account.");
		return true;
	}
	
	
}

function verifyEmail(email) {
	var atpos = email.indexOf("@");
	var dotpos = email.lastIndexOf(".");
	if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
		return false;
	}
	return true;
}

function verifyPhoneNum(landLineNum) {
	var phoneRe = /^[2-9]\d{2}[2-9]\d{2}\d{4}$/;
	var digits = landLineNum.replace(/\D/g, "");
	return (digits.match(phoneRe) !== null);
}

function verifyCellNum(cellNum) {
	var phoneRe = /^[2-9]\d{2}[2-9]\d{2}\d{4}$/;
	var digits = cellNum.replace(/\D/g, "");
	return (digits.match(phoneRe) !== null);
}