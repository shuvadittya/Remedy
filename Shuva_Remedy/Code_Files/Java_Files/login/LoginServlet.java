package com.drexel.remedy.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.drexel.remedy.util.Constants;

public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
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
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String regUsername =null;
		String regPassword = null;

           try
           {
             
		System.out.println(username + " " + password); 

		
		// Step1: register the JDBC driver
		Class.forName("com.mysql.jdbc.Driver").newInstance();

		// Step2: Invoke its getConnection() method
		conn = DriverManager.getConnection(con.URL, con.USER, con.PASSWORD);

		System.out.println("Database connection established");
		
        // Step3: Get a Statement Object

		Statement s = conn.createStatement();
		
		
		s.executeQuery("SELECT * FROM remedyapp.register_customer_details r where customer_username='"+username+"' AND customer_password='" +password+"'");
		
		//Retreiving the datas through resultset
		ResultSet rs = s.getResultSet();
		while (rs.next()) {
			regUsername = rs.getString("customer_username");
		    regPassword = rs.getString("customer_password");
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
		
           if(regUsername != null && regPassword != null){
			if (regUsername.equals(username) && regPassword.equals(password)) {
				
				request.getRequestDispatcher("RemedyDashboard.jsp").forward(request,
						response);
					
			} else {
				request.setAttribute("validity", "info");
				RequestDispatcher next = request.getRequestDispatcher("Login.jsp");
				next.forward(request, response);
			}
           } else {
        	   request.setAttribute("validity", "info");
				RequestDispatcher next = request.getRequestDispatcher("Login.jsp");
				next.forward(request, response);
			}

	}


}
