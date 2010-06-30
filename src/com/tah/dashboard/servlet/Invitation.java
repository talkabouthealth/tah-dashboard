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
		String imUsername = request.getParameter("imusername");
		String imService = request.getParameter("imservice");
		if (imService != null && imUsername != null) {
			//select needed singleton
			//TODO: we can make one interface "singleton" and create/get it with Factory pattern
			//TODO: for some services imUsername should be full email?
			if (imService.equals("GoogleTalk")) {
				//TODO: code conventions?
				googleSingleton _googleSingleton = googleSingleton.getInstance();
				try {
					System.out.println("Add google contact!");
					_googleSingleton.addContact(imUsername);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			else if (imService.equals("YahooIM")) {
				yahooSingleton _yahooSingleton = yahooSingleton.getInstance();
				try {
					System.out.println("Add yahoo contact!");
					_yahooSingleton.addContact(imUsername);					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			else if (imService.equals("WindowsLive")) {
				msnSingleton _msnSingleton = msnSingleton.getInstance();
				try {
					System.out.println("Add msn contact!");
					_msnSingleton.addContact(imUsername);
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
