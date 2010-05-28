package com.tah.dashboard.singleton;

import com.tah.im.IMNotifier;

public class onlineUsersSingleton{
	private static IMNotifier _instance;
	private void onlineUsersSingleton(){
	//	_instance = new IMNotifier();
		
	}
	public static IMNotifier getInstance(){
		return _instance;
	}

}
