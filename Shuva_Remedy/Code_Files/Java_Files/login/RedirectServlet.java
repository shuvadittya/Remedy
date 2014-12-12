package com.drexel.remedy.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RedirectServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RedirectServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
	
		 if (request.getParameter("GoAddDoctor") != null) {
		        request.getRequestDispatcher("AddNewDoctor.jsp").forward(request, response);

		    } else if (request.getParameter("GoSearchDoctor") != null) {
		        request.getRequestDispatcher("SearchADoctor.jsp").forward(request, response);

		    }  else if (request.getParameter("GoAddHospital") != null) {
		        request.getRequestDispatcher("AddNewHospital.jsp").forward(request, response);
		        
		    } else if (request.getParameter("GoSearchAppointment") != null) {
		        request.getRequestDispatcher("SearchAppointment.jsp").forward(request, response);
		        
		    } else if (request.getParameter("GoAddChamber") != null) {
		        request.getRequestDispatcher("AddNewChamber.jsp").forward(request, response);
		        
		    } else if (request.getParameter("GoSearchChamber") != null) {
		        request.getRequestDispatcher("SearchAChamber.jsp").forward(request, response);
		        
		    }else if (request.getParameter("GoSearchHospital") != null) {
		        request.getRequestDispatcher("SearchAHospital.jsp").forward(request, response);
		        
		    } else if (request.getParameter("GoMakeAnAppointment") != null) {
		        request.getRequestDispatcher("MakeAnAppointment.jsp").forward(request, response);
		        
		    }
	}
}
