<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.lang.Object.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.tah.dashboard.*"%>
<%@ page import="com.tah.im.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.List"%>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Dashboard</title>
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
//									String sqlStatement = 
//									"SELECT DISTINCT topics.topic_id, topics.*, noti_history.noti_time, talkers.* 
//									FROM topics LEFT JOIN noti_history ON topics.topic_id = noti_history.topic_id 
//									LEFT JOIN talkers ON topics.uid = talkers.uid 
//									WHERE noti_history.noti_time is null ORDER BY topics.creation_date";
										List<Map<String, String>> topicsList = DBUtil.loadTopics(false);
										for (Map<String, String> topicInfo : topicsList) {
									%>
											<br>
											<input type = "radio" name = "conversation" value = "<%= topicInfo.get("topicId") %>">
									<%
											
											out.println(topicInfo.get("topic") + " was created by " + 
													topicInfo.get("uid") + " on " + 
													topicInfo.get("cr_date") +"</br>");
											out.println("<br>User name:   " + topicInfo.get("uname") + "</br>");
											out.println("<br>Gender:   " + topicInfo.get("gender") + "</br>");
										}
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
										//String sqlStatement3 = 
										//	"SELECT DISTINCT topics.*, noti_history.noti_time, talkers.* FROM topics 
										//	RIGHT JOIN noti_history ON topics.topic_id = noti_history.topic_id 
										//	LEFT JOIN talkers ON topics.uid = talkers.uid 
										//	WHERE noti_history.noti_time is not null 
										//	GROUP BY topics.topic_id ORDER BY topics.creation_date";									
										
										topicsList = DBUtil.loadTopics(true);
										for (Map<String, String> topicInfo : topicsList) {
									%>
											<br>
											<input type = "radio" name = "conversation" value = "<%= topicInfo.get("topicId") %>">
									<%
											//String sqlStatement4 = 
											//	"SELECT COUNT(*) FROM topics 
											//	RIGHT JOIN noti_history ON topics.topic_id = noti_history.topic_id 
											//	WHERE topics.topic_id = " + con3.getRs().getInt("topics.topic_id");
											int numOfTopic = DBUtil.getNotiNumByTopic(topicInfo.get("topicId"));
											out.println(topicInfo.get("topic") + " was created by " 
													+ topicInfo.get("uid") + " on " 
													+ topicInfo.get("cr_date") +"</br>");
											out.println("<br>Topic " + topicInfo.get("topicId")
													+ " has inviteed " + numOfTopic + " people</br>");
											
											out.println("<br>User name:   " + topicInfo.get("uname") + "</br>");
											out.println("<br>Gender:   " + topicInfo.get("gender") + "</br>");
										}
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
										//String sqlStatement2 = "SELECT talkers.*, MAX(noti_history.noti_time) 
										//	FROM talkers LEFT JOIN noti_history ON talkers.uid = noti_history.uid 
										//	GROUP BY talkers.uid ORDER BY MAX(noti_history.noti_time)";
										List<Map<String, String>> talkersList = DBUtil.loadTalkers();
										java.util.Date date = new java.util.Date();
										userInfo uInfo;
	
										IMNotifier IM = new IMNotifier();
										for (Map<String, String> talkerInfo : talkersList) {
											uInfo = new userInfo();
	
											if(IM.isUserOnline(talkerInfo.get("email"))) {
									%>
												<br> 
												<input type = "checkbox" name = "user_id" value = "<%= talkerInfo.get("id") %>"> 
									<%
												out.println(talkerInfo.get("uname") + " has account of " 
														+ talkerInfo.get("email") + "</br>");
												out.println("<br>" + talkerInfo.get("uname") + " is online </br>");
												out.println("<br> Last notified on: " + 
														DBUtil.getLastNotification(talkerInfo.get("id")) + "</br>");
//												out.println("<br> current time: " + (new Timestamp(date.getTime())) + "</br>");
												out.println("<br> " + talkerInfo.get("uname") 
														+ " has been notified " + uInfo.numOfNoti(talkerInfo.get("id")) 
														+ " times in past 24 hours.");		
																							
											} 
											
										}
									%>								
									</td>   
								</tr>
								<tr>
									<th> Offline Users
									</th>   
								</tr>
								<tr>
									<td>
									<%
										for (Map<String, String> talkerInfo : talkersList) {
											uInfo = new userInfo();
																														
											if(!IM.isUserOnline(talkerInfo.get("email"))){
												%>
												<br> 
												<input type = "checkbox" name = "user_id" value = "<%= talkerInfo.get("id") %>"> 												
												<%
												out.println(talkerInfo.get("uname") + " has account of " 
														+ talkerInfo.get("email") + "</br>");
												out.println("<br>" + talkerInfo.get("uname") + " is NOT online </br>");
												out.println("<br> Last notified on: " + 
														DBUtil.getLastNotification(talkerInfo.get("id")) + "</br>");
//												out.println("<br> current time: " + (new Timestamp(date.getTime())) + "</br>");
												out.println("<br> " + talkerInfo.get("uname") 
														+ " has been notified " + uInfo.numOfNoti(talkerInfo.get("id")) 
														+ " times in past 24 hours.");													
											} 											
										}
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