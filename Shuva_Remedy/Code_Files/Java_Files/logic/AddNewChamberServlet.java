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

public class AddNewChamberServlet extends HttpServlet  {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddNewChamberServlet() {
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
        	   
		String chamberName = request.getParameter("chamberName");
		String addrLine1 = request.getParameter("addrLine1");
		String addrLine2 = request.getParameter("addrLine2");
		String email = request.getParameter("email");
		String landLineNum = request.getParameter("landLineNum");
		String officeHour = request.getParameter("officeHour");
		
		System.out.println(chamberName + " " + addrLine1 + " " + addrLine2 + " " + 
				email + " " +landLineNum + " " + officeHour); 

		
		// Step1: register the JDBC driver
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Step2: Invoke its getConnection() method
		conn = DriverManager.getConnection(con.URL, con.USER, con.PASSWORD);

		System.out.println("Database connection established");
		
        // Step3: Get a Statement Object

			//StringBuilder & StringBuffer
			StringBuffer sb = new StringBuffer();
			
			sb.append("INSERT INTO Chamber_Details ");
			sb.append(" (Chamber_name,Chamber_addrLine1, ");
			sb.append(" Chamber_addrLine2,Chamber_email, ");
			sb.append(" Chamber_landLineNum,Chamber_officeHour, ");
			sb.append(" submission_date) VALUES ");
			sb.append(" (?,?,?,?,?,?,?) ");
			
			
			PreparedStatement s = conn.prepareStatement(sb.toString());
			s.setString(1, chamberName);
			s.setString(2, addrLine1);
			s.setString(3, addrLine2);
			s.setString(4, email);
			s.setString(5, landLineNum);
			s.setString(6, officeHour);
			Date utilDate = new Date();
			s.setDate(7, new java.sql.Date(utilDate.getTime()));
		
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
				
				request.getRequestDispatcher("ChamberConfirmationPage.jsp").forward(request,
						response);
	
					
			} else {
				request.getRequestDispatcher("RemedyDashboard.jsp").forward(request,
						response);

			}
	}
}
