<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.lang.Object.*" %>
<%@ page import="com.tah.dashboard.*"%>
<%@ page import="com.tah.im.IMNotifier" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>

 	<script src="http://code.jquery.com/jquery-latest.js"></script>
  	<script>
  	var convTid = "";
  	var concOwner = "";
  	var convTopic = "";
  	var previousLatestTopicId = 0;
  	var userId = new Array();
  	var userEmail = new Array;
  	var param = "";
	function createHttpObj(){
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		}
		else{// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		return xmlhttp;
	}
	
  	setInterval("checkLatestTopic()", 5000);
  	
  	function checkLatestTopic(){
  		var xmlhttp = createHttpObj();
		xmlhttp.open("GET", "newTopicAlert", true);
		xmlhttp.onreadystatechange=function(){
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
				currentTopicId = xmlhttp.responseText;	
				if(previousLatestTopicId == 0){
					previousLatestTopicId = currentTopicId;
					$("#alert").text("There are no new topics... pre = " + previousLatestTopicId + " current = " + currentTopicId);
				}else if(currentTopicId > previousLatestTopicId && previousLatestTopicId != 0){
//					window.alert("You got a new topic!!!" + previousLatestTopicId);
					$("#alert").text("You got a new topic!!!" + " currentTopicId is " + currentTopicId + " and previoustopicid is "+ previousLatestTopicId);
					previousLatestTopicId = currentTopicId;
				}
		    }
		};	
		xmlhttp.send();
  	}
  	function addConversationInfo(_convTid, _convOwner, _convTopic){
  	  	convTid = _convTid;
  	  	convOwner = _convOwner;
  	  	convTopic = _convTopic;
  	  	show();
	}
	function addUserInfo(_userId, _userEmail){
		var exist = 0;
		if(userId.length == 0){
			userId.push(_userId);
			userEmail.push(_userEmail);
		}else{
			for(i = 0; i < userId.length; i++){
				if(userId[i] == _userId){
					userId.splice(i, 1);
					userEmail.splice(i, 1);
					exist = 1;
				}
			}	
			if(!exist){
				userId.push(_userId);
				userEmail.push(_userEmail);				
			}		
		}
		show();	
	}
  	function show(){
//	  	$("#results").html(convTid + " " + convOwner + " " + convTopic + "<br />" + userId + "<br />" + userEmail + "<br />" + "You've chosen " + userId.length + " users.");
		$("#results").html("You've selected " + userId.length + " users to join conversation(" + convTid + ").");	 
	}
	
	function sendtoservlet(){
		var param = setParam();
		var httprequest = createHttpObj();
		httprequest.open("POST","Notification",true);
		httprequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		httprequest.onreadystatechange=function(){
			if (httprequest.readyState == 4 && httprequest.status == 200){
				window.location.reload();
		    }
		};	
		httprequest.send(param);
	}
	function setParam(){
		param = "convTid=" + convTid + "&convOwner=" + convOwner + "&convTopic=" + convTopic;
		for(i = 0; i < userId.length; i++){
			param = param + "&userId=" + userId[i];
		}
		for(j = 0; j < userEmail.length; j++){
			param = param + "&userEmail=" + userEmail[j];
		}
		return param; 
	}

	</script>
	</head>
	<body>
		<p><tt id="results"></tt></p>
		<p><tt id="alert"></tt></p>
			<table>
				<tr>
					<td valign = "top">
						<div id = "topiclist">
							<table border = "1">
								<tr>
									<th>Topics list 1
									</th>   
								</tr>
									<tr>
										<td>
									<%	
										dbConnection con = new dbConnection();
	
										String sqlStatement = "SELECT DISTINCT topics.*, noti_history.noti_time, talkers.* FROM topics LEFT JOIN noti_history ON topics.topic_id = noti_history.topic_id LEFT JOIN talkers ON topics.uid = talkers.uid WHERE noti_history.noti_time is null ORDER BY topics.creation_date";
										con.setRs(sqlStatement);
	
										while(con.getRs().next()){
									%>
											<br>
											
											<input type = "radio" name = "conversation" value = "<%= con.getRs().getObject("topic_id") %>" onclick = "addConversationInfo('<%= con.getRs().getObject("topic_id") %>', '<%= con.getRs().getObject("uname") %>', '<%= con.getRs().getObject("topic") %>')">
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
											<input type = "radio" name = "conversation" value = "<%= con3.getRs().getObject("topic_id") %>" onclick = "addConversationInfo('<%= con3.getRs().getObject("topic_id") %>', '<%= con3.getRs().getObject("uname") %>', '<%= con3.getRs().getObject("topic") %>')">
											
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
						<div id = "userlist">
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
	
										IMNotifier IM = IMNotifier.getInstance();
										List<String> onlineUsers = IM.getSession().getOnlineContacts(IM.getMainAcc());
					
										for(int i = 0; i < onlineUsers.size(); i++){
									%>
											<br> 
											<input type = "checkbox" name = "user_id" value = "<%= onlineUsers.get(i) %>" > 
									<%	
											out.println(onlineUsers.get(i) + " </br>");
										}										
										
										while(con2.getRs().next()){
											uInfo = new userInfo();
	
											if(IM.isUserOnline(con2.getRs().getString("email"))){
									%>
												<br> 
												<input type = "checkbox" name = "user_id" value = "<%= con2.getRs().getInt("uid") %>" onclick = "addUserInfo('<%= con2.getRs().getObject("uid") %>', '<%= con2.getRs().getObject("email") %>')"> 
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
										do{
											uInfo = new userInfo();
																														
											if(!IM.isUserOnline(con2.getRs().getString("email"))){
												%>
												<br> 
												<input type = "checkbox" name = "user_id" value = "<%= con2.getRs().getInt("uid") %>" onclick = "addUserInfo('<%= con2.getRs().getObject("uid") %>', '<%= con2.getRs().getObject("email") %>')"> 
												<%
												out.println(con2.getRs().getString("uname") + " has account of " + con2.getRs().getString("email") + "</br>");
												out.println("<br>" + con2.getRs().getString("uname") + " is NOT online </br>");
												out.println("<br> Last notified on: " + con2.getRs().getTimestamp("MAX(noti_history.noti_time)") + "</br>");
//												out.println("<br> current time: " + (new Timestamp(date.getTime())) + "</br>");
												period = ((new Timestamp(date.getTime())).getYear() + 1900) + "-" + ((new Timestamp(date.getTime())).getMonth() + 1) + "-" + ((new Timestamp(date.getTime())).getDate()  - 1) + " " + (new Timestamp(date.getTime())).getHours() + ":" + (new Timestamp(date.getTime())).getMinutes() + ":" + (new Timestamp(date.getTime())).getSeconds();
												out.println("<br> " + con2.getRs().getObject("uname") + " has been notified " + uInfo.numOfNoti(con2.getRs().getInt("uid"), period) + " times in past 24 hours.");		
												
											} 											
										}while(con2.getRs().next());
										con2.getRs().close();
									%>
									</td>   
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
	
			<button type="button" onclick="sendtoservlet()">Send Notifications</button>

	</body>
</html>