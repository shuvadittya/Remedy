package com.drexel.remedy.logic;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.drexel.remedy.bean.SearchDoctorBean;
import com.drexel.remedy.util.Constants;

public class SearchDoctorServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	ArrayList<SearchDoctorBean> listOfDoctors = new ArrayList<SearchDoctorBean>();
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchDoctorServlet() {
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
	String specialization = ""; 
		 if (request.getParameter("Acupuncture") != null) {
			 specialization = "Acupuncture";

		    } else if (request.getParameter("GeneralDentistry") != null) {
		       
		    	specialization = "General Dentistry";
		    }  else if (request.getParameter("CancerSpecialist") != null) {
		    	specialization = "Cancer Specialist";
		        
		    } else if (request.getParameter("Orthodontics") != null) {
		    	specialization = "Orthodontics";
		        
		    } else if (request.getParameter("Gastroenterology") != null) {
		    	specialization = "Gastroenterology";
		        
		    } else if (request.getParameter("Homeopathy") != null) {
		    	specialization = "Homeopathy";
		        
		    } 
		
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
		
        // Step3: Get a Statement Object

		Statement s = conn.createStatement();
		
		
		s.executeQuery("SELECT * FROM remedyapp.doctor_details r where doctor_specialization='"+specialization+"'");
		
		//Retreiving the datas through resultset
		ResultSet rs = s.getResultSet();
		listOfDoctors.clear();
		while (rs.next()) {
			SearchDoctorBean doctorBean = new SearchDoctorBean();
			doctorBean.setFirstName(rs.getString("doctor_firstname"));
			doctorBean.setLastName(rs.getString("doctor_lastName"));
				doctorBean.setAffiliation(rs.getString("doctor_affiliation"));
				doctorBean.setSpecialization(rs.getString("doctor_specialization"));
				doctorBean.setRating(rs.getString("doctor_rating"));
				doctorBean.setEmail(rs.getString("doctor_email"));
				doctorBean.setCellNum(rs.getString("doctor_cellNum"));
				doctorBean.setLandLineNum(rs.getString("doctor_landLineNum"));
				doctorBean.setOfficeHour(rs.getString("doctor_officeHour"));
				listOfDoctors.add(doctorBean);
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
		
           if(listOfDoctors != null && listOfDoctors.size() > 0){
        	   request.setAttribute("list", listOfDoctors);
				request.getRequestDispatcher("SearchDoctorResults.jsp").forward(request,
						response);
					
			} else {
				request.setAttribute("validity", "info");
				RequestDispatcher next = request.getRequestDispatcher("SearchADoctor.jsp");
				next.forward(request, response);
			}

	}


}