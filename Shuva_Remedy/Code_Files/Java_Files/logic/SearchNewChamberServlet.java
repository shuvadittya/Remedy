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

import com.drexel.remedy.bean.SearchChamberBean;
import com.drexel.remedy.bean.SearchHospitalBean;
import com.drexel.remedy.util.Constants;

public class SearchNewChamberServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	ArrayList<SearchChamberBean> listOfHospitals = new ArrayList<SearchChamberBean>();
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchNewChamberServlet() {
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
	String chamberName = request.getParameter("chamberName");
		
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
		
		
		s.executeQuery("SELECT * FROM remedyapp.chamber_details r where Chamber_name='"+chamberName+"'");
		
		//Retreiving the datas through resultset
		ResultSet rs = s.getResultSet();
		listOfHospitals.clear();
		while (rs.next()) {
			SearchChamberBean chamberBean = new SearchChamberBean();
			chamberBean.setChamberName(rs.getString("Chamber_name"));
			chamberBean.setChamberAddrLine1(rs.getString("Chamber_addrLine1"));
			chamberBean.setChamberAddrLine2(rs.getString("Chamber_addrLine2"));
			chamberBean.setChamberEmail(rs.getString("Chamber_email"));
			chamberBean.setChamberLandLineNum(rs.getString("Chamber_landLineNum"));
			chamberBean.setChamberOfficeHour(rs.getString("Chamber_officeHour"));
			
			listOfHospitals.add(chamberBean);
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
				request.getRequestDispatcher("SearchChamberResults.jsp").forward(request,
						response);
					
			} else {
				request.setAttribute("validity", "info");
				RequestDispatcher next = request.getRequestDispatcher("SearchAChamber.jsp");
				next.forward(request, response);
			}

	}


}

