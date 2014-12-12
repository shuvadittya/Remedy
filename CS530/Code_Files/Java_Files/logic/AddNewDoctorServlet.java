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

public class AddNewDoctorServlet extends HttpServlet  {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddNewDoctorServlet() {
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
        	   
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String affiliation = request.getParameter("affiliation");
		String specialization = request.getParameter("specialization");
		String rating = request.getParameter("rating");
		String email = request.getParameter("email");
		String cellNum = request.getParameter("cellNum");
		String landLineNum = request.getParameter("landLineNum");
		String officeHour = request.getParameter("officeHour");

		
		
		System.out.println(firstName + " " + lastName + " " + affiliation + " " + 
				specialization + " " +rating + " " + email + " " + cellNum + " " 
				+landLineNum + " " + officeHour); 

		
		// Step1: register the JDBC driver
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Step2: Invoke its getConnection() method
		conn = DriverManager.getConnection(con.URL, con.USER, con.PASSWORD);

		System.out.println("Database connection established");
		
        // Step3: Get a Statement Object

			//StringBuilder & StringBuffer
			StringBuffer sb = new StringBuffer();
			
			sb.append("INSERT INTO Doctor_Details ");
			sb.append(" (doctor_firstname,doctor_lastName, ");
			sb.append(" doctor_affiliation,doctor_specialization, ");
			sb.append(" doctor_rating,doctor_email, ");
			sb.append(" doctor_cellNum,doctor_landLineNum,doctor_officeHour, ");
			sb.append(" submission_date) VALUES ");
			sb.append(" (?,?,?,?,?,?,?,?,?,?) ");
			
			
			PreparedStatement s = conn.prepareStatement(sb.toString());
			s.setString(1, firstName);
			s.setString(2, lastName);
			s.setString(3, affiliation);
			s.setString(4, specialization);
			s.setString(5, rating);
			s.setString(6, email);
			s.setString(7, cellNum);
			s.setString(8, landLineNum);
			s.setString(9, officeHour);
			Date utilDate = new Date();
			s.setDate(10, new java.sql.Date(utilDate.getTime()));
		
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
				
				request.getRequestDispatcher("DoctorConfirmationPage.jsp").forward(request,
						response);
	
					
			} else {
				request.getRequestDispatcher("RemedyDashboard.jsp").forward(request,
						response);

			}
	}
}