package com.tah.dashboard.singleton;

import java.util.Map;

import com.tah.im.IMNotifier;
import com.tah.im.IMNotifierMSN;
import com.tah.im.IMNotifierYahoo;
import com.tah.im.userInfo;
import com.tah.im.singleton.googleSingleton;
import com.tah.im.singleton.msnSingleton;
import com.tah.im.singleton.onlineUsersSingleton;
import com.tah.im.singleton.yahooSingleton;



public class runOnlineUsersSingleton implements Runnable {
	public void run()
	{
		System.out.println("***Preparing Online User List");
		System.out.println("Initiating Live Conversation Data Structure!");
		googleSingleton _googleSingleton = googleSingleton.getInstance();
		yahooSingleton _yahooSingleton = yahooSingleton.getInstance();
		msnSingleton _msnSingleton = msnSingleton.getInstance();
		onlineUsersSingleton _onlineUsersSingleton = onlineUsersSingleton.getInstance();
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
