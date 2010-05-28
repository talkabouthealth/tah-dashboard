package com.tah.dashboard.singleton;



public class runOnlineUsersSingleton implements Runnable {
	public void run()
	{
		System.out.println("***Preparing Online User List");
		System.out.println("Initiating Live Conversation Data Structure!");
		onlineUsersSingleton ous = onlineUsersSingleton.getInstance();
		
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
