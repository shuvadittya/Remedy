package com.drexel.remedy.logic;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.drexel.remedy.bean.SearchAppointmentBean;
import com.drexel.remedy.bean.SearchHospitalBean;
import com.drexel.remedy.util.Constants;

public class SearchAppointmentServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	ArrayList<SearchAppointmentBean> listOfAppointments = new ArrayList<SearchAppointmentBean>();
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchAppointmentServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	String doctorLastName = request.getParameter("doctorName");
	String patientName = request.getParameter("patientName");
	String appointmentTime = request.getParameter("appointmentTime");
	String appointmentDate = request.getParameter("appointmentDate");
		
           Connection conn = null;
           Constants con = new Constants();
           int count = 0;
           
		//MMIE Type
		response.setContentType("text/html");

           try
           {

     
        	   
		// Step1: register the JDBC driver
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Step2: Invoke its getConnection() method
		conn = DriverManager.getConnection(con.URL, con.USER, con.PASSWORD);

		System.out.println("Database connection established");
		
		  Statement s = conn.createStatement();
        // Step3: Get a Statement Object
		StringBuffer sb = new StringBuffer();
		
		//sb.append("select distinct a.Appointment_PatientName, a.Appointment_DoctorName, a.Appointment_Time,a.appointmentDate, ");
		/*sb.append("select distinct a.Appointment_PatientName, a.Appointment_DoctorName, a.Appointment_Time,a.Appointment_Date, ");
		sb.append(" c.Chamber_name, c.Chamber_addrLine1, c.Chamber_addrLine2, ");
		sb.append(" d.doctor_specialization, d.doctor_cellNum, ");
		sb.append(" d.doctor_email from remedyapp.Doctor_Details d, remedyapp.Hospital_Details h, ");
		sb.append(" remedyapp.Chamber_Details c, remedyapp.Appointment_Details a ");
		sb.append(" where ");
		sb.append(" d.doctor_lastName = '"+ doctorLastName +"' AND ");
		sb.append(" a.Appointment_PatientName = '"+ patientName +"' AND "); 
		sb.append(" a.Appointment_Time = '"+appointmentTime +"' AND ");
		sb.append(" a.Appointment_Date = '"+appointmentDate +"'");*/
		
		sb.append("select distinct a.Appointment_PatientName, a.Appointment_DoctorName, a.Appointment_Time,a.Appointment_Date, ");
        sb.append(" c.Chamber_name, c.Chamber_addrLine1, c.Chamber_addrLine2, ");
        sb.append(" d.doctor_specialization, d.doctor_cellNum, ");
        sb.append(" d.doctor_email from remedyapp.Doctor_Details d, remedyapp.Hospital_Details h, ");
        sb.append(" remedyapp.Chamber_Details c, remedyapp.Appointment_Details a ");
        sb.append(" where ");
        sb.append(" d.doctor_lastName = '"+ doctorLastName +"' AND ");
        sb.append(" a.Appointment_DoctorName = '"+ doctorLastName +"' AND ");
        sb.append(" a.Appointment_PatientName = '"+ patientName +"' AND "); 
        sb.append(" a.Appointment_Time = '"+appointmentTime +"' AND ");
        sb.append(" a.Appointment_Date = '"+appointmentDate +"'");
		
	
		s.executeQuery(sb.toString());
		
		
		//Retreiving the datas through resultset
		ResultSet rs = s.getResultSet();
		listOfAppointments.clear();
		while (rs.next()) {
			SearchAppointmentBean appointmentBean = new SearchAppointmentBean();
			appointmentBean.setDoctorName(rs.getString("Appointment_DoctorName"));
			appointmentBean.setPatientName(rs.getString("Appointment_PatientName"));
			appointmentBean.setAppointmentTime(rs.getString("Appointment_Time"));
			appointmentBean.setAppointmentDate(rs.getString("Appointment_Date"));
			appointmentBean.setDoctor_email(rs.getString("doctor_email"));
			appointmentBean.setDoctor_cellNum(rs.getString("doctor_cellNum"));
			appointmentBean.setChamberName(rs.getString("Chamber_name"));
			appointmentBean.setChamberAddressLine1(rs.getString("Chamber_addrLine1"));
			appointmentBean.setChamberAddressLine2(rs.getString("Chamber_addrLine2"));
			appointmentBean.setDoctor_specialization(rs.getString("doctor_specialization"));
	
			listOfAppointments.add(appointmentBean);
			++count;
		}
		rs.close();
		s.close();
		System.out.println(count + " rows were retrieved");

		} catch (Exception e) {
			System.err.println("Cannot connect to database server");
		} finally {
			if (conn != null) {
				try {
					conn.close();
					System.out.println("Database connection terminated");
				} catch (Exception e) { /* ignore close errors */
				}
			}
		}
		
           if(listOfAppointments != null && listOfAppointments.size() > 0){
        	   request.setAttribute("list", listOfAppointments);
				request.getRequestDispatcher("SearchAppointmentResults.jsp").forward(request,
						response);
					
			} else {
				request.setAttribute("validity", "info");
				RequestDispatcher next = request.getRequestDispatcher("SearchAppointment.jsp");
				next.forward(request, response);
			}

	}


}