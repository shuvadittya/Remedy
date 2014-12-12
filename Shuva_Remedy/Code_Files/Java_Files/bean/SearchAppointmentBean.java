package com.drexel.remedy.bean;

public class SearchAppointmentBean {
	
	private String doctorName;
	private String patientName;
	private String appointmentTime;
	private String appointmentDate;
	private String chamberName;
	private String chamberAddressLine1;
	private String chamberAddressLine2;
	private String doctor_specialization;
	private String doctor_cellNum;
	private String doctor_email;
	
	public String getDoctorName() {
		return doctorName;
	}
	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}
	public String getPatientName() {
		return patientName;
	}
	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}
	public String getAppointmentTime() {
		return appointmentTime;
	}
	public void setAppointmentTime(String appointmentTime) {
		this.appointmentTime = appointmentTime;
	}
	public String getChamberName() {
		return chamberName;
	}
	public void setChamberName(String chamberName) {
		this.chamberName = chamberName;
	}
	public String getChamberAddressLine1() {
		return chamberAddressLine1;
	}
	public void setChamberAddressLine1(String chamberAddressLine1) {
		this.chamberAddressLine1 = chamberAddressLine1;
	}
	public String getChamberAddressLine2() {
		return chamberAddressLine2;
	}
	public void setChamberAddressLine2(String chamberAddressLine2) {
		this.chamberAddressLine2 = chamberAddressLine2;
	}
	public String getDoctor_specialization() {
		return doctor_specialization;
	}
	public void setDoctor_specialization(String doctor_specialization) {
		this.doctor_specialization = doctor_specialization;
	}
	public String getDoctor_cellNum() {
		return doctor_cellNum;
	}
	public void setDoctor_cellNum(String doctor_cellNum) {
		this.doctor_cellNum = doctor_cellNum;
	}
	public String getDoctor_email() {
		return doctor_email;
	}
	public void setDoctor_email(String doctor_email) {
		this.doctor_email = doctor_email;
	}
	public String getAppointmentDate() {
		return appointmentDate;
	}
	public void setAppointmentDate(String appointmentDate) {
		this.appointmentDate = appointmentDate;
	}

}
