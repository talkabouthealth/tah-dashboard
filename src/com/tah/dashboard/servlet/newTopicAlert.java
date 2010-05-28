package com.tah.dashboard.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tah.dashboard.dbConnection;

/**
 * Servlet implementation class newTopicAlert
 */
public class newTopicAlert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public newTopicAlert() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			queryNewTopic(request, response);
		} catch (SQLException e) {
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
			queryNewTopic(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void queryNewTopic(HttpServletRequest request,
			HttpServletResponse response) throws SQLException, IOException {
		// TODO Auto-generated method stub
		dbConnection con = new dbConnection();
		String str;
		int lastTopicId = 0;
		str = "SELECT MAX(topic_id) FROM topics";
		con.setRs(str);
		while(con.getRs().next()){
			lastTopicId = con.getRs().getInt("MAX(topic_id)");
		}
		request.setAttribute("currentLatestTopic", lastTopicId);
		response.setContentType("text/html"); 
        PrintWriter out = response.getWriter(); 
        out.println(lastTopicId);		
	}

}
