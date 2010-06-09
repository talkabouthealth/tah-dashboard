package com.tah.dashboard.singleton;

import java.util.Map;

import com.tah.im.IMNotifier;
import com.tah.im.IMNotifierMSN;
import com.tah.im.IMNotifierYahoo;
import com.tah.im.onlineUsersSingleton;
import com.tah.im.userInfo;



public class runOnlineUsersSingleton implements Runnable {
	public void run()
	{
		System.out.println("***Preparing Online User List");
		System.out.println("Initiating Live Conversation Data Structure!");
		IMNotifier ous = IMNotifier.getInstance();
		IMNotifierYahoo ousYahoo = IMNotifierYahoo.getInstance();
		IMNotifierMSN ousMSN = IMNotifierMSN.getInstance();
		Map<String, userInfo> ousList = onlineUsersSingleton.getInstance();
		System.out.println("***OnlineUser List Ready");
		
		boolean run = true;
    	while(run == true)
        {
        	try {
				Thread.sleep(600000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
        }
	}
	
	
}
