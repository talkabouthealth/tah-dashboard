package com.tah.dashboard;
import java.sql.*;



public class dbConnection {
    /**
     * @see HttpServlet#HttpServlet()
     */
	private String db_host;
	private String db_user;
	private String db_password;
	private Connection con;
	private String uname;
	private String email;
	private Statement stmt;
	private ResultSet rs;
	private int rows;
	

    
    public dbConnection() throws SQLException {
        
        // TODO Auto-generated constructor stub
    //	System.out.println("Creating connection...");
        db_host = "jdbc:mysql://localhost:3306/talkmidb";
        db_user = "root";
        db_password = "applepie";
        con = DriverManager.getConnection(db_host, db_user, db_password);
        stmt = con.createStatement();
    }


	public void getUserList() throws SQLException {
		// TODO Auto-generated method stub


		
		System.out.println();
		System.out.println("Listing User Info......");
		while(rs.next()){
			setUname(rs.getObject("uname").toString());
			setUname(rs.getObject("email").toString());
			System.out.println(rs.getObject("uname") + " has account of " + rs.getObject("email"));
		}
	}
	
	public Connection getCon(){
		return con;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}


	public String getUname() {
		return uname;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getEmail() {
		return email;
	}

	public void setRs(String _sqlStmt) throws SQLException{
		rs =  stmt.executeQuery(_sqlStmt);	
	}
	public ResultSet getRs(){
		return rs;
	}
	public int getRows() throws SQLException{
		rows = rs.getRow();
		return rows;
	}

}
