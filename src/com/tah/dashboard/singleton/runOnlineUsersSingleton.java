package com.tah.dashboard.singleton;

import com.tah.im.IMNotifier;



public class runOnlineUsersSingleton implements Runnable {
	public void run()
	{
		System.out.println("***Preparing Online User List");
		System.out.println("Initiating Live Conversation Data Structure!");
		IMNotifier ous = IMNotifier.getInstance();
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
