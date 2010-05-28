package com.tah.dashboard.singleton;

import com.tah.im.IMNotifier;

public class onlineUsersSingleton {
	private static onlineUsersSingleton _instance = new onlineUsersSingleton();
	private IMNotifier onlineUsersSingleton(){
		IMNotifier IM = new IMNotifier();
		return IM;
	}
	public static onlineUsersSingleton getInstance(){
		return _instance;
	}

}
