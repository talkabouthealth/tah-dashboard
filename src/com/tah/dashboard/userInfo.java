package com.tah.dashboard;

import java.sql.ResultSet;
import java.sql.SQLException;

public class userInfo {
	
	private dbConnection con;
	public userInfo() throws SQLException{
	//	RS = _rs;
			con = new dbConnection();

	}
	
	public ResultSet getUserInfo(int _uid) throws SQLException{
		ResultSet userInfoRS = null;
		String sql = "SELECT * FROM talkers WHERE uid = " + _uid;
		con.setRs(sql);
		userInfoRS = con.getRs();
		return userInfoRS;
	}
	
	public int numOfNoti(int _uid, String _time) throws SQLException{
		int counter;
		counter = 0;
		
		String sql = "SELECT COUNT(*) FROM talkers LEFT JOIN noti_history ON talkers.uid = noti_history.uid WHERE noti_history.noti_time > '" + _time + "' AND noti_history.uid =" + _uid + " ORDER BY noti_history.noti_time"; 
		con.setRs(sql);
		while(con.getRs().next()){
			counter = con.getRs().getInt("COUNT(*)");
		}
		con.getRs().close();
		return counter;
	}
}
