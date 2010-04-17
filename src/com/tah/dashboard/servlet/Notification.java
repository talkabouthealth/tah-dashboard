package com.tah.dashboard.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.tah.dashboard.dbConnection;
import com.tah.im.IMNotifier;
import com.test.printTest;



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

				try {
					passData(request);
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
	}
	private void passData(HttpServletRequest request) throws Exception{
		
//		String email [] = request.getParameterValues("user_email");
		String UID_S [] = request.getParameterValues("user_email");
		printTest pt = new printTest();
		pt.printline();
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
			//	 System.out.println(email[i] + " " + _uid[i]);
			 }
			 System.out.println(email[i] + " " + _uid[i]);
		}
		
		IMNotifier IM = new IMNotifier();
		IM.Broadcast(email, _uid);
		
	/*	
		String[] mail_list = {"thero666@gmail.com", "talkabouthealth.com@gmail.com"};
		
		int[] UID = {1,5};
		
		IMNotifier MyNotifier = new IMNotifier();
								
		
		System.out.println("Is it broadcast to all users? " + MyNotifier.Broadcast(mail_list, UID));
		
*/
	}
}
