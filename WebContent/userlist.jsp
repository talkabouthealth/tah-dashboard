<%@ page import="com.tah.dashboard.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.sql.Date"%>
<%@ page import ="java.lang.Object.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
		<form method = "GET" action = "/tah-dashboard/Notification" >
			<table border = 1>
				<tr>
					<td>
						<div class = "userlist" style="color:#00FFFF">
							
								<%	
									dbConnection con = new dbConnection();

									String sqlStatement = "SELECT * FROM topics";
									con.setRs(sqlStatement);

									while(con.getRs().next()){
								%>
										<br>
										<input type = "radio" name = "conversation" value = "<%= con.getRs().getObject("topic_id") %>">
								<%
										out.println(con.getRs().getObject("topic") + " was created by " + con.getRs().getObject("uid") + " on " + con.getRs().getObject("creation_date") +"</br>");
								
									}
									
								
								%>
							
						</div>
					</td>
					
					<td>
						<div class = "userlist" style="color:#000000">
							
								<%	
									dbConnection con2 = new dbConnection();
									java.util.Date date= new java.util.Date();
									userInfo uInfo;
									String period;

									String sqlStatement2 = "SELECT *, MAX(noti_history.noti_time) FROM talkers LEFT JOIN noti_history ON talkers.uid = noti_history.uid GROUP BY talkers.uid ORDER BY MAX(noti_history.noti_time)";
									con2.setRs(sqlStatement2);
									
									System.out.println("Listing User Info......");
									while(con2.getRs().next()){
										uInfo = new userInfo();

								%>
								<br>
								<input type = "checkbox" name = "user_email" value = "<%= con2.getRs().getInt("uid") %>"> 
								<%
										out.println(con2.getRs().getObject("uname") + " has account of " + con2.getRs().getObject("email") + "</br>");
										out.println("<br> Last notified on: " + con2.getRs().getTimestamp("MAX(noti_history.noti_time)") + "</br>");
										out.println("<br> current time: " + (new Timestamp(date.getTime())) + "</br>");
										period = ((new Timestamp(date.getTime())).getYear() + 1900) + "-" + ((new Timestamp(date.getTime())).getMonth() + 1) + "-" + ((new Timestamp(date.getTime())).getDate()  - 1) + " " + (new Timestamp(date.getTime())).getHours() + ":" + (new Timestamp(date.getTime())).getMinutes() + ":" + (new Timestamp(date.getTime())).getSeconds();
										out.println(uInfo.numOfNoti(con2.getRs().getInt("uid"), period));
										
									}
									
								%>
								
							
						</div>
					</td>
				</tr>
			</table>
			<input type = "submit" value = "Send Notifications">
		</form>
	</body> 
</html>