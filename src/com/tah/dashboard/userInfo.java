package com.tah.dashboard;

import java.sql.ResultSet;
import java.sql.SQLException;

public class userInfo {
	
	private dbConnection con;
	private int uid;
	private String uname;
	private String email;
	private String gender;
	public userInfo() throws SQLException{
	//	RS = _rs;
			con = new dbConnection();

	}
	public userInfo(int _uid) throws SQLException{
		String sql = "SELECT * FROM talkers WHERE uid = " + _uid;
		con = new dbConnection();
		con.setRs(sql);

		while(con.getRs().next()){
			
			uname = con.getRs().getString("uname");
			email = con.getRs().getString("email");
			gender = con.getRs().getString("gender");
		}
		con.getRs().close();
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
	public String getUname(){
		return uname;
	}
	public String getEmail(){
		return email;
	}
	public String getGender(){
		return gender;
	}
}
