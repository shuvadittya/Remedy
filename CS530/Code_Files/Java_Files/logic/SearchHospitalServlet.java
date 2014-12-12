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
import com.drexel.remedy.bean.SearchHospitalBean;
import com.drexel.remedy.util.Constants;

public class SearchHospitalServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	ArrayList<SearchHospitalBean> listOfHospitals = new ArrayList<SearchHospitalBean>();
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchHospitalServlet() {
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
	String hospitalName = request.getParameter("hospitalName");
		
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
		
		
		s.executeQuery("SELECT * FROM remedyapp.hospital_details r where hospital_name='"+hospitalName+"'");
		
		//Retreiving the datas through resultset
		ResultSet rs = s.getResultSet();
		listOfHospitals.clear();
		while (rs.next()) {
			SearchHospitalBean hospitalBean = new SearchHospitalBean();
			hospitalBean.setHospitalName(rs.getString("hospital_name"));
			hospitalBean.setHospitalAddrLine1(rs.getString("hospital_addrLine1"));
			hospitalBean.setHospitalAddrLine2(rs.getString("hospital_addrLine2"));
			hospitalBean.setHospitalEmail(rs.getString("hospital_email"));
			hospitalBean.setHospitalLandLineNum(rs.getString("hospital_landLineNum"));
			
			listOfHospitals.add(hospitalBean);
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
		
           if(listOfHospitals != null && listOfHospitals.size() > 0){
        	   request.setAttribute("list", listOfHospitals);
				request.getRequestDispatcher("SearchHospitalResults.jsp").forward(request,
						response);
					
			} else {
				request.setAttribute("validity", "info");
				RequestDispatcher next = request.getRequestDispatcher("SearchAHospital.jsp");
				next.forward(request, response);
			}

	}


}