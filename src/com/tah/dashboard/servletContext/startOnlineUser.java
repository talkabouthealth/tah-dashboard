package com.tah.dashboard.servletContext;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.tah.dashboard.singleton.runOnlineUsersSingleton;


public class startOnlineUser implements ServletContextListener{
	public void contextInitialized (ServletContextEvent sce){
		System.out.println("***Starting Talkmi Thread!!!");
		Thread tRunTalkmi = new Thread(new runOnlineUsersSingleton(), "RunTalkmiThread");
    	tRunTalkmi.start();
    }
	public void contextDestroyed(ServletContextEvent sce){
 
	}
}