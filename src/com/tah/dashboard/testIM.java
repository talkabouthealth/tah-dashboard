package com.tah.dashboard;

import java.util.List;

import com.tah.im.IMNotifier;

import improject.IMSession;
import improject.Message;
import improject.IMSession.IMService;

public class testIM {
	public static void main(String[] args) throws Exception {
		/*String[][] data_list = {{"thero666@gmail.com", "talkabouthealth.com@gmail.com"}, 
                {"http://yahoo.com", "http://www.google.com"}};
		*/
        
		String[] mail_list = {"testIM1122@gmail.com"};
		
		int[] UID = {12};
		IMNotifier IM = IMNotifier.getInstance();
		IMSession session = IM.getSession();
		
		 List<String> onlineUsers = IM.getSession().getOnlineContacts(IM.getMainAcc());
		 System.out.println("The following users are online: ");
		 for(int i = 0; i < onlineUsers.size(); i++){
			 System.out.println(onlineUsers.get(i));
		 }
		
		
/*		
		IMNotifier MyNotifier = new IMNotifier();

		MyNotifier.isUserOnline("testIM1122@gmail.com");
		System.out.println("Is it broadcast to all users? " + MyNotifier.Broadcast(mail_list, UID, 0));
//		MyNotifier.isUserOnline("testIM1122@gmail.com");
		//MyNotifier.Broadcast(data_list2);
	*/
		
	}
}
