package com.book_conference.adminreserve.controller;

import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;

import com.book_conference.adminreserve.dao.AdminReserveIDao;
import com.book_conference.adminreserve.dto.RoomDto;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class RoomBookStatus {
	public static List RoomBookStatusGet(String roomnum, String inputDate) throws IOException {
		//URL을 통해 일자별 예약 현황 조회
		String url ="http://localhost:8080/book_conference/RoomBookStatus?roomnum="+roomnum+"&inputDate="+inputDate;
		URL postUrl = new URL(url);
		HttpURLConnection con = (HttpURLConnection)postUrl.openConnection();
		Object obj = JSONValue.parse(new InputStreamReader(con.getInputStream()));
		org.json.simple.JSONArray jObj = (org.json.simple.JSONArray) obj;
		// Gson API를 통해 JsonArray를 List 형태로 변환
		Gson gson = new Gson();
		List itemList=new ArrayList();
		Type listType = new TypeToken<ArrayList>(){}.getType();
		itemList = gson.fromJson(jObj.toString(), listType);
		return itemList;
	}
}
