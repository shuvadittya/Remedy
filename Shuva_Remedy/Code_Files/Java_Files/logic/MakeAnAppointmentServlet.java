package com.drexel.remedy.logic;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.drexel.remedy.util.Constants;

public class MakeAnAppointmentServlet extends HttpServlet  {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MakeAnAppointmentServlet() {
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
	
           Connection conn = null;
           Constants con = new Constants();
           int count = 0;
           
		//MMIE Type
		response.setContentType("text/html");

           try
           {
        	   
		String appointmentTime = request.getParameter("appointmentTime");
		String appointmentDate = request.getParameter("appointmentDate");
		String doctorName = request.getParameter("doctorName");
		String patientName = request.getParameter("patientName");
		String chamberAddress = request.getParameter("chamberAddress");


		System.out.println(appointmentTime + " " + doctorName + " " + patientName + " " + 
				chamberAddress ); 

		
		// Step1: register the JDBC driver
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Step2: Invoke its getConnection() method
		conn = DriverManager.getConnection(con.URL, con.USER, con.PASSWORD);

		System.out.println("Database connection established");
		
        // Step3: Get a Statement Object
			StringBuffer sb = new StringBuffer();
			
			sb.append("INSERT INTO Appointment_Details ");
			sb.append(" (Appointment_PatientName,Appointment_DoctorName, ");
			sb.append(" Appointment_ChamberAddress,Appointment_Time,Appointment_Date, ");
			sb.append(" submission_date) VALUES ");
			sb.append(" (?,?,?,?,?,?) ");
			
			
			PreparedStatement s = conn.prepareStatement(sb.toString());
			s.setString(1, patientName);
			s.setString(2, doctorName);
			s.setString(3, chamberAddress);
			s.setString(4, appointmentTime);
			s.setString(5, appointmentDate);
			Date utilDate = new Date();
			s.setDate(6, new java.sql.Date(utilDate.getTime()));
		
			count = s.executeUpdate();
			
			s.close();
			System.out.println(count + " rows were inserted");

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
		
			if (count > 0) {
				
				request.getRequestDispatcher("AppointmentConfirmationPage.jsp").forward(request,
						response);
	
					
			} else {
				request.getRequestDispatcher("RemedyDashboard.jsp").forward(request,
						response);

			}
	}
}

