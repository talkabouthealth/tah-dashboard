package com.tah.dashboard.servletContext;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import com.tah.dashboard.singleton.runOnlineUsersSingleton;


public class startOnlineUser implements ServletContextListener {
	public void contextInitialized (ServletContextEvent sce) {
		System.out.println("***Starting Onlin User Singleton Thread!!!");
		Thread tRunTalkmi = new Thread(new runOnlineUsersSingleton(), "runOnlineUsersSingleton");
    	tRunTalkmi.start();
    }
	public void contextDestroyed(ServletContextEvent sce){
 
	}
}