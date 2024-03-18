<%@page import="com.project3.yogiaudio.dto.music.CancelDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.util.Base64.Encoder"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.Reader" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="com.project3.yogiaudio.repository.interfaces.PurchaseRepository" %>
<%@ page import="com.project3.yogiaudio.service.PurchaseService" %>



<%
 
	


	 String paymentKey = request.getParameter("paymentKey");
 	 String cancelReason = "고객 변심";
  	 String method = "카드";
  	 String orderName = "김진수";
  	 
  	 
  //String bank = "신한";  
  
  
  //부분 취소에서만 사용
  //String cancelAmount = "300";

  //refundReceiveAccount - 가상계좌 거래에 대해 입금후에 취소하는 경우만 필요
  //String bank = "신한";
  //String accountNumber = "12345678901234";
  //String holderName = "홍길동";
  
  String secretKey = "test_sk_E92LAa5PVbNd9ZAwpxZWV7YmpXyJ:";
  
  Encoder encoder = Base64.getEncoder(); 
  byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
  String authorizations = "Basic "+ new String(encodedBytes, 0, encodedBytes.length);
  
  URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");
  
  HttpURLConnection connection = (HttpURLConnection) url.openConnection();
  connection.setRequestProperty("Authorization", authorizations);
  connection.setRequestProperty("Content-Type", "application/json");
  connection.setRequestMethod("POST");
  connection.setDoOutput(true);

  JSONObject obj = new JSONObject();
  obj.put("cancelReason", cancelReason);

  JSONObject refundReceiveAccount = new JSONObject();

  //obj.put("refundReceiveAccount", refundReceiveAccount);
    
  OutputStream outputStream = connection.getOutputStream();
  outputStream.write(obj.toString().getBytes("UTF-8"));
  
  int code = connection.getResponseCode();
  boolean isSuccess = code == 200 ? true : false;
  
  InputStream responseStream = isSuccess? connection.getInputStream(): connection.getErrorStream();
  
  Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
  JSONParser parser = new JSONParser();
  JSONObject jsonObject = (JSONObject) parser.parse(reader);
  responseStream.close();
%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <title>취소 성공</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  </head>
  <body>
    <section>
      <% if (isSuccess) { %>
      <h1>취소 성공</h1>
      <p>결과 데이터 : <%= jsonObject.toJSONString() %></p>
      <p>orderName : <%= jsonObject.get("orderName") %></p>
      <p>method : <%= jsonObject.get("method") %></p>
      <p>cancels -> cancelReason : <% JSONArray cancels = ((JSONArray)jsonObject.get("cancels")); JSONObject cancel = (JSONObject) cancels.iterator().next(); %> <%=cancel.get("cancelReason") %></p>
	
	   <script>
	        alert("취소성공 환불이 완료되었습니다!");
	        window.location.href = "/purchase/main"; // 취소 성공 후 /purchase/main 페이지로 이동
    	</script>
	
	
	
	
      <%} else { %>
      <h1>취소 실패</h1>
      <p><%= jsonObject.get("message") %></p>
      <span>에러코드: <%= jsonObject.get("code") %></span>
      
      
        <script>
       	  alert("취소 실패: <%= jsonObject.get("message") %>");
	      window.location.href = "/purchase/main"; // 취소 성공 후 /purchase/main 페이지로 이동
    	</script>
      
      
      
      <% } %>
    </section>
  </body>
</html>