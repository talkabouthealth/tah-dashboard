package com.tah.dashboard;

import java.sql.ResultSet;
import java.sql.SQLException;

public class userInfo {
	
	ResultSet RS;
	public userInfo(){
	//	RS = _rs;
	}
	
	public int numOfNoti(int _uid, String _time) throws SQLException{
		int counter;
		counter = 0;
		dbConnection con = new dbConnection();
		String sql = "SELECT * FROM talkers LEFT JOIN noti_history ON talkers.uid = noti_history.uid WHERE noti_history.noti_time > '" + _time + "' AND noti_history.uid =" + _uid + " ORDER BY noti_history.noti_time"; 
		con.setRs(sql);
		while(con.getRs().next()){
			counter ++;
		}
		return counter;
	}
}
