<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.lang.Object.*" %>
<%@ page import="com.tah.dashboard.*"%>
<%@ page import="com.tah.im.*" %>
<%@ page import="com.tah.im.singleton.onlineUsersSingleton" %>
<%@ page import="java.util.*" %>
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
  	var GOOGLE = new Array();
  	var YAHOO = new Array();
  	var MSN = new Array();
  	var idGOOGLE = new Array();
  	var idYAHOO = new Array();
  	var idMSN = new Array();
  	// Create HTTP request object.
	function createHttpObj(){
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		}
		else{// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		return xmlhttp;
	}
	// check latest topic every 5 seconds.
  	setInterval("checkLatestTopic()", 5000);
  	//Send http request to newTopicAlert servlet to check if there's new topic
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
					$("#alert").text("You got a new topic!!!" + " currentTopicId is " + currentTopicId + " and previoustopicid is "+ previousLatestTopicId);
					previousLatestTopicId = currentTopicId;
				}
		    }
		};	
		xmlhttp.send();
  	}
  	// Create conversation information
  	function addConversationInfo(_convTid, _convOwner, _convTopic){
  	  	convTid = _convTid;
  	  	convOwner = _convOwner;
  	  	convTopic = _convTopic;
  	  	show();
	}
	// Create user information for different IM services
	function addUserInfo(_userId, _userEmail, _imType){
		switch(_imType){
		case "GoogleTalk":
			addUserGOOGLE(_userId, _userEmail);
			break;
		case "WindowLive":
			addUserMSN(_userId, _userEmail);
			break;
		case "YahooIM":
			addUserYAHOO(_userId, _userEmail);
			break;
		default:
			break;	
		}
	}
	// Google user information
	function addUserGOOGLE(_userId, _userEmail){
		var exist = 0;
		if(idGOOGLE.length == 0){
			idGOOGLE.push(_userId);
			GOOGLE.push(_userEmail);
		}else{
			for(i = 0; i < idGOOGLE.length; i++){
				if(idGOOGLE[i] == _userId){
					idGOOGLE.splice(i, 1);
					GOOGLE.splice(i, 1);
					exist = 1;
				}
			}	
			if(!exist){
				idGOOGLE.push(_userId);
				GOOGLE.push(_userEmail);				
			}		
		}
		show();	
	}
	// MSN user information
	function addUserMSN(_userId, _userEmail){
		var exist = 0;
		if(idMSN.length == 0){
			idMSN.push(_userId);
			MSN.push(_userEmail);
		}else{
			for(i = 0; i < idMSN.length; i++){
				if(idMSN[i] == _userId){
					idMSN.splice(i, 1);
					MSN.splice(i, 1);
					exist = 1;
				}
			}	
			if(!exist){
				idMSN.push(_userId);
				MSN.push(_userEmail);				
			}		
		}
		show();	
	}
	//Yahoo user information
	function addUserYAHOO(_userId, _userEmail){
		var exist = 0;
		if(idYAHOO.length == 0){
			idYAHOO.push(_userId);
			YAHOO.push(_userEmail.slice(0, _userEmail.indexOf("@")));
		}else{
			for(i = 0; i < idYAHOO.length; i++){
				if(idYAHOO[i] == _userId){
					idYAHOO.splice(i, 1);
					YAHOO.splice(i, 1);
					exist = 1;
				}
			}	
			if(!exist){
				idYAHOO.push(_userId);
				YAHOO.push(_userEmail.slice(0, _userEmail.indexOf("@")));				
			}		
		}
		show();	
	}
	// Display information of selected topic and number of users who has been selected.
  	function show(){
		$("#results").html("You've selected " + (idGOOGLE.length + idYAHOO.length + idMSN.length) 
			+ " users to join conversation(" + convTid + "). <br>" + "Yahoo: " + idYAHOO.length 
			+ "<br> GOOGLE: " + idGOOGLE.length + "<br> MSN: " + idMSN.length + "<br>");	 
	}
	// Send http request to IMNotifier to invited users
	function sendtoservlet(){
		var param = setParam(idGOOGLE, GOOGLE);
		var paramYahoo = setParam(idYAHOO, YAHOO);
		var paramMSN = setParam(idMSN, MSN);
		var httprequest = createHttpObj();
		var httprequestYahoo = createHttpObj();
		var httprequestMSN = createHttpObj();
		$("#results").html("GOOGLE: " + param + "<br> Yahoo: " + paramYahoo + "<br> MSN: " + paramMSN);
		httprequest.open("POST","Notification",true);
		httprequestYahoo.open("POST","NotificationYAHOO",true);
		httprequestMSN.open("POST","NotificationMSN",true);
		httprequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		httprequestYahoo.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		httprequestMSN.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		httprequest.onreadystatechange=function(){
			if (httprequestYahoo.readyState == 4 && httprequestYahoo.status == 200 
					&& httprequestMSN.readyState == 4 && httprequestMSN.status == 200 
					&& httprequest.readyState == 4 && httprequest.status == 200){
				window.location.reload();
		    }
		};	
		httprequestYahoo.onreadystatechange=function(){
			if (httprequestYahoo.readyState == 4 && httprequestYahoo.status == 200 
					&& httprequestMSN.readyState == 4 && httprequestMSN.status == 200 
					&& httprequest.readyState == 4 && httprequest.status == 200){
				window.location.reload();
		    }
		};	
		httprequestMSN.onreadystatechange=function(){
			if (httprequestYahoo.readyState == 4 && httprequestYahoo.status == 200 
					&& httprequestMSN.readyState == 4 && httprequestMSN.status == 200 
					&& httprequest.readyState == 4 && httprequest.status == 200){
				window.location.reload();
		    }
		};	
		httprequest.send(param);
		httprequestYahoo.send(paramYahoo);
		httprequestMSN.send(paramMSN);
	}
	// Create parameter string for POST method.
	function setParam(_userId, _userEmail){
		param = "convTid=" + convTid + "&convOwner=" + convOwner + "&convTopic=" + convTopic;
		for(i = 0; i < _userId.length; i++){
			param = param + "&userId=" + _userId[i];
		}
		for(j = 0; j < _userEmail.length; j++){
			param = param + "&userEmail=" + _userEmail[j];
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
										//String sqlStatement = "SELECT DISTINCT topics.*, noti_history.noti_time, talkers.* 
										//FROM topics LEFT JOIN noti_history ON topics.topic_id = noti_history.topic_id 
										//LEFT JOIN talkers ON topics.uid = talkers.uid 
										//WHERE noti_history.noti_time is null ORDER BY topics.creation_date";
					
										List<Map<String, String>> topicsList = DBUtil.loadTopics(false);
										for (Map<String, String> topicInfo : topicsList) {
									%>
											<input type = "radio" name = "conversation" value = "<%= topicInfo.get("topicId") %>" 
												onclick = "addConversationInfo('<%= topicInfo.get("topicId") %>', 
													'<%= topicInfo.get("uname") %>', '<%= topicInfo.get("uname") %>')">
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
										//String sqlStatement3 = "SELECT DISTINCT topics.*, noti_history.noti_time, talkers.* 
										//FROM topics RIGHT JOIN noti_history ON topics.topic_id = noti_history.topic_id 
										//LEFT JOIN talkers ON topics.uid = talkers.uid WHERE noti_history.noti_time is not null 
										//GROUP BY topics.topic_id ORDER BY topics.creation_date";
										
										topicsList = DBUtil.loadTopics(true);
										for (Map<String, String> topicInfo : topicsList) {
									%>
											<input type = "radio" name = "conversation" value = "<%= topicInfo.get("topicId") %>" 
												onclick = "addConversationInfo('<%= topicInfo.get("topicId") %>', 
													'<%= topicInfo.get("uname") %>', '<%= topicInfo.get("uname") %>')">
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
						<div id = "userlist">
							<table border = "1">
								<tr>								
								<% onlineUsersSingleton onlineUserInfo = onlineUsersSingleton.getInstance(); %>
									<th> Online Users ( <%= onlineUserInfo.getOnlineUserMap().size() %> )
									</th>   
								</tr>
								<tr>
									<td>
									<%
										Collection collection = onlineUserInfo.getOnlineUserMap().values();
										Iterator iterator = collection.iterator();
										while(iterator.hasNext()){
											userInfo uI = (userInfo) iterator.next();
									%>
											<input type = "checkbox" name = "user_id" value = "<%= uI.getUid() %>" 
												onclick = "addUserInfo('<%= uI.getUid() %>', 
													'<%= uI.getEmail() %>', '<%= uI.getIMType(uI.getUid()) %>')"> 
									<%										
										out.println(uI.getUname() + " has account of " + uI.getEmail() + " with IM type of " + 
												uI.getIMType(uI.getUid()) + "<br>");
										out.println("Last notified on: " + uI.lastNotiTime(uI.getUid()) + "<br>");
										out.println(uI.getUname() + " has been notified " + uI.numOfNoti(uI.getUid()) 
												+ " times in past 24 hours.<br>");		
										
									}	
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