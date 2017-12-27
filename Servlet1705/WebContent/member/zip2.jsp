<?xml version="1.0" encoding="utf-8" ?>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8");
	String srchwrd="&srchwrd="+URLEncoder.encode(request.getParameter("srchwrd"), "utf-8");
 	String ip="http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdService/retrieveNewAdressAreaCdService/getNewAddressListAreaCd";
	ip+="?ServiceKey=VBbRB0OLiR6SRHcmzRfDK07UJ02%2FmLnHfWIJytzqHQQeCkNDL9EUdAPRnkDUQafVqMnjiLjOaVmI2ATwyQhs9w%3D%3D";
	ip+="&searchSe=road"+srchwrd;
	
	URL url=new URL(ip);
	URLConnection connection=url.openConnection();
	
	connection.setRequestProperty("CONTENT-TYPE", "text/xml");
	BufferedReader in=new BufferedReader(new InputStreamReader(url.openStream(), "utf-8"));
	String inputLine="";
	String buffer="";
	while((inputLine=in.readLine()) != null){
		buffer += inputLine.trim();
	}in.close();
%>
<%=buffer %>
