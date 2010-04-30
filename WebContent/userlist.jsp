<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import ="java.lang.Object.*" %>
<%@ page import="com.tah.dashboard.*"%>
<%@ page import="com.tah.im.IMNotifier" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>TAH-Dashboard</title>
	</head>

	<body>
		<form method = "GET" action = "/tah-dashboard/Notification" >
			<table border = 1>
				<tr>
					<th>Topic List</th>
					<th>User List</th>
				</tr>
				<tr>
					<th>
						Notifications need to be sent to following conversations:
					</th>
					<th>
						Online Users:
					</th>
				</tr>
				<tr>
									<td>
						<div class = "topics_1" style="color:#000000">
							
								<%	
									dbConnection con = new dbConnection();

									String sqlStatement = "SELECT DISTINCT topics.topic_id, topics.*, noti_history.noti_time, talkers.* FROM topics LEFT JOIN noti_history ON topics.topic_id = noti_history.topic_id LEFT JOIN talkers ON topics.uid = talkers.uid WHERE noti_history.noti_time is null ORDER BY topics.creation_date";
									con.setRs(sqlStatement);

									while(con.getRs().next()){
								%>
										<br>
										<input type = "radio" name = "conversation" value = "<%= con.getRs().getObject("topic_id") %>">
								<%
										
										out.println(con.getRs().getObject("topics.topic") + " was created by " + con.getRs().getObject("topics.uid") + " on " + con.getRs().getObject("topics.creation_date") +"</br>");
										out.println("<br>User name:   " + con.getRs().getObject("talkers.uname") + "</br>");
										out.println("<br>Gender:   " + con.getRs().getObject("talkers.gender") + "</br>");
									}
									con.getRs().close();
								
								%>
							
						</div>
					</td> 
					<td valign = "top" rowspan = "2">
						<div class = "userlist" style="color:#000000">
							
								<%	
									String sqlStatement2 = "SELECT talkers.*, MAX(noti_history.noti_time) FROM talkers LEFT JOIN noti_history ON talkers.uid = noti_history.uid GROUP BY talkers.uid ORDER BY MAX(noti_history.noti_time)";
									dbConnection con2 = new dbConnection(sqlStatement2);
									java.util.Date date= new java.util.Date();
									userInfo uInfo;
									String period;

									IMNotifier IM = new IMNotifier();
									
									
									while(con2.getRs().next()){
										uInfo = new userInfo();
										
								%>
								<br>
								<input type = "checkbox" name = "user_id" value = "<%= con2.getRs().getInt("uid") %>"> 
								<%	
									
											out.println(con2.getRs().getString("uname") + " has account of " + con2.getRs().getString("email") + "</br>");
											if(IM.isUserOnline(con2.getRs().getString("email"))){
												out.println("<br>" + con2.getRs().getString("uname") + " is online </br>");
												
											} else {
												out.println("<br>" + con2.getRs().getString("uname") + " is NOT online </br>");
											}
											
											
									}
									con2.getRs().close();
								%>
								
								
						</div>
					</td>
				</tr>
				<tr>

 			

				</tr>
				<tr>
					<th>
						Notifications have been sent to following conversations:
					</th>
					<th>
						Offline users:
					</th>
				</tr>
				<tr>
					<td>
						<div class = "topics_2" style="color:#000000">
							
								<%	
									dbConnection con3 = new dbConnection();

									String sqlStatement3 = "SELECT DISTINCT topics.*, noti_history.noti_time, talkers.* FROM topics RIGHT JOIN noti_history ON topics.topic_id = noti_history.topic_id LEFT JOIN talkers ON topics.uid = talkers.uid WHERE noti_history.noti_time is not null GROUP BY topics.topic_id ORDER BY topics.creation_date";
									con3.setRs(sqlStatement3);

									while(con3.getRs().next()){
								%>
										<br>
										<input type = "radio" name = "conversation" value = "<%= con3.getRs().getObject("topic_id") %>">
								<%
										dbConnection con4 = new dbConnection();
										String sqlStatement4 = "SELECT COUNT(*) FROM topics RIGHT JOIN noti_history ON topics.topic_id = noti_history.topic_id WHERE topics.topic_id = " + con3.getRs().getInt("topics.topic_id");
										con4.setRs(sqlStatement4);
										out.println(con3.getRs().getObject("topics.topic") + " was created by " + con3.getRs().getObject("topics.uid") + " on " + con3.getRs().getObject("topics.creation_date") +"</br>");
										while(con4.getRs().next()){
											out.println("<br>Topic " + con3.getRs().getObject("topics.topic_id") + " has inviteed " + con4.getRs().getInt("COUNT(*)") + " people</br>");
										
										}
										out.println("<br>User name:   " + con3.getRs().getObject("talkers.uname") + "</br>");
										out.println("<br>Gender:   " + con3.getRs().getObject("talkers.gender") + "</br>");
										
									}
									con3.getRs().close();
								
								%>
							
						</div>
						
					</td>
					<td>
					</td>
				</tr>
				
			</table>
			<input type = "submit" value = "Send Notifications">
		</form>
	</body> 
</html>