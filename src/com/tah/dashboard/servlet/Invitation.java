package com.tah.dashboard.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tah.im.singleton.googleSingleton;
import com.tah.im.singleton.msnSingleton;
import com.tah.im.singleton.yahooSingleton;

public class Invitation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		String contactEmail = request.getParameter("email");
		if (contactEmail != null) {
			//select needed singleton
			//TODO: we can make one interface "singleton" and create/get it with Factory pattern
			if (contactEmail.contains("gmail.com")) {
				//TODO: code conventions?
				googleSingleton _googleSingleton = googleSingleton.getInstance();
				try {
					System.out.println("Add contact!");
					_googleSingleton.addContact(contactEmail);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			else if (contactEmail.contains("yahoo.")){
				yahooSingleton _yahooSingleton = yahooSingleton.getInstance();
				try {
					_yahooSingleton.addContact(contactEmail);					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			else {
				msnSingleton _msnSingleton = msnSingleton.getInstance();
				try {
					_msnSingleton.addContact(contactEmail);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
