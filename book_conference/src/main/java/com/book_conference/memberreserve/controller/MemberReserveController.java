package com.book_conference.memberreserve.controller;

import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.book_conference.memberreserve.dto.RoomDto;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


import com.book_conference.memberreserve.dao.MemberReserveIDao;

@Controller
public class MemberReserveController {

	@Autowired
	private SqlSession slqSession;
	
	//사용자 예약 페이지 요청 
	@RequestMapping("/MemberReserve")
	public String MemberReserve(HttpServletRequest request, HttpServletResponse response,Model model) {
		String roomnum=request.getParameter("roomnum");
		request.setAttribute("roomnum", roomnum);
		return "/member_reserve/member_reserve.membertiles";
	}
	
	// 사용자 예약 페이지 달력 폼
	@RequestMapping("/MemberRoomBookCalendar")
	public String MemberRoomBookCalendar(HttpServletRequest request, HttpServletResponse response,Model model) {
		
		String roomnum=request.getParameter("roomnum");
		request.setAttribute("roomnum", roomnum);

		return "/member_reserve/member_book_calendar";
	}
	
	// 사용자 예약 처리
	@RequestMapping("/MemberBookWrite")
	public String MemberBookWrite(HttpServletRequest request,Model model){
		String roomnum=request.getParameter("roomnum");	
		String[] BOOK_TIME_ARR = request.getParameterValues("BOOK_TIME");

		String book_time ="";
		int book_total_time=0;
		for(int i=0;i<BOOK_TIME_ARR.length;i++)
		{
			if(i<BOOK_TIME_ARR.length-1){
			book_time = book_time + BOOK_TIME_ARR[i] +",";
			}else{
			book_time = book_time + BOOK_TIME_ARR[i];
			}
			book_total_time++;
		}
		MemberReserveIDao Idao = slqSession.getMapper(MemberReserveIDao.class);
		
		Idao.MemberBookWrite(roomnum,request.getParameter("BOOK_MEMBER"), 
				book_time,
				Integer.toString(book_total_time),
				request.getParameter("BOOK_DATE"),
				request.getParameter("BOOK_REASON"));
		
		request.setAttribute("roomnum", roomnum);
		
		return "redirect:/MemberReserve?roomnum="+roomnum;
	}
	// 사용자 예약 리스트 페이지 요청
	@RequestMapping("/MemberReserveList")
	public String MemberReserveList
	(HttpServletRequest request, HttpServletResponse response,Model model) {
		String roomnum=request.getParameter("roomnum");
		HttpSession session=request.getSession(); 
		String memberid = (String)session.getAttribute("id");
		String year = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
		String month="";
		String inputDate="";
		new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		
		if(request.getParameter("month") ==null){
			month = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			month =request.getParameter("month");
		}
		inputDate = year+"-"+(month.length() == 1 ? "0" + month : month);
		List<RoomDto> itemList=null;
		MemberReserveIDao Idao = slqSession.getMapper(MemberReserveIDao.class);
		
		int count=1;
		int page=1;			
		int pageSize=7;		
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}

		itemList =Idao.SelectMemberReserveList(roomnum,memberid,inputDate,page);
		count =Idao.SelectMemberReserveListCount(roomnum,memberid,inputDate);
				
		int pageCount=count/pageSize+(count % pageSize==0?0:1);
		int startPage=(int)((page-1)/10)*10+1;
		int endPage=startPage+10-1;
		if (endPage>pageCount) endPage=pageCount;

		request.setAttribute("itemList", itemList);
		request.setAttribute("count", page);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("roomnum", roomnum);
		request.setAttribute("year", year);
		request.setAttribute("month", month);
		return "/member_reserve/member_reserve_list.membertiles";
	}
	
	// 사용자 예약 수정 페이지 요청
	@RequestMapping("/MemberModifyBook")
	public String MemberModifyBook(HttpServletRequest request,Model model){
		String roomnum=request.getParameter("roomnum");
		String month="";
		if(request.getParameter("month") ==null){
			month = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			month =request.getParameter("month");
		}
		
		String book_num=request.getParameter("book_num");
		
		int page=1;	
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		
		MemberReserveIDao Idao = slqSession.getMapper(MemberReserveIDao.class);
		RoomDto Dto = Idao.SelectMemberBookInfo(roomnum,book_num);
		
		request.setAttribute("month", month);
		request.setAttribute("roomnum", roomnum);
		request.setAttribute("book_num", book_num);
		request.setAttribute("Dto", Dto);
		
		return "/member_reserve/member_modify_reserve.membertiles";
	}
	// 사용자 예약 수정 달력 폼
	@RequestMapping("/MemberBookModifyCalendar")
	public String MemberBookModifyCalendar(HttpServletRequest request, HttpServletResponse response,Model model) {
		
		String roomnum=request.getParameter("roomnum");
		String bookdate=request.getParameter("bookdate");
		String year = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
		String month="";
		if(request.getParameter("month") ==null){
			month = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			month =request.getParameter("month");
		}
		
		request.setAttribute("month", month);
		request.setAttribute("roomnum", roomnum);
		request.setAttribute("bookdate", bookdate);

		return "/member_reserve/member_modify_calendar";
	}
	
	// 사용자 예약 수정 처리
	@RequestMapping("/MemberModifyBookProcess")
	public String MemberModifyBookProcess(HttpServletRequest request,Model model){
		String page=request.getParameter("page");	
		String roomnum=request.getParameter("roomnum");	
		
		String month="";
		if(request.getParameter("month") ==null){
			month = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			month =request.getParameter("month");
		}
		
		String[] BOOK_TIME_ARR = request.getParameterValues("BOOK_TIME");

		String book_time ="";
		int book_total_time=0;
		for(int i=0;i<BOOK_TIME_ARR.length;i++)
		{
			if(i<BOOK_TIME_ARR.length-1){
			book_time = book_time + BOOK_TIME_ARR[i] +",";
			}else{
			book_time = book_time + BOOK_TIME_ARR[i];
			}
			book_total_time++;
		}
		MemberReserveIDao Idao = slqSession.getMapper(MemberReserveIDao.class);

		Idao.MemberBookUpdate(roomnum,
				book_time,
				Integer.toString(book_total_time),
				request.getParameter("BOOK_DATE"),
				request.getParameter("BOOK_REASON"),
				request.getParameter("BOOK_NUM"));
		String returnmsg ="수정 되었습니다.";
		request.setAttribute("msg", returnmsg); 
		request.setAttribute("url", "./MemberReserveList?roomnum="+roomnum+"&page="+page+"&month="+month);

		return "/alertredirect/redirect";
	}
	
	// 사용자 예약 삭제
	@RequestMapping("/MemberDeleteBook")
	public String MemberDeleteBook(HttpServletRequest request,Model model){
		String roomnum=request.getParameter("roomnum");
		String month="";
		if(request.getParameter("month") ==null){
			month = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			month =request.getParameter("month");
		}
		String book_num=request.getParameter("book_num");
		int page=1;	
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		
		MemberReserveIDao Idao = slqSession.getMapper(MemberReserveIDao.class);
		Idao.MemberDeleteBook(roomnum,book_num);
		
		request.setAttribute("month", month);
		request.setAttribute("roomnum", roomnum);
		String returnmsg ="예약을 삭제하였습니다.";
		request.setAttribute("msg", returnmsg); 
		request.setAttribute("url", "./MemberReserveList?page="+page+"&month="+month);
		
		return "/alertredirect/redirect";
	}
	
	// 사용자 예약 
	@RequestMapping("/MemberReserveStatusForm")
	public String MemberReserveStatusForm(HttpServletRequest request, HttpServletResponse response,Model model) {

		return "/member_reserve/member_reserve_status.membertiles";
	}
	
	@RequestMapping("/MemberReserveStatus")
	public void MemberReserveStatus(HttpServletRequest request, HttpServletResponse response,Model model) throws Exception{
		String roomnum=request.getParameter("roomnum");	
		List<RoomDto> itemList=null;
		new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String year ="";
		String month ="";
		String inputdate;
		int count=1;
		int page=1;			
		int pageSize=7;	
		year=request.getParameter("year");
		month=request.getParameter("month");
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		if(year ==null && month==null){
			inputdate = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date())
					+"-"+ new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		}else{
			inputdate = year +"-"+ (month.length() == 1 ? "0" + month : month);
		}
		MemberReserveIDao Idao = slqSession.getMapper(MemberReserveIDao.class);
		itemList= Idao.MemberReserveStatusList(roomnum,inputdate,page);
		count=Idao.MemberReserveStatusListCount(roomnum,inputdate);
		
		int pageCount=count/pageSize+(count % pageSize==0?0:1);

		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		for(int i=0;i<itemList.size();i++){
			obj.put( "RNUM", ((RoomDto) itemList.get(i)).getRNUM());
			obj.put( "BOOK_NUM", ((RoomDto) itemList.get(i)).getBOOK_NUM());
			obj.put( "BOOK_MEMBER", ((RoomDto) itemList.get(i)).getBOOK_MEMBER());
			obj.put( "BOOK_TIME", ((RoomDto) itemList.get(i)).getBOOK_TIME());
			obj.put( "BOOK_DATE", ((RoomDto) itemList.get(i)).getBOOK_DATE());
			arr.add(obj);
		}
		
		obj.put("page",page);
		arr.add(obj);
		obj.put("pageCount",pageCount);
		arr.add(obj);
	
		response.setHeader( "Content-Type", "text/html;charset=utf-8" );
		PrintWriter out = new PrintWriter( new OutputStreamWriter(response.getOutputStream(), "UTF-8" ) );
		out.print(arr);
		out.flush();
		out.close();
	}
	
}
