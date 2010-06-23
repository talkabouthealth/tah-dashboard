package com.tah.dashboard.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.tah.dashboard.dbConnection;
import com.tah.im.IMNotifier;
import com.tah.im.singleton.yahooSingleton;

/**
 * Servlet implementation class Notification
 */
public class NotificationYAHOO extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NotificationYAHOO() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response){
		// TODO Auto-generated method stub
		try {
			passGetData(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			passPostData(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void passPostData(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// TODO Auto-generated method stub
		System.out.println(request.getParameter("convTid").toString());
		System.out.println(request.getParameter("convOwner").toString());
		System.out.println(request.getParameter("convTopic").toString());
		String _uId_s [] = request.getParameterValues("userId"); 
		String _uMail [] = request.getParameterValues("userEmail"); 
		int _tId = Integer.valueOf(request.getParameter("convTid").toString());
		int _uId [] = new int [_uId_s.length];
		for(int i = 0; i < _uId.length; i++){
			_uId[i] = Integer.valueOf(_uId_s[i]);
			System.out.println(_uMail[i] + " has uid of " + _uId[i]);
		}
		yahooSingleton _yahooSingleton = yahooSingleton.getInstance();


		 _yahooSingleton.Broadcast(_uMail, _uId, _tId);
		response.sendRedirect("./userlist.jsp");
	}

	private void passGetData(HttpServletRequest request, HttpServletResponse response) throws Exception{
	
	}
}
