package com.book_conference.memberreserve.controller;


import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import org.json.simple.JSONValue;
import org.json.simple.parser.ParseException;
import com.book_conference.memberreserve.dto.RoomDto;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;


public class RoomBookList {

	
	public static List<RoomDto> RoomBookListGet(String  roomnum,String  inputDate) throws UnsupportedEncodingException, IOException, ParseException {
		
		
		String url ="http://localhost:8080/book_conference/RoomBookList?roomnum="+roomnum+"&inputDate="+inputDate;
		URL postUrl = new URL(url);
		HttpURLConnection con = (HttpURLConnection)postUrl.openConnection();
		Object obj = JSONValue.parse(new InputStreamReader(con.getInputStream()));
		org.json.simple.JSONArray jObj = (org.json.simple.JSONArray) obj;
		ObjectMapper om = new ObjectMapper();
		Gson gson = new Gson();
		List<RoomDto> itemList=new ArrayList<RoomDto>();
		Type listType = new TypeToken<ArrayList<RoomDto>>(){}.getType();
		itemList = gson.fromJson(jObj.toString(), listType);
		return itemList;
		

	}

}
