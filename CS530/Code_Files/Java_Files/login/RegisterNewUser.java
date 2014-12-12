package com.drexel.remedy.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.drexel.remedy.util.Constants;

public class RegisterNewUser extends HttpServlet  {

		private static final long serialVersionUID = 1L;

		/**
		 * @see HttpServlet#HttpServlet()
		 */
		public RegisterNewUser() {
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
	             
			String name = request.getParameter("name");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String confirmPassword = request.getParameter("confirmPassword");
			String email = request.getParameter("email");
			String confirmEmail = request.getParameter("confirmEmail");
			String quesOne = request.getParameter("quesOne");
			String quesTwo = request.getParameter("quesTwo");
			
			
			System.out.println(name + " " + username + " " + password + " " + 
			                    confirmPassword + " " + email + " " + confirmEmail + " " +quesOne + " " + quesTwo); 

			
			// Step1: register the JDBC driver
			Class.forName("com.mysql.jdbc.Driver").newInstance();

			// Step2: Invoke its getConnection() method
			conn = DriverManager.getConnection(con.URL, con.USER, con.PASSWORD);

			System.out.println("Database connection established");
			
            // Step3: Get a Statement Object
		
/*			s.executeUpdate("CREATE TABLE animal ("
					+ "id INT UNSIGNED NOT NULL AUTO_INCREMENT,"
					+ "PRIMARY KEY (id)," + "name CHAR(40), category CHAR(40))");*/
			
			
			Statement st = conn.createStatement();
			st.executeQuery("SELECT * FROM remedyapp.register_customer_details r where customer_username='"+username+"'");
			
		
			//Retreiving the datas through resultset
			ResultSet rs = st.getResultSet();
			if (rs.next()) {
				
				request.setAttribute("validity", "duplicate");
			}else{
				
				//StringBuilder & StringBuffer
				StringBuffer sb = new StringBuffer();
				
				sb.append("INSERT INTO Register_Customer_Details ");
				sb.append(" (customer_name,customer_username, ");
				sb.append(" customer_password,customer_confimPassword, ");
				sb.append(" customer_emailAddr,customer_confirmEmail, ");
				sb.append(" customer_sq1,customer_sq2, ");
				sb.append(" submission_date) VALUES ");
				sb.append(" (?,?,?,?,?,?,?,?,?) ");
				
				
				PreparedStatement s = conn.prepareStatement(sb.toString());
				s.setString(1, name);
				s.setString(2, username);
				s.setString(3, password);
				s.setString(4, confirmPassword);
				s.setString(5, email);
				s.setString(6, confirmEmail);
				s.setString(7, quesOne);
				s.setString(8, quesTwo);
				Date utilDate = new Date();
				s.setDate(9, new java.sql.Date(utilDate.getTime()));
			
				count = s.executeUpdate();
				
				s.close();
				System.out.println(count + " rows were inserted");
			}
	           }catch (Exception e) {
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
					
					request.getRequestDispatcher("AfterRegistrationPage.jsp").forward(request,
							response);
					
	/*				RequestDispatcher rd = request.getRequestDispatcher("/HelloServlet");
					request.setAttribute("color", "red");
							rd.forward(request,response);*/
						
				} else {
					request.getRequestDispatcher("Login.jsp").forward(request,
							response);

				}
		}
	}
