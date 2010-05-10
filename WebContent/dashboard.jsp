<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.lang.Object.*" %>
<%@ page import="com.tah.dashboard.*"%>
<%@ page import="com.tah.im.IMNotifier" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<form method = "GET" action = "/tah-dashboard/Notification" >
			<table>
				<tr>
					<td valign = "top">
						<div>
							<table border = "1">
								<tr>
									<th>Topics list 1
									</th>   
								</tr>
									<tr>
										<td>
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
										</td>   
									</tr>
									<tr>
										<th>Topics list 2
										</th>   
									</tr>
									<tr>
										<td>
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
										</td>   
									</tr>
							</table>
						</div>
					</td>
					<td valign = "top">
						<div>
							<table border = "1">
								<tr>
									<th> Online Users
									</th>   
								</tr>
								<tr>
									<td>
									<%	
										String sqlStatement2 = "SELECT talkers.*, MAX(noti_history.noti_time) FROM talkers LEFT JOIN noti_history ON talkers.uid = noti_history.uid GROUP BY talkers.uid ORDER BY MAX(noti_history.noti_time)";
										dbConnection con2 = new dbConnection(sqlStatement2);
										java.util.Date date= new java.util.Date();
										userInfo uInfo;
										String period;
	
										IMNotifier IM = new IMNotifier();
										
										
										while(con2.getRs().next()){
											uInfo = new userInfo();
	
											if(IM.isUserOnline(con2.getRs().getString("email"))){
									%>
												<br> 
												<input type = "checkbox" name = "user_id" value = "<%= con2.getRs().getInt("uid") %>"> 
									<%
												out.println(con2.getRs().getString("uname") + " has account of " + con2.getRs().getString("email") + "</br>");
												out.println("<br>" + con2.getRs().getString("uname") + " is online </br>");
												out.println("<br> Last notified on: " + con2.getRs().getTimestamp("MAX(noti_history.noti_time)") + "</br>");
//												out.println("<br> current time: " + (new Timestamp(date.getTime())) + "</br>");
												period = ((new Timestamp(date.getTime())).getYear() + 1900) + "-" + ((new Timestamp(date.getTime())).getMonth() + 1) + "-" + ((new Timestamp(date.getTime())).getDate()  - 1) + " " + (new Timestamp(date.getTime())).getHours() + ":" + (new Timestamp(date.getTime())).getMinutes() + ":" + (new Timestamp(date.getTime())).getSeconds();
												out.println("<br> " + con2.getRs().getObject("uname") + " has been notified " + uInfo.numOfNoti(con2.getRs().getInt("uid"), period) + " times in past 24 hours.");		
																							
											} 
											
										}
									%>								
									</td>   
								</tr>
								<tr>
									<th> Offlien Users
									</th>   
								</tr>
								<tr>
									<td>
									<%
										con2.getRs().first();
										while(con2.getRs().next()){
											uInfo = new userInfo();
																														
											if(!IM.isUserOnline(con2.getRs().getString("email"))){
												%>
												<br> 
												<input type = "checkbox" name = "user_id" value = "<%= con2.getRs().getInt("uid") %>"> 
												<%
												out.println(con2.getRs().getString("uname") + " has account of " + con2.getRs().getString("email") + "</br>");
												out.println("<br>" + con2.getRs().getString("uname") + " is NOT online </br>");
												out.println("<br> Last notified on: " + con2.getRs().getTimestamp("MAX(noti_history.noti_time)") + "</br>");
//												out.println("<br> current time: " + (new Timestamp(date.getTime())) + "</br>");
												period = ((new Timestamp(date.getTime())).getYear() + 1900) + "-" + ((new Timestamp(date.getTime())).getMonth() + 1) + "-" + ((new Timestamp(date.getTime())).getDate()  - 1) + " " + (new Timestamp(date.getTime())).getHours() + ":" + (new Timestamp(date.getTime())).getMinutes() + ":" + (new Timestamp(date.getTime())).getSeconds();
												out.println("<br> " + con2.getRs().getObject("uname") + " has been notified " + uInfo.numOfNoti(con2.getRs().getInt("uid"), period) + " times in past 24 hours.");		
												
											} 											
										}
										con2.getRs().close();
									%>
									</td>   
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
			<input type = "submit" value = "Send Notifications">
		</form>
	</body>
</html>