package com.tah.dashboard.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.tah.dashboard.dbConnection;
import com.tah.im.IMNotifier;

/**
 * Servlet implementation class Notification
 */
public class Notification extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Notification() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response){
		// TODO Auto-generated method stub
		/*
		response.encodeRedirectURL("userlist.jsp");
				try {
					passData(request, response);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			passData(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void passData(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String UID_S [] = request.getParameterValues("user_id");
		String _tid_s;
		int _tid;
		
		_tid_s = request.getParameter("conversation").toString();
		_tid = Integer.valueOf(_tid_s);
		dbConnection con = new dbConnection();
		String sql; 
		int [] _uid = new int [UID_S.length];
		String email [] = new String [UID_S.length];
		for (int i = 0; i < UID_S.length; i++){
			
			 _uid[i] = Integer.valueOf(UID_S[i]);
			 sql = "SELECT email FROM talkers WHERE uid = '" + _uid[i] + "'";
			 con.setRs(sql);
			 while(con.getRs().next()){
				 email[i] = (String) con.getRs().getObject("email");
			 }
			 System.out.println(email[i] + " " + _uid[i]);
		}
		IMNotifier IM = new IMNotifier();
		

		IM.Broadcast(email, _uid, _tid);

//		response.sendRedirect("./dashboard.jsp");
	}
}
